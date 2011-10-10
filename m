From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] ide: Fix file references in drivers/ide/
Date: Mon, 10 Oct 2011 11:37:00 -0700
Message-ID: <4E933B4C.5050104@xenotime.net>
References: <1317683499.5990.2.camel@LAPJFS>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317683499.5990.2.camel@LAPJFS>
Sender: linux-kernel-owner@vger.kernel.org
To: Johann Felix Soden <johfel@gmx.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, trivial@kernel.org, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: linux-ide@vger.kernel.org

From: Johann Felix Soden <johfel@users.sourceforge.net>

Fix file references in drivers/ide/

There are a lot of file references to now moved or deleted files in the
whole tree, especially in documentation and Kconfig files. This patch
fixes the references in drivers/ide/.

Signed-off-by: Johann Felix Soden <johfel@users.sourceforge.net>
Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/ide/Kconfig |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- lnx-31-rc9.orig/drivers/ide/Kconfig
+++ lnx-31-rc9/drivers/ide/Kconfig
@@ -327,7 +327,7 @@ config BLK_DEV_OPTI621
 	select BLK_DEV_IDEPCI
 	help
 	  This is a driver for the OPTi 82C621 EIDE controller.
-	  Please read the comments at the top of <file:drivers/ide/pci/opti621.c>.
+	  Please read the comments at the top of <file:drivers/ide/opti621.c>.
 
 config BLK_DEV_RZ1000
 	tristate "RZ1000 chipset bugfix/support"
@@ -365,7 +365,7 @@ config BLK_DEV_ALI15X3
 	  normal dual channel support.
 
 	  Please read the comments at the top of
-	  <file:drivers/ide/pci/alim15x3.c>.
+	  <file:drivers/ide/alim15x3.c>.
 
 	  If unsure, say N.
 
@@ -528,7 +528,7 @@ config BLK_DEV_NS87415
 	  This driver adds detection and support for the NS87415 chip
 	  (used mainly on SPARC64 and PA-RISC machines).
 
-	  Please read the comments at the top of <file:drivers/ide/pci/ns87415.c>.
+	  Please read the comments at the top of <file:drivers/ide/ns87415.c>.
 
 config BLK_DEV_PDC202XX_OLD
 	tristate "PROMISE PDC202{46|62|65|67} support"
@@ -547,7 +547,7 @@ config BLK_DEV_PDC202XX_OLD
 	  for more than one card.
 
 	  Please read the comments at the top of
-	  <file:drivers/ide/pci/pdc202xx_old.c>.
+	  <file:drivers/ide/pdc202xx_old.c>.
 
 	  If unsure, say N.
 
@@ -593,7 +593,7 @@ config BLK_DEV_SIS5513
 	  ATA100: SiS635, SiS645, SiS650, SiS730, SiS735, SiS740,
 	  SiS745, SiS750
 
-	  Please read the comments at the top of <file:drivers/ide/pci/sis5513.c>.
+	  Please read the comments at the top of <file:drivers/ide/sis5513.c>.
 
 config BLK_DEV_SL82C105
 	tristate "Winbond SL82c105 support"
@@ -616,7 +616,7 @@ config BLK_DEV_SLC90E66
 	  look-a-like to the PIIX4 it should be a nice addition.
 
 	  Please read the comments at the top of
-	  <file:drivers/ide/pci/slc90e66.c>.
+	  <file:drivers/ide/slc90e66.c>.
 
 config BLK_DEV_TRM290
 	tristate "Tekram TRM290 chipset support"
@@ -625,7 +625,7 @@ config BLK_DEV_TRM290
 	  This driver adds support for bus master DMA transfers
 	  using the Tekram TRM290 PCI IDE chip. Volunteers are
 	  needed for further tweaking and development.
-	  Please read the comments at the top of <file:drivers/ide/pci/trm290.c>.
+	  Please read the comments at the top of <file:drivers/ide/trm290.c>.
 
 config BLK_DEV_VIA82CXXX
 	tristate "VIA82CXXX chipset support"
@@ -836,7 +836,7 @@ config BLK_DEV_ALI14XX
 	  of the ALI M1439/1443/1445/1487/1489 chipsets, and permits faster
 	  I/O speeds to be set as well.
 	  See the files <file:Documentation/ide/ide.txt> and
-	  <file:drivers/ide/legacy/ali14xx.c> for more info.
+	  <file:drivers/ide/ali14xx.c> for more info.
 
 config BLK_DEV_DTC2278
 	tristate "DTC-2278 support"
@@ -847,7 +847,7 @@ config BLK_DEV_DTC2278
 	  boot parameter. It enables support for the secondary IDE interface
 	  of the DTC-2278 card, and permits faster I/O speeds to be set as
 	  well. See the <file:Documentation/ide/ide.txt> and
-	  <file:drivers/ide/legacy/dtc2278.c> files for more info.
+	  <file:drivers/ide/dtc2278.c> files for more info.
 
 config BLK_DEV_HT6560B
 	tristate "Holtek HT6560B support"
@@ -858,7 +858,7 @@ config BLK_DEV_HT6560B
 	  boot parameter. It enables support for the secondary IDE interface
 	  of the Holtek card, and permits faster I/O speeds to be set as well.
 	  See the <file:Documentation/ide/ide.txt> and
-	  <file:drivers/ide/legacy/ht6560b.c> files for more info.
+	  <file:drivers/ide/ht6560b.c> files for more info.
 
 config BLK_DEV_QD65XX
 	tristate "QDI QD65xx support"
@@ -867,7 +867,7 @@ config BLK_DEV_QD65XX
 	help
 	  This driver is enabled at runtime using the "qd65xx.probe" kernel
 	  boot parameter.  It permits faster I/O speeds to be set.  See the
-	  <file:Documentation/ide/ide.txt> and <file:drivers/ide/legacy/qd65xx.c>
+	  <file:Documentation/ide/ide.txt> and <file:drivers/ide/qd65xx.c>
 	  for more info.
 
 config BLK_DEV_UMC8672
@@ -879,7 +879,7 @@ config BLK_DEV_UMC8672
 	  boot parameter. It enables support for the secondary IDE interface
 	  of the UMC-8672, and permits faster I/O speeds to be set as well.
 	  See the files <file:Documentation/ide/ide.txt> and
-	  <file:drivers/ide/legacy/umc8672.c> for more info.
+	  <file:drivers/ide/umc8672.c> for more info.
 
 endif
 
