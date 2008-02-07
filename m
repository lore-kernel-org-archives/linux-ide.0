From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2.5/3] palm_bk3710: port initialization/probing bugfix
Date: Thu, 7 Feb 2008 21:50:34 +0100
Message-ID: <200802072150.34389.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:11556 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213AbYBGUij (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 15:38:39 -0500
Received: by wx-out-0506.google.com with SMTP id h31so3799325wxd.4
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 12:38:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Anton Salnikov <asalnikov@ru.mvista.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>


Probe port _after_ it is fully initialized.

Cc: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/palm_bk3710.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: b/drivers/ide/arm/palm_bk3710.c
===================================================================
--- a/drivers/ide/arm/palm_bk3710.c
+++ b/drivers/ide/arm/palm_bk3710.c
@@ -370,13 +370,6 @@ static int __devinit palm_bk3710_probe(s
 	ide_init_port_hw(hwif, &hw);
 	hwif->quirkproc = NULL;
 
-	idx[0] = i;
-
-	ide_device_add(idx, NULL);
-
-	if (!hwif->present)
-		goto out;
-
 	hwif->set_pio_mode = &palm_bk3710_set_pio_mode;
 	hwif->set_dma_mode = &palm_bk3710_set_dma_mode;
 	hwif->mmio = 1;
@@ -390,6 +383,13 @@ static int __devinit palm_bk3710_probe(s
 
 	ide_setup_dma(hwif, mem->start);
 
+	idx[0] = i;
+
+	ide_device_add(idx, NULL);
+
+	if (!hwif->present)
+		goto out;
+
 	return 0;
 out:
 	printk(KERN_WARNING "Palm Chip BK3710 IDE Register Fail\n");
