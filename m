From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/4] ide: add 'config' field to hw_regs_t
Date: Sun, 22 Jun 2008 21:35:48 +0200
Message-ID: <20080622193548.5325.82258.sendpatchset@localhost.localdomain>
References: <20080622193537.5325.43764.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:35996 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758636AbYFVTdz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jun 2008 15:33:55 -0400
Received: by an-out-0708.google.com with SMTP id d40so510185and.103
        for <linux-ide@vger.kernel.org>; Sun, 22 Jun 2008 12:33:54 -0700 (PDT)
In-Reply-To: <20080622193537.5325.43764.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add 'config' field to hw_regs_t and use it to set hwif->config_data in
ide_init_port_hw(), then convert ide_legacy_init_one() to use hw->config.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    4 +---
 drivers/ide/ide.c       |    1 +
 include/linux/ide.h     |    1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1695,14 +1695,12 @@ static void ide_legacy_init_one(u8 *idx,
 	ide_std_init_ports(hw, base, ctl);
 	hw->irq = irq;
 	hw->chipset = d->chipset;
+	hw->config = config;
 
 	hwif = ide_find_port_slot(d);
 	if (hwif) {
 		hwif->chipset = hw->chipset;
 
-		if (config)
-			hwif->config_data = config;
-
 		hws[port_no] = hw;
 		idx[port_no] = hwif->index;
 	}
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -286,6 +286,7 @@ void ide_init_port_hw(ide_hwif_t *hwif, 
 	hwif->dev = hw->dev;
 	hwif->gendev.parent = hw->parent ? hw->parent : hw->dev;
 	hwif->ack_intr = hw->ack_intr;
+	hwif->config_data = hw->config;
 }
 
 /*
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -172,6 +172,7 @@ typedef struct hw_regs_s {
 	ide_ack_intr_t	*ack_intr;		/* acknowledge interrupt */
 	hwif_chipset_t  chipset;
 	struct device	*dev, *parent;
+	unsigned long	config;
 } hw_regs_t;
 
 void ide_init_port_data(struct hwif_s *, unsigned int);
