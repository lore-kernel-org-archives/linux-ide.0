From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2.6.22-rc5] ahci: fix PORTS_IMPL override
Date: Tue, 19 Jun 2007 18:52:56 +0900
Message-ID: <20070619095256.GQ29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:44286 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936AbXFSJxD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jun 2007 05:53:03 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1683528nzf
        for <linux-ide@vger.kernel.org>; Tue, 19 Jun 2007 02:53:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

If PORTS_IMPL register is zero, ahci initialize it to full mask
corresponding to nr_ports in the CAP register.  hpriv->cap, which is
initialized at the end of the function, is incorrectly used as value
of CAP causing ahci to always override PORTS_IMPL to 0x1 if it's zero.
Fix it.

This fixes a bug where early ich6 ahci can only access the first port.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 545f330..ca5229d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -527,7 +527,7 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
 
 	/* fixup zero port_map */
 	if (!port_map) {
-		port_map = (1 << ahci_nr_ports(hpriv->cap)) - 1;
+		port_map = (1 << ahci_nr_ports(cap)) - 1;
 		dev_printk(KERN_WARNING, &pdev->dev,
 			   "PORTS_IMPL is zero, forcing 0x%x\n", port_map);
 
