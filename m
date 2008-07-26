From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 05/10] ide: remove IDE_CHIPSET_* macros
Date: Sat, 26 Jul 2008 15:40:37 +0200
Message-ID: <20080726134037.10589.58019.sendpatchset@localhost.localdomain>
References: <20080726134010.10589.51679.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:42093 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830AbYGZNml (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jul 2008 09:42:41 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2728698fkq.5
        for <linux-ide@vger.kernel.org>; Sat, 26 Jul 2008 06:42:41 -0700 (PDT)
In-Reply-To: <20080726134010.10589.51679.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

They just obfuscate the code.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    3 ++-
 include/linux/ide.h     |    4 ----
 2 files changed, 2 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1105,7 +1105,8 @@ static int init_irq (ide_hwif_t *hwif)
 		sa = IRQF_SHARED;
 #endif /* __mc68000__ */
 
-		if (IDE_CHIPSET_IS_PCI(hwif->chipset))
+		if (hwif->chipset == ide_pci || hwif->chipset == ide_cmd646 ||
+		    hwif->chipset == ide_ali14xx)
 			sa = IRQF_SHARED;
 
 		if (io_ports->ctl_addr)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -482,10 +482,6 @@ typedef struct ide_drive_s ide_drive_t;
 
 #define to_ide_device(dev)container_of(dev, ide_drive_t, gendev)
 
-#define IDE_CHIPSET_PCI_MASK	\
-    ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
-#define IDE_CHIPSET_IS_PCI(c)	((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
-
 struct ide_task_s;
 struct ide_port_info;
 
