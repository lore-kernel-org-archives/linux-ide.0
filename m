From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (2.6.20) pata_mpiix: probing cleanup
Date: Mon, 5 Feb 2007 20:57:24 +0300
Message-ID: <200702052057.24688.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:16371 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751994AbXBER5i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 12:57:38 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

MPIIX has only single channel IDE which can be configured for either primary or
secondary legacy I/O ports and IRQ.  So, get rid of the unneeded second probe
entry in mpiix_init_one() and of the invalid (but unused anyway) enable bits in
mpiix_pre_reset().

Warning: this cleanup has only been compile-tested...

 drivers/ata/pata_mpiix.c |   63 ++++++++++++++++++++---------------------------
 1 files changed, 27 insertions(+), 36 deletions(-)

Index: linux-2.6/drivers/ata/pata_mpiix.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_mpiix.c
+++ linux-2.6/drivers/ata/pata_mpiix.c
@@ -35,7 +35,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_mpiix"
-#define DRV_VERSION "0.7.4"
+#define DRV_VERSION "0.7.5"
 
 enum {
 	IDETIM = 0x6C,		/* IDE control register */
@@ -49,12 +49,9 @@ enum {
 static int mpiix_pre_reset(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	static const struct pci_bits mpiix_enable_bits[] = {
-		{ 0x6D, 1, 0x80, 0x80 },
-		{ 0x6F, 1, 0x80, 0x80 }
-	};
+	static const struct pci_bits mpiix_enable_bits = { 0x6D, 1, 0x80, 0x80 };
 
-	if (!pci_test_config_bits(pdev, &mpiix_enable_bits[ap->port_no]))
+	if (!pci_test_config_bits(pdev, &mpiix_enable_bits))
 		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
@@ -202,10 +199,9 @@ static struct ata_port_operations mpiix_
 static int mpiix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	/* Single threaded by the PCI probe logic */
-	static struct ata_probe_ent probe[2];
+	static struct ata_probe_ent probe;
 	static int printed_version;
 	u16 idetim;
-	int enabled;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &dev->dev, "version " DRV_VERSION "\n");
@@ -224,37 +220,32 @@ static int mpiix_init_one(struct pci_dev
 	   without BARs set fools the setup.  #2 If you pci_disable_device
 	   the MPIIX your box goes castors up */
 
-	INIT_LIST_HEAD(&probe[0].node);
-	probe[0].dev = pci_dev_to_dev(dev);
-	probe[0].port_ops = &mpiix_port_ops;
-	probe[0].sht = &mpiix_sht;
-	probe[0].pio_mask = 0x1F;
-	probe[0].irq = 14;
-	probe[0].irq_flags = SA_SHIRQ;
-	probe[0].port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
-	probe[0].n_ports = 1;
-	probe[0].port[0].cmd_addr = 0x1F0;
-	probe[0].port[0].ctl_addr = 0x3F6;
-	probe[0].port[0].altstatus_addr = 0x3F6;
-
-	/* The secondary lurks at different addresses but is otherwise
-	   the same beastie */
-
-	INIT_LIST_HEAD(&probe[1].node);
-	probe[1] = probe[0];
-	probe[1].irq = 15;
-	probe[1].port[0].cmd_addr = 0x170;
-	probe[1].port[0].ctl_addr = 0x376;
-	probe[1].port[0].altstatus_addr = 0x376;
+	INIT_LIST_HEAD(&probe.node);
+	probe.dev = pci_dev_to_dev(dev);
+	probe.port_ops = &mpiix_port_ops;
+	probe.sht = &mpiix_sht;
+	probe.pio_mask = 0x1F;
+	probe.irq_flags = SA_SHIRQ;
+	probe.port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
+	probe.n_ports = 1;
+
+	/* See if it's primary or secondary channel... */
+	if (idetim & SECONDARY) {
+		probe.irq = 15;
+		probe.port[0].cmd_addr = 0x170;
+		probe.port[0].ctl_addr = 0x376;
+		probe.port[0].altstatus_addr = 0x376;
+	} else {
+		probe.irq = 14;
+		probe.port[0].cmd_addr = 0x1F0;
+		probe.port[0].ctl_addr = 0x3F6;
+		probe.port[0].altstatus_addr = 0x3F6;
+	}
 
 	/* Let libata fill in the port details */
-	ata_std_ports(&probe[0].port[0]);
-	ata_std_ports(&probe[1].port[0]);
+	ata_std_ports(&probe.port[0]);
 
-	/* Now add the port that is active */
-	enabled = (idetim & SECONDARY) ? 1 : 0;
-
-	if (ata_device_add(&probe[enabled]))
+	if (ata_device_add(&probe))
 		return 0;
 	return -ENODEV;
 }

