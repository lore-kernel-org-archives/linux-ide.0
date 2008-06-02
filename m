From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/9] ide-cs: use struct ide_port_info
Date: Mon, 02 Jun 2008 22:24:04 +0200
Message-ID: <20080602202404.7265.39402.sendpatchset@localhost.localdomain>
References: <20080602202253.7265.23590.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:17008 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692AbYFBUWg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2008 16:22:36 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1229319mue.1
        for <linux-ide@vger.kernel.org>; Mon, 02 Jun 2008 13:22:36 -0700 (PDT)
In-Reply-To: <20080602202253.7265.23590.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Convert the driver to use struct ide_port_info.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/ide-cs.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: b/drivers/ide/legacy/ide-cs.c
===================================================================
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -150,6 +150,11 @@ static const struct ide_port_ops idecs_p
 	.quirkproc		= ide_undecoded_slave,
 };
 
+static const struct ide_port_info idecs_port_info = {
+	.port_ops		= &idecs_port_ops,
+	.host_flags		= IDE_HFLAG_NO_DMA,
+};
+
 static ide_hwif_t *idecs_register(unsigned long io, unsigned long ctl,
 				unsigned long irq, struct pcmcia_device *handle)
 {
@@ -184,11 +189,10 @@ static ide_hwif_t *idecs_register(unsign
     i = hwif->index;
 
     ide_init_port_hw(hwif, &hw);
-    hwif->port_ops = &idecs_port_ops;
 
     idx[0] = i;
 
-    ide_device_add(idx, NULL);
+    ide_device_add(idx, &idecs_port_info);
 
     if (hwif->present)
 	return hwif;
