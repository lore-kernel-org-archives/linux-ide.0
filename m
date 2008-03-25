From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 25/27] libata: clean up dummy port_ops
Date: Tue, 25 Mar 2008 22:17:03 +0900
Message-ID: <12064510293046-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:16486 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbYCYNRo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:44 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2257952wra.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:44 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

Now that SFF assumptions are removed from core layer, dummy port_ops
can be slimmed down.  Chop it down.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   22 +++++-----------------
 1 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ce10edb..0ffe61d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6107,32 +6107,20 @@ u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
 /*
  * Dummy port_ops
  */
-static void ata_dummy_noret(struct ata_port *ap)	{ }
-static int ata_dummy_ret0(struct ata_port *ap)		{ return 0; }
-static void ata_dummy_qc_noret(struct ata_queued_cmd *qc) { }
-
-static u8 ata_dummy_check_status(struct ata_port *ap)
+static unsigned int ata_dummy_qc_issue(struct ata_queued_cmd *qc)
 {
-	return ATA_DRDY;
+	return AC_ERR_SYSTEM;
 }
 
-static unsigned int ata_dummy_qc_issue(struct ata_queued_cmd *qc)
+static void ata_dummy_error_handler(struct ata_port *ap)
 {
-	return AC_ERR_SYSTEM;
+	/* truly dummy */
 }
 
 struct ata_port_operations ata_dummy_port_ops = {
-	.sff_check_status	= ata_dummy_check_status,
-	.sff_check_altstatus	= ata_dummy_check_status,
 	.qc_prep		= ata_noop_qc_prep,
 	.qc_issue		= ata_dummy_qc_issue,
-	.freeze			= ata_dummy_noret,
-	.thaw			= ata_dummy_noret,
-	.error_handler		= ata_dummy_noret,
-	.post_internal_cmd	= ata_dummy_qc_noret,
-	.sff_irq_clear		= ata_dummy_noret,
-	.port_start		= ata_dummy_ret0,
-	.port_stop		= ata_dummy_noret,
+	.error_handler		= ata_dummy_error_handler,
 };
 
 const struct ata_port_info ata_dummy_port_info = {
-- 
1.5.2.4

