From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/12] ahci: make NO_NCQ handling more consistent
Date: Sun, 1 Jul 2007 18:53:37 +0900
Message-ID: <11832836173613-git-send-email-htejun@gmail.com>
References: <118328361627-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:29288 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164AbXGAJxm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 05:53:42 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1876601wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 02:53:42 -0700 (PDT)
In-Reply-To: <118328361627-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

ahci_save_initial_config() is responsible for reading, screening the
host CAP register and storing the modified result into hpriv->cap for
the rest of the driver.  Move ATA_FLAG_NO_NCQ handling into
ahci_save_initial_config().  It's more consistent this way and the
rest of the driver can always refer to hpriv->cap to determine
configured capability.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0e001ad..0555db5 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -527,13 +527,19 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
 	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
 	hpriv->saved_port_map = port_map = readl(mmio + HOST_PORTS_IMPL);
 
-	/* some chips lie about 64bit support */
+	/* some chips lie about their capabilities, bust them */
 	if ((cap & HOST_CAP_64) && (pi->flags & AHCI_FLAG_32BIT_ONLY)) {
 		dev_printk(KERN_INFO, &pdev->dev,
 			   "controller can't do 64bit DMA, forcing 32bit\n");
 		cap &= ~HOST_CAP_64;
 	}
 
+	if ((cap & HOST_CAP_NCQ) && (pi->flags & AHCI_FLAG_NO_NCQ)) {
+		dev_printk(KERN_INFO, &pdev->dev,
+			   "controller can't do NCQ, turning off CAP_NCQ\n");
+		cap &= ~HOST_CAP_NCQ;
+	}
+
 	/* fixup zero port_map */
 	if (!port_map) {
 		port_map = (1 << ahci_nr_ports(cap)) - 1;
@@ -1752,7 +1758,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ahci_save_initial_config(pdev, &pi, hpriv);
 
 	/* prepare host */
-	if (!(pi.flags & AHCI_FLAG_NO_NCQ) && (hpriv->cap & HOST_CAP_NCQ))
+	if (hpriv->cap & HOST_CAP_NCQ)
 		pi.flags |= ATA_FLAG_NCQ;
 
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, fls(hpriv->port_map));
-- 
1.5.0.3


