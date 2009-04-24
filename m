From: Arjan van de Ven <arjan@infradead.org>
Subject: [patch] Enable parallel scan on ata_piix
Date: Thu, 23 Apr 2009 21:44:11 -0700
Message-ID: <20090423214411.515310df@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:54561 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbZDXEmJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Apr 2009 00:42:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Hi,

This patch turns on parallel scanning for the ata_piix driver.
This driver is used on most netbooks (no AHCI for cheap storage it seems).
The scan is the dominating time factor in the kernel boot for these
devices; with this flag it gets cut in half for the device I used
for testing (eeepc).
Alan took a look at the driver source and concluded that it ought to be safe
to do for this driver.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index ef8b30d..993f7af 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1563,6 +1563,7 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 		host->ports[1]->mwdma_mask = 0;
 		host->ports[1]->udma_mask = 0;
 	}
+	host->flags |= ATA_HOST_PARALLEL_SCAN;
 
 	pci_set_master(pdev);
 	return ata_pci_sff_activate_host(host, ata_sff_interrupt, &piix_sht);


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
