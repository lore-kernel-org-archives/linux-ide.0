From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_qdi: set cable type
Date: Thu, 1 Mar 2007 18:20:14 +0000
Message-ID: <20070301182014.51389528@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35756 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965421AbXCARQI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Mar 2007 12:16:08 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2/drivers/ata/pata_qdi.c linux-2.6.21-rc2/drivers/ata/pata_qdi.c
--- linux.vanilla-2.6.21-rc2/drivers/ata/pata_qdi.c	2007-03-01 13:36:03.000000000 +0000
+++ linux-2.6.21-rc2/drivers/ata/pata_qdi.c	2007-03-01 15:04:58.956270784 +0000
@@ -183,6 +183,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= qdi_qc_issue_prot,
@@ -211,6 +212,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= qdi_qc_issue_prot,
