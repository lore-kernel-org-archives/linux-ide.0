From: Ondrej Zary <linux@rainbow-software.org>
Subject: [resend] [patch] ide-floppy - software eject not working with LS-120
 drive
Date: Wed, 28 Sep 2005 19:22:07 +0200
Message-ID: <433AD13F.50508@rainbow-software.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_tic-34602-1127928129-0001-2"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751445AbVI1RWN@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_tic-34602-1127928129-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a resend because I didn't get any reply before.

The problem (eject not working on ATAPI LS-120 drive) is caused by 
idefloppy_ioctl() function which *first* tries generic_ide_ioctl() and 
*only* if it fails with -EINVAL, proceeds with the specific ioctls. The 
generic eject command fails with something other than -EINVAL and the 
specific one is never executed.
This patch fixes it by first going through the internal ioctls and only
trying generic_ide_ioctl() if none of them matches.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

-- 
Ondrej Zary

--=_tic-34602-1127928129-0001-2
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




--=_tic-34602-1127928129-0001-2--
