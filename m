From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] ahci: rename ahci_vt8251_hardreset() to
	ahci_broken_hardreset()
Date: Thu, 25 Oct 2007 12:02:24 +0900
Message-ID: <20071025030224.GE11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:51842 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759750AbXJYDCd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 23:02:33 -0400
Received: by rv-out-0910.google.com with SMTP id k20so351991rvb
        for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2007 20:02:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Rename ahci_vt8251_hardreset() to ahci_broken_hardreset() and rename
related names accordingly.  This is preparation for ASUS P5W-DH Deluxe
workaround.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -240,7 +240,7 @@ static void ahci_thaw(struct ata_port *a
 static void ahci_pmp_attach(struct ata_port *ap);
 static void ahci_pmp_detach(struct ata_port *ap);
 static void ahci_error_handler(struct ata_port *ap);
-static void ahci_vt8251_error_handler(struct ata_port *ap);
+static void ahci_broken_hrst_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
 static int ahci_port_resume(struct ata_port *ap);
 static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl);
@@ -305,7 +305,7 @@ static const struct ata_port_operations 
 	.port_stop		= ahci_port_stop,
 };
 
-static const struct ata_port_operations ahci_vt8251_ops = {
+static const struct ata_port_operations ahci_broken_hrst_ops = {
 	.check_status		= ahci_check_status,
 	.check_altstatus	= ahci_check_status,
 	.dev_select		= ata_noop_dev_select,
@@ -324,7 +324,7 @@ static const struct ata_port_operations 
 	.freeze			= ahci_freeze,
 	.thaw			= ahci_thaw,
 
-	.error_handler		= ahci_vt8251_error_handler,
+	.error_handler		= ahci_broken_hrst_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
 	.pmp_attach		= ahci_pmp_attach,
@@ -357,7 +357,7 @@ static const struct ata_port_info ahci_p
 		.link_flags	= AHCI_LFLAG_COMMON | ATA_LFLAG_HRST_TO_RESUME,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_vt8251_ops,
+		.port_ops	= &ahci_broken_hrst_ops,
 	},
 	/* board_ahci_ign_iferr */
 	{
@@ -1185,7 +1185,7 @@ static int ahci_hardreset(struct ata_lin
 	return rc;
 }
 
-static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
+static int ahci_broken_hardreset(struct ata_link *link, unsigned int *class,
 				 unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
@@ -1657,7 +1657,7 @@ static void ahci_error_handler(struct at
 		       sata_pmp_std_hardreset, sata_pmp_std_postreset);
 }
 
-static void ahci_vt8251_error_handler(struct ata_port *ap)
+static void ahci_broken_hrst_error_handler(struct ata_port *ap)
 {
 	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 		/* restart engine */
@@ -1666,7 +1666,7 @@ static void ahci_vt8251_error_handler(st
 	}
 
 	/* perform recovery */
-	ata_do_eh(ap, ata_std_prereset, ahci_softreset, ahci_vt8251_hardreset,
+	ata_do_eh(ap, ata_std_prereset, ahci_softreset, ahci_broken_hardreset,
 		  ahci_postreset);
 }
 

