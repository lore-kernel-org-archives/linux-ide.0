From: "Dave" <dave@cc0.net>
Subject: 2.4 IDE ARM question
Date: Mon, 30 May 2005 00:59:14 -0700
Message-ID: <001701c564ed$7926a650$2a00a8c0@laptop2>
Reply-To: "Dave" <dave@cc0.net>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 67-130-138-100.unixstudios.net ([67.130.138.100]:36561 "HELO
	mail.unixstudios.net") by vger.kernel.org with SMTP id S261550AbVE3H5q
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 May 2005 03:57:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello all,

I am working on an IDE driver for a IXP425 based ARM board and would like to 
know if this is the appropriate place to ask 2.4 IDE related questions or is 
this for 2.6 only?

To save bandwidth a brief description of the issue follows in the event this 
is the appropriate list.

A CF socket is hooked up to the Expansion Bus on a custom IXP425 based 
board. The board is wired identical to a IXDP425 with the exception of a few 
additional items and less flash/sdram.

Most everything seems to work ok with the exception of writes to the CF. 
Identify works correctly, fdisk, mke2fs, etc. Writing to the card works..but 
the data is corrupted. If a file is copied to the CF on another machine, the 
file is fine when the CF is used on the IXP board.

After successfully copying a file to the CF on the IXP board the file size 
reports correct but a md5sum on it differs from the original file.

Looking at a diff of the data of the original file and the file on the CF I 
see every 512 bytes, byte number 511 contains the value of byte 512 and byte 
512 is 0 on the bad file.

A current copy of the driver can be found at 
http://avila.cc0.net/avila-ide.c


Thanks for any assistance or pointers to an appropriate mailing list if this 
one is not.




-Dave




