From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] ide: fix crash at boot with siimage driver
Date: Tue, 29 Apr 2008 14:49:36 +1000
Message-ID: <1209444576.18023.128.camel@pasglop>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44478 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbYD2Eu3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 00:50:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, list linux-ide <linux-ide@vger.kernel.org>

Some change to the IDE layer are causing the siimage driver to crash
at boot with a NULL dereference. This is due to the sil_dma_ops not
containing all the necessary pointers. I suppose it used to just
"override" the defaults while now, it needs to contain everything.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Index: linux-work/drivers/ide/pci/siimage.c
===================================================================
--- linux-work.orig/drivers/ide/pci/siimage.c	2008-04-29 14:44:37.000000000 +1000
+++ linux-work/drivers/ide/pci/siimage.c	2008-04-29 14:44:44.000000000 +1000
@@ -780,7 +780,14 @@ static const struct ide_port_ops sil_sat
 };
 
 static struct ide_dma_ops sil_dma_ops = {
+	.dma_host_set		= ide_dma_host_set,
+	.dma_setup		= ide_dma_setup,
+	.dma_exec_cmd		= ide_dma_exec_cmd,
+	.dma_start		= ide_dma_start,
+	.dma_end		= __ide_dma_end,
 	.dma_test_irq		= siimage_dma_test_irq,
+	.dma_timeout		= ide_dma_timeout,
+	.dma_lost_irq		= ide_dma_lost_irq,
 };
 
 #define DECLARE_SII_DEV(name_str, p_ops)		\


