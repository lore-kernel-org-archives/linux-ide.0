From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/5] mpc8xx-ide: use ide_find_port()
Date: Mon, 24 Mar 2008 19:53:24 +0100
Message-ID: <20080324185324.15320.23248.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:42484 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759138AbYCXSiW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Mar 2008 14:38:22 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3711820fkr.5
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2008 11:38:20 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/mpc8xx.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

Index: b/drivers/ide/ppc/mpc8xx.c
===================================================================
--- a/drivers/ide/ppc/mpc8xx.c
+++ b/drivers/ide/ppc/mpc8xx.c
@@ -811,24 +811,28 @@ static int __init mpc8xx_ide_probe(void)
 #ifdef IDE0_BASE_OFFSET
 	memset(&hw, 0, sizeof(hw));
 	if (!m8xx_ide_init_ports(&hw, 0)) {
-		ide_hwif_t *hwif = &ide_hwifs[0];
+		ide_hwif_t *hwif = ide_find_port();
 
-		ide_init_port_hw(hwif, &hw);
-		hwif->pio_mask = ATA_PIO4;
-		hwif->port_ops = &m8xx_port_ops;
+		if (hwif) {
+			ide_init_port_hw(hwif, &hw);
+			hwif->pio_mask = ATA_PIO4;
+			hwif->port_ops = &m8xx_port_ops;
 
-		idx[0] = 0;
+			idx[0] = hwif->index;
+		}
 	}
 #ifdef IDE1_BASE_OFFSET
 	memset(&hw, 0, sizeof(hw));
 	if (!m8xx_ide_init_ports(&hw, 1)) {
-		ide_hwif_t *mate = &ide_hwifs[1];
+		ide_hwif_t *mate = ide_find_port();
 
-		ide_init_port_hw(mate, &hw);
-		mate->pio_mask = ATA_PIO4;
-		mate->port_ops = &m8xx_port_ops;
+		if (mate) {
+			ide_init_port_hw(mate, &hw);
+			mate->pio_mask = ATA_PIO4;
+			mate->port_ops = &m8xx_port_ops;
 
-		idx[1] = 1;
+			idx[1] = mate->index;
+		}
 	}
 #endif
 #endif
