From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_hpt366: Enable bits are unreliable so don't use them
Date: Mon, 21 May 2007 14:52:49 +0100
Message-ID: <20070521145249.67bf910b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50797 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755966AbXEUNtB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 09:49:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, akpm@osdl.org, linux-ide@vger.kernel.org

Various people had problems with both old and new IDE when hpt366 enable
bits started getting honoured. It turns out they are not reliable so
don't rely on them

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/drivers/ata/pata_hpt366.c linux-2.6.22-rc1-mm1/drivers/ata/pata_hpt366.c
--- linux.vanilla-2.6.22-rc1-mm1/drivers/ata/pata_hpt366.c	2007-05-18 16:21:46.000000000 +0100
+++ linux-2.6.22-rc1-mm1/drivers/ata/pata_hpt366.c	2007-05-18 17:15:23.000000000 +0100
@@ -220,32 +220,6 @@
 	return ATA_CBL_PATA80;
 }
 
-static int hpt36x_pre_reset(struct ata_port *ap, unsigned long deadline)
-{
-	static const struct pci_bits hpt36x_enable_bits[] = {
-		{ 0x50, 1, 0x04, 0x04 },
-		{ 0x54, 1, 0x04, 0x04 }
-	};
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-
-	if (!pci_test_config_bits(pdev, &hpt36x_enable_bits[ap->port_no]))
-		return -ENOENT;
-
-	return ata_std_prereset(ap, deadline);
-}
-
-/**
- *	hpt36x_error_handler	-	reset the hpt36x bus
- *	@ap: ATA port to reset
- *
- *	Perform the reset handling for the 366/368
- */
-
-static void hpt36x_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, hpt36x_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
 /**
  *	hpt366_set_piomode		-	PIO setup
  *	@ap: ATA interface
@@ -351,7 +325,7 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= hpt36x_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= hpt36x_cable_detect,
 
