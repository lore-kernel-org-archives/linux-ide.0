From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/4] ide: remove ->bus_state field from ide_hwif_t
Date: Tue, 05 Aug 2008 18:40:22 +0200
Message-ID: <20080805164022.17094.27615.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:46473 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758546AbYHEQmc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Aug 2008 12:42:32 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1328087fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 05 Aug 2008 09:42:30 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

It is always set to BUSSTATE_ON.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c   |    4 +---
 include/linux/ide.h |    1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -96,8 +96,6 @@ void ide_init_port_data(ide_hwif_t *hwif
 	hwif->name[2]	= 'e';
 	hwif->name[3]	= '0' + index;
 
-	hwif->bus_state	= BUSSTATE_ON;
-
 	init_completion(&hwif->gendev_rel_comp);
 
 	hwif->tp_ops = &default_tp_ops;
@@ -620,7 +618,7 @@ int generic_ide_ioctl(ide_drive_t *drive
 		case HDIO_GET_BUSSTATE:
 			if (!capable(CAP_SYS_ADMIN))
 				return -EACCES;
-			if (put_user(HWIF(drive)->bus_state, (long __user *)arg))
+			if (put_user(BUSSTATE_ON, (long __user *)arg))
 				return -EFAULT;
 			return 0;
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -560,7 +560,6 @@ typedef struct hwif_s {
 	u8 major;	/* our major number */
 	u8 index;	/* 0 for ide0; 1 for ide1; ... */
 	u8 channel;	/* for dual-port chips: 0=primary, 1=secondary */
-	u8 bus_state;	/* power state of the IDE bus */
 
 	u32 host_flags;
 
