From: Hans-Peter Jansen <hpj@urpla.net>
Subject: Re: Time spent waiting for uncorrectable errors
Date: Thu, 19 Feb 2004 17:30:24 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402191730.24660.hpj@urpla.net>
References: <20040216082157.GK57556@vivien.franken.de> <200402191613.18342.hpj@urpla.net> <200402191639.10351.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.185]:38091 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S267348AbUBSQab (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2004 11:30:31 -0500
In-Reply-To: <200402191639.10351.bzolnier@elka.pw.edu.pl>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alex Goller <alex@vivien.franken.de>, linux-ide@vger.kernel.org

On Thursday 19 February 2004 16:39, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 19 of February 2004 16:13, Hans-Peter Jansen wrote:
> >
> > IIRC, the kernel tries to read a defect block exactly 8 times.
> >
> > The problem is (according to some Maxtor guy), a drive, that
> > returns a hard sector error has tried to read it internally a few
> > tausand times (~2650), which results in about 21200 physical
> > retries.
> >
> > Unfortunately this renders an unpatched linux kernel useless for
> > data recovery tasks. Well, not useless in general, but you simply
> > need a _lot_ of patience.
>
> So where are the patches? :-)

First of all, I'm still on 2.4 here. Sorry..

When I looked into this last autumn, I discovered serveral problems:
 - crc-errors are also used for PIO fall back
 - ide crc-error handling is scattered over several modules for disk/
   cdrom/ide-scsi
 - differenciate medium/transport errors correctly (cable...)
and I'm a real dummy in those concerns.

Here's something I hacked up for internal use, only. Please don't 
consume with empty/full stomach:

--- linux-x/include/linux/ide.h	2003-09-23 21:13:31.000000000 +0200
+++ linux/include/linux/ide.h	2003-10-21 18:06:25.000000000 +0200
@@ -793,6 +793,9 @@
 	int		forced_lun;	/* if hdxlun was given at boot */
 	int		lun;		/* logical unit */
 	int		crc_count;	/* crc counter to reduce drive speed */
+	int		crc_err;	/* count crc errors */
+	u8		fail_on_crc_err; /* fail on all crc errors, will prevent */
+					/* retries and automatic speed reduce */
 
 	char		special_buf[4];	/* IDE_DRIVE_CMD, free use */
 } ide_drive_t;
--- linux-x/drivers/ide/ide-disk.c	2003-09-23 20:03:19.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2003-10-21 18:00:55.000000000 +0200
@@ -905,9 +905,21 @@
 			    hwif->INB(IDE_COMMAND_REG) == WIN_SPECIFY)
 				return ide_stopped;
 		} else if ((err & BAD_CRC) == BAD_CRC) {
-			/* UDMA crc error, just retry the operation */
-			drive->crc_count++;
+			if (drive->crc_err++ == 0x7fffffff)
+			    /* we have > MAX_INT-1 errors, stop counting
+			       to avoid a wrap around */
+			    drive->crc_err--;
+			if (drive->fail_on_crc_err)
+			    /* no retries */
+			    rq->errors = ERROR_MAX;
+			else
+			    /* UDMA crc error, just retry the operation */
+			    drive->crc_count++;
 		} else if (err & (BBD_ERR | ECC_ERR)) {
+			if (drive->crc_err++ == 0x7fffffff)
+			    /* we have > MAX_INT-1 errors, stop counting
+			       to avoid a wrap around */
+			    drive->crc_err--;
 			/* retries won't help these */
 			rq->errors = ERROR_MAX;
 		} else if (err & TRK0_ERR) {
@@ -1565,6 +1577,8 @@
 	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		set_acoustic);
  	ide_add_setting(drive,	"failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->failures,		NULL);
  	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
+ 	ide_add_setting(drive,	"crc_err",		SETTING_READ,					-1,			-1,			TYPE_INT,	0,	0x7fffffff,			1,	1,	&drive->crc_err,		NULL);
+ 	ide_add_setting(drive,	"fail_on_crc_err",	SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	1,				1,	1,	&drive->fail_on_crc_err,	NULL);
 }
 
 static int idedisk_ioctl (ide_drive_t *drive, struct inode *inode,


Here's an equally butt ugly attempt for ide-scsi:

