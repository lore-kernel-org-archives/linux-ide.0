From: Clemens Buchacher <drizzd@aon.at>
Subject: [patch] MIN/MAX in ide-timing.h
Date: Thu, 8 Jul 2004 20:18:43 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040708181843.GA1370@moley.homelinux.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from L1206P27.dipool.highway.telekom.at ([62.46.214.187]:17397 "EHLO
	moley.homelinux.net") by vger.kernel.org with ESMTP id S266203AbUGJKMR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jul 2004 06:12:17 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: vojtech@suse.cz
Cc: Linux-ide list <linux-ide@vger.kernel.org>, kernel janitors list <kernel-janitors@lists.osdl.org>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I replaced the custom MIN/MAX macros with the type safe min/max macros
from linux/kernel.h.

The typecasts of the FIT macro parameters in amd74xx.c are a bit
asymmetric because min/max don't seem to return a value of the same type
as the parameters they are passed.

I do not have the hardware to test this. The patch is based on the
current bk kernel repository.

Clemens

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="minmax.stat"

 drivers/ide/ide-timing.h    |   25 ++++++++++++-------------
 drivers/ide/pci/amd74xx.c   |   14 +++++++-------
 drivers/ide/pci/via82cxxx.c |   14 +++++++-------
 3 files changed, 26 insertions(+), 27 deletions(-)

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="minmax.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/04 03:24:26+02:00 drizzd@aon 
#   replaced custom MIN/MAX macros with min/max from kernel.h
# 
# drivers/ide/pci/via82cxxx.c
#   2004/07/04 03:23:22+02:00 drizzd@aon +7 -7
#   added typecasts to satisfy min/max
# 
# drivers/ide/pci/amd74xx.c
#   2004/07/04 03:23:22+02:00 drizzd@aon +7 -7
#   added typecasts to satisfy min/max
# 
# drivers/ide/ide-timing.h
#   2004/07/04 03:23:22+02:00 drizzd@aon +12 -11
#   using min/max from kernel.h now
# 
# drivers/ide/ide-timing.h
#   2004/07/03 17:18:20+02:00 drizzd@aon +0 -2
#   removed unused macros
# 
diff -Nru a/drivers/ide/ide-timing.h b/drivers/ide/ide-timing.h
--- a/drivers/ide/ide-timing.h	2004-07-04 12:23:14 +02:00
+++ b/drivers/ide/ide-timing.h	2004-07-04 12:23:14 +02:00
@@ -27,6 +27,7 @@
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
+#include <linux/kernel.h>
 #include <linux/hdreg.h>
 
 #define XFER_PIO_5		0x0d
@@ -96,11 +97,9 @@
 #define IDE_TIMING_UDMA		0x80
 #define IDE_TIMING_ALL		0xff
 
-#define MIN(a,b)	((a)<(b)?(a):(b))
-#define MAX(a,b)	((a)>(b)?(a):(b))
-#define FIT(v,min,max)	MAX(MIN(v,max),min)
-#define ENOUGH(v,unit)	(((v)-1)/(unit)+1)
-#define EZ(v,unit)	((v)?ENOUGH(v,unit):0)
+#define FIT(v,vmin,vmax)	max(min(v,vmax),vmin)
+#define ENOUGH(v,unit)		(((v)-1)/(unit)+1)
+#define EZ(v,unit)		((v)?ENOUGH(v,unit):0)
 
 #define XFER_MODE	0xf0
 #define XFER_UDMA_133	0x48
@@ -188,14 +187,14 @@
 
 static void ide_timing_merge(struct ide_timing *a, struct ide_timing *b, struct ide_timing *m, unsigned int what)
 {
-	if (what & IDE_TIMING_SETUP  ) m->setup   = MAX(a->setup,   b->setup);
-	if (what & IDE_TIMING_ACT8B  ) m->act8b   = MAX(a->act8b,   b->act8b);
-	if (what & IDE_TIMING_REC8B  ) m->rec8b   = MAX(a->rec8b,   b->rec8b);
-	if (what & IDE_TIMING_CYC8B  ) m->cyc8b   = MAX(a->cyc8b,   b->cyc8b);
-	if (what & IDE_TIMING_ACTIVE ) m->active  = MAX(a->active,  b->active);
-	if (what & IDE_TIMING_RECOVER) m->recover = MAX(a->recover, b->recover);
-	if (what & IDE_TIMING_CYCLE  ) m->cycle   = MAX(a->cycle,   b->cycle);
-	if (what & IDE_TIMING_UDMA   ) m->udma    = MAX(a->udma,    b->udma);
+	if (what & IDE_TIMING_SETUP  ) m->setup   = max(a->setup,   b->setup);
+	if (what & IDE_TIMING_ACT8B  ) m->act8b   = max(a->act8b,   b->act8b);
+	if (what & IDE_TIMING_REC8B  ) m->rec8b   = max(a->rec8b,   b->rec8b);
+	if (what & IDE_TIMING_CYC8B  ) m->cyc8b   = max(a->cyc8b,   b->cyc8b);
+	if (what & IDE_TIMING_ACTIVE ) m->active  = max(a->active,  b->active);
+	if (what & IDE_TIMING_RECOVER) m->recover = max(a->recover, b->recover);
+	if (what & IDE_TIMING_CYCLE  ) m->cycle   = max(a->cycle,   b->cycle);
+	if (what & IDE_TIMING_UDMA   ) m->udma    = max(a->udma,    b->udma);
 }
 
 static struct ide_timing* ide_timing_find_mode(short speed)
diff -Nru a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
--- a/drivers/ide/pci/amd74xx.c	2004-07-04 12:23:14 +02:00
+++ b/drivers/ide/pci/amd74xx.c	2004-07-04 12:23:14 +02:00
@@ -205,20 +205,20 @@
 	unsigned char t;
 
 	pci_read_config_byte(dev, AMD_ADDRESS_SETUP, &t);
-	t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
+	t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, (short)4) - 1) << ((3 - dn) << 1));
 	pci_write_config_byte(dev, AMD_ADDRESS_SETUP, t);
 
 	pci_write_config_byte(dev, AMD_8BIT_TIMING + (1 - (dn >> 1)),
-		((FIT(timing->act8b, 1, 16) - 1) << 4) | (FIT(timing->rec8b, 1, 16) - 1));
+		((FIT(timing->act8b, 1, (short)16) - 1) << 4) | (FIT(timing->rec8b, 1, (short)16) - 1));
 
 	pci_write_config_byte(dev, AMD_DRIVE_TIMING + (3 - dn),
-		((FIT(timing->active, 1, 16) - 1) << 4) | (FIT(timing->recover, 1, 16) - 1));
+		((FIT(timing->active, 1, (short)16) - 1) << 4) | (FIT(timing->recover, 1, (short)16) - 1));
 
 	switch (amd_config->flags & AMD_UDMA) {
-		case AMD_UDMA_33:  t = timing->udma ? (0xc0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
-		case AMD_UDMA_66:  t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 2, 10)]) : 0x03; break;
-		case AMD_UDMA_100: t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 1, 10)]) : 0x03; break;
-		case AMD_UDMA_133: t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 1, 15)]) : 0x03; break;
+		case AMD_UDMA_33:  t = timing->udma ? (0xc0 | (FIT(timing->udma, 2, (short)5) - 2)) : 0x03; break;
+		case AMD_UDMA_66:  t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 2, (short)10)]) : 0x03; break;
+		case AMD_UDMA_100: t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 1, (short)10)]) : 0x03; break;
+		case AMD_UDMA_133: t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 1, (short)15)]) : 0x03; break;
 		default: return;
 	}
 
