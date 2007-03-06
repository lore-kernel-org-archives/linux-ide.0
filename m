From: akpm@linux-foundation.org
Subject: [patch 17/30] pata_ixp4xx_cf - set cable type
Date: Tue, 06 Mar 2007 02:38:03 -0800
Message-ID: <200703061038.l26Ac3uS019509@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34453 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934040AbXCFKiU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_ixp4xx_cf.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/ata/pata_ixp4xx_cf.c~pata_ixp4xx_cf-set-cable-type drivers/ata/pata_ixp4xx_cf.c
--- a/drivers/ata/pata_ixp4xx_cf.c~pata_ixp4xx_cf-set-cable-type
+++ a/drivers/ata/pata_ixp4xx_cf.c
@@ -129,6 +129,7 @@ static struct ata_port_operations ixp4xx
 	.qc_issue	= ata_qc_issue_prot,
 	.eng_timeout	= ata_eng_timeout,
 	.data_xfer	= ixp4xx_mmio_data_xfer,
+	.cable_detect	= ata_cable_40wire,
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ixp4xx_irq_clear,
_
