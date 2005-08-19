From: Arnaud Patard <apatard@mandriva.com>
Subject: [RFC][PATCH] add support for SIS 182 sata chipset in sata sis
Date: Fri, 19 Aug 2005 18:39:20 +0200
Message-ID: <m31x4pkhjb.fsf@anduin.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ezoffice.mandriva.com ([84.14.106.134]:24588 "EHLO
	anduin.mandrakesoft.com") by vger.kernel.org with ESMTP
	id S932345AbVHSQgf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Aug 2005 12:36:35 -0400
Received: from anduin.mandrakesoft.com (localhost [127.0.0.1])
	by anduin.mandrakesoft.com (Postfix) with ESMTP id 9DCE4FF87A
	for <linux-ide@vger.kernel.org>; Fri, 19 Aug 2005 18:39:20 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--=-=-=

Hi,


I got recently a motherboard shipped with the SATA SIS 182 chipset. This
chipset is not supported by the kernel. I tried to just add the PCI IDS
in the supported chipset list as suggested on some mails in this
list but it didn't work for the hard drive connected on the second sata port.

I found that this has been reported on
http://bugme.osdl.org/show_bug.cgi?id=4192. Unfortunately the patch
didn't apply to the recents kernel. So, I've written a new minimal patch that
add support for this chipset. 

It works well on the machine I have with a 2.6.12.5 kernel but I was not
able to test it on SIS 180/181 chipset (I don't have the hardware). 

imho having support for this chipset in the kernel could be usefull, so
any feedback/comments are welcome. 

Regards,
Arnaud Patard



Signed-off-by: Arnaud Patard <apatard@mandriva.com>
 ---


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=add_support_sis182.patch

--- linux/drivers/scsi/sata_sis.c.orig	2005-08-11 08:54:58.000000000 -0400
+++ linux/drivers/scsi/sata_sis.c	2005-08-19 04:59:17.000000000 -0400
@@ -47,7 +47,10 @@ enum {
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
@@ -62,6 +65,7 @@ static void sis_scr_write (struct ata_po
 static struct pci_device_id sis_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SI, 0x180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 	{ PCI_VENDOR_ID_SI, 0x181, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
+	{ PCI_VENDOR_ID_SI, 0x182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 	{ }	/* terminate list */
 };
 
@@ -134,56 +138,94 @@ MODULE_LICENSE("GPL");
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
@@ -205,6 +247,8 @@ static int sis_init_one (struct pci_dev 
 	u32 genctl;
 	struct ata_port_info *ppi;
 	int pci_dev_busy = 0;
+	u8 pmr;
+	u8 port2_start;
 
 	rc = pci_enable_device(pdev);
 	if (rc)
@@ -246,11 +290,21 @@ static int sis_init_one (struct pci_dev 
 		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
 	}
 
+	pci_read_config_byte(pdev, SIS_PMR, &pmr);
+	if (ent->device != 0x182) {
+		if ((pmr & SIS_PMR_COMBINED) == 0)
+			port2_start=0x64;
+		else
+			port2_start=0;
+	}
+	else
+		port2_start = 0x20;
+
 	if (!(probe_ent->host_flags & SIS_FLAG_CFGSCR)) {
 		probe_ent->port[0].scr_addr =
 			pci_resource_start(pdev, SIS_SCR_PCI_BAR);
 		probe_ent->port[1].scr_addr =
-			pci_resource_start(pdev, SIS_SCR_PCI_BAR) + 64;
+			pci_resource_start(pdev, SIS_SCR_PCI_BAR) + port2_start;
 	}
 
 	pci_set_master(pdev);

--=-=-=--

