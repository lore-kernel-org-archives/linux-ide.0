From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/6] ide: remove stale changelog from ide-disk.c
Date: Mon, 3 Dec 2007 22:51:42 +0100
Message-ID: <200712032251.42242.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:20756 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbXLCVrO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 16:47:14 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2458774ugc
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2007 13:47:13 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   26 --------------------------
 1 file changed, 26 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -13,32 +13,6 @@
  *                and Andre Hedrick <andre@linux-ide.org>
  *
  * This is the IDE/ATA disk driver, as evolved from hd.c and ide.c.
- *
- * Version 1.00		move disk only code from ide.c to ide-disk.c
- *			support optional byte-swapping of all data
- * Version 1.01		fix previous byte-swapping code
- * Version 1.02		remove ", LBA" from drive identification msgs
- * Version 1.03		fix display of id->buf_size for big-endian
- * Version 1.04		add /proc configurable settings and S.M.A.R.T support
- * Version 1.05		add capacity support for ATA3 >= 8GB
- * Version 1.06		get boot-up messages to show full cyl count
- * Version 1.07		disable door-locking if it fails
- * Version 1.08		fixed CHS/LBA translations for ATA4 > 8GB,
- *			process of adding new ATA4 compliance.
- *			fixed problems in allowing fdisk to see
- *			the entire disk.
- * Version 1.09		added increment of rq->sector in ide_multwrite
- *			added UDMA 3/4 reporting
- * Version 1.10		request queue changes, Ultra DMA 100
- * Version 1.11		added 48-bit lba
- * Version 1.12		adding taskfile io access method
- * Version 1.13		added standby and flush-cache for notifier
- * Version 1.14		added acoustic-wcache
- * Version 1.15		convert all calls to ide_raw_taskfile
- *				since args will return register content.
- * Version 1.16		added suspend-resume-checkpower
- * Version 1.17		do flush on standby, do flush on ATA < ATA6
- *			fix wcache setup.
  */
 
 #define IDEDISK_VERSION	"1.18"
