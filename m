From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: ide-floppy - software eject not working with LS-120 drive
Date: Sun, 04 Sep 2005 14:25:49 +0200
Message-ID: <431AE7CD.3040108@rainbow-software.org>
References: <4318BA6C.8070707@rainbow-software.org> <200509031801.11356.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_tic-53091-1125836751-0001-2"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp3.nextra.sk ([195.168.1.142]:7177 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1750778AbVIDM0B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Sep 2005 08:26:01 -0400
In-Reply-To: <200509031801.11356.vda@ilport.com.ua>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: paul@paulbristow.net, linux-ide@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_tic-53091-1125836751-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Denis Vlasenko wrote:
> On Friday 02 September 2005 23:47, Ondrej Zary wrote:
> 
>>Hello,
>>I've bought "new" LS-120 drive and found that software eject does not 
>>work with 2.6.13 kernel:
>>root@pentium:~# eject /dev/hdc
>>eject: unable to eject, last error: Invalid argument
>>
>>The drive spins up and after a while the command fails.
>>This appears in dmesg after each eject attempt:
>>  hdc: unknown partition table
>>ide-floppy: hdc: I/O error, pc = 1b, key =  5, asc = 24, ascq =  0
>>
>>When I boot 2.4.31, eject works fine.
> 
> 
> Can you probive something narrower than 2.4.31 -> 2.6.13 jump?

The problem is caused by idefloppy_ioctl() function which *first* tries
generic_ide_ioctl() and *only* if it fails with -EINVAL, proceeds with
the specific ioctls.
This patch fixes it by first going through the internal ioctls and only
trying generic_ide_ioctl() if none of them matches.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

-- 
Ondrej Zary



--=_tic-53091-1125836751-0001-2
Content-Type: text/plain; name="ide-floppy-eject.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-floppy-eject.patch"

--- linux-2.6.13-orig/drivers/ide/ide-floppy.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13-pentium/drivers/ide/ide-floppy.c	2005-09-04 14:07:53.000000000 +0200
@@ -2038,11 +2038,9 @@
 	struct ide_floppy_obj *floppy = ide_floppy_g(bdev->bd_disk);
 	ide_drive_t *drive = floppy->drive;
 	void __user *argp = (void __user *)arg;
-	int err = generic_ide_ioctl(drive, file, bdev, cmd, arg);
+	int err;
 	int prevent = (arg) ? 1 : 0;
 	idefloppy_pc_t pc;
-	if (err != -EINVAL)
-		return err;
 
 	switch (cmd) {
 	case CDROMEJECT:
@@ -2094,7 +2092,7 @@
 	case IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS:
 		return idefloppy_get_format_progress(drive, argp);
 	}
- 	return -EINVAL;
+	return generic_ide_ioctl(drive, file, bdev, cmd, arg);
 }
 
 static int idefloppy_media_changed(struct gendisk *disk)



--=_tic-53091-1125836751-0001-2--
