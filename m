From: akpm@linux-foundation.org
Subject: [patch 05/10] drivers/ata/pata_ixp4xx_cf.c: ioremap return code check
Date: Tue, 02 Oct 2007 13:53:01 -0700
Message-ID: <200710022053.l92Kr2gN021691@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33547 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753882AbXJBUxQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 16:53:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, postfailathushmaildotcom@yahoo.com, alan@lxorguk.ukuu.org.uk, htejun@gmail.com

From: Scott Thompson <postfailathushmaildotcom@yahoo.com>

Add missing ioremap return checks.

Signed-off-by: Scott Thompson <postfail <at> hushmail.com>
Acked-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_ixp4xx_cf.c |    3 +++
 1 file changed, 3 insertions(+)

diff -puN drivers/ata/pata_ixp4xx_cf.c~drivers-ata-pata_ixp4xx_cfc-ioremap-return-code-check drivers/ata/pata_ixp4xx_cf.c
--- a/drivers/ata/pata_ixp4xx_cf.c~drivers-ata-pata_ixp4xx_cfc-ioremap-return-code-check
+++ a/drivers/ata/pata_ixp4xx_cf.c
@@ -195,6 +195,9 @@ static __devinit int ixp4xx_pata_probe(s
 	data->cs0 = devm_ioremap(&pdev->dev, cs0->start, 0x1000);
 	data->cs1 = devm_ioremap(&pdev->dev, cs1->start, 0x1000);
 
+	if (!data->cs0 || !data->cs1)
+		return -ENOMEM;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq)
 		set_irq_type(irq, IRQT_RISING);
_
