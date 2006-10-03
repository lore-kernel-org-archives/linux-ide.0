From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [patch] 2.6.18: 32-bit compatibility HDIO IOCTLs
Date: Tue, 3 Oct 2006 17:20:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0610031703010.4642@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:24327 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1750888AbWJCQUV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Oct 2006 12:20:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello,

 A couple of HDIO IOCTLs are not yet handled and a few others are marked 
as using a pointer rather than an unsigned long.  The formers include: 
HDIO_GET_WCACHE, HDIO_GET_ACOUSTIC, HDIO_GET_ADDRESS and 
HDIO_GET_BUSSTATE.  The latters are: HDIO_SET_MULTCOUNT, 
HDIO_SET_UNMASKINTR, HDIO_SET_KEEPSETTINGS, HDIO_SET_32BIT, 
HDIO_SET_NOWERR, HDIO_SET_DMA, HDIO_SET_PIO_MODE and HDIO_SET_NICE.  
Additionally 0x330 used to be HDIO_GETGEO_BIG and may be issued by 32-bit 
`hdparm' run on a 64-bit kernel making Linux complain loudly.

 The following patch fixes these issues.  Please apply.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

patch-mips-2.6.15-20060124-hdio-ioctl32-3
diff -up --recursive --new-file linux-mips-2.6.15-20060124.macro/fs/compat_ioctl.c linux-mips-2.6.15-20060124/fs/compat_ioctl.c
--- linux-mips-2.6.15-20060124.macro/fs/compat_ioctl.c	2006-01-12 06:00:27.000000000 +0000
+++ linux-mips-2.6.15-20060124/fs/compat_ioctl.c	2006-02-01 21:32:14.000000000 +0000
@@ -2776,13 +2776,17 @@ HANDLE_IOCTL(0x1260, broken_blkgetsize)
 HANDLE_IOCTL(BLKFRAGET, w_long)
 HANDLE_IOCTL(BLKSECTGET, w_long)
 HANDLE_IOCTL(BLKPG, blkpg_ioctl_trans)
-HANDLE_IOCTL(HDIO_GET_KEEPSETTINGS, hdio_ioctl_trans)
 HANDLE_IOCTL(HDIO_GET_UNMASKINTR, hdio_ioctl_trans)
-HANDLE_IOCTL(HDIO_GET_DMA, hdio_ioctl_trans)
-HANDLE_IOCTL(HDIO_GET_32BIT, hdio_ioctl_trans)
 HANDLE_IOCTL(HDIO_GET_MULTCOUNT, hdio_ioctl_trans)
+HANDLE_IOCTL(HDIO_GET_KEEPSETTINGS, hdio_ioctl_trans)
+HANDLE_IOCTL(HDIO_GET_32BIT, hdio_ioctl_trans)
 HANDLE_IOCTL(HDIO_GET_NOWERR, hdio_ioctl_trans)
+HANDLE_IOCTL(HDIO_GET_DMA, hdio_ioctl_trans)
 HANDLE_IOCTL(HDIO_GET_NICE, hdio_ioctl_trans)
+HANDLE_IOCTL(HDIO_GET_WCACHE, hdio_ioctl_trans)
+HANDLE_IOCTL(HDIO_GET_ACOUSTIC, hdio_ioctl_trans)
+HANDLE_IOCTL(HDIO_GET_ADDRESS, hdio_ioctl_trans)
+HANDLE_IOCTL(HDIO_GET_BUSSTATE, hdio_ioctl_trans)
 HANDLE_IOCTL(FDSETPRM32, fd_ioctl_trans)
 HANDLE_IOCTL(FDDEFPRM32, fd_ioctl_trans)
 HANDLE_IOCTL(FDGETPRM32, fd_ioctl_trans)
diff -up --recursive --new-file linux-mips-2.6.15-20060124.macro/include/linux/compat_ioctl.h linux-mips-2.6.15-20060124/include/linux/compat_ioctl.h
--- linux-mips-2.6.15-20060124.macro/include/linux/compat_ioctl.h	2006-01-12 06:00:39.000000000 +0000
+++ linux-mips-2.6.15-20060124/include/linux/compat_ioctl.h	2006-02-01 21:31:56.000000000 +0000
@@ -61,17 +61,23 @@ COMPATIBLE_IOCTL(FIGETBSZ)
  *         Some need translations, these do not.
  */
 COMPATIBLE_IOCTL(HDIO_GET_IDENTITY)
-COMPATIBLE_IOCTL(HDIO_SET_DMA)
-COMPATIBLE_IOCTL(HDIO_SET_UNMASKINTR)
-COMPATIBLE_IOCTL(HDIO_SET_NOWERR)
-COMPATIBLE_IOCTL(HDIO_SET_32BIT)
-COMPATIBLE_IOCTL(HDIO_SET_MULTCOUNT)
-COMPATIBLE_IOCTL(HDIO_DRIVE_CMD)
 COMPATIBLE_IOCTL(HDIO_DRIVE_TASK)
-COMPATIBLE_IOCTL(HDIO_SET_PIO_MODE)
-COMPATIBLE_IOCTL(HDIO_SET_NICE)
-COMPATIBLE_IOCTL(HDIO_SET_KEEPSETTINGS)
+COMPATIBLE_IOCTL(HDIO_DRIVE_CMD)
+ULONG_IOCTL(HDIO_SET_MULTCOUNT)
+ULONG_IOCTL(HDIO_SET_UNMASKINTR)
+ULONG_IOCTL(HDIO_SET_KEEPSETTINGS)
+ULONG_IOCTL(HDIO_SET_32BIT)
+ULONG_IOCTL(HDIO_SET_NOWERR)
+ULONG_IOCTL(HDIO_SET_DMA)
+ULONG_IOCTL(HDIO_SET_PIO_MODE)
+ULONG_IOCTL(HDIO_SET_NICE)
+ULONG_IOCTL(HDIO_SET_WCACHE)
+ULONG_IOCTL(HDIO_SET_ACOUSTIC)
+ULONG_IOCTL(HDIO_SET_BUSSTATE)
+ULONG_IOCTL(HDIO_SET_ADDRESS)
 COMPATIBLE_IOCTL(HDIO_SCAN_HWIF)
+/* 0x330 is reserved -- it used to be HDIO_GETGEO_BIG */
+COMPATIBLE_IOCTL(0x330)
 /* 0x02 -- Floppy ioctls */
 COMPATIBLE_IOCTL(FDMSGON)
 COMPATIBLE_IOCTL(FDMSGOFF)
