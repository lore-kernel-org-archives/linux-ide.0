From: akpm@linux-foundation.org
Subject: [patch 16/30] pata_isapnp: set cable type
Date: Tue, 06 Mar 2007 02:38:02 -0800
Message-ID: <200703061038.l26Ac2OM019506@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34476 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934051AbXCFKi1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_isapnp.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/ata/pata_isapnp.c~pata_isapnp-set-cable-type drivers/ata/pata_isapnp.c
--- a/drivers/ata/pata_isapnp.c~pata_isapnp-set-cable-type
+++ a/drivers/ata/pata_isapnp.c
@@ -49,6 +49,7 @@ static struct ata_port_operations isapnp
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
_
