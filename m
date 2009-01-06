From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/9] ide: fix IDE_DFLAG_NO_IO_32BIT handling
Date: Tue, 06 Jan 2009 19:35:41 +0100
Message-ID: <20090106183541.21193.691.sendpatchset@localhost.localdomain>
References: <20090106183520.21193.63704.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:59614 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923AbZAFSe7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2009 13:34:59 -0500
In-Reply-To: <20090106183520.21193.63704.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix IDE_DFLAG_NO_IO_32BIT handling

* IDE_DFLAG_NO_IO_32BIT may be set by cmd640's ->init_dev method
  so don't clear it in ide_port_tune_devices() (+ no need to do it).

* Move IDE_DFLAG_NO_IO_32BIT handling to ide_port_init_devices().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -847,13 +847,6 @@ static void ide_port_tune_devices(ide_hw
 				ide_set_dma(drive);
 		}
 	}
-
-	ide_port_for_each_dev(i, drive, hwif) {
-		if (hwif->host_flags & IDE_HFLAG_NO_IO_32BIT)
-			drive->dev_flags |= IDE_DFLAG_NO_IO_32BIT;
-		else
-			drive->dev_flags &= ~IDE_DFLAG_NO_IO_32BIT;
-	}
 }
 
 /*
@@ -1186,6 +1179,8 @@ static void ide_port_init_devices(ide_hw
 
 		if (hwif->host_flags & IDE_HFLAG_IO_32BIT)
 			drive->io_32bit = 1;
+		if (hwif->host_flags & IDE_HFLAG_NO_IO_32BIT)
+			drive->dev_flags |= IDE_DFLAG_NO_IO_32BIT;
 		if (hwif->host_flags & IDE_HFLAG_UNMASK_IRQS)
 			drive->dev_flags |= IDE_DFLAG_UNMASK;
 		if (hwif->host_flags & IDE_HFLAG_NO_UNMASK_IRQS)
