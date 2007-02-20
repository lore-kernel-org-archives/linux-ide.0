From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_via: fix resource-managed iomap conversion
Date: Tue, 20 Feb 2007 20:01:53 +0900
Message-ID: <20070220110153.GO1625@htj.dyndns.org>
References: <20070210010914.GA19717@havoc.gtf.org> <20070210054629.GA4395@gentoox2.trippelsdorf.de> <45CF93D1.9080009@gmail.com> <20070212025843.GA4406@gentoox2.trippelsdorf.de> <45D0B740.9050704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:22869 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932877AbXBTLB4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Feb 2007 06:01:56 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1984129wxd
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 03:01:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <45D0B740.9050704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Conversion to resource-managed iomap was buggy causing init failures
on both vt6420 and 6421 - BAR5 wasn't mapped for both controllers
while on vt6420 sata_via tried to map BAR0-4 twice.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
I thought I have a vt6421 but mine too was a vt6420.  So, the patch is
verified only for vt6420 but, the vt6421 path is pretty obvious and
should be correct.  Please apply.

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index baca6d7..fe9101a 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -423,16 +423,21 @@ static struct ata_probe_ent *vt6420_init_probe_ent(struct pci_dev *pdev)
 {
 	struct ata_probe_ent *probe_ent;
 	struct ata_port_info *ppi[2];
-	void __iomem * const *iomap;
+	void __iomem *bar5;
 
 	ppi[0] = ppi[1] = &vt6420_port_info;
 	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
 		return NULL;
 
-	iomap = pcim_iomap_table(pdev);
-	probe_ent->port[0].scr_addr = svia_scr_addr(iomap[5], 0);
-	probe_ent->port[1].scr_addr = svia_scr_addr(iomap[5], 1);
+	bar5 = pcim_iomap(pdev, 5, 0);
+	if (!bar5) {
+		dev_printk(KERN_ERR, &pdev->dev, "failed to iomap PCI BAR 5\n");
+		return NULL;
+	}
+
+	probe_ent->port[0].scr_addr = svia_scr_addr(bar5, 0);
+	probe_ent->port[1].scr_addr = svia_scr_addr(bar5, 1);
 
 	return probe_ent;
 }
@@ -460,6 +465,13 @@ static struct ata_probe_ent *vt6421_init_probe_ent(struct pci_dev *pdev)
 	probe_ent->mwdma_mask	= 0x07;
 	probe_ent->udma_mask	= 0x7f;
 
+	for (i = 0; i < 6; i++)
+		if (!pcim_iomap(pdev, i, 0)) {
+			dev_printk(KERN_ERR, &pdev->dev,
+				   "failed to iomap PCI BAR %d\n", i);
+			return NULL;
+		}
+
 	for (i = 0; i < N_PORTS; i++)
 		vt6421_init_addrs(probe_ent, pcim_iomap_table(pdev), i);
 
@@ -522,7 +534,7 @@ static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, 0x1f, DRV_NAME);
+	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
 		pcim_pin_device(pdev);
 		return rc;

