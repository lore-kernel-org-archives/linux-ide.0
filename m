From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2] pdc202xx_old: wire test_irq() method for PDC2026x
Date: Wed, 14 Apr 2010 19:50:26 +0400
Message-ID: <201004141950.27083.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:47308 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755863Ab0DNPvS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Apr 2010 11:51:18 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net, linux-ide@vger.kernel.org
Cc: rmk@arm.linux.org.uk

In the commit e0321fbe6d34b4bb514fb6daff9e0859e5d76001 (pdc202xx_old: implement
test_irq() method (take 2)) I forgot to modify 'pdc2026x_port_ops'... :-/

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of ide-2.6.git tree...

 drivers/ide/pdc202xx_old.c |    1 +
 1 file changed, 1 insertion(+)

Index: ide-2.6/drivers/ide/pdc202xx_old.c
===================================================================
--- ide-2.6.orig/drivers/ide/pdc202xx_old.c
+++ ide-2.6/drivers/ide/pdc202xx_old.c
@@ -241,6 +241,7 @@ static const struct ide_port_ops pdc2024
 static const struct ide_port_ops pdc2026x_port_ops = {
 	.set_pio_mode		= pdc202xx_set_pio_mode,
 	.set_dma_mode		= pdc202xx_set_mode,
+	.test_irq		= pdc202xx_test_irq,
 	.cable_detect		= pdc2026x_cable_detect,
 };
 
