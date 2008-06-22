From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] gayle: reserve memory resources at once
Date: Sun, 22 Jun 2008 19:16:58 +0200
Message-ID: <200806221916.59751.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:21972 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbYFVRQE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jun 2008 13:16:04 -0400
Received: by an-out-0708.google.com with SMTP id d40so502024and.103
        for <linux-ide@vger.kernel.org>; Sun, 22 Jun 2008 10:16:01 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

* Reserve memory resources for all IDE ports at once by moving
  request_mem_region() out of 'for ()' loop and always defining
  GAYLE_IDEREG_SIZE to 0x2000.

* Keep memory resources even if no free IDE slots can be found
  (this driver is unloadable currently).

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/gayle.c |   25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

Index: b/drivers/ide/legacy/gayle.c
===================================================================
--- a/drivers/ide/legacy/gayle.c
+++ b/drivers/ide/legacy/gayle.c
@@ -31,6 +31,8 @@
 #define GAYLE_BASE_4000	0xdd2020	/* A4000/A4000T */
 #define GAYLE_BASE_1200	0xda0000	/* A1200/A600 and E-Matrix 530 */
 
+#define GAYLE_IDEREG_SIZE	0x2000
+
     /*
      *  Offsets from one of the above bases
      */
@@ -56,13 +58,11 @@
 #define GAYLE_NUM_HWIFS		1
 #define GAYLE_NUM_PROBE_HWIFS	GAYLE_NUM_HWIFS
 #define GAYLE_HAS_CONTROL_REG	1
-#define GAYLE_IDEREG_SIZE	0x2000
 #else /* CONFIG_BLK_DEV_IDEDOUBLER */
 #define GAYLE_NUM_HWIFS		2
 #define GAYLE_NUM_PROBE_HWIFS	(ide_doubler ? GAYLE_NUM_HWIFS : \
 					       GAYLE_NUM_HWIFS-1)
 #define GAYLE_HAS_CONTROL_REG	(!ide_doubler)
-#define GAYLE_IDEREG_SIZE	(ide_doubler ? 0x1000 : 0x2000)
 
 static int ide_doubler;
 module_param_named(doubler, ide_doubler, bool, 0);
@@ -124,6 +124,9 @@ static void __init gayle_setup_ports(hw_
 
 static int __init gayle_init(void)
 {
+    unsigned long phys_base, res_start, res_n;
+    unsigned long base, ctrlport, irqport;
+    ide_ack_intr_t *ack_intr;
     int a4000, i;
     hw_regs_t hw[GAYLE_NUM_HWIFS], *hws[] = { NULL, NULL, NULL, NULL };
     u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
@@ -149,12 +152,6 @@ found:
 #endif
 			 "");
 
-    for (i = 0; i < GAYLE_NUM_PROBE_HWIFS; i++) {
-	unsigned long base, ctrlport, irqport;
-	ide_ack_intr_t *ack_intr;
-	ide_hwif_t *hwif;
-	unsigned long phys_base, res_start, res_n;
-
 	if (a4000) {
 	    phys_base = GAYLE_BASE_4000;
 	    irqport = (unsigned long)ZTWO_VADDR(GAYLE_IRQ_4000);
@@ -168,15 +165,16 @@ found:
  * FIXME: we now have selectable modes between mmio v/s iomio
  */
 
-	phys_base += i*GAYLE_NEXT_PORT;
-
 	res_start = ((unsigned long)phys_base) & ~(GAYLE_NEXT_PORT-1);
 	res_n = GAYLE_IDEREG_SIZE;
 
 	if (!request_mem_region(res_start, res_n, "IDE"))
-	    continue;
+		return -EBUSY;
 
-	base = (unsigned long)ZTWO_VADDR(phys_base);
+    for (i = 0; i < GAYLE_NUM_PROBE_HWIFS; i++) {
+	ide_hwif_t *hwif;
+
+	base = (unsigned long)ZTWO_VADDR(phys_base + i * GAYLE_NEXT_PORT);
 	ctrlport = GAYLE_HAS_CONTROL_REG ? (base + GAYLE_CONTROL) : 0;
 
 	gayle_setup_ports(&hw[i], base, ctrlport, irqport, ack_intr);
@@ -187,8 +185,7 @@ found:
 
 	    hws[i] = &hw[i];
 	    idx[i] = hwif->index;
-	} else
-	    release_mem_region(res_start, res_n);
+	}
     }
 
     ide_device_add(idx, NULL, hws);
