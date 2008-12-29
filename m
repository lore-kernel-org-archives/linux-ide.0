From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/6] ide: use ide_pci_is_in_compatibility_mode() helper in setup-pci.c
Date: Mon, 29 Dec 2008 20:04:22 +0100
Message-ID: <20081229190422.1020.53832.sendpatchset@localhost.localdomain>
References: <20081229190415.1020.43119.sendpatchset@localhost.localdomain>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752370AbYL2TEi@vger.kernel.org>
In-Reply-To: <20081229190415.1020.43119.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: use ide_pci_is_in_compatibility_mode() helper in setup-pci.c

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -519,8 +519,7 @@ static int do_ide_setup_pci_device(struc
 	if (ret < 0)
 		goto out;
 
-	/* Is it an "IDE storage" device in non-PCI mode? */
-	if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE && (dev->class & 5) != 5) {
+	if (ide_pci_is_in_compatibility_mode(dev)) {
 		if (noisy)
 			printk(KERN_INFO "%s %s: not 100%% native mode: will "
 				"probe irqs later\n", d->name, pci_name(dev));
