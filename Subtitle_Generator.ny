;nyquist plug-in
;version 4
;type tool analyze
;name "Subtitle Generator"
;manpage "Subtitle_Generator"
;debugbutton enabled
;author "Cheng Huaiyu"
;release 1.0.0
;copyright "Released under terms of the GNU General Public License version 2"

$control filename "Export Label Track to File:" file "Select a file" "*default*/subtitles" "SRT file|*.srt;*.SRT|LRC files|*.lrc;*.LRC" "save,overwrite"

;; Return number as string with at least 2 digits
(defun pad (num)
  (format nil "~a~a" (if (< num 10) "0" "") num)
)
  
;; Return number as string with at least 3 digits
(defun pad3 (num)
  (format nil "~a~a" (if (< num 100) "00" (if (< num 100) "0" "")) num)
)

;; Format time (seconds) as hh:mm:ss,xxx
(defun srt-time-format (sec)
  (let* ((seconds (truncate sec))
        (hh (truncate (/ seconds 3600)))
        (mm (truncate (/ (rem seconds 3600) 60)))
        (ss (rem seconds 60))
        (xxx (round (* (- sec seconds) 1000))))
    (format nil "~a:~a:~a,~a" (pad hh) (pad mm) (pad ss) (pad3 xxx))
  )
)

;; Format time (seconds) as mm:ss.xx
(defun lrc-time-format (sec)
  (let* ((seconds (truncate sec))
         (mm (truncate (/ seconds 60)))
         (ss (rem seconds 60))
         (xx (round (* (- sec seconds) 100))))
    (format nil "~a:~a.~a" (pad mm) (pad ss) (pad xx)))
)

; generate srt format subtitle
(defun label-to-srt (labels)
  ;; subtitle index
  (let ((srt "") 
        (ind 0))
    (dolist (label labels)
      (setq ind (1+ ind))
      (setf timeS (srt-time-format (first label)))
      (setf timeE (srt-time-format (second label)))
      (string-append srt (format nil "~a~%~a --> ~a~%~a~%~%" ind timeS timeE (third label)))
    )
    (format nil srt)
  )
)

;; generate mp3 lyric
(defun label-to-lrc (labels)
  (setf lrc "")
  (string-append lrc "[ar:Lyrics artist]\n"
                      "[al:Album where the song is from]\n"
                      "[ti:Lyrics (song) title]\n"
                      "[au:Creator of the Songtext]\n"
                      "[length:How long the song is]\n"
                      "[by:Creator of the LRC file]\n"
                      "[offset:+/- Overall timestamp adjustment in milliseconds, + shifts time up, - shifts down]\n"
                      "[re:The player or editor that created the LRC file]\n"
                      "[ve:version of program]\n\n"
  )

  (dolist (label labels)
    (setf timeS (lrc-time-format (first label)))
    (string-append lrc (format nil "[~a] ~s~%" timeS (third label)))
  )
  (format nil lrc)
)

;; Return file extension or empty string
(defun get-file-extension (fname)
  (let ((n (1- (length fname)))
        (ext ""))
    (do ((i n (1- i)))
        ((= i 0) ext)
      (when (char= (char fname i) #\.)
        (setf ext (subseq fname i))
        (return ext)
      )
    )
  )
)

;; Get labels from first label track
(setf labels (second (first (aud-get-info "labels"))))

(setf file-ext (string-upcase (get-file-extension filename)))

;; detect file extension to determine which format to export
(setf txt (if (string= ".LRC" file-ext)
            (label-to-lrc labels)
            (label-to-srt labels)))

(setf fp (open filename :direction :output))
(format fp "~a" txt)
(close fp)

(format nil "File exported successfully to: ~a" filename)
