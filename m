From: akpm@linux-foundation.org
Subject: [patch 1/1] pata-rb532-cf: platform_get_irq() failure ignored
Date: Tue, 12 May 2009 13:44:58 -0700
Message-ID: <200905122104.n4CL4DDB008142@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41119 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752738AbZELVKN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 May 2009 17:10:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, roel.kluin@gmail.com, alan@lxorguk.ukuu.org.uk, florian@openwrt.org, n0-1@freewrt.org

From: Roel Kluin <roel.kluin@gmail.com>

platform_get_irq() can return -ENXIO, but since 'irq' is an unsigned int,
it does not show when the IRQ resource wasn't found.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Acked-by: Phil Sutter <n0-1@freewrt.org>
Cc: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_rb532_cf.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/ata/pata_rb532_cf.c~pata-rb532-cf-platform_get_irq-failure-ignored drivers/ata/pata_rb532_cf.c
--- a/drivers/ata/pata_rb532_cf.c~pata-rb532-cf-platform_get_irq-failure-ignored
+++ a/drivers/ata/pata_rb532_cf.c
@@ -117,11 +117,12 @@ static __devinit int rb532_pata_driver_p
 		return -EINVAL;
 	}
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
+	ret = platform_get_irq(pdev, 0);
+	if (ret <= 0) {
 		dev_err(&pdev->dev, "no IRQ resource found\n");
 		return -ENOENT;
 	}
+	irq = ret;
 
 	gpio = irq_to_gpio(irq);
 	if (gpio < 0) {
_
