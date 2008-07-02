From: kristen.c.accardi@intel.com
Subject: [patch 2/2] set default of ahci driver to power off unused ports
Date: Wed, 2 Jul 2008 16:14:07 -0700
Message-ID: <20080702161407.13be7fc9@appleyard>
References: <20080702225743.518230210@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38654 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752432AbYGBXQA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jul 2008 19:16:00 -0400
In-Reply-To: <20080702225743.518230210@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

If the port isn't either a drive bay or an external SATA port, 
mark the port not-hotpluggable.  This will cause libata to 
power off the phy if it is unoccupied. This saves .75 watts
on most laptops.  A module parameter can be used to override this 
behavior and allow the phy's to be powered up regardless of whether it
has externally accessible SATA ports. 

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 drivers/ata/ahci.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

Index: linux-ahci-phy/drivers/ata/ahci.c
===================================================================
--- linux-ahci-phy.orig/drivers/ata/ahci.c	2008-07-01 16:27:56.000000000 -0700
+++ linux-ahci-phy/drivers/ata/ahci.c	2008-07-01 16:35:03.000000000 -0700
@@ -53,9 +53,13 @@ static int ahci_skip_host_reset;
 module_param_named(skip_host_reset, ahci_skip_host_reset, int, 0444);
 MODULE_PARM_DESC(skip_host_reset, "skip global host reset (0=don't skip, 1=skip)");
 
+static int ahci_power_save = 1;
+module_param_named(power_save, ahci_power_save, int, 0444);
+MODULE_PARM_DESC(power_save, "Power off unused ports (0=don't power off, 1=power off)");
 static int ahci_enable_alpm(struct ata_port *ap,
 		enum link_pm policy);
 static void ahci_disable_alpm(struct ata_port *ap);
+static int ahci_is_hotplug_capable(struct ata_port *ap);
 
 enum {
 	AHCI_PCI_BAR		= 5,
@@ -168,6 +172,8 @@ enum {
 	PORT_CMD_ASP		= (1 << 27), /* Aggressive Slumber/Partial */
 	PORT_CMD_ALPE		= (1 << 26), /* Aggressive Link PM enable */
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
+	PORT_CMD_ESP		= (1 << 21), /* External SATA Port */
+	PORT_CMD_HPCP		= (1 << 18), /* port is hot plug capable */
 	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
@@ -1998,6 +2004,18 @@ static int ahci_pci_device_resume(struct
 }
 #endif
 
+static int ahci_is_hotplug_capable(struct ata_port *ap)
+{
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u8 cmd;
+
+	if (!ahci_power_save)
+		return 1;
+
+	cmd = readl(port_mmio + PORT_CMD);
+	return ((cmd & PORT_CMD_HPCP) || (cmd & PORT_CMD_ESP));
+}
+
 static int ahci_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host->dev;
@@ -2049,6 +2067,9 @@ static int ahci_port_start(struct ata_po
 
 	ap->private_data = pp;
 
+	/* set some flags based on port capabilities */
+	if (!ahci_is_hotplug_capable(ap))
+		ap->flags |= ATA_FLAG_NO_HOTPLUG;
 	/* engage engines, captain */
 	return ahci_port_resume(ap);
 }

-- 
