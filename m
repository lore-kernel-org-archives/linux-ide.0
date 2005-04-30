From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/ide/pci/sis5513.c: section fixes
Date: Sat, 30 Apr 2005 22:08:31 +0200
Message-ID: <20050430200831.GU3571@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261408AbVD3UOq@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Lionel.Bouton@inet6.fr, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

These three functions are referenced from the __devinitdata 
sis5513_chipset.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Apr 2005

 drivers/ide/pci/sis5513.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.12-rc3/drivers/ide/pci/sis5513.c.old	2005-04-21 04:26:36.000000000 +0200
+++ linux-2.6.12-rc3/drivers/ide/pci/sis5513.c	2005-04-21 04:27:32.000000000 +0200
@@ -726,7 +726,7 @@
 */
 
 /* Chip detection and general config */
-static unsigned int __init init_chipset_sis5513 (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_sis5513 (struct pci_dev *dev, const char *name)
 {
 	struct pci_dev *host;
 	int i = 0;
@@ -879,7 +879,7 @@
 	return 0;
 }
 
-static unsigned int __init ata66_sis5513 (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_sis5513 (ide_hwif_t *hwif)
 {
 	u8 ata66 = 0;
 
@@ -897,7 +897,7 @@
         return ata66;
 }
 
-static void __init init_hwif_sis5513 (ide_hwif_t *hwif)
+static void __devinit init_hwif_sis5513 (ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 
