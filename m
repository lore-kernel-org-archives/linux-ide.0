From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_at91: call clk_put() on ata_host_activate() failure
Date: Mon, 10 Oct 2011 19:09:17 +0400
Message-ID: <201110101909.17566.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:45099 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750786Ab1JJPKo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Oct 2011 11:10:44 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

pata_at91_probe() forgets to call clk_put() iff ata_host_activate() fails...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent Linus' tree.

 drivers/ata/pata_at91.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/ata/pata_at91.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_at91.c
+++ linux-2.6/drivers/ata/pata_at91.c
@@ -414,10 +414,13 @@ static int __devinit pata_at91_probe(str
 
 	host->private_data = info;
 
-	return ata_host_activate(host, irq ? gpio_to_irq(irq) : 0,
+	ret = ata_host_activate(host, irq ? gpio_to_irq(irq) : 0,
 			irq ? ata_sff_interrupt : NULL,
 			irq_flags, &pata_at91_sht);
 
+	if (!ret)
+		return 0;
+
 err_put:
 	clk_put(info->mck);
 	return ret;
