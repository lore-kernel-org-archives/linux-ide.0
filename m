From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2 #upstream] ahci: honor PORTS_IMPL on ICH8s
Date: Thu, 2 Nov 2006 12:20:59 +0900
Message-ID: <20061102032059.GW13677@htj.dyndns.org>
References: <20061102031723.GV13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:7381 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750885AbWKBDVJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 22:21:09 -0500
Received: by ug-out-1314.google.com with SMTP id m3so29302ugc
        for <linux-ide@vger.kernel.org>; Wed, 01 Nov 2006 19:21:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20061102031723.GV13677@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, robbat2@gentoo.org
Cc: linux-ide@vger.kernel.org

Some ICH8s use non-linear port mapping.  ahci driver didn't use to
honor PORTS_IMPL and this made ports after hole nonfunctional.  This
patch makes ahci mark those ports as dummy and properly initialize all
the implemented ports after the dummies.

As it's unknown whether other AHCIs implement PORTS_IMPL register
properly, new board id board_ahci_pi is added and selectively applied
to ICH8s.  All other AHCIs continue to use linear mapping regardless
of PORTS_IMPL value.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Robin H. Johnson <robbat2@gentoo.org>
---
Updated to mark unimplemented ports as dummies.  Tested on ICH7
(consecutive mapping) and ICH8 (inconsecutive mapping).  Error paths
are tested too.

Thanks.

 drivers/ata/ahci.c |   71 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 16 deletions(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -53,6 +53,7 @@
 
 enum {
 	AHCI_PCI_BAR		= 5,
+	AHCI_MAX_PORTS		= 32,
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
 	AHCI_DMA_BOUNDARY	= 0xffffffff,
 	AHCI_USE_CLUSTERING	= 0,
@@ -77,7 +78,8 @@ enum {
 	RX_FIS_UNK		= 0x60, /* offset of Unknown FIS data */
 
 	board_ahci		= 0,
-	board_ahci_vt8251	= 1,
+	board_ahci_pi		= 1,
+	board_ahci_vt8251	= 2,
 
 	/* global controller registers */
 	HOST_CAP		= 0x00, /* host capabilities */
@@ -166,6 +168,7 @@ enum {
 	AHCI_FLAG_MSI		= (1 << 0),
 
 	/* ap->flags bits */
+	AHCI_FLAG_HONOR_PI		= (1 << 23), /* honor PORTS_IMPL */
 	AHCI_FLAG_NO_NCQ		= (1 << 24),
 };
 
@@ -315,6 +318,16 @@ static const struct ata_port_info ahci_p
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
 	},
+	/* board_ahci_pi */
+	{
+		.sht		= &ahci_sht,
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
+				  ATA_FLAG_SKIP_D2H_BSY | AHCI_FLAG_HONOR_PI,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &ahci_ops,
+	},
 	/* board_ahci_vt8251 */
 	{
 		.sht		= &ahci_sht,
@@ -340,11 +353,11 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0x2682), board_ahci }, /* ESB2 */
 	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci }, /* ESB2 */
 	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci }, /* ICH7-M DH */
-	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci }, /* ICH8M */
-	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci }, /* ICH8M */
+	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci_pi }, /* ICH8 */
+	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_pi }, /* ICH8 */
+	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci_pi }, /* ICH8 */
+	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci_pi }, /* ICH8M */
+	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci_pi }, /* ICH8M */
 
 	/* JMicron */
 	{ PCI_VDEVICE(JMICRON, 0x2360), board_ahci }, /* JMicron JMB360 */
@@ -659,7 +672,8 @@ static int ahci_reset_controller(void __
 }
 
 static void ahci_init_controller(void __iomem *mmio, struct pci_dev *pdev,
-				 int n_ports, u32 cap)
+				 int n_ports, unsigned int port_flags,
+				 struct ahci_host_priv *hpriv)
 {
 	int i, rc;
 	u32 tmp;
@@ -668,13 +682,12 @@ static void ahci_init_controller(void __
 		void __iomem *port_mmio = ahci_port_base(mmio, i);
 		const char *emsg = NULL;
 
-#if 0 /* BIOSen initialize this incorrectly */
-		if (!(hpriv->port_map & (1 << i)))
+		if ((port_flags & AHCI_FLAG_HONOR_PI) &&
+		    !(hpriv->port_map & (1 << i)))
 			continue;
-#endif
 
 		/* make sure port is not active */
-		rc = ahci_deinit_port(port_mmio, cap, &emsg);
+		rc = ahci_deinit_port(port_mmio, hpriv->cap, &emsg);
 		if (rc)
 			dev_printk(KERN_WARNING, &pdev->dev,
 				   "%s (%d)\n", emsg, rc);
@@ -1327,7 +1340,8 @@ static int ahci_pci_device_resume(struct
 		if (rc)
 			return rc;
 
-		ahci_init_controller(mmio, pdev, host->n_ports, hpriv->cap);
+		ahci_init_controller(mmio, pdev, host->n_ports,
+				     host->ports[0]->flags, hpriv);
 	}
 
 	ata_host_resume(host);
@@ -1439,7 +1453,7 @@ static int ahci_host_init(struct ata_pro
 	struct ahci_host_priv *hpriv = probe_ent->private_data;
 	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
 	void __iomem *mmio = probe_ent->mmio_base;
-	unsigned int i, using_dac;
+	unsigned int i, cap_n_ports, using_dac;
 	int rc;
 
 	rc = ahci_reset_controller(mmio, pdev);
@@ -1448,10 +1462,34 @@ static int ahci_host_init(struct ata_pro
 
 	hpriv->cap = readl(mmio + HOST_CAP);
 	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
-	probe_ent->n_ports = ahci_nr_ports(hpriv->cap);
+	cap_n_ports = ahci_nr_ports(hpriv->cap);
 
 	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
-		hpriv->cap, hpriv->port_map, probe_ent->n_ports);
+		hpriv->cap, hpriv->port_map, n_ports);
+
+	if (probe_ent->port_flags & AHCI_FLAG_HONOR_PI) {
+		unsigned int n_ports = cap_n_ports;
+		u32 port_map = hpriv->port_map;
+		int max_port = 0;
+
+		for (i = 0; i < AHCI_MAX_PORTS && n_ports; i++) {
+			if (port_map & (1 << i)) {
+				n_ports--;
+				port_map &= ~(1 << i);
+				max_port = i;
+			} else
+				probe_ent->dummy_port_mask |= 1 << i;
+		}
+
+		if (n_ports || port_map)
+			dev_printk(KERN_WARNING, &pdev->dev,
+				   "nr_ports (%u) and implemented port map "
+				   "(0x%x) don't match\n",
+				   cap_n_ports, hpriv->port_map);
+
+		probe_ent->n_ports = max_port + 1;
+	} else
+		probe_ent->n_ports = cap_n_ports;
 
 	using_dac = hpriv->cap & HOST_CAP_64;
 	if (using_dac &&
@@ -1483,7 +1521,8 @@ static int ahci_host_init(struct ata_pro
 	for (i = 0; i < probe_ent->n_ports; i++)
 		ahci_setup_port(&probe_ent->port[i], (unsigned long) mmio, i);
 
-	ahci_init_controller(mmio, pdev, probe_ent->n_ports, hpriv->cap);
+	ahci_init_controller(mmio, pdev, probe_ent->n_ports,
+			     probe_ent->port_flags, hpriv);
 
 	pci_set_master(pdev);
 
