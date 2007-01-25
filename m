From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: implement ATA_FLAG_IGN_SIMPLEX and use it in sata_uli
Date: Thu, 25 Jan 2007 19:40:05 +0900
Message-ID: <20070125104005.GB8606@htj.dyndns.org>
References: <20070116055551.GN10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:43660 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965761AbXAYKkL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 05:40:11 -0500
Received: by nz-out-0506.google.com with SMTP id s1so381335nze
        for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 02:40:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070116055551.GN10987@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Some uli controllers have stuck SIMPLEX bit which can't be cleared
with ata_pci_clear_simplex(), but the controller is capable of doing
DMAs on both channels simultaneously.  Implement ATA_FLAG_IGN_SIMPLEX
which makes libata ignore the simplex bit and use it in sata_uli.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, implemented as ATA_FLAG_* as requested.  The patch is against
#upstream-fixes and should probably included in 2.6.20.  Thanks.

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 623cec9..71e6ddd 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -870,7 +870,8 @@ ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int
 			pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
 		bmdma = pci_resource_start(pdev, 4);
 		if (bmdma) {
-			if (inb(bmdma + 2) & 0x80)
+			if (!(port[p]->flags & ATA_FLAG_IGN_SIMPLEX) &&
+			    inb(bmdma + 2) & 0x80)
 				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
 			probe_ent->port[p].bmdma_addr = bmdma;
 		}
@@ -886,7 +887,8 @@ ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int
 		bmdma = pci_resource_start(pdev, 4);
 		if (bmdma) {
 			bmdma += 8;
-			if(inb(bmdma + 2) & 0x80)
+			if (!(port[p]->flags & ATA_FLAG_IGN_SIMPLEX) &&
+			    inb(bmdma + 2) & 0x80)
 				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
 			probe_ent->port[p].bmdma_addr = bmdma;
 		}
@@ -920,7 +922,8 @@ static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev,
 		probe_ent->port[0].ctl_addr = ATA_PRIMARY_CTL;
 		if (bmdma) {
 			probe_ent->port[0].bmdma_addr = bmdma;
-			if (inb(bmdma + 2) & 0x80)
+			if (!(port[0]->flags & ATA_FLAG_IGN_SIMPLEX) &&
+			    inb(bmdma + 2) & 0x80)
 				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
 		}
 		ata_std_ports(&probe_ent->port[0]);
@@ -937,7 +940,8 @@ static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev,
 		probe_ent->port[1].ctl_addr = ATA_SECONDARY_CTL;
 		if (bmdma) {
 			probe_ent->port[1].bmdma_addr = bmdma + 8;
-			if (inb(bmdma + 10) & 0x80)
+			if (!(port[1]->flags & ATA_FLAG_IGN_SIMPLEX) &&
+			    inb(bmdma + 10) & 0x80)
 				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
 		}
 		ata_std_ports(&probe_ent->port[1]);
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 5c603ca..a43aec6 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -128,7 +128,8 @@ static const struct ata_port_operations uli_ops = {
 
 static struct ata_port_info uli_port_info = {
 	.sht            = &uli_sht,
-	.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+	.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+			  ATA_FLAG_IGN_SIMPLEX,
 	.pio_mask       = 0x1f,		/* pio0-4 */
 	.udma_mask      = 0x7f,		/* udma0-6 */
 	.port_ops       = &uli_ops,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index df76fc4..22aa69e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -177,6 +177,7 @@ enum {
 					      * Register FIS clearing BSY */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
 	ATA_FLAG_SETXFER_POLLING= (1 << 14), /* use polling for SETXFER */
+	ATA_FLAG_IGN_SIMPLEX	= (1 << 15), /* ignore SIMPLEX */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
