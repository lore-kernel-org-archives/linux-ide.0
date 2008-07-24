From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/4] include/linux/hdreg.h: remove unused defines
Date: Thu, 24 Jul 2008 21:24:32 +0200
Message-ID: <200807242124.32894.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:19769 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbYGXT1N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 15:27:13 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1152972nfc.21
        for <linux-ide@vger.kernel.org>; Thu, 24 Jul 2008 12:27:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Move HD_IRQ define to drivers/block/hd.c (only user).

* Remove unused *_STAT, *_ERR, HD_*, CD, IO, REL and TAG_MASK defines.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/block/hd.c    |    2 +
 include/linux/hdreg.h |   58 --------------------------------------------------
 2 files changed, 2 insertions(+), 58 deletions(-)

Index: b/drivers/block/hd.c
===================================================================
--- a/drivers/block/hd.c
+++ b/drivers/block/hd.c
@@ -42,6 +42,8 @@
 #include <linux/ata.h>
 #include <linux/hdreg.h>
 
+#define HD_IRQ 14
+
 #define REALLY_SLOW_IO
 #include <asm/system.h>
 #include <asm/io.h>
Index: b/include/linux/hdreg.h
===================================================================
--- a/include/linux/hdreg.h
+++ b/include/linux/hdreg.h
@@ -3,64 +3,6 @@
 
 #ifdef __KERNEL__
 #include <linux/ata.h>
-
-/*
- * This file contains some defines for the AT-hd-controller.
- * Various sources.
- */
-
-/* ide.c has its own port definitions in "ide.h" */
-
-#define HD_IRQ		14
-
-/* Hd controller regs. Ref: IBM AT Bios-listing */
-#define HD_DATA		0x1f0		/* _CTL when writing */
-#define HD_ERROR	0x1f1		/* see err-bits */
-#define HD_NSECTOR	0x1f2		/* nr of sectors to read/write */
-#define HD_SECTOR	0x1f3		/* starting sector */
-#define HD_LCYL		0x1f4		/* starting cylinder */
-#define HD_HCYL		0x1f5		/* high byte of starting cyl */
-#define HD_CURRENT	0x1f6		/* 101dhhhh , d=drive, hhhh=head */
-#define HD_STATUS	0x1f7		/* see status-bits */
-#define HD_FEATURE	HD_ERROR	/* same io address, read=error, write=feature */
-#define HD_PRECOMP	HD_FEATURE	/* obsolete use of this port - predates IDE */
-#define HD_COMMAND	HD_STATUS	/* same io address, read=status, write=cmd */
-
-#define HD_CMD		0x3f6		/* used for resets */
-#define HD_ALTSTATUS	0x3f6		/* same as HD_STATUS but doesn't clear irq */
-
-/* remainder is shared between hd.c, ide.c, ide-cd.c, and the hdparm utility */
-
-/* Bits of HD_STATUS */
-#define ERR_STAT		0x01
-#define INDEX_STAT		0x02
-#define ECC_STAT		0x04	/* Corrected error */
-#define DRQ_STAT		0x08
-#define SEEK_STAT		0x10
-#define SRV_STAT		0x10
-#define WRERR_STAT		0x20
-#define READY_STAT		0x40
-#define BUSY_STAT		0x80
-
-/* Bits for HD_ERROR */
-#define MARK_ERR		0x01	/* Bad address mark */
-#define ILI_ERR			0x01	/* Illegal Length Indication (ATAPI) */
-#define TRK0_ERR		0x02	/* couldn't find track 0 */
-#define EOM_ERR			0x02	/* End Of Media (ATAPI) */
-#define ABRT_ERR		0x04	/* Command aborted */
-#define MCR_ERR			0x08	/* media change request */
-#define ID_ERR			0x10	/* ID field not found */
-#define MC_ERR			0x20	/* media changed */
-#define ECC_ERR			0x40	/* Uncorrectable ECC error */
-#define BBD_ERR			0x80	/* pre-EIDE meaning:  block marked bad */
-#define ICRC_ERR		0x80	/* new meaning:  CRC error during transfer */
-#define LFS_ERR			0xf0	/* Last Failed Sense (ATAPI) */
-
-/* Bits of HD_NSECTOR */
-#define CD			0x01
-#define IO			0x02
-#define REL			0x04
-#define TAG_MASK		0xf8
 #endif /* __KERNEL__ */
 
 #include <linux/types.h>
