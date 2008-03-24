From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/5] ide: sanitize ide_unregister() usage
Date: Mon, 24 Mar 2008 19:53:30 +0100
Message-ID: <20080324185330.15320.19056.sendpatchset@localhost.localdomain>
References: <20080324185324.15320.23248.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:35228 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761459AbYCXSi2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Mar 2008 14:38:28 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3068219fgb.17
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2008 11:38:27 -0700 (PDT)
In-Reply-To: <20080324185324.15320.23248.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Remove ide_unregister() call from ide_exit()
  (host drivers take care of unregistering hwif-s themselves).

* Remove ide_unregister() call from probe methods of
  bast-ide, palm_bk3710, ide-cs and delkin_cb host drivers
  (ide_find_port() returns only free ide_hwifs[] entries).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/bast-ide.c    |    6 +-----
 drivers/ide/arm/palm_bk3710.c |    6 +-----
 drivers/ide/ide.c             |    5 -----
 drivers/ide/legacy/ide-cs.c   |    6 +-----
 drivers/ide/pci/delkin_cb.c   |    6 +-----
 5 files changed, 4 insertions(+), 25 deletions(-)

Index: b/drivers/ide/arm/bast-ide.c
===================================================================
--- a/drivers/ide/arm/bast-ide.c
+++ b/drivers/ide/arm/bast-ide.c
@@ -49,11 +49,7 @@ static int __init bastide_register(unsig
 
 	i = hwif->index;
 
-	if (hwif->present)
-		ide_unregister(i);
-	else
-		ide_init_port_data(hwif, i);
-
+	ide_init_port_data(hwif, i);
 	ide_init_port_hw(hwif, &hw);
 	hwif->port_ops = NULL;
 
Index: b/drivers/ide/arm/palm_bk3710.c
===================================================================
--- a/drivers/ide/arm/palm_bk3710.c
+++ b/drivers/ide/arm/palm_bk3710.c
@@ -398,11 +398,7 @@ static int __devinit palm_bk3710_probe(s
 
 	i = hwif->index;
 
-	if (hwif->present)
-		ide_unregister(i);
-	else
-		ide_init_port_data(hwif, i);
-
+	ide_init_port_data(hwif, i);
 	ide_init_port_hw(hwif, &hw);
 
 	hwif->mmio = 1;
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1041,11 +1041,6 @@ out_port_class:
 
 static void __exit ide_exit(void)
 {
-	int index;
-
-	for (index = 0; index < MAX_HWIFS; ++index)
-		ide_unregister(index);
-
 	proc_ide_destroy();
 
 	class_destroy(ide_port_class);
Index: b/drivers/ide/legacy/ide-cs.c
===================================================================
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -183,11 +183,7 @@ static ide_hwif_t *idecs_register(unsign
 
     i = hwif->index;
 
-    if (hwif->present)
-	ide_unregister(i);
-    else
-	ide_init_port_data(hwif, i);
-
+    ide_init_port_data(hwif, i);
     ide_init_port_hw(hwif, &hw);
     hwif->port_ops = &idecs_port_ops;
 
Index: b/drivers/ide/pci/delkin_cb.c
===================================================================
--- a/drivers/ide/pci/delkin_cb.c
+++ b/drivers/ide/pci/delkin_cb.c
@@ -87,11 +87,7 @@ delkin_cb_probe (struct pci_dev *dev, co
 
 	i = hwif->index;
 
-	if (hwif->present)
-		ide_unregister(i);
-	else
-		ide_init_port_data(hwif, i);
-
+	ide_init_port_data(hwif, i);
 	ide_init_port_hw(hwif, &hw);
 	hwif->port_ops = &delkin_cb_port_ops;
 
