From: tony@bakeyournoodle.com (Tony Breeds)
Subject: [PATCH] drivers/ata/pata_hpt37x.c Remove unused static variable.
Date: Fri, 11 May 2007 16:46:03 +1000
Message-ID: <20070511064603.GC15955@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760800AbXEKGqS@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Remove unused static variable.

drivers/ata/pata_hpt37x.c: In function 'hpt37x_init_one':
drivers/ata/pata_hpt37x.c:935: warning: unused variable 'info_hpt372_50'

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
CC: Jeff Garzik <jgarzik@pobox.com>
CC: Alan Cox <alan@redhat.com>
CC: linux-ide@vger.kernel.org
---

 drivers/ata/pata_hpt37x.c |    9 ---------
 1 file changed, 9 deletions(-)

Index: working/drivers/ata/pata_hpt37x.c
===================================================================
--- working.orig/drivers/ata/pata_hpt37x.c
+++ working/drivers/ata/pata_hpt37x.c
@@ -931,15 +931,6 @@ static int hpt37x_init_one(struct pci_de
 		.udma_mask = 0x7f,
 		.port_ops = &hpt372_port_ops
 	};
-	/* HPT371, 372 and friends - UDMA100 at 50MHz clock */
-	static struct ata_port_info info_hpt372_50 = {
-		.sht = &hpt37x_sht,
-		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
-		.pio_mask = 0x1f,
-		.mwdma_mask = 0x07,
-		.udma_mask = 0x3f,
-		.port_ops = &hpt372_port_ops
-	};
 	/* HPT374 - UDMA133 */
 	static struct ata_port_info info_hpt374 = {
 		.sht = &hpt37x_sht,
Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
