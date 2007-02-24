From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_mv: fix pci_enable_msi() error handling
Date: Sat, 24 Feb 2007 15:12:31 +0900
Message-ID: <20070224061231.GZ1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:35983 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbXBXGMk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Feb 2007 01:12:40 -0500
Received: by nz-out-0506.google.com with SMTP id s1so672878nze
        for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2007 22:12:39 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

intx should be turned on when pci_enable_msi() fails not when it
succeeds.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 06867b9..d724bc7 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2347,7 +2347,7 @@ static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return rc;
 
 	/* Enable interrupts */
-	if (msi && !pci_enable_msi(pdev))
+	if (msi && pci_enable_msi(pdev))
 		pci_intx(pdev, 1);
 
 	mv_dump_pci_cfg(pdev, 0x68);
