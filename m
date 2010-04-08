From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] IDE: pass IRQ flags to the IDE core
Date: Thu, 8 Apr 2010 16:26:29 +0200
Message-ID: <q2rf69abfc31004080726scbf96429ub4d84a318835d53d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53343 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695Ab0DHO0a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 10:26:30 -0400
Received: by gyg13 with SMTP id 13so1194888gyg.19
        for <linux-ide@vger.kernel.org>; Thu, 08 Apr 2010 07:26:29 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: davem@davemloft.net

IDE: pass IRQ flags to the IDE core

This enables shared IRQs and other features to be used with platform devices

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Index: b/drivers/ide/ide_platform.c
===================================================================
--- a/drivers/ide/ide_platform.c	2010-04-02 01:02:33.000000000 +0200
+++ b/drivers/ide/ide_platform.c	2010-04-08 16:04:21.000000000 +0200
@@ -95,6 +95,7 @@
 	plat_ide_setup_ports(&hw, base, alt_base, pdata, res_irq->start);
 	hw.dev = &pdev->dev;

+	d.irq_flags = res_irq->flags;
 	if (mmio)
 		d.host_flags |= IDE_HFLAG_MMIO;