diff -Nru a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c	2004-07-04 12:23:14 +02:00
+++ b/drivers/ide/pci/via82cxxx.c	2004-07-04 12:23:14 +02:00
@@ -291,21 +291,21 @@
 
 	if (~via_config->flags & VIA_BAD_AST) {
 		pci_read_config_byte(dev, VIA_ADDRESS_SETUP, &t);
-		t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
+		t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, (short)4) - 1) << ((3 - dn) << 1));
 		pci_write_config_byte(dev, VIA_ADDRESS_SETUP, t);
 	}
 
 	pci_write_config_byte(dev, VIA_8BIT_TIMING + (1 - (dn >> 1)),
-		((FIT(timing->act8b, 1, 16) - 1) << 4) | (FIT(timing->rec8b, 1, 16) - 1));
+		((FIT(timing->act8b, 1, (short)16) - 1) << 4) | (FIT(timing->rec8b, 1, (short)16) - 1));
 
 	pci_write_config_byte(dev, VIA_DRIVE_TIMING + (3 - dn),
-		((FIT(timing->active, 1, 16) - 1) << 4) | (FIT(timing->recover, 1, 16) - 1));
+		((FIT(timing->active, 1, (short)16) - 1) << 4) | (FIT(timing->recover, 1, (short)16) - 1));
 
 	switch (via_config->flags & VIA_UDMA) {
-		case VIA_UDMA_33:  t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
-		case VIA_UDMA_66:  t = timing->udma ? (0xe8 | (FIT(timing->udma, 2, 9) - 2)) : 0x0f; break;
-		case VIA_UDMA_100: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 9) - 2)) : 0x07; break;
-		case VIA_UDMA_133: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 9) - 2)) : 0x07; break;
+		case VIA_UDMA_33:  t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, (short)5) - 2)) : 0x03; break;
+		case VIA_UDMA_66:  t = timing->udma ? (0xe8 | (FIT(timing->udma, 2, (short)9) - 2)) : 0x0f; break;
+		case VIA_UDMA_100: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, (short)9) - 2)) : 0x07; break;
+		case VIA_UDMA_133: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, (short)9) - 2)) : 0x07; break;
 		default: return;
 	}
 

--X1bOJ3K7DJ5YkBrT--
