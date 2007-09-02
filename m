From: Kantor Zsolt <kantorzsolt@yahoo.com>
Subject: (unknown)
Date: Sun, 2 Sep 2007 14:24:59 -0700 (PDT)
Message-ID: <686098.41553.qm@web35404.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web35404.mail.mud.yahoo.com ([66.163.179.113]:42450 "HELO
	web35404.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752888AbXIBVZA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 17:25:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, I want get the information from the hard drive via ioctl command. I want to use the HDIO_DRIVE
_TASK command not the HDIO_DRIVE_CMD. With the HDIO_DRIVE _TASK the function returns 0 thats ok,
but no data is in the additional 512 unsigned char array. Here is the code:

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/hdreg.h>

#define SIZE 520

int main ()
{
int fd, i;
	unsigned char args[SIZE]; 
	
	for (i = 0; i < SIZE; i++)
		 args[i] = 0;
 
  // prerequisites DRDY set to 1
  
  args[0] = 0xEC;	   //COMMAND
 	//args[1] = 0xD0;	   //FEATURE
 //args[2] = 0x1;   	//NSECTOR
	//args[3] =  0x1;	   //SECTOR
	//args[4] = 0x4F;	   //LCYL
	//args[5] = 0xC2;	   //HCYL
	//args[6] = 64;	     //SELECT
	args[7] = 0xff;
	
 	fd = open ("/dev/hda", O_RDONLY);

	printf ("%d\n", ioctl (fd, HDIO_DRIVE_TASK, &args));

	
	for (i = 0; i < SIZE; i++)
		{
			if (i == 7)
				puts ("\ndata:");	
			printf ("%X|", args[i]);
		}
	
	
	close (fd);
	
	puts ("");
	
	return (0);
}


       
____________________________________________________________________________________
Got a little couch potato? 
Check out fun summer activities for kids.
http://search.yahoo.com/search?fr=oni_on_mail&p=summer+activities+for+kids&cs=bz 
