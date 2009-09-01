From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream] sata_sis: convert to slave_link
Date: Tue, 01 Sep 2009 23:19:10 +0900
Message-ID: <4A9D2D5E.90209@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58861 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754753AbZIAOUM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Sep 2009 10:20:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Uwe Koziolek <uwe.koziolek@gmx.net>

During introduction of slave_link, sata_sis slipped through the crack
and left with ad-hoc merged SCR access.  As SCR status was shared for
both the master and slave devices, when only one of the device is
online, libata EH would think both are online but would only get valid
device signature for the actually present one, which in turn trigger
the probing safety net mechanism and make EH retry causing large delay
during boot.  This patch converts sata_sis to slave_link mechanism.

This bug was reported by TAXI in bko#14075.

 http://bugzilla.kernel.org/show_bug.cgi?id=14075

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: TAXI <taxi@a-city.de>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>
---
This is fairly straight-forward fix but I couldn't test it extensively
and it's way too late in the rc cycle.  I think it would be best to
put it in #upstream and let it see some testing in linux-next and then
backport them through -stable.

Thanks.

 drivers/ata/sata_sis.c |   75 ++++++++++++++++---------------------------------
 1 file changed, 25 insertions(+), 50 deletions(-)

diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 8f98332..f8a91bf 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -109,8 +109,9 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, sis_pci_tbl);
 MODULE_VERSION(DRV_VERSION);

-static unsigned int get_scr_cfg_addr(struct ata_port *ap, unsigned int sc_reg)
+static unsigned int get_scr_cfg_addr(struct ata_link *link, unsigned int sc_reg)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	unsigned int addr = SIS_SCR_BASE + (4 * sc_reg);
 	u8 pmr;
@@ -131,6 +132,9 @@ static unsigned int get_scr_cfg_addr(struct ata_port *ap, unsigned int sc_reg)
 			break;
 		}
 	}
+	if (link->pmp)
+		addr += 0x10;
+
 	return addr;
 }

@@ -138,24 +142,12 @@ static u32 sis_scr_cfg_read(struct ata_link *link,
 			    unsigned int sc_reg, u32 *val)
 {
 	struct pci_dev *pdev = to_pci_dev(link->ap->host->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(link->ap, sc_reg);
-	u32 val2 = 0;
-	u8 pmr;
+	unsigned int cfg_addr = get_scr_cfg_addr(link, sc_reg);

 	if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
 		return -EINVAL;

-	pci_read_config_byte(pdev, SIS_PMR, &pmr);
-
 	pci_read_config_dword(pdev, cfg_addr, val);
-
-	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) ||
-	    (pdev->device == 0x1182) || (pmr & SIS_PMR_COMBINED))
-		pci_read_config_dword(pdev, cfg_addr+0x10, &val2);
-
-	*val |= val2;
-	*val &= 0xfffffffb;	/* avoid problems with powerdowned ports */
-
 	return 0;
 }

@@ -163,28 +155,16 @@ static int sis_scr_cfg_write(struct ata_link *link,
 			     unsigned int sc_reg, u32 val)
 {
 	struct pci_dev *pdev = to_pci_dev(link->ap->host->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(link->ap, sc_reg);
-	u8 pmr;
-
-	if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
-		return -EINVAL;
-
-	pci_read_config_byte(pdev, SIS_PMR, &pmr);
+	unsigned int cfg_addr = get_scr_cfg_addr(link, sc_reg);

 	pci_write_config_dword(pdev, cfg_addr, val);
-
-	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) ||
-	    (pdev->device == 0x1182) || (pmr & SIS_PMR_COMBINED))
-		pci_write_config_dword(pdev, cfg_addr+0x10, val);
-
 	return 0;
 }

 static int sis_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val)
 {
 	struct ata_port *ap = link->ap;
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u8 pmr;
+	void __iomem *base = ap->ioaddr.scr_addr + link->pmp * 0x10;

 	if (sc_reg > SCR_CONTROL)
 		return -EINVAL;
@@ -192,39 +172,23 @@ static int sis_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val)
 	if (ap->flags & SIS_FLAG_CFGSCR)
 		return sis_scr_cfg_read(link, sc_reg, val);

-	pci_read_config_byte(pdev, SIS_PMR, &pmr);
-
-	*val = ioread32(ap->ioaddr.scr_addr + (sc_reg * 4));
-
-	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) ||
-	    (pdev->device == 0x1182) || (pmr & SIS_PMR_COMBINED))
-		*val |= ioread32(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
-
-	*val &= 0xfffffffb;
-
+	*val = ioread32(base + sc_reg * 4);
 	return 0;
 }

 static int sis_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)
 {
 	struct ata_port *ap = link->ap;
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u8 pmr;
+	void __iomem *base = ap->ioaddr.scr_addr + link->pmp * 0x10;

 	if (sc_reg > SCR_CONTROL)
 		return -EINVAL;

-	pci_read_config_byte(pdev, SIS_PMR, &pmr);
-
 	if (ap->flags & SIS_FLAG_CFGSCR)
 		return sis_scr_cfg_write(link, sc_reg, val);
-	else {
-		iowrite32(val, ap->ioaddr.scr_addr + (sc_reg * 4));
-		if ((pdev->device == 0x0182) || (pdev->device == 0x0183) ||
-		    (pdev->device == 0x1182) || (pmr & SIS_PMR_COMBINED))
-			iowrite32(val, ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
-		return 0;
-	}
+
+	iowrite32(val, base + (sc_reg * 4));
+	return 0;
 }

 static int sis_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -236,7 +200,7 @@ static int sis_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	u32 genctl, val;
 	u8 pmr;
 	u8 port2_start = 0x20;
-	int rc;
+	int i, rc;

 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
@@ -319,6 +283,17 @@ static int sis_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;

+	for (i = 0; i < 2; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		if (ap->flags & ATA_FLAG_SATA &&
+		    ap->flags & ATA_FLAG_SLAVE_POSS) {
+			rc = ata_slave_link_init(ap);
+			if (rc)
+				return rc;
+		}
+	}
+
 	if (!(pi.flags & SIS_FLAG_CFGSCR)) {
 		void __iomem *mmio;

