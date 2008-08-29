From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] pata_sil680: remove duplicate pcim_enable_device
Date: Fri, 29 Aug 2008 10:36:28 -0500
Message-ID: <20080829153628.GA20130@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:35810 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbYH2Pmm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Aug 2008 11:42:42 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Remove duplicate call to pcim_enable_device in sil680_init_one.

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/pata_sil680.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 720b864..e970b22 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -322,9 +322,6 @@ static int __devinit sil680_init_one(struct pci_dev *pdev,
 	/* Try to acquire MMIO resources and fallback to PIO if
 	 * that fails
 	 */
-	rc = pcim_enable_device(pdev);
-	if (rc)
-		return rc;
 	rc = pcim_iomap_regions(pdev, 1 << SIL680_MMIO_BAR, DRV_NAME);
 	if (rc)
 		goto use_ioports;
