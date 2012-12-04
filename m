From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ahci: convert ata_link_printk() to ata_link_warn()
Date: Mon, 3 Dec 2012 23:39:31 -0500
Message-ID: <CAPgLHd-4yiFx+t2sgohyYgouvzRzGJkgG3kBFOuOM3MgvzpYJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:53927 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab2LDEjc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2012 23:39:32 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so422710qad.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2012 20:39:31 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: yongjun_wei@trendmicro.com.cn, linux-ide@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Using ata_link_warn() instead of ata_link_printk().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/ata/libahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 4201e53..320712a 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1384,7 +1384,7 @@ int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
 	if (rc == -EIO) {
 		irq_sts = readl(port_mmio + PORT_IRQ_STAT);
 		if (irq_sts & PORT_IRQ_BAD_PMP) {
-			ata_link_printk(link, KERN_WARNING,
+			ata_link_warn(link,
 					"applying PMP SRST workaround "
 					"and retrying\n");
 			rc = ahci_do_softreset(link, class, 0, deadline,


