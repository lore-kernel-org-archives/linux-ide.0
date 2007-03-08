From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_cs5530: Re-remove all the crap and switch back to the
 cable method
Date: Thu, 8 Mar 2007 19:30:37 +0000
Message-ID: <20070308193037.5a8f2633@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60502 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932489AbXCHS0Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:26:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_cs5530.c linux-2.6.21-rc3-mm2/drivers/ata/pata_cs5530.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_cs5530.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_cs5530.c	2007-03-08 16:45:52.000000000 +0000
@@ -160,18 +160,6 @@
 	return ata_qc_issue_prot(qc);
 }
 
-static int cs5530_pre_reset(struct ata_port *ap, unsigned long deadline)
-{
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap, deadline);
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
@@ -213,8 +201,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= cs5530_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= cs5530_qc_issue_prot,
