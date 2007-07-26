From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-sff; Unbreak non DMA capable controllers again
Date: Thu, 26 Jul 2007 18:41:30 +0100
Message-ID: <20070726184130.68f6c8ac@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:48773 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761056AbXGZRem (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2007 13:34:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Seems nobody else is checking/testing this case as it keeps getting
horked.

If we have no BAR4 mapping on an SFF controller this is *NOT* an error,
it just means it isn't doing BMDMA.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-sff.c linux-2.6.23rc1-mm1/drivers/ata/libata-sff.c
--- linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-sff.c	2007-07-26 15:01:52.899754968 +0100
+++ linux-2.6.23rc1-mm1/drivers/ata/libata-sff.c	2007-07-26 15:17:55.178466368 +0100
@@ -573,6 +573,10 @@
 	struct pci_dev *pdev = to_pci_dev(gdev);
 	int i, rc;
 
+	/* No BAR4 allocation: No DMA */
+	if (pci_resource_start(pdev, 4) == 0)
+		return 0;
+
 	/* TODO: If we get no DMA mask we should fall back to PIO */
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
