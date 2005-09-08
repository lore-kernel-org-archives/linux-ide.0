From: Jeff Garzik <jgarzik@pobox.com>
Subject: [git patches] libata update
Date: Thu, 8 Sep 2005 14:43:38 -0400
Message-ID: <20050908184338.GA1962@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:33761 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751091AbVIHSnl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Sep 2005 14:43:41 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org


Please pull from 'upstream' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain the two changes described below:


 drivers/scsi/ata_piix.c |   10 +++--
 drivers/scsi/sata_sis.c |   82 +++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 77 insertions(+), 15 deletions(-)



commit 6a690df5c8b37d4a1c41df40770d42d44fac0e97
Author: Hannes Reinecke <hare@suse.de>
Date:   Tue Jun 28 17:30:38 2005 -0700

    [PATCH] scan all enabled ports on ata_piix
    
    ICH6 spec defines the PORT_ bits as:
    
    PORT_ENABLED (R/W):
    
      0 = Disabled.  The port is in the off state and cannot detect any
      devices.
    
      1 = Enabled.  The port can transition between the on, partial, and
      slumber states and can detect devices.
    
    PORT_PRESENT  (R/O)
    
      The status of this bit may change at any time.  This bit is cleared
      when the port is disabled via PORT_ENABLED.  This bit is not cleared upon
      surprise removal of a device.
    
    So from a textual view it is not necessary that PORT_PRESENT _must_ be set,
    especially if a device detection has to be done anyway.  And, in fact, this
    is the view that ACER has been taken with its new Laptops (e.g.  Travelmate
    4150).
    
    And the definition of PORT_ENABLED / PORT_PRESENT is mixed up, btw.
    
    Signed-off-by: Hannes Reinecke <hare@suse.de>
    Signed-off-by: Jens Axboe <axboe@suse.de>
    Cc: Jeff Garzik <jgarzik@pobox.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit f2c853bca542f5ac0b036377637192a74f2091c2
Author: Arnaud Patard <apatard@mandriva.com>
Date:   Wed Sep 7 22:44:48 2005 +0200

    [PATCH] sata_sis: Add support for SiS182 chipset
    
    This patch adds support for the SiS182 sata chipset. This is a
    minimalistic version of the patch from
    http://bugme.osdl.org/show_bug.cgi?id=4192. Basically, it add the PCI
    IDs and handles the change of the 2nd port adress register.
    
    Signed-Off-By: Arnaud Patard <apatard@mandriva.com>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -68,8 +68,8 @@ enum {
 	PIIX_COMB_PATA_P0	= (1 << 1),
 	PIIX_COMB		= (1 << 2), /* combined mode enabled? */
 
-	PIIX_PORT_PRESENT	= (1 << 0),
-	PIIX_PORT_ENABLED	= (1 << 4),
+	PIIX_PORT_ENABLED	= (1 << 0),
+	PIIX_PORT_PRESENT	= (1 << 4),
 
 	PIIX_80C_PRI		= (1 << 5) | (1 << 4),
 	PIIX_80C_SEC		= (1 << 7) | (1 << 6),
@@ -377,7 +377,9 @@ static void piix_pata_phy_reset(struct a
  *	None (inherited from caller).
  *
  *	RETURNS:
- *	Non-zero if device detected, zero otherwise.
+ *	Non-zero if port is enabled, it may or may not have a device
+ *	attached in that case (PRESENT bit would only be set if BIOS probe
+ *	was done). Zero is returned if port is disabled.
  */
 static int piix_sata_probe (struct ata_port *ap)
 {
@@ -401,7 +403,7 @@ static int piix_sata_probe (struct ata_p
 	 */
 
 	for (i = 0; i < 4; i++) {
-		mask = (PIIX_PORT_PRESENT << i) | (PIIX_PORT_ENABLED << i);
+		mask = (PIIX_PORT_ENABLED << i);
 
 		if ((orig_mask & mask) == mask)
 			if (combined || (i == ap->hard_port_no))
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -52,7 +52,10 @@ enum {
 	/* PCI configuration registers */
 	SIS_GENCTL		= 0x54, /* IDE General Control register */
 	SIS_SCR_BASE		= 0xc0, /* sata0 phy SCR registers */
-	SIS_SATA1_OFS		= 0x10, /* offset from sata0->sata1 phy regs */
+	SIS180_SATA1_OFS	= 0x10, /* offset from sata0->sata1 phy regs */
+	SIS182_SATA1_OFS	= 0x20, /* offset from sata0->sata1 phy regs */
+	SIS_PMR			= 0x90, /* port mapping register */
+	SIS_PMR_COMBINED	= 0x30, 
 
 	/* random bits */
 	SIS_FLAG_CFGSCR		= (1 << 30), /* host flag: SCRs via PCI cfg */
@@ -67,6 +70,7 @@ static void sis_scr_write (struct ata_po
 static struct pci_device_id sis_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SI, 0x180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 	{ PCI_VENDOR_ID_SI, 0x181, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
+	{ PCI_VENDOR_ID_SI, 0x182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 	{ }	/* terminate list */
 };
 
@@ -139,56 +143,94 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, sis_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg)
+static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg, int device)
 {
 	unsigned int addr = SIS_SCR_BASE + (4 * sc_reg);
 
-	if (port_no)
-		addr += SIS_SATA1_OFS;
+	if (port_no) 
+		if (device == 0x182)
+			addr += SIS182_SATA1_OFS;
+		else
+			addr += SIS180_SATA1_OFS;
 	return addr;
 }
 
 static u32 sis_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg);
-	u32 val;
+	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg, pdev->device);
+	u32 val, val2;
+	u8 pmr;
 
 	if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
 		return 0xffffffff;
+
+	pci_read_config_byte(pdev, SIS_PMR, &pmr);
+	
 	pci_read_config_dword(pdev, cfg_addr, &val);
-	return val;
+
+	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED)) 
+		pci_read_config_dword(pdev, cfg_addr+0x10, &val2);
+
+	return val|val2;
 }
 
 static void sis_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr, pdev->device);
