From: akpm@linux-foundation.org
Subject: [patch 14/30] pata_cs55x0: clean up by using the cable_detect method
Date: Tue, 06 Mar 2007 02:38:01 -0800
Message-ID: <200703061038.l26Ac1ZW019499@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34481 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934045AbXCFKi1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_cs5520.c |   15 ++-------------
 drivers/ata/pata_cs5530.c |   15 ++-------------
 2 files changed, 4 insertions(+), 26 deletions(-)

diff -puN drivers/ata/pata_cs5520.c~pata_cs55x0-clean-up-by-using-the-cable_detect-method drivers/ata/pata_cs5520.c
--- a/drivers/ata/pata_cs5520.c~pata_cs55x0-clean-up-by-using-the-cable_detect-method
+++ a/drivers/ata/pata_cs5520.c
@@ -139,18 +139,6 @@ static void cs5520_set_piomode(struct at
 	cs5520_set_timings(ap, adev, adev->pio_mode);
 }
 
-
-static int cs5520_pre_reset(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
-}
-
-static void cs5520_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, cs5520_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
 static struct scsi_host_template cs5520_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -186,8 +174,9 @@ static struct ata_port_operations cs5520
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= cs5520_error_handler,
+	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_40wire,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
diff -puN drivers/ata/pata_cs5530.c~pata_cs55x0-clean-up-by-using-the-cable_detect-method drivers/ata/pata_cs5530.c
--- a/drivers/ata/pata_cs5530.c~pata_cs55x0-clean-up-by-using-the-cable_detect-method
+++ a/drivers/ata/pata_cs5530.c
@@ -160,18 +160,6 @@ static unsigned int cs5530_qc_issue_prot
 	return ata_qc_issue_prot(qc);
 }
 
-static int cs5530_pre_reset(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
-}
-
-static void cs5530_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, cs5530_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-
 static struct scsi_host_template cs5530_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -213,8 +201,9 @@ static struct ata_port_operations cs5530
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= cs5530_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= cs5530_qc_issue_prot,
_
