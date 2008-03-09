From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/7] au1xxx-ide: use ->init_dma method
Date: Sun, 9 Mar 2008 16:33:39 +0100
Message-ID: <200803091633.39456.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:14686 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbYCIPYk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 11:24:40 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1558456fga.17
        for <linux-ide@vger.kernel.org>; Sun, 09 Mar 2008 08:24:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Pass 'ide_hwif_t *hwif' instead of '_auide_hwif *auide' to
  auide_ddma_init().

* Add 'const struct ide_port_info *d' argument to auide_ddma_init().

* Convert the driver to use ->init_dma method.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/mips/au1xxx-ide.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -385,13 +385,12 @@ static void auide_dma_timeout(ide_drive_
 
 	hwif->ide_dma_end(drive);
 }
-					
 
-static int auide_ddma_init(_auide_hwif *auide) {
-	
+static int auide_ddma_init(ide_hwif_t *hwif, const struct ide_port_info *d)
+{
+	_auide_hwif *auide = (_auide_hwif *)hwif->hwif_data;
 	dbdev_tab_t source_dev_tab, target_dev_tab;
 	u32 dev_id, tsize, devwidth, flags;
-	ide_hwif_t *hwif = auide->hwif;
 
 	dev_id   = AU1XXX_ATA_DDMA_REQ;
 
@@ -448,9 +447,9 @@ static int auide_ddma_init(_auide_hwif *
 	return 0;
 } 
 #else
- 
-static int auide_ddma_init( _auide_hwif *auide )
+static int auide_ddma_init(ide_hwif_t *hwif, const struct ide_port_info *d)
 {
+	_auide_hwif *auide = (_auide_hwif *)hwif->hwif_data;
 	dbdev_tab_t source_dev_tab;
 	int flags;
 
@@ -515,9 +514,9 @@ static const struct ide_port_ops au1xxx_
 };
 
 static const struct ide_port_info au1xxx_port_info = {
+	.init_dma		= auide_ddma_init,
 	.port_ops		= &au1xxx_port_ops,
 	.host_flags		= IDE_HFLAG_POST_SET_MODE |
-				  IDE_HFLAG_NO_DMA | /* no SFF-style DMA */
 				  IDE_HFLAG_NO_IO_32BIT |
 				  IDE_HFLAG_UNMASK_IRQS,
 	.pio_mask		= ATA_PIO4,
@@ -610,8 +609,6 @@ static int au_ide_probe(struct device *d
 	auide_hwif.hwif                 = hwif;
 	hwif->hwif_data                 = &auide_hwif;
 
-	auide_ddma_init(&auide_hwif);
-
 	idx[0] = hwif->index;
 
 	ide_device_add(idx, &au1xxx_port_info);
