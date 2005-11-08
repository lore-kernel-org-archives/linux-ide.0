From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Highpoint IDE types
Date: Tue, 08 Nov 2005 17:38:02 +0000
Message-ID: <1131471483.25192.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965000AbVKHRHM@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Ok thanks to Sergei I can now post what I think is the complete table of
HPT chip versions:

        Chip                    PCI ID          Rev
 *      HPT366                  4 (HPT366)      0
 *      HPT366                  4 (HPT366)      1    
 *      HPT368                  4 (HPT366)      2      
 *      HPT370                  4 (HPT366)      3      
 *      HPT370A                 4 (HPT366)      4      
 *      HPT372                  4 (HPT366)      5     
 *      HPT372N                 4 (HPT366)      6     
 *      HPT372                  5 (HPT372)      0       
 *      HPT372N                 5 (HPT372)      > 0     
 *      HPT302                  6 (HPT302)      *       
 *      HPT302N                 6 (HPT302)      > 1    
 *      HPT371                  7 (HPT371)      *      
 *      HPT371N                 7 (HPT371)      > 1     
 *      HPT374                  8 (HPT374)      *     
 *      HPT372N                 9 (HPT372N)     *     


The base clocks for the devices are as follows (note this means most of
the drivers/ide/pci detection code for frequency is wrong). Also for PLL
mode the 3x2N PLL stabilization code is subtly different.

371N/372N/302N		77
302/371/372A		66
372			55
370/374			48

The DPLLs are
	48, 50, 66, 75Mhz

75 is only available on the later chips and used with PATA/SATA bridge
chips for UDMA7.
