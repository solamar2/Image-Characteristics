# Image characteristics
This is my final project in the 'Image Characteristics' course. This project focuses on a paper and includes a brief summary, reproducible results using Matlab, a critical review, and suggestions for improving the algorithm. This work is based on an article on the Hough transform written by Fatoumata Dembele. The Hough transform is a method for finding imperfect instances of certain shapes within an image by pointing. It is based on algorithms for finding edges that turn a grayscale image into a binary image like the Canny or Sobel algorithms. By converting the image into binary form, only the edges of the shapes are visible, and this is the basis upon which the method is developed. A matrix of votes is created by manipulating the edge pixels corresponding to the shapes we want to detect. From this matrix we can find the appropriate shapes. In this project, I reproduce the linear and circular detection including improving them by two functions in Matalb: 

Isclose: The purpose of this function is to check if there are circles that are too close. For all circles whose center distances are smaller than the input value, the choice is made by taking the circle with the highest score in this group.

IsEmpty: This function checks whether a certain circle received a high score by chance and therefore passed the threshold in the article function. This is accomplished by finding the number of pixels in the selected circle that overlap with the edge image.

Results:

Fig. 1. Lines detection

![image](https://user-images.githubusercontent.com/111680890/220384532-58434607-cd31-4c1c-a3de-6dcb4a4c55a7.png)


Fig. 2. Circular Hough transform
Right: the algorithm in the article. Left: Gradient algorithm

![image](https://user-images.githubusercontent.com/111680890/220384725-1ad1db21-e2d1-4e91-9cf0-f58253e05022.png)



 
