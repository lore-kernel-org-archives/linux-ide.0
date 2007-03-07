From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_pcmcia: Cable detect
Date: Wed, 7 Mar 2007 16:27:22 +0000
Message-ID: <20070307162722.5b45bafc@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57116 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751924AbXCGPXE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:23:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

This one is a bit odd. Most PCMCIA adapters don't really have a "cable"
but have the controller embedded in the CF adapter or similar. Some real
IDE adapters do exist although they are rare.

As PCMCIA is ISA timing it can only support PIO0 so reporting 40 wire
seems closest to the truth and I don't see the need for a
'ATA_CBL_HARDWIRED' type although we could add one if Jeff wanted.

(As a PS Jeff - if you don't want to merge the code for spotting missing
slave detect for 2.6.21 it would be best to remove the SLAVE flag from
that driver for 2.6.21 and just probe master only - safer and will break
only ultra-obscure setups)

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_pcmcia.c linux-2.6.21-rc2-mm2/drivers/ata/pata_pcmcia.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_pcmcia.c	2007-03-06 23:09:46.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/pata_pcmcia.c	2007-03-06 17:56:21.000000000 +0000
@@ -42,7 +42,7 @@
 
 
 #define DRV_NAME "pata_pcmcia"
-#define DRV_VERSION "0.3.0"
+#define DRV_VERSION "0.3.1"
 
 /*
  *	Private data structure to glue stuff together
@@ -118,6 +118,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
