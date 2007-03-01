From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_cypress: clean up by using cable_detect method
Date: Thu, 1 Mar 2007 17:43:57 +0000
Message-ID: <20070301174357.167187a4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53652 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965357AbXCAQkV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Mar 2007 11:40:21 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2/drivers/ata/pata_cypress.c linux-2.6.21-rc2/drivers/ata/pata_cypress.c
--- linux.vanilla-2.6.21-rc2/drivers/ata/pata_cypress.c	2007-03-01 13:36:03.000000000 +0000
+++ linux-2.6.21-rc2/drivers/ata/pata_cypress.c	2007-03-01 14:52:50.939946088 +0000
@@ -41,17 +41,6 @@
 	CY82_INDEX_TIMEOUT	= 0x32
 };
 
-static int cy82c693_pre_reset(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
-}
-
-static void cy82c693_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, cy82c693_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
 /**
  *	cy82c693_set_piomode	-	set initial PIO mode data
  *	@ap: ATA interface
@@ -154,8 +143,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= cy82c693_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
