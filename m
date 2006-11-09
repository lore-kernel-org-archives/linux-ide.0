From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: [PATCH] sata_via: add VT6421 PATA support
Date: Thu, 09 Nov 2006 15:35:02 +0100
Message-ID: <45533C96.1080109@wpkg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020906010607070809050900"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:17288 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP id S966013AbWKIOfW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Nov 2006 09:35:22 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

This is a multi-part message in MIME format.
--------------020906010607070809050900
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds VT6421 PATA support to sata_via.

If we don't want to enable PATA support, nothing is changed in sata_via 
driver:

<M> VIA SATA support
      [ ]   VT6421 PATA support (HIGHLY EXPERIMENTAL)


The patch is based on the patch from VIA.


It applies to 2.6.18.2, if someone wants, I can make it work with 
2.6.19-rc5.


-- 
Tomasz Chmielewski

--------------020906010607070809050900
Content-Type: text/plain;
 name="patch.sata_via-vt6421_pata"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.sata_via-vt6421_pata"

diff -uprN linux-2.6.18.2/drivers/scsi/Kconfig linux-2.6.18.2.new/drivers/scsi/Kconfig
--- linux-2.6.18.2/drivers/scsi/Kconfig	2006-11-04 02:33:58.000000000 +0100
+++ linux-2.6.18.2.new/drivers/scsi/Kconfig	2006-11-09 11:56:12.000000000 +0100
@@ -606,6 +606,14 @@ config SCSI_SATA_VIA
 
 	  If unsure, say N.
 
+config SCSI_VT6421_PATA
+        bool "VT6421 PATA support (HIGHLY EXPERIMENTAL)"
+        depends on SCSI_SATA_VIA
+        help
+          This option enables support for PATA on VT6421 chips.
+
+          If unsure, say N.
+
 config SCSI_SATA_VITESSE
 	tristate "VITESSE VSC-7174 / INTEL 31244 SATA support"
 	depends on SCSI_SATA && PCI
diff -uprN linux-2.6.18.2/drivers/scsi/sata_via.c linux-2.6.18.2.new/drivers/scsi/sata_via.c
--- linux-2.6.18.2/drivers/scsi/sata_via.c	2006-11-04 02:33:58.000000000 +0100
+++ linux-2.6.18.2.new/drivers/scsi/sata_via.c	2006-11-09 12:43:59.000000000 +0100
@@ -3,7 +3,7 @@
  *
  *  Maintained by:  Jeff Garzik <jgarzik@pobox.com>
  * 		   Please ALWAYS copy linux-ide@vger.kernel.org
- 		   on emails.
+ *		   on emails.
  *
  *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
  *  Copyright 2003-2004 Jeff Garzik
@@ -29,10 +29,6 @@
  *
  *  Hardware documentation available under NDA.
  *
- *
- *  To-do list:
- *  - VT6421 PATA support
- *
  */
 
 #include <linux/kernel.h>
@@ -63,7 +59,12 @@ enum {
 	PORT0			= (1 << 1),
 	PORT1			= (1 << 0),
 	ALL_PORTS		= PORT0 | PORT1,
+	
+#ifndef CONFIG_SCSI_VT6421_PATA
 	N_PORTS			= 2,
+#else
+	N_PORTS			= 3,
+#endif
 
 	NATIVE_MODE_ALL		= (1 << 7) | (1 << 6) | (1 << 5) | (1 << 4),
 
@@ -109,9 +110,18 @@ static struct scsi_host_template svia_sh
 	.bios_param		= ata_std_bios_param,
 };
 
+#ifdef CONFIG_SCSI_VT6421_PATA
+static void via_pata_phy_reset(struct ata_port *ap);
+static void via_pata_set_piomode(struct ata_port *ap, struct ata_device *adev);
+static void via_pata_set_dmamode(struct ata_port *ap, struct ata_device *adev);
+#endif
+
 static const struct ata_port_operations vt6420_sata_ops = {
 	.port_disable		= ata_port_disable,
-
+#ifdef CONFIG_SCSI_VT6421_PATA
+	.set_piomode            = via_pata_set_piomode,
+	.set_dmamode            = via_pata_set_dmamode,
+#endif
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
@@ -309,8 +319,10 @@ static void vt6421_init_addrs(struct ata
 	probe_ent->port[port].ctl_addr = (reg_addr + 8) | ATA_PCI_CTL_OFS;
 	probe_ent->port[port].bmdma_addr = bmdma_addr;
 
+#ifndef CONFIG_SCSI_VT6421_PATA
 	scr_addr = vt6421_scr_addr(pci_resource_start(pdev, 5), port);
 	probe_ent->port[port].scr_addr = scr_addr;
+#endif
 
 	ata_std_ports(&probe_ent->port[port]);
 }
@@ -346,7 +358,12 @@ static struct ata_probe_ent *vt6421_init
 	INIT_LIST_HEAD(&probe_ent->node);
 
 	probe_ent->sht		= &svia_sht;
+#ifndef CONFIG_SCSI_VT6421_PATA
 	probe_ent->host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY;
+#else
+	probe_ent->host_flags   = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
+				  ATA_FLAG_NO_LEGACY;
+#endif
 	probe_ent->port_ops	= &vt6421_sata_ops;
 	probe_ent->n_ports	= N_PORTS;
 	probe_ent->irq		= pdev->irq;
@@ -361,6 +378,166 @@ static struct ata_probe_ent *vt6421_init
 	return probe_ent;
 }
 
