From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ata: ahci_sunxi: fix code formatting
Date: Mon, 17 Mar 2014 14:08:12 +0100
Message-ID: <10509185.3UEOEZKTc5@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Oliver Schinagl <oliver@schinagl.nl>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/ahci_sunxi.c |   44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

Index: b/drivers/ata/ahci_sunxi.c
===================================================================
--- a/drivers/ata/ahci_sunxi.c	2014-03-17 13:59:06.220474478 +0100
+++ b/drivers/ata/ahci_sunxi.c	2014-03-17 14:00:48.720472730 +0100
@@ -27,28 +27,28 @@
 #include <linux/regulator/consumer.h>
 #include "ahci.h"
 
-#define AHCI_BISTAFR 0x00a0
-#define AHCI_BISTCR 0x00a4
-#define AHCI_BISTFCTR 0x00a8
-#define AHCI_BISTSR 0x00ac
-#define AHCI_BISTDECR 0x00b0
-#define AHCI_DIAGNR0 0x00b4
-#define AHCI_DIAGNR1 0x00b8
-#define AHCI_OOBR 0x00bc
-#define AHCI_PHYCS0R 0x00c0
-#define AHCI_PHYCS1R 0x00c4
-#define AHCI_PHYCS2R 0x00c8
-#define AHCI_TIMER1MS 0x00e0
-#define AHCI_GPARAM1R 0x00e8
-#define AHCI_GPARAM2R 0x00ec
-#define AHCI_PPARAMR 0x00f0
-#define AHCI_TESTR 0x00f4
-#define AHCI_VERSIONR 0x00f8
-#define AHCI_IDR 0x00fc
-#define AHCI_RWCR 0x00fc
-#define AHCI_P0DMACR 0x0170
-#define AHCI_P0PHYCR 0x0178
-#define AHCI_P0PHYSR 0x017c
+#define AHCI_BISTAFR	0x00a0
+#define AHCI_BISTCR	0x00a4
+#define AHCI_BISTFCTR	0x00a8
+#define AHCI_BISTSR	0x00ac
+#define AHCI_BISTDECR	0x00b0
+#define AHCI_DIAGNR0	0x00b4
+#define AHCI_DIAGNR1	0x00b8
+#define AHCI_OOBR	0x00bc
+#define AHCI_PHYCS0R	0x00c0
+#define AHCI_PHYCS1R	0x00c4
+#define AHCI_PHYCS2R	0x00c8
+#define AHCI_TIMER1MS	0x00e0
+#define AHCI_GPARAM1R	0x00e8
+#define AHCI_GPARAM2R	0x00ec
+#define AHCI_PPARAMR	0x00f0
+#define AHCI_TESTR	0x00f4
+#define AHCI_VERSIONR	0x00f8
+#define AHCI_IDR	0x00fc
+#define AHCI_RWCR	0x00fc
+#define AHCI_P0DMACR	0x0170
+#define AHCI_P0PHYCR	0x0178
+#define AHCI_P0PHYSR	0x017c
 
 static void sunxi_clrbits(void __iomem *reg, u32 clr_val)
 {
