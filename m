From: Jon Burgess <mplayer@jburgess.uklinux.net>
Subject: [PATCH] Fix IDE bus reset and DMA disable when reading blank DVD-R
Date: Mon, 15 Dec 2003 13:44:46 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FDDBACE.5060300@jburgess.uklinux.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020506040603050908090507"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from columba1.eur.3com.com ([161.71.171.235]:41386 "EHLO
	columba1.eur.3com.com") by vger.kernel.org with ESMTP
	id S263571AbTLONot (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Dec 2003 08:44:49 -0500
Received: from toucana.eur.3com.com (eurelay.eur.3com.com [140.204.220.50])
	by columba1.eur.3com.com  with ESMTP id hBFDie4q016739
	for <linux-ide@vger.kernel.org>; Mon, 15 Dec 2003 13:44:40 GMT
Received: from isolan.pdd.3com.com ([161.71.120.148])
	by toucana.eur.3com.com  with ESMTP id hBFDlWja013837
	for <linux-ide@vger.kernel.org>; Mon, 15 Dec 2003 13:47:32 GMT
Received: from jburgess.uklinux.net (titanic [161.71.121.152])
	by isolan.pdd.3com.com (8.11.6+Sun/8.9.3) with ESMTP id hBFDikM04633
	for <linux-ide@vger.kernel.org>; Mon, 15 Dec 2003 13:44:47 GMT
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020506040603050908090507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've had a problems burning DVD's in linux-2.6.0-test11 using the ide-cd 
driver.

The DVD writing tool, growisofs, attempts to read the blank disk before 
it writes the new data. The drive responds to the read request on blank 
DVD-R's by returning a "blank media" error. The kernel doesn't have any 
special case handling for this sense value and retries the request a 
couple of times, then gives up and does a bus reset and disables DMA to 
the device. Here is the log:

hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x80LastFailedSense 0x08
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x80LastFailedSense 0x08
hdd: DMA disabled
hdd: ide_intr: huh? expected NULL handler on exit
hdd: ATAPI reset complete

The same thing occurs if I simply try "mount /dev/dvd" on a DVD-R blank.

The sense key value of 8 isn't listed in ide-cd.h, but it is listed in 
scsi.h as a "BLANK_CHECK" error.

I took a look at the code in ide-cd.c and developed the patch attached. 
This handles treats this error condition as a reason to abort the 
request. This behaviour is the same as when I try to do the same thing 
on another drive with a CD-R blank.

With this patch I just get a single "blank media" error, but no bus 
reset and DMA is left enabled. This makes DVD writing with ide-cd work 
well for me.

It looks like the same fix might be desired for 2.4 as well, although is 
perhaps not so important since scsi-ide is normally used instead.

Does the patch look correct?
Should it be applied to 2.6?

Please CC me on any response.

Thanks,
    Jon


--------------020506040603050908090507
Content-Type: text/plain;
 name="dvd-blank.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dvd-blank.diff"

--- linux-2.6.0-test11/drivers/ide/ide-cd.c~	2003-10-10 13:57:03.000000000 +0100
+++ linux-2.6.0-test11/drivers/ide/ide-cd.c	2003-12-14 00:01:27.628417328 +0000
@@ -799,6 +799,10 @@
 			 * sector...  If we got here the error is not correctable */
 			ide_dump_status (drive, "media error (bad sector)", stat);
 			do_end_request = 1;
+		} else if (sense_key == BLANK_CHECK) {
+			/* Disk appears blank ?? */
+			ide_dump_status (drive, "media error (blank)", stat);
+			do_end_request = 1;
 		} else if ((err & ~ABRT_ERR) != 0) {
 			/* Go to the default handler
 			   for other errors. */
--- linux-2.6.0-test11/drivers/ide/ide-cd.h~	2003-07-17 23:16:09.000000000 +0100
+++ linux-2.6.0-test11/drivers/ide/ide-cd.h	2003-12-13 23:58:06.900932544 +0000
@@ -501,6 +501,7 @@
 #define ILLEGAL_REQUEST         0x05
 #define UNIT_ATTENTION          0x06
 #define DATA_PROTECT            0x07
+#define BLANK_CHECK             0x08
 #define ABORTED_COMMAND         0x0b
 #define MISCOMPARE              0x0e
 
@@ -578,7 +579,7 @@
 	"Illegal request",
 	"Unit attention",
 	"Data protect",
-	"(reserved)",
+	"Blank check",
 	"(reserved)",
 	"(reserved)",
 	"Aborted command",

--------------020506040603050908090507--

