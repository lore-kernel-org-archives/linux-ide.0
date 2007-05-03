From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] pata_scc: fix compilation
Date: Thu, 3 May 2007 23:44:59 +0400
Message-ID: <20070503194459.GC5836@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:8347 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767861AbXECTpF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 May 2007 15:45:05 -0400
Received: by ug-out-1314.google.com with SMTP id 44so521548uga
        for <linux-ide@vger.kernel.org>; Thu, 03 May 2007 12:45:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/ata/pata_scc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -1142,14 +1142,14 @@ static int scc_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	static int printed_version;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	const struct ata_port_info *ppi[] = { &scc_port_info[board_idx], NULL };
-	struct device *dev = &pdev->dev;
+	struct ata_host *host;
 	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	host = ata_port_alloc_pinfo(&pdev->dev, ppi, 1);
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 1);
 	if (!host)
 		return -ENOMEM;
 

