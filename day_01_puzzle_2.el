;; https://adventofcode.com/2025/day/1#part2
(load-file "./day_01_puzzle_1.el")

(defun perform-rotation (start-position rotation)
  "Performs rotation, returning '(POSITION . TIMES-CROSSED-ZERO)"
  (let* ((rotation (string-to-rotation rotation))
         (position (+ start-position rotation))
         (times-crossed
          (if (> position 0)
              (/ position dial-digits)
            (+ (abs (/ position dial-digits))
               (if (zerop start-position) 0 1)))) ; Mannnn... Idk.
         (position (mod position dial-digits)))
    (cons position times-crossed)))

(perform-rotation 50 "L68") ; -> '(82 1)
(perform-rotation 82 "L30") ; -> '(52 0)
(perform-rotation 52 "R48") ; -> '(0 1)

(perform-rotation 50 "R1000") ; -> '(50 10)

(defun has-more-sexps ()
  (scan-sexps (point) 1))

(defun process-rotations (file)
  (with-temp-buffer
    (insert-file-contents file)
    (cl-do* ((rotation nil
                       (read-rotation))
             (perf-rot nil
                       (perform-rotation position rotation))
             (position dial-start-position
                       (car perf-rot))
             (zeroes-found 0
                           (+ zeroes-found
                              (cdr perf-rot))))
        ((not (has-more-sexps)) zeroes-found)
      (message "%s %s %s %s" rotation perf-rot position zeroes-found))))


(process-rotations "./day_01_puzzle_1_input.txt") ; -> 6700
