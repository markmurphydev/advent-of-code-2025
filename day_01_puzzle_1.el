;; https://adventofcode.com/2025/day/1
(require 'cl-lib)

(defconst dial-start-position 50)
(defconst dial-digits 100)

(defun string-to-rotation (str)
  (let* ((direction (substring str 0 1))
         (rightwards (string= direction "R"))
         (magnitude (substring str 1))
         (magnitude (string-to-number magnitude)))
    (if rightwards
        magnitude
      (- magnitude))))

(defun perform-rotation (position rotation)
  (let* ((rotation (string-to-rotation rotation)))
    (mod (+ position rotation)
         dial-digits)))

(defun read-rotation ()
  (kill-sexp)
  (string-trim (pop kill-ring)))

(defun process-rotations (file)
  "Read rotations from file, processing each sequentially"
  (with-temp-buffer
    (insert-file-contents file)
    (cl-do* ((rotation nil
                       (read-rotation))
             (position dial-start-position
                       (perform-rotation position rotation))
             (zeroes-found 0
                           (if (= position 0)
                               (1+ zeroes-found)
                             zeroes-found)))
        ((not (scan-sexps (point) 1)) zeroes-found))))

(process-rotations "./day_01_puzzle_1_input.txt") ; -> 1071
