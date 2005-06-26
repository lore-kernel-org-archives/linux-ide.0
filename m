From: maximilian attems <janitor@sternwelten.at>
Subject: [patch 1/13] ide hotplug mark __devinit alim15x3.c
Date: Sun, 26 Jun 2005 18:45:57 +0200
Message-ID: <20050626164557.GI12811@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:56247 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261452AbVFZRE7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 13:04:59 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch.

see the thread about the pci hotplug crash on a stratus box.
http://marc.theaimsgroup.com/?l=linux-kernel&m=111930108613386&w=2


Signed-off-by: maximilian attems <janitor@sternwelten.at>

diff -aurN a/drivers/ide/pci/alim15x3.c b/drivers/ide/pci/alim15x3.c
--- a/drivers/ide/pci/alim15x3.c	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/pci/alim15x3.c	2005-06-15 22:01:23.000000000 -0400
@@ -583,7 +583,7 @@
  *	appropriate also sets up the 1533 southbridge.
  */
   
-static unsigned int __init init_chipset_ali15x3 (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_ali15x3 (struct pci_dev *dev, const char *name)
 {
 	unsigned long flags;
 	u8 tmpbyte;
@@ -677,7 +677,7 @@
  *	FIXME: frobs bits that are not defined on newer ALi devicea
  */
 
-static unsigned int __init ata66_ali15x3 (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_ali15x3 (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev	= hwif->pci_dev;
 	unsigned int ata66	= 0;
@@ -748,7 +748,7 @@
  *	Initialize the IDE structure side of the ALi 15x3 driver.
  */
  
-static void __init init_hwif_common_ali15x3 (ide_hwif_t *hwif)
+static void __devinit init_hwif_common_ali15x3 (ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 	hwif->tuneproc = &ali15x3_tune_drive;
@@ -794,7 +794,7 @@
  *	Sparc systems
  */
 
-static void __init init_hwif_ali15x3 (ide_hwif_t *hwif)
+static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
 {
 	u8 ideic, inmir;
 	s8 irq_routing_table[] = { -1,  9, 3, 10, 4,  5, 7,  6,
@@ -847,7 +847,7 @@
  *	the actual work.
  */
 
-static void __init init_dma_ali15x3 (ide_hwif_t *hwif, unsigned long dmabase)
+static void __devinit init_dma_ali15x3 (ide_hwif_t *hwif, unsigned long dmabase)
 {
 	if (m5229_revision < 0x20)
 		return;
