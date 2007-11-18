From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/21] ide: don't try to unregister interfaces if 'initializing' in ide_register_hw()
Date: Sun, 18 Nov 2007 23:19:59 +0100
Message-ID: <200711182319.59382.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:48819 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbXKRWgh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:37 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873018ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:36 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Host drivers using ide_register_hw() and 'initializing == 1':

* ide-pnp
  - depends on ISA

* ide_arm 
  - ARM arch specific
  - initialized before all other host drivers

* ide-cris
  - CRIS arch specific => IDE_ARCH_OBSOLETE_INIT is not defined
  - broken

* ide-h8300
  - H8300 arch specific => IDE_ARCH_OBSOLETE_INIT is not defined, no PCI

* buddha/q40/gayle/macide/falconide
  - M68K arch specific => IDE_ARCH_OBSOLETE_INIT is not defined, no PCI

Since the only host drivers which probe interfaces before the above ones are:

* ali14xx/dtc2278/ht6560b/qd65xx/umc8672
  - depend on ISA
  - require IDE_ARCH_OBSOLETE_INIT=y to work

* PCI ones
  - depend on PCI

don't try to unregister interfaces if 'initializing == 1' in ide_register_hw()
(it is possible that built-in host drivers will claim all IDE interfaces but
later ide-pnp host driver will try to unregister them - this change fixes it).

Also skip hwif->hold check if 'initializing == 1' since it is set only by:

* pmac
  - PPC && PMAC specific => no ISA

* au1xxx-ide
  - MIPS && SOC_AU1200 specific => no ISA

and use ide_find_port() helper to find free ide_hwifs[] slot.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -694,6 +694,15 @@ int ide_register_hw(hw_regs_t *hw, void 
 	int index, retry = 1;
 	ide_hwif_t *hwif;
 
+	if (initializing) {
+		hwif = ide_find_port(hw->io_ports[IDE_DATA_OFFSET]);
+		if (hwif) {
+			index = hwif->index;
+			goto found;
+		}
+		return -1;
+	}
+
 	do {
 		for (index = 0; index < MAX_HWIFS; ++index) {
 			hwif = &ide_hwifs[index];
@@ -704,8 +713,7 @@ int ide_register_hw(hw_regs_t *hw, void 
 			hwif = &ide_hwifs[index];
 			if (hwif->hold)
 				continue;
-			if ((!hwif->present && !hwif->mate && !initializing) ||
-			    (!hwif->io_ports[IDE_DATA_OFFSET] && initializing))
+			if (!hwif->present && hwif->mate == NULL)
 				goto found;
 		}
 		for (index = 0; index < MAX_HWIFS; index++)
