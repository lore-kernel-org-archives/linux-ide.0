From: akpm@linux-foundation.org
Subject: [patch 21/30] pata_sc1200: set cable type, add freeze/thaw methods
Date: Tue, 06 Mar 2007 02:38:07 -0800
Message-ID: <200703061038.l26Ac7Od019527@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34468 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934047AbXCFKiZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:25 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_sc1200.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/ata/pata_sc1200.c~pata_sc1200-set-cable-type-add-freeze-thaw-methods drivers/ata/pata_sc1200.c
--- a/drivers/ata/pata_sc1200.c~pata_sc1200-set-cable-type-add-freeze-thaw-methods
+++ a/drivers/ata/pata_sc1200.c
@@ -216,6 +216,7 @@ static struct ata_port_operations sc1200
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
_
