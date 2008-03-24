From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/5] ide: make ide_hwifs[] static
Date: Mon, 24 Mar 2008 19:53:51 +0100
Message-ID: <20080324185351.15320.58464.sendpatchset@localhost.localdomain>
References: <20080324185324.15320.23248.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:35228 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762891AbYCXSis (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Mar 2008 14:38:48 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3068219fgb.17
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2008 11:38:47 -0700 (PDT)
In-Reply-To: <20080324185324.15320.23248.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Move ide_hwifs[] from ide.c to ide-probe.c and make it static.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    2 ++
 drivers/ide/ide.c       |    2 --
 include/linux/ide.h     |   12 ------------
 3 files changed, 2 insertions(+), 14 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -39,6 +39,8 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
+static ide_hwif_t ide_hwifs[MAX_HWIFS]; /* master data repository */
+
 /**
  *	generic_id		-	add a generic drive id
  *	@drive:	drive to make an ID block for
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -91,8 +91,6 @@ DEFINE_MUTEX(ide_cfg_mtx);
 __cacheline_aligned_in_smp DEFINE_SPINLOCK(ide_lock);
 EXPORT_SYMBOL(ide_lock);
 
-ide_hwif_t ide_hwifs[MAX_HWIFS];	/* master data repository */
-
 static void ide_port_init_devices_data(ide_hwif_t *);
 
 /*
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -788,18 +788,6 @@ struct ide_driver_s {
 
 int generic_ide_ioctl(ide_drive_t *, struct file *, struct block_device *, unsigned, unsigned long);
 
-/*
- * ide_hwifs[] is the master data structure used to keep track
- * of just about everything in ide.c.  Whenever possible, routines
- * should be using pointers to a drive (ide_drive_t *) or
- * pointers to a hwif (ide_hwif_t *), rather than indexing this
- * structure directly (the allocation/layout may change!).
- *
- */
-#ifndef _IDE_C
-extern	ide_hwif_t	ide_hwifs[];		/* master data repository */
-#endif
-
 extern int ide_vlb_clk;
 extern int ide_pci_clk;
 
