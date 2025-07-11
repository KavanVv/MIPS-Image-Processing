# Dynamic Image Processing System Using MIPS Assembly

![License](https://img.shields.io/badge/license-MIT-green)

> Project Overview

This repository contains an **Image Processing System implemented in MIPS Assembly**, running on the **MARS (MIPS Assembler and Runtime Simulator)** environment.

Unlike high-level languages like Python or MATLAB, this project demonstrates how fundamental image operations can be performed at a **low level**, helping learners understand how **memory management, bitwise operations, and arithmetic processing** work inside a CPU.

---

> Features

 **Brightness Adjustment**  
- Increases or decreases pixel brightness by a user-specified amount.  
- Ensures pixel values remain in the 0–255 range to avoid overflow/underflow.

 **Grayscale Conversion**  
- Converts RGB images to grayscale using the formula:  


Gray = (R + G + B) / 3

- Accepts direct **RGB inputs** for each pixel, processes, and stores the result.

 **Dynamic Matrix Handling**  
- Supports custom image dimensions (rows × columns).  
- Processes all pixel data dynamically in memory.

 **Menu-Driven Interface**  
- Allows users to choose between different processing operations.  
- Displays results in a neatly formatted matrix.

---

> How It Works

1. **User Inputs Matrix Size**
 - Rows and columns.
2. **User Inputs Pixel Data**
 - Either grayscale values or separate R, G, B components depending on the chosen operation.
3. **Select Operation**
 - Brightness Adjustment
 - Grayscale Conversion
 - Exit
4. **Process Image**
 - Performs the chosen operation pixel-by-pixel.
5. **Print Resultant Matrix**
 - Displays the processed image matrix in the console.

---

> Requirements

- **MARS Simulator**
- [Download MARS](http://courses.missouristate.edu/kenvollmar/mars/)

---

> Running the Project

1. **Clone this Repository:**
   
 ```bash
 git clone https://github.com/yourusername/mips-image-processing.git
 cd mips-image-processing
````

2. **Open MARS:**

   * Go to `File → Open` and select `Image_processing.asm`.

3. **Assemble and Run the Program.**

---

> Example Input/Output

### Example Grayscale Conversion

* **User Input:**
* 

  Rows: 2
  Columns: 2

  Pixel 1:
    R = 100
    G = 50
    B = 200

  Pixel 2:
    R = 0
    G = 255
    B = 100

  Pixel 3:
    R = 180
    G = 180
    B = 90

  Pixel 4:
    R = 90
    G = 60
    B = 30


* **Resulting Matrix:**

  Your resultant image matrix is:
  116  118
  150   60
  


> Applications

* Embedded Systems (IoT Cameras, low-power devices)
* Educational tools for teaching computer architecture
* Preprocessing in Computer Vision pipelines
* Robotics and autonomous systems

---

> Author(s)

* **Kavan Vaishnav (22BEC066)**
  

Department of Electronics & Communication Engineering
Institute of Technology, Nirma University, Ahmedabad, India

---

> License

MIT License

> Contributing

Contributions are welcome!
Feel free to open an issue or submit a pull request to improve this project.

---

> Contact

For any queries:

* [Email: 22bec066@nirmauni.ac.in](mailto:22bec066@nirmauni.ac.in)


Happy Coding! 