+	u8 pmr;
 
 	if (scr == SCR_ERROR) /* doesn't exist in PCI cfg space */
 		return;
+
+	pci_read_config_byte(pdev, SIS_PMR, &pmr);
+	
 	pci_write_config_dword(pdev, cfg_addr, val);
+
+	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+		pci_write_config_dword(pdev, cfg_addr+0x10, val);
 }
 
 static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	u32 val,val2;
+	u8 pmr;
+
 	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
 
 	if (ap->flags & SIS_FLAG_CFGSCR)
 		return sis_scr_cfg_read(ap, sc_reg);
-	return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
+
+	pci_read_config_byte(pdev, SIS_PMR, &pmr);
+
+	val = inl(ap->ioaddr.scr_addr + (sc_reg * 4));
+
+	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+		val2 = inl(ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
+
+	return val|val2;
 }
 
 static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	u8 pmr;
+
 	if (sc_reg > SCR_CONTROL)
 		return;
 
+	pci_read_config_byte(pdev, SIS_PMR, &pmr);
+	
 	if (ap->flags & SIS_FLAG_CFGSCR)
 		sis_scr_cfg_write(ap, sc_reg, val);
-	else
+	else {
 		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+		if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+			outl(val, ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
+	}
 }
 
 /* move to PCI layer, integrate w/ MSI stuff */
@@ -210,6 +252,8 @@ static int sis_init_one (struct pci_dev 
 	u32 genctl;
 	struct ata_port_info *ppi;
 	int pci_dev_busy = 0;
+	u8 pmr;
+	u8 port2_start;
 
 	rc = pci_enable_device(pdev);
 	if (rc)
@@ -251,11 +295,27 @@ static int sis_init_one (struct pci_dev 
 		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
 	}
 
+	pci_read_config_byte(pdev, SIS_PMR, &pmr);
+	if (ent->device != 0x182) {
+		if ((pmr & SIS_PMR_COMBINED) == 0) {
+			printk(KERN_INFO "sata_sis: Detected SiS 180/181 chipset in SATA mode\n");
+			port2_start=0x64;
+		}
+		else {
+			printk(KERN_INFO "sata_sis: Detected SiS 180/181 chipset in combined mode\n");
+			port2_start=0;
+		}
+	}
+	else {
+		printk(KERN_INFO "sata_sis: Detected SiS 182 chipset\n");
+		port2_start = 0x20;
+	}
+
 	if (!(probe_ent->host_flags & SIS_FLAG_CFGSCR)) {
 		probe_ent->port[0].scr_addr =
 			pci_resource_start(pdev, SIS_SCR_PCI_BAR);
 		probe_ent->port[1].scr_addr =
-			pci_resource_start(pdev, SIS_SCR_PCI_BAR) + 64;
+			pci_resource_start(pdev, SIS_SCR_PCI_BAR) + port2_start;
 	}
 
 	pci_set_master(pdev);
