From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 11/13] ATA ACPI: fix pata host typo
Date: Wed, 22 Feb 2006 14:02:48 -0800
Message-ID: <20060222140248.5a6e745e.randy_d_dunlap@linux.intel.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:28038 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751499AbWBVWLB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Feb 2006 17:11:01 -0500
In-Reply-To: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Fix a typo.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2616-rc4-ata.orig/drivers/scsi/libata-core.c
+++ linux-2616-rc4-ata/drivers/scsi/libata-core.c
@@ -4920,7 +4920,7 @@ int ata_pci_init_one (struct pci_dev *pd
 	    && (pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		printk(KERN_DEBUG "%s: NO_LEGACY == 0\n", __FUNCTION__);
 		port[0]->host_flags |= ATA_FLAG_PATA_MODE;
-		port[0]->host_flags &= ATA_FLAG_SATA;
+		port[0]->host_flags &= ~ATA_FLAG_SATA;
 		/* TODO: What if one channel is in native mode ... */
 		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
 		mask = (1 << 2) | (1 << 0);
