From: akpm@linux-foundation.org
Subject: [patch 09/30] pata_platform: set a cable type (which to set ?)
Date: Tue, 06 Mar 2007 02:37:57 -0800
Message-ID: <200703061037.l26AbvZF019484@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34452 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934038AbXCFKiU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_platform.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/ata/pata_platform.c~pata_platform-set-a-cable-type-which-to-set drivers/ata/pata_platform.c
--- a/drivers/ata/pata_platform.c~pata_platform-set-a-cable-type-which-to-set
+++ a/drivers/ata/pata_platform.c
@@ -80,6 +80,7 @@ static struct ata_port_operations pata_p
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_unknown,
 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
_
