From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_sis: fix SCR read breakage
Date: Thu, 18 Oct 2007 11:53:39 +0900
Message-ID: <20071018025339.GB18322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:19183 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760087AbXJRCxs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Oct 2007 22:53:48 -0400
Received: by wa-out-1112.google.com with SMTP id v27so34582wah
        for <linux-ide@vger.kernel.org>; Wed, 17 Oct 2007 19:53:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

SCR read for controllers which uses PCI configuration space for SCR
access got broken while adding @val argument to SCR accessors.  Fix
it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_sis.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 8d98a9f..dc8e5c0 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -166,11 +166,11 @@ static unsigned int get_scr_cfg_addr(struct ata_port *ap, unsigned int sc_reg)
 	return addr;
 }
 
-static u32 sis_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
+static u32 sis_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg, u32 *val)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	unsigned int cfg_addr = get_scr_cfg_addr(ap, sc_reg);
-	u32 val, val2 = 0;
+	u32 val2 = 0;
 	u8 pmr;
 
 	if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
@@ -178,13 +178,16 @@ static u32 sis_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
 
-	pci_read_config_dword(pdev, cfg_addr, &val);
+	pci_read_config_dword(pdev, cfg_addr, val);
 
 	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) ||
 	    (pdev->device == 0x1182) || (pmr & SIS_PMR_COMBINED))
 		pci_read_config_dword(pdev, cfg_addr+0x10, &val2);
 
-	return (val|val2) &  0xfffffffb; /* avoid problems with powerdowned ports */
+	*val |= val2;
+	*val &= 0xfffffffb;	/* avoid problems with powerdowned ports */
+
+	return 0;
 }
 
 static void sis_scr_cfg_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
@@ -214,7 +217,7 @@ static int sis_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
 		return -EINVAL;
 
 	if (ap->flags & SIS_FLAG_CFGSCR)
-		return sis_scr_cfg_read(ap, sc_reg);
+		return sis_scr_cfg_read(ap, sc_reg, val);
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
 
