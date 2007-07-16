From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/21] ahci: make NO_NCQ handling more consistent
Date: Mon, 16 Jul 2007 14:29:40 +0900
Message-ID: <11845637804110-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:2491 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762070AbXGPF3v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:51 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1464057wah
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:51 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
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
index e044d64..9faf008 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -545,13 +545,19 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
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
@@ -1822,7 +1828,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ahci_save_initial_config(pdev, &pi, hpriv);
 
 	/* prepare host */
-	if (!(pi.flags & AHCI_FLAG_NO_NCQ) && (hpriv->cap & HOST_CAP_NCQ))
+	if (hpriv->cap & HOST_CAP_NCQ)
 		pi.flags |= ATA_FLAG_NCQ;
 
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, fls(hpriv->port_map));
-- 
1.5.0.3


