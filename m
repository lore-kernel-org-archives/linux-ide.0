From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_inic162x: kill double region requests
Date: Fri, 16 Mar 2007 01:59:42 +0900
Message-ID: <20070315165942.GC15600@htj.dyndns.org>
References: <20070310205636.GA14704@movealong.org> <45F4F483.9080302@gmail.com> <20070312220656.GA5457@movealong.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:54976 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030603AbXCOQ7u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 12:59:50 -0400
Received: by wr-out-0506.google.com with SMTP id 41so201443wry
        for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 09:59:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070312220656.GA5457@movealong.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nate Riffe <inkblot@movealong.org>
Cc: linux-ide@vger.kernel.org, kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Regions are requested twice during initialization causing the second
one to fail.  This is regression introduced during iomap conversion.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Nate, this should fix it.  But LBA48 support is broken on the
controller.

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index dcf5fe5..11c3079 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -674,10 +674,6 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
-		return rc;
-
 	rc = pcim_iomap_regions(pdev, 0x3f, DRV_NAME);
 	if (rc)
 		return rc;
