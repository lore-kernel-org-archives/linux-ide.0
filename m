From: Tejun Heo <tj@kernel.org>
Subject: Re: pata_atiixp regression in 4.11-rc1
Date: Mon, 27 Mar 2017 13:55:50 -0400
Message-ID: <20170327175550.GB13353@htj.duckdns.org>
References: <22571b6e-a8f3-05bc-d68b-a728f595af1d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34475 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdC0Rz6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Mar 2017 13:55:58 -0400
Received: by mail-yw0-f194.google.com with SMTP id d191so6885661ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 27 Mar 2017 10:55:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <22571b6e-a8f3-05bc-d68b-a728f595af1d@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Markku Pesonen <tourula@gmail.com>
Cc: linux-ide@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>

>From a431ecd2d459da3c91a612061f09eb422ffe78e2 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 27 Mar 2017 13:52:00 -0400
Subject: [PATCH] Revert "pata_atiixp: Don't use unconnected secondary port on
 SB600/SB700"

This reverts commit 5946fdaee4ba449e8fbb5d403e1ed69437f916e8.

The original commit's assumption that the secondary port is
unconnected turns out to be false.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Markku Pesonen <tourula@gmail.com>
Fixes: 5946fdaee4ba ("pata_atiixp: Don't use unconnected secondary port on SB600/SB700")
Cc: Darren Stevens <darren@stevens-zone.net>
---
 drivers/ata/pata_atiixp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 6c9aa95..49d705c 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -278,11 +278,6 @@ static int atiixp_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 	const struct ata_port_info *ppi[] = { &info, &info };
 
-	/* SB600/700 don't have secondary port wired */
-	if ((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE) ||
-		(pdev->device == PCI_DEVICE_ID_ATI_IXP700_IDE))
-		ppi[1] = &ata_dummy_port_info;
-
 	return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
 				      ATA_HOST_PARALLEL_SCAN);
 }
-- 
2.9.3

