From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3 #upstream] ahci: kill AHCI_FLAG_RESET_NEEDS_CLO
Date: Wed, 1 Nov 2006 17:58:33 +0900
Message-ID: <20061101085833.GP13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:4286 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423955AbWKAI6m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 03:58:42 -0500
Received: by nf-out-0910.google.com with SMTP id c2so727689nfe
        for <linux-ide@vger.kernel.org>; Wed, 01 Nov 2006 00:58:40 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Now that ahci_softreset() is fixed to automatically perform CLO if
BSY/DRQ is set on entry, AHCI_FLAG_RESET_NEEDS_CLO is redundant.  Kill
it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Jeff, this is respin of the following patch series.

    http://thread.gmane.org/gmane.linux.ide/13471/focus=13471

fix-status-check-in-ahci_softreset patch is separated and submitted
for #upstream-fixes inclusion.

This patch series is against.

   upstream (ee0fd6c1b95105832d463f7318b874ad448e476a)
   + fix-status-check-in-ahci_softreset
     (http://article.gmane.org/gmane.linux.ide/13815)

Thanks.

 drivers/ata/ahci.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -166,8 +166,7 @@ enum {
 	AHCI_FLAG_MSI		= (1 << 0),
 
 	/* ap->flags bits */
-	AHCI_FLAG_RESET_NEEDS_CLO	= (1 << 24),
-	AHCI_FLAG_NO_NCQ		= (1 << 25),
+	AHCI_FLAG_NO_NCQ		= (1 << 24),
 };
 
 struct ahci_cmd_hdr {
@@ -289,8 +288,7 @@ static const struct ata_port_info ahci_p
 		.sht		= &ahci_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY |
-				  AHCI_FLAG_RESET_NEEDS_CLO | AHCI_FLAG_NO_NCQ,
+				  ATA_FLAG_SKIP_D2H_BSY | AHCI_FLAG_NO_NCQ,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
@@ -697,17 +695,6 @@ static int ahci_clo(struct ata_port *ap)
 	return 0;
 }
 
-static int ahci_prereset(struct ata_port *ap)
-{
-	if ((ap->flags & AHCI_FLAG_RESET_NEEDS_CLO) &&
-	    (ata_busy_wait(ap, ATA_BUSY, 1000) & ATA_BUSY)) {
-		/* ATA_BUSY hasn't cleared, so send a CLO */
-		ahci_clo(ap);
-	}
-
-	return ata_std_prereset(ap);
-}
-
 static int ahci_softreset(struct ata_port *ap, unsigned int *class)
 {
 	struct ahci_port_priv *pp = ap->private_data;
@@ -1160,7 +1147,7 @@ static void ahci_error_handler(struct at
 	}
 
 	/* perform recovery */
-	ata_do_eh(ap, ahci_prereset, ahci_softreset, ahci_hardreset,
+	ata_do_eh(ap, ata_std_prereset, ahci_softreset, ahci_hardreset,
 		  ahci_postreset);
 }
 
