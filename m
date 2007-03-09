From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix native mode disabled port handling
Date: Fri, 9 Mar 2007 19:43:35 +0900
Message-ID: <20070309104335.GD32687@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:44897 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767149AbXCIKnf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 05:43:35 -0500
Received: by nz-out-0506.google.com with SMTP id s1so734954nze
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 02:43:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Disabled port handling in ata_pci_init_native_mode() is slightly
broken in that it may end up using the wrong port_info.  This patch
updates it such that disables ports are made dummy as done in the
legacy and other cases.

While at it, fix indentation in ata_resources_present().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-sff.c |   62 ++++++++++++++++++++++++++--------------------
 1 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 2ffcca0..df9c83b 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -526,8 +526,8 @@ static int ata_resources_present(struct pci_dev *pdev, int port)
 	port = port * 2;
 	for (i = 0; i < 2; i ++) {
 		if (pci_resource_start(pdev, port + i) == 0 ||
-			pci_resource_len(pdev, port + i) == 0)
-		return 0;
+		    pci_resource_len(pdev, port + i) == 0)
+			return 0;
 	}
 	return 1;
 }
@@ -554,11 +554,26 @@ struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int ports)
 {
 	struct ata_probe_ent *probe_ent;
-	int i, p = 0;
+	int i;
 	void __iomem * const *iomap;
 
+	/* Discard disabled ports.  Some controllers show their unused
+	 * channels this way.  Disabled ports will be made dummy.
+	 */
+	if (ata_resources_present(pdev, 0) == 0)
+		ports &= ~ATA_PORT_PRIMARY;
+	if (ata_resources_present(pdev, 1) == 0)
+		ports &= ~ATA_PORT_SECONDARY;
+
+	if (!ports) {
+		dev_printk(KERN_ERR, &pdev->dev, "no available port\n");
+		return NULL;
+	}
+
 	/* iomap BARs */
 	for (i = 0; i < 4; i++) {
+		if (!(ports & (1 << (i / 2))))
+			continue;
 		if (pcim_iomap(pdev, i, 0) == NULL) {
 			dev_printk(KERN_ERR, &pdev->dev,
 				   "failed to iomap PCI BAR %d\n", i);
@@ -574,48 +589,41 @@ ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int
 	if (!probe_ent)
 		return NULL;
 
+	probe_ent->n_ports = 2;
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = IRQF_SHARED;
 
-	/* Discard disabled ports. Some controllers show their
-	   unused channels this way */
-	if (ata_resources_present(pdev, 0) == 0)
-		ports &= ~ATA_PORT_PRIMARY;
-	if (ata_resources_present(pdev, 1) == 0)
-		ports &= ~ATA_PORT_SECONDARY;
-
 	if (ports & ATA_PORT_PRIMARY) {
-		probe_ent->port[p].cmd_addr = iomap[0];
-		probe_ent->port[p].altstatus_addr =
-		probe_ent->port[p].ctl_addr = (void __iomem *)
+		probe_ent->port[0].cmd_addr = iomap[0];
+		probe_ent->port[0].altstatus_addr =
+		probe_ent->port[0].ctl_addr = (void __iomem *)
 			((unsigned long)iomap[1] | ATA_PCI_CTL_OFS);
 		if (iomap[4]) {
-			if ((!(port[p]->flags & ATA_FLAG_IGN_SIMPLEX)) &&
+			if ((!(port[0]->flags & ATA_FLAG_IGN_SIMPLEX)) &&
 			    (ioread8(iomap[4] + 2) & 0x80))
 				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
-			probe_ent->port[p].bmdma_addr = iomap[4];
+			probe_ent->port[0].bmdma_addr = iomap[4];
 		}
-		ata_std_ports(&probe_ent->port[p]);
-		p++;
-	}
+		ata_std_ports(&probe_ent->port[0]);
+	} else
+		probe_ent->dummy_port_mask |= ATA_PORT_PRIMARY;
 
 	if (ports & ATA_PORT_SECONDARY) {
-		probe_ent->port[p].cmd_addr = iomap[2];
-		probe_ent->port[p].altstatus_addr =
-		probe_ent->port[p].ctl_addr = (void __iomem *)
+		probe_ent->port[1].cmd_addr = iomap[2];
+		probe_ent->port[1].altstatus_addr =
+		probe_ent->port[1].ctl_addr = (void __iomem *)
 			((unsigned long)iomap[3] | ATA_PCI_CTL_OFS);
 		if (iomap[4]) {
-			if ((!(port[p]->flags & ATA_FLAG_IGN_SIMPLEX)) &&
+			if ((!(port[1]->flags & ATA_FLAG_IGN_SIMPLEX)) &&
 			    (ioread8(iomap[4] + 10) & 0x80))
 				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
-			probe_ent->port[p].bmdma_addr = iomap[4] + 8;
+			probe_ent->port[1].bmdma_addr = iomap[4] + 8;
 		}
-		ata_std_ports(&probe_ent->port[p]);
+		ata_std_ports(&probe_ent->port[1]);
 		probe_ent->pinfo2 = port[1];
-		p++;
-	}
+	} else
+		probe_ent->dummy_port_mask |= ATA_PORT_SECONDARY;
 
-	probe_ent->n_ports = p;
 	return probe_ent;
 }
 
-- 
1.5.0.1

