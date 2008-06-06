From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/4] icside: use ide_init_port_hw()
Date: Fri, 6 Jun 2008 23:32:35 +0200
Message-ID: <200806062332.36075.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:23256 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761152AbYFFVkr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jun 2008 17:40:47 -0400
Received: by gv-out-0910.google.com with SMTP id e6so432560gvc.37
        for <linux-ide@vger.kernel.org>; Fri, 06 Jun 2008 14:40:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

* Move ide_find_port() and default_hwif_mmiops() calls from icside_setup()
  to icside_register_v{5,6}().

* Convert icside_setup() to initialize hw_regs_t instead ide_hwif_t
  and icside_register_v{5,6}() to use ide_init_port_hw().

* Rename icside_setup() to icside_setup_ports().

There should be no functional changes caused by this patch.

Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c |   72 ++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -415,36 +415,24 @@ static int icside_dma_off_init(ide_hwif_
 	return -EOPNOTSUPP;
 }
 
-static ide_hwif_t *
-icside_setup(void __iomem *base, struct cardinfo *info, struct expansion_card *ec)
+static void icside_setup_ports(hw_regs_t *hw, void __iomem *base,
+			       struct cardinfo *info, struct expansion_card *ec)
 {
 	unsigned long port = (unsigned long)base + info->dataoffset;
-	ide_hwif_t *hwif;
-
-	hwif = ide_find_port();
-	if (hwif) {
-		/*
-		 * Ensure we're using MMIO
-		 */
-		default_hwif_mmiops(hwif);
 
-		hwif->io_ports.data_addr = port;
-		hwif->io_ports.error_addr = port + (1 << info->stepping);
-		hwif->io_ports.nsect_addr = port + (2 << info->stepping);
-		hwif->io_ports.lbal_addr = port + (3 << info->stepping);
-		hwif->io_ports.lbam_addr = port + (4 << info->stepping);
-		hwif->io_ports.lbah_addr = port + (5 << info->stepping);
-		hwif->io_ports.device_addr = port + (6 << info->stepping);
-		hwif->io_ports.status_addr = port + (7 << info->stepping);
-		hwif->io_ports.ctl_addr =
-			(unsigned long)base + info->ctrloffset;
-		hwif->irq     = ec->irq;
-		hwif->chipset = ide_acorn;
-		hwif->gendev.parent = &ec->dev;
-		hwif->dev = &ec->dev;
-	}
-
-	return hwif;
+	hw->io_ports.data_addr	 = port;
+	hw->io_ports.error_addr	 = port + (1 << info->stepping);
+	hw->io_ports.nsect_addr	 = port + (2 << info->stepping);
+	hw->io_ports.lbal_addr	 = port + (3 << info->stepping);
+	hw->io_ports.lbam_addr	 = port + (4 << info->stepping);
+	hw->io_ports.lbah_addr	 = port + (5 << info->stepping);
+	hw->io_ports.device_addr = port + (6 << info->stepping);
+	hw->io_ports.status_addr = port + (7 << info->stepping);
+	hw->io_ports.ctl_addr	 = (unsigned long)base + info->ctrloffset;
+
+	hw->irq = ec->irq;
+	hw->dev = &ec->dev;
+	hw->chipset = ide_acorn;
 }
 
 static int __init
@@ -453,6 +441,7 @@ icside_register_v5(struct icside_state *
 	ide_hwif_t *hwif;
 	void __iomem *base;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
+	hw_regs_t hw;
 
 	base = ecardm_iomap(ec, ECARD_RES_MEMC, 0, 0);
 	if (!base)
@@ -470,10 +459,15 @@ icside_register_v5(struct icside_state *
 	 */
 	icside_irqdisable_arcin_v5(ec, 0);
 
-	hwif = icside_setup(base, &icside_cardinfo_v5, ec);
+	icside_setup_ports(&hw, base, &icside_cardinfo_v5, ec);
+
+	hwif = ide_find_port();
 	if (!hwif)
 		return -ENODEV;
 
+	ide_init_port_hw(hwif, &hw);
+	default_hwif_mmiops(hwif);
+
 	state->hwif[0] = hwif;
 
 	ecard_set_drvdata(ec, state);
@@ -503,6 +497,7 @@ icside_register_v6(struct icside_state *
 	int ret;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 	struct ide_port_info d = icside_v6_port_info;
+	hw_regs_t hw[2];
 
 	ioc_base = ecardm_iomap(ec, ECARD_RES_IOCFAST, 0, 0);
 	if (!ioc_base) {
@@ -538,16 +533,25 @@ icside_register_v6(struct icside_state *
 	 */
 	icside_irqdisable_arcin_v6(ec, 0);
 
+	icside_setup_ports(&hw[0], easi_base, &icside_cardinfo_v6_1, ec);
+	icside_setup_ports(&hw[1], easi_base, &icside_cardinfo_v6_2, ec);
+
 	/*
 	 * Find and register the interfaces.
 	 */
-	hwif = icside_setup(easi_base, &icside_cardinfo_v6_1, ec);
-	mate = icside_setup(easi_base, &icside_cardinfo_v6_2, ec);
+	hwif = ide_find_port();
+	if (hwif == NULL)
+		return -ENODEV;
 
-	if (!hwif || !mate) {
-		ret = -ENODEV;
-		goto out;
-	}
+	ide_init_port_hw(hwif, &hw[0]);
+	default_hwif_mmiops(hwif);
+
+	mate = ide_find_port();
+	if (mate == NULL)
+		return -ENODEV;
+
+	ide_init_port_hw(mate, &hw[1]);
+	default_hwif_mmiops(mate);
 
 	state->hwif[0]    = hwif;
 	state->hwif[1]    = mate;
