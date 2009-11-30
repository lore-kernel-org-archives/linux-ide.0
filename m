From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 5/6] pata_ali: Fix regression with old devices
Date: Mon, 30 Nov 2009 13:23:05 +0000
Message-ID: <20091130132305.27236.95145.stgit@localhost.localdomain>
References: <20091130132005.27236.77890.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50847 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752839AbZK3Nmj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Nov 2009 08:42:39 -0500
In-Reply-To: <20091130132005.27236.77890.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org, davem@davemloft.net

Making the new stuff work broke some of the old chipsets. We need to go
back to the old set up values for these it seems. Unfortunately even with
documentation this is basically a mix of cargoculting and guesswork.

Chased down to the exact line by Gianluca.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/ata/pata_ali.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)


diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 1432dc9..9434114 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -453,7 +453,9 @@ static void ali_init_chipset(struct pci_dev *pdev)
 			/* Clear CD-ROM DMA write bit */
 			tmp &= 0x7F;
 		/* Cable and UDMA */
-		pci_write_config_byte(pdev, 0x4B, tmp | 0x09);
+		if (pdev->revision >= 0xc2)
+			tmp |= 0x01;
+		pci_write_config_byte(pdev, 0x4B, tmp | 0x08);
 		/*
 		 * CD_ROM DMA on (0x53 bit 0). Enable this even if we want
 		 * to use PIO. 0x53 bit 1 (rev 20 only) - enable FIFO control

