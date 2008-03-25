From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 2/2] libata: power off unused ports
Date: Tue, 25 Mar 2008 15:28:13 -0700
Message-ID: <20080325152813.0b34761f@appleyard>
References: <20080325221646.567639335@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46231 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756745AbYCYWdK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Mar 2008 18:33:10 -0400
In-Reply-To: <20080325221646.567639335@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, arjan@linux.intel.com, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

If a port doesn't support hot plug, there's no reason to keep the phy powered
on unoccupied ports.  

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Index: linux-2.6.25-rc3/drivers/ata/ahci.c
===================================================================
--- linux-2.6.25-rc3.orig/drivers/ata/ahci.c
+++ linux-2.6.25-rc3/drivers/ata/ahci.c
@@ -52,6 +52,7 @@
 static int ahci_enable_alpm(struct ata_port *ap,
 		enum link_pm policy);
 static void ahci_disable_alpm(struct ata_port *ap);
+static int ahci_is_hotplug_capable(struct ata_port *ap);
 
 enum {
 	AHCI_PCI_BAR		= 5,
@@ -163,6 +164,7 @@ enum {
 	PORT_CMD_ASP		= (1 << 27), /* Aggressive Slumber/Partial */
 	PORT_CMD_ALPE		= (1 << 26), /* Aggressive Link PM enable */
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
+	PORT_CMD_HPCP		= (1 << 18), /* port is hot plug capable */
 	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
@@ -783,6 +785,15 @@ static int ahci_scr_write(struct ata_por
 	return -EINVAL;
 }
 
+static int ahci_is_hotplug_capable(struct ata_port *ap)
+{
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u8 cmd;
+
+	cmd = readl(port_mmio + PORT_CMD);
+	return (cmd & PORT_CMD_HPCP);
+}
+
 static int ahci_is_device_present(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
@@ -2060,6 +2071,9 @@ static int ahci_port_start(struct ata_po
 
 	ap->private_data = pp;
 
+	/* set some flags based on port capabilities */
+	if (!ahci_is_hotplug_capable(ap))
+		ap->flags |= ATA_FLAG_NO_HOTPLUG;
 	/* engage engines, captain */
 	return ahci_port_resume(ap);
 }
Index: linux-2.6.25-rc3/drivers/ata/libata-core.c
===================================================================
--- linux-2.6.25-rc3.orig/drivers/ata/libata-core.c
+++ linux-2.6.25-rc3/drivers/ata/libata-core.c
@@ -1004,6 +1004,19 @@ static void ata_lpm_disable(struct ata_h
 }
 #endif	/* CONFIG_PM */
 
+static void ata_phy_offline(struct ata_link *link)
+{
+	u32 scontrol;
+	int rc;
+
+	/* set DET to 4 */
+	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
+	if (rc)
+		return;
+	scontrol &= ~0xf;
+	scontrol |= (1 << 2);
+	sata_scr_write(link, SCR_CONTROL, scontrol);
+}
 
 /**
  *	ata_devchk - PATA device presence detection
@@ -2812,6 +2825,7 @@ void ata_port_disable(struct ata_port *a
 	ap->link.device[0].class = ATA_DEV_NONE;
 	ap->link.device[1].class = ATA_DEV_NONE;
 	ap->flags |= ATA_FLAG_DISABLED;
+	ata_phy_offline(&ap->link);
 }
 
 /**
@@ -7111,6 +7125,8 @@ int ata_host_register(struct ata_host *h
 		if (ap->ops->error_handler) {
 			struct ata_eh_info *ehi = &ap->link.eh_info;
 			unsigned long flags;
+			int device_attached = 0;
+			struct ata_device *dev;
 
 			ata_port_probe(ap);
 
@@ -7130,6 +7146,14 @@ int ata_host_register(struct ata_host *h
 
 			/* wait for EH to finish */
 			ata_port_wait_eh(ap);
+			ata_link_for_each_dev(dev, &ap->link)
+				if (ata_dev_enabled(dev))
+					device_attached++;
+			if (!device_attached &&
+			    (ap->flags & ATA_FLAG_NO_HOTPLUG)) {
+				/* no device present, disable port */
+				ata_port_disable(ap);
+			}
 		} else {
 			DPRINTK("ata%u: bus probe begin\n", ap->print_id);
 			rc = ata_bus_probe(ap);
Index: linux-2.6.25-rc3/include/linux/libata.h
===================================================================
--- linux-2.6.25-rc3.orig/include/linux/libata.h
+++ linux-2.6.25-rc3/include/linux/libata.h
@@ -194,6 +194,7 @@ enum {
 	ATA_FLAG_AN		= (1 << 18), /* controller supports AN */
 	ATA_FLAG_PMP		= (1 << 19), /* controller supports PMP */
 	ATA_FLAG_IPM		= (1 << 20), /* driver can handle IPM */
+	ATA_FLAG_NO_HOTPLUG	= (1 << 21), /* port doesn't support HP */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be

-- 
