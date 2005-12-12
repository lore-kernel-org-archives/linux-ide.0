From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] sata_via VT6421 vendor update
Date: Sun, 11 Dec 2005 23:07:29 -0500
Message-ID: <439CF781.3080400@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010304060907060200000506"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751085AbVLLEHi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010304060907060200000506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


VIA contributed the attached update to sata_via, which adds support for 
the third (PATA) port, and switches around the reset method a bit.

I submit this verbatim for review, comment and testing.  My initial 
reaction is positive, though on the negative side the patch removes 
support for the SATA SCRs and doesn't really separate the SATA/PATA 
ports properly.

	Jeff




--------------010304060907060200000506
Content-Type: text/plain;
 name="sata_via.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_via.c.patch"

--- sata_via.c.orig	2005-10-28 13:49:49.000000000 +0800
+++ sata_via.c	2005-10-28 13:46:24.000000000 +0800
@@ -59,7 +59,7 @@
 	PORT0			= (1 << 1),
 	PORT1			= (1 << 0),
 	ALL_PORTS		= PORT0 | PORT1,
-	N_PORTS			= 2,
+	N_PORTS			= 3,
 
 	NATIVE_MODE_ALL		= (1 << 7) | (1 << 6) | (1 << 5) | (1 << 4),
 
@@ -104,9 +104,14 @@
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
 };
+static void via_pata_phy_reset(struct ata_port *ap);
+static void via_pata_set_piomode (struct ata_port *ap, struct ata_device *adev);
+static void via_pata_set_dmamode (struct ata_port *ap, struct ata_device *adev);
 
 static struct ata_port_operations svia_sata_ops = {
 	.port_disable		= ata_port_disable,
+	.set_piomode		= via_pata_set_piomode,
+	.set_dmamode		= via_pata_set_dmamode,
 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -114,7 +119,7 @@
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.phy_reset		= sata_phy_reset,
+	.phy_reset		= via_pata_phy_reset,
 
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
@@ -129,9 +134,6 @@
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
-	.scr_read		= svia_scr_read,
-	.scr_write		= svia_scr_write,
-
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
 };
@@ -196,9 +198,6 @@
 	probe_ent->port[port].ctl_addr = (reg_addr + 8) | ATA_PCI_CTL_OFS;
 	probe_ent->port[port].bmdma_addr = bmdma_addr;
 
-	scr_addr = vt6421_scr_addr(pci_resource_start(pdev, 5), port);
-	probe_ent->port[port].scr_addr = scr_addr;
-
 	ata_std_ports(&probe_ent->port[port]);
 }
 
@@ -233,7 +232,7 @@
 	INIT_LIST_HEAD(&probe_ent->node);
 
 	probe_ent->sht		= &svia_sht;
-	probe_ent->host_flags	= ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
+	probe_ent->host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
 				  ATA_FLAG_NO_LEGACY;
 	probe_ent->port_ops	= &svia_sata_ops;
 	probe_ent->n_ports	= N_PORTS;
@@ -248,6 +247,165 @@
 
 	return probe_ent;
 }
+/* add functions for pata */
+
+
+/**
+ *	via_pata_cbl_detect - Probe host controller cable detect info
+ *	@ap: Port for which cable detect info is desired
+ *
+ *	Read 80c cable indicator from ATA PCI device's PCI config
+ *	register.  This register is normally set by firmware (BIOS).
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+static void via_pata_cbl_detect(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	int cfg_addr;
+	u8 tmp, mask;
+
+	if (ap->port_no == 2) { /* PATA channel in VT6421 */
+		ap->cbl = ATA_CBL_PATA80;
+		cfg_addr = 0xB3;
+		pci_read_config_byte(pdev, cfg_addr, &tmp);
+		if (tmp & 0x10) { /* 40pin cable */
+			ap->cbl = ATA_CBL_PATA40;
+		} else { /* 80pin cable */
+			ap->cbl = ATA_CBL_PATA80;
+		}
+	} else { /* channel 0 and 1 are SATA channels */
+		ap->cbl = ATA_CBL_SATA;
+	}
+
+	return;
+}
+
+/**
+ *	via_pata_phy_reset - Probe specified port on PATA host controller
+ *	@ap: Port to probe
+ *
+ *	Probe PATA phy.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void via_pata_phy_reset(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+
+	via_pata_cbl_detect(ap);
+
+	ata_port_probe(ap);
+
+	ata_bus_reset(ap);
+}
+
+
+/**
+ *	via_pata_set_piomode - Initialize host controller PATA PIO timings
+ *	@ap: Port whose timings we are configuring
+ *	@adev: um
+ *	@pio: PIO mode, 0 - 4
+ *
+ *	Set PIO mode for device, in host controller PCI config space.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void via_pata_set_piomode (struct ata_port *ap, struct ata_device *adev)
+{
+	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
+
+	u8 cfg_byte;
+	int cfg_addr;
+
+	if (ap->port_no != 2) { /* SATA channel in VT6421 */
+		/* no need to set */
+		return;
+	}
+
+
+ 	cfg_addr = 0xAB;
+	switch (adev->pio_mode & 0x07) {
+		case 0:
+			cfg_byte = 0xa8;
+			break;
+		case 1:
+			cfg_byte = 0x65;
+			break;
+		case 2:
+			cfg_byte = 0x65;
+			break;
+		case 3:
+			cfg_byte = 0x31;
+			break;
+		case 4:
+			cfg_byte = 0x20;
+			break;
+		default:
+			cfg_byte = 0x20;
+	}
+
+	pci_write_config_byte (dev, cfg_addr, cfg_byte);
+}
+
+/**
+ *	via_pata_set_dmamode - Initialize host controller PATA PIO timings
+ *	@ap: Port whose timings we are configuring
+ *	@adev: um
+ *	@udma: udma mode, 0 - 6
+ *
+ *	Set UDMA mode for device, in host controller PCI config space.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void via_pata_set_dmamode (struct ata_port *ap, struct ata_device *adev)
+{
+	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
+
+	u8 cfg_byte;
+	int cfg_addr;
+
+	if (ap->port_no != 2) { /* SATA channel in VT6421 */
+		/* no need to set */
+		return;
+	}
+
+ 	cfg_addr = 0xB3;
+	switch (adev->dma_mode & 0x07) {
+		case 0:
+			cfg_byte = 0xee;
+			break;	
+		case 1:
+			cfg_byte = 0xe8;
+			break;	
+		case 2:
+			cfg_byte = 0xe6;
+			break;	
+		case 3:
+			cfg_byte = 0xe4;
+			break;	
+		case 4:
+			cfg_byte = 0xe2;
+			break;	
+		case 5:
+			cfg_byte = 0xe1;
+			break;	
+		case 6:
+			cfg_byte = 0xe0;
+			break;	
+		default:
+			cfg_byte = 0xe0;
+	}
+
+	pci_write_config_byte (dev, cfg_addr, cfg_byte);
+}
 
 static void svia_configure(struct pci_dev *pdev)
 {

--------------010304060907060200000506--
