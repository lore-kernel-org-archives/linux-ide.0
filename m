From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patches] IDE fixes
Date: Fri, 20 Apr 2007 22:19:30 +0200
Message-ID: <200704202219.30464.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:35965 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993320AbXDTUPR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2007 16:15:17 -0400
Received: by ug-out-1314.google.com with SMTP id 44so975039uga
        for <linux-ide@vger.kernel.org>; Fri, 20 Apr 2007 13:15:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hopefully the last update for 2.6.21.

Please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 drivers/ide/Kconfig         |    1 +
 drivers/ide/pci/delkin_cb.c |    1 +
 drivers/ide/pci/hpt366.c    |    5 +++--
 3 files changed, 5 insertions(+), 2 deletions(-)


Bartlomiej Zolnierkiewicz (1):
      ide/Kconfig: add missing range check for IDE_MAX_HWIFS

Mark Lord (1):
      ide/pci/delkin_cb.c: add new PCI ID

Sergei Shtylyov (1):
      hpt366: fix kernel oops with HPT302N


diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index ca2e4f8..5bdf64b 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -57,6 +57,7 @@ if IDE
 config IDE_MAX_HWIFS
 	int "Max IDE interfaces"
 	depends on ALPHA || SUPERH || IA64 || EMBEDDED
+	range 1 10
 	default 4
 	help
 	  This is the maximum number of IDE hardware interfaces that will
diff --git a/drivers/ide/pci/delkin_cb.c b/drivers/ide/pci/delkin_cb.c
index d4b753e..dd7ec37 100644
--- a/drivers/ide/pci/delkin_cb.c
+++ b/drivers/ide/pci/delkin_cb.c
@@ -108,6 +108,7 @@ delkin_cb_remove (struct pci_dev *dev)
 
 static struct pci_device_id delkin_cb_pci_tbl[] __devinitdata = {
 	{ 0x1145, 0xf021, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ 0x1145, 0xf024, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, delkin_cb_pci_tbl);
diff --git a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
index 60ecdc2..ab6fa27 100644
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1,10 +1,10 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.01	Dec 23, 2006
+ * linux/drivers/ide/pci/hpt366.c		Version 1.02	Apr 18, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
- * Portions Copyright (C) 2005-2006	MontaVista Software, Inc.
+ * Portions Copyright (C) 2005-2007	MontaVista Software, Inc.
  *
  * Thanks to HighPoint Technologies for their assistance, and hardware.
  * Special Thanks to Jon Burchmore in SanDiego for the deep pockets, his
@@ -494,6 +494,7 @@ static struct hpt_info hpt302n __devinitdata = {
 	.chip_type	= HPT302N,
 	.max_mode	= HPT302_ALLOW_ATA133_6 ? 4 : 3,
 	.dpll_clk	= 77,
+	.settings	= hpt37x_settings
 };
 
 static struct hpt_info hpt371n __devinitdata = {
