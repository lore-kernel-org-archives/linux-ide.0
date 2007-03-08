From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_platform: Add cable method again
Date: Thu, 8 Mar 2007 22:54:04 +0000
Message-ID: <20070308225404.0652df51@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51735 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030683AbXCHVtw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 16:49:52 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <number6@the-village.bc.nu>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_platform.c linux-2.6.21-rc3-mm2/drivers/ata/pata_platform.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_platform.c	2007-03-08 15:59:20.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_platform.c	2007-03-08 16:47:08.000000000 +0000
@@ -80,6 +80,7 @@
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_unknown,
 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