+/* add functions for pata */
+
+
+/**
+ *     via_pata_cbl_detect - Probe host controller cable detect info
+ *     @ap: Port for which cable detect info is desired
+ *
+ *     Read 80c cable indicator from ATA PCI device's PCI config
+ *     register.  This register is normally set by firmware (BIOS).
+ *
+ *     LOCKING:
+ *     None (inherited from caller).
+ */
+static void via_pata_cbl_detect(struct ata_port *ap)
+{
+       struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+       int cfg_addr;
+       u8 tmp, mask;
+
+       if (ap->port_no == 2) { /* PATA channel in VT6421 */
+               ap->cbl = ATA_CBL_PATA80;
+               cfg_addr = 0xB3;
+               pci_read_config_byte(pdev, cfg_addr, &tmp);
+               if (tmp & 0x10) { /* 40pin cable */
+                       ap->cbl = ATA_CBL_PATA40;
+               } else { /* 80pin cable */
+                       ap->cbl = ATA_CBL_PATA80;
+               }
+       } else { /* channel 0 and 1 are SATA channels */
+               ap->cbl = ATA_CBL_SATA;
+       }
+
+       return;
+}
+
+/**
+ *     via_pata_phy_reset - Probe specified port on PATA host controller
+ *     @ap: Port to probe
+ *
+ *     Probe PATA phy.
+ *
+ *     LOCKING:
+ *     None (inherited from caller).
+ */
+
+static void via_pata_phy_reset(struct ata_port *ap)
+{
+       struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+
+       via_pata_cbl_detect(ap);
+
+       ata_port_probe(ap);
+
+       ata_bus_reset(ap);
+}
+
+
+/**
+ *     via_pata_set_piomode - Initialize host controller PATA PIO timings
+ *     @ap: Port whose timings we are configuring
+ *     @adev: um
+ *     @pio: PIO mode, 0 - 4
+ *
+ *     Set PIO mode for device, in host controller PCI config space.
+ *
+ *     LOCKING:
+ *     None (inherited from caller).
+ */
+
+static void via_pata_set_piomode (struct ata_port *ap, struct ata_device *adev)
+{
+       struct pci_dev *dev     = to_pci_dev(ap->host_set->dev);
+
+       u8 cfg_byte;
+       int cfg_addr;
+
+       if (ap->port_no != 2) { /* SATA channel in VT6421 */
+               /* no need to set */
+               return;
+       }
+
+
+       cfg_addr = 0xAB;
+       switch (adev->pio_mode & 0x07) {
+               case 0:
+                       cfg_byte = 0xa8;
+                       break;
+               case 1:
+                       cfg_byte = 0x65;
+                       break;
+               case 2:
+                       cfg_byte = 0x65;
+                       break;
+               case 3:
+                       cfg_byte = 0x31;
+                       break;
+               case 4:
+                       cfg_byte = 0x20;
+                       break;
+               default:
+                       cfg_byte = 0x20;
+       }
+
+       pci_write_config_byte (dev, cfg_addr, cfg_byte);
+}
+
+/**
+ *     via_pata_set_dmamode - Initialize host controller PATA PIO timings
+ *     @ap: Port whose timings we are configuring
+ *     @adev: um
+ *     @udma: udma mode, 0 - 6
+ *
+ *     Set UDMA mode for device, in host controller PCI config space.
+ *
+ *     LOCKING:
+ *     None (inherited from caller).
+ */
+
+static void via_pata_set_dmamode (struct ata_port *ap, struct ata_device *adev)
+{
+       struct pci_dev *dev     = to_pci_dev(ap->host_set->dev);
+
+       u8 cfg_byte;
+       int cfg_addr;
+
+       if (ap->port_no != 2) { /* SATA channel in VT6421 */
+               /* no need to set */
+               return;
+       }
+
+       cfg_addr = 0xB3;
+       switch (adev->dma_mode & 0x07) {
+               case 0:
+                       cfg_byte = 0xee;
+                       break;
+               case 1:
+                       cfg_byte = 0xe8;
+                       break;
+               case 2:
+                       cfg_byte = 0xe6;
+                       break;
+               case 3:
+                       cfg_byte = 0xe4;
+                       break;
+               case 4:
+                       cfg_byte = 0xe2;
+                       break;
+               case 5:
+                       cfg_byte = 0xe1;
+                       break;
+               case 6:
+                       cfg_byte = 0xe0;
+                       break;
+               default:
+                       cfg_byte = 0xe0;
+       }
+
+       pci_write_config_byte (dev, cfg_addr, cfg_byte);
+}
+
 static void svia_configure(struct pci_dev *pdev)
 {
 	u8 tmp8;

--------------020906010607070809050900--
