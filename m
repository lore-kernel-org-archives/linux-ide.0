From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [RFT] sata_promise: intermittent errors bug hunting
Date: Tue, 27 Feb 2007 23:25:41 +0100 (MET)
Message-ID: <200702272225.l1RMPfSt021674@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:62245 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956AbXB0WZv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Feb 2007 17:25:51 -0500
Received: from harpo.it.uu.se (daemon@harpo.it.uu.se [130.238.12.34])
	by aun.it.uu.se (8.13.6/8.13.6) with ESMTP id l1RMPfc3008554
	for <linux-ide@vger.kernel.org>; Tue, 27 Feb 2007 23:25:41 +0100 (MET)
Received: (from mikpe@localhost)
	by harpo.it.uu.se (8.13.8+Sun/8.13.7) id l1RMPfSt021674
	for linux-ide@vger.kernel.org; Tue, 27 Feb 2007 23:25:41 +0100 (MET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

There have been some reports of intermittent errors
with sata_promise, especially with newer disks.
My theory is that the driver isn't initialisating the
controller properly for SATAII 3Gbps transfer speeds.

It would be helpful if people seeing intermittent errors
with sata_promise could do the following:

1. Check if affected disks have jumpers for selecting
   between 1.5Gbps and 3Gbps operation, and adjust the
   jumpers for 1.5Gbps operation.

   This is exactly what happened to me last year:
   I replaced an older SATA disk with a new Seagate SATAII
   disk on a SATA 300 TX2plus controller, and immediately
   started getting errors. Resetting the disk's jumper to
   1.5Gbps operation eliminated the problems.
   
2. Try the patch included below, on top of a 2.6.21-rc1
   or newer kernel. This patch ports all initialisation
   quirks I could find in Promise's SATAII driver to
   sata_promise. I've tested it and the one quirk that does
   seem to actually change something is the "phy quality"
   reprogramming.

   If you find that this patch makes a difference, you can
   then test each quirk individually simply by editing the
   "#if 1" that precedes the quirk.

/Mikael

--- linux-2.6.21-rc1/drivers/ata/sata_promise.c.~1~	2007-02-27 18:22:49.000000000 +0100
+++ linux-2.6.21-rc1/drivers/ata/sata_promise.c	2007-02-27 21:51:23.000000000 +0100
@@ -113,6 +113,7 @@ struct pdc_port_priv {
 struct pdc_host_priv {
 	unsigned long		flags;
 	unsigned long		port_flags[ATA_MAX_PORTS];
+	unsigned char		asic_rev;
 };
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -349,6 +350,22 @@ static int pdc_port_start(struct ata_por
 		writel(tmp, mmio + 0x014);
 	}
 
+#if 1
+	/* set suitable value for PHY quality */
+	if ((hp->flags & PDC_FLAG_GEN_II) && sata_scr_valid(ap)) {
+		void __iomem *mmio = ap->ioaddr.scr_addr;
+		unsigned int tmp;
+
+		tmp = readl(mmio + 0x02C);
+		printk("%s: port %u: Old PHY Quality: %#x\n",
+		       __FUNCTION__, ap->port_no, tmp);
+		tmp = 0x405500A0;
+		printk("%s: port %u: New PHY Quality: %#x\n",
+		       __FUNCTION__, ap->port_no, tmp);
+		writel(tmp, mmio + 0x02C); /* PHY Quality Reg */
+	}
+#endif
+
 	return 0;
 }
 
@@ -830,6 +847,17 @@ static void pdc_host_init(unsigned int c
 	tmp = readl(mmio + hotplug_offset);
 	writel(tmp | 0xff0000, mmio + hotplug_offset);
 
+#if 1
+	/* disable BMR burst on 2nd generation chips prior to revision 2 */
+	if ((hp->flags & PDC_FLAG_GEN_II) && hp->asic_rev < 2) {
+		tmp = readl(mmio + PDC_FLASH_CTL);
+		tmp &= ~0x02000;	/* disable bmr burst */
+		writel(tmp, mmio + PDC_FLASH_CTL);
+		printk("%s: disabled BMR burst due to asic_rev %d\n",
+		       __FUNCTION__, hp->asic_rev);
+	}
+#endif
+
 	/* don't initialise TBG or SLEW on 2nd generation chips */
 	if (hp->flags & PDC_FLAG_GEN_II)
 		return;
@@ -945,6 +973,28 @@ static int pdc_ata_init_one (struct pci_
 		break;
 	}
 
+	if (hp->flags & PDC_FLAG_GEN_II) {
+		/* record ASIC rev */
+		pci_read_config_byte(pdev, PCI_REVISION_ID, &hp->asic_rev);
+
+#if 1
+		/* set cache line size = 1 */
+		pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &tmp);
+		printk("%s: changing pci_cache_line_size from %#02x to 0x01\n",
+		       __FUNCTION__, tmp);
+		pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x01);
+#endif
+
+#if 1
+		/* set WMI = 1 */
+		pci_read_config_byte(pdev, 0x42, &tmp);
+		printk("%s: changing pci config byte 0x42 from %#02x to %#02x\n",
+		       __FUNCTION__, tmp, tmp | 0x04);
+		tmp |= 0x04;
+		pci_write_config_byte(pdev, 0x42, tmp);
+#endif
+	}
+
 	pci_set_master(pdev);
 
 	/* initialize adapter */
