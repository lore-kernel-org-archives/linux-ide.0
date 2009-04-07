From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] cs5536: define dma_sff_read_status() method
Date: Tue, 7 Apr 2009 20:03:40 +0400
Message-ID: <200904072003.40866.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:40588 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758196AbZDGQDD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Apr 2009 12:03:03 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, stable@kernel.org

The driver somehow got merged with the initializer for the dma_sff_read_status()
method missing which caused kernel panic on bootup.

This should fix the kernel.org bug #13026...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent Linus' tree.
It should go into 2.6.29-stable as the driver was merged/broken in 2.6.29 time.

 drivers/ide/cs5536.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6/drivers/ide/cs5536.c
===================================================================
--- linux-2.6.orig/drivers/ide/cs5536.c
+++ linux-2.6/drivers/ide/cs5536.c
@@ -236,6 +236,7 @@ static const struct ide_dma_ops cs5536_d
 	.dma_test_irq		= ide_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timer_expiry	= ide_dma_sff_timer_expiry,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
 static const struct ide_port_info cs5536_info = {

