From: Tony Vroon <chainsaw@gentoo.org>
Subject: [PATCH 2.6.22 3/3] Add LED trigger to libata core
Date: Mon, 19 Mar 2007 21:49:06 +0000 (GMT)
Message-ID: <20070319214907.094B65B80F2@ganymede.vroon.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ganymede.vroon.org ([195.66.242.11]:56007 "EHLO
	ganymede.vroon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030684AbXCSVtT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Mar 2007 17:49:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: htejun@gmail.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

The first user of ata_ac_issue_prot_with_ledtrigger, the ServerWorks Frodo/
Apple K2 driver. Used by the IDE LED trigger on G5 towers.
Respin of an earlier patch, based on comments by Tejun Heo & Alan Cox.

Signed-off-by: Tony Vroon <chainsaw@gentoo.org>

--- linux-2.6/drivers/ata/sata_svw.c.orig	2007-03-19 20:58:20.000000000 +0000
+++ linux-2.6/drivers/ata/sata_svw.c	2007-03-19 20:58:35.000000000 +0000
@@ -348,7 +348,7 @@
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
+	.qc_issue		= ata_qc_issue_prot_with_ledtrigger,
 	.data_xfer		= ata_data_xfer,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
