From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/18] ide: change order of register access in ide_config_drive_speed()
Date: Fri, 20 Jun 2008 23:34:31 +0200
Message-ID: <20080620213431.13202.79378.sendpatchset@localhost.localdomain>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:6668 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761535AbYFTVcf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jun 2008 17:32:35 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1410728fkq.5
        for <linux-ide@vger.kernel.org>; Fri, 20 Jun 2008 14:32:34 -0700 (PDT)
In-Reply-To: <20080620213323.13202.71450.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Write ATA Feature register before ATA Sector Count register as
a preparation to use ->tf_load in ide_config_drive_speed().

This change shouldn't affect anything (just an usual paranoia).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -828,8 +828,8 @@ int ide_config_drive_speed(ide_drive_t *
 	SELECT_MASK(drive, 0);
 	udelay(1);
 	hwif->set_irq(hwif, 0);
-	hwif->OUTB(speed, io_ports->nsect_addr);
 	hwif->OUTB(SETFEATURES_XFER, io_ports->feature_addr);
+	hwif->OUTB(speed, io_ports->nsect_addr);
 	hwif->exec_command(hwif, WIN_SETFEATURES);
 	if (drive->quirk_list == 2)
 		hwif->set_irq(hwif, 1);
