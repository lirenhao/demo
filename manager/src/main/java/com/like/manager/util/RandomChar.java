package com.like.manager.util;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.Random;

public class RandomChar {
    private String strRandomString;

    public String getRandomString() {
        return strRandomString;
    }

    public void setRandomString(String randomString) {
        this.strRandomString = randomString;
    }

    private Color getRandColor(int fc, int bc) {
        Random random = new Random();
        if (fc > 255) {
            fc = 255;
        }
        if (bc > 255) {
            bc = 255;
        }
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r, g, b);
    }

    private String getRandomString(int nRandomCount) {
        /*
         * String[] a = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A",
		 * "B", "C", "D", "E", "F", "G", "H", "I", "G", "K", "L", "M", "N", "O",
		 * "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c",
		 * "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q",
		 * "r", "s", "t", "u", "v", "w", "x", "y", "z" };
		 */
        String[] a =
                {
                        "a", "b", "c", "d", "e", "f", "g", "h", "g", "k", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v",
                        "w", "x", "y", "z"
                };
        String strRand = "";
        int nRand;
        int LengthOfRandom = a.length;
        Random random = new Random();
        for (int i = 0; i < nRandomCount; i++) {
            nRand = random.nextInt(LengthOfRandom);
            strRand += a[nRand];
        }
        return strRand;
    }

    public BufferedImage getRandomImage(int nWidth, int nHeight, int nLengthOfRandom, int nDisturbLineCount) {
        BufferedImage image = new BufferedImage(nWidth, nHeight, BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();
        String strRand = "";
        nLengthOfRandom = (nLengthOfRandom <= 0) ? 6 : nLengthOfRandom;
        nDisturbLineCount = (nDisturbLineCount <= 0) ? 0 : nDisturbLineCount;
        Random random = new Random();
        g.setColor(getRandColor(200, 250));
        g.fillRect(0, 0, nWidth, nHeight);
        g.setFont(new Font("Times New Roman", Font.PLAIN, 16));
        g.setColor(new Color(255, 255, 255));
        g.drawRect(0, 0, nWidth - 1, nHeight - 1);
        g.setColor(getRandColor(160, 200));
        for (int i = 0; i < nDisturbLineCount; i++) {
            int x = random.nextInt(nWidth);
            int y = random.nextInt(nHeight);
            int xl = random.nextInt(12);
            int yl = random.nextInt(12);
            g.drawLine(x, y, x + xl, y + yl);
        }
        strRand = this.getRandomString(nLengthOfRandom);
        this.strRandomString = strRand;
        for (int i = 0; i < nLengthOfRandom; i++) {
            g.setColor(new Color(20 + random.nextInt(110), 20 + random.nextInt(110), 20 + random.nextInt(110)));
            try {
                g.drawString(strRand.substring(i, i + 1), 13 * i + 5, 14);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        System.out.println(strRand);
        g.dispose();
        return image;
    }
}
