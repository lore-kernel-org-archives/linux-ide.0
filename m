From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_mpc52xx: Cable detect
Date: Wed, 7 Mar 2007 16:20:05 +0000
Message-ID: <20070307162005.197d4cc4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57112 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751844AbXCGPPs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:15:48 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_mpc52xx.c linux-2.6.21-rc2-mm2/drivers/ata/pata_mpc52xx.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_mpc52xx.c	2007-03-06 23:09:46.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/pata_mpc52xx.c	2007-03-06 23:35:28.000000000 +0000
@@ -24,7 +24,7 @@
 
 
 #define DRV_NAME	"mpc52xx_ata"
-#define DRV_VERSION	"0.1.0"
+#define DRV_VERSION	"0.1.0ac2"
 
 
 /* Private structures used by the driver */
@@ -297,6 +297,7 @@
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= mpc52xx_ata_error_handler,
+	.cable_detect		= ata_cable_40wire,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
