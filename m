From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [patch] MIN/MAX in ide-timing.h
Date: Sun, 11 Jul 2004 11:12:50 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040711091249.GG1991@moley.homelinux.net>
References: <20040708181843.GA1370@moley.homelinux.net> <20040710105529.22e81954.lcapitulino@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from L1198P27.dipool.highway.telekom.at ([62.46.213.187]:57582 "EHLO
	moley.homelinux.net") by vger.kernel.org with ESMTP id S266527AbUGKJLi
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Jul 2004 05:11:38 -0400
Content-Disposition: inline
In-Reply-To: <20040710105529.22e81954.lcapitulino@terra.com.br>
List-Id: linux-ide@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@terra.com.br>
Cc: vojtech@suse.cz, linux-ide@vger.kernel.org, kernel-janitors@lists.osdl.org

On Sat, Jul 10, 2004 at 10:55:29AM -0300, Luiz Fernando N. Capitulino wrote:
> | -#define MIN(a,b)	        ((a)<(b)?(a):(b))
> | -#define MAX(a,b)	        ((a)>(b)?(a):(b))
> | -#define FIT(v,min,max)	MAX(MIN(v,max),min)
> | -#define ENOUGH(v,unit)	(((v)-1)/(unit)+1)
> | -#define EZ(v,unit)	        ((v)?ENOUGH(v,unit):0)
> | +#define FIT(v,vmin,vmax)	max(min(v,vmax),vmin)
> | +#define ENOUGH(v,unit)	(((v)-1)/(unit)+1)
> | +#define EZ(v,unit)		((v)?ENOUGH(v,unit):0)
> 
>  Did you changed something in ENOUGH and EZ ?

Yes, I added an additional tab to line up with the FIT definition.

>  Maybe we can try to make it inlined functions, thus maybe is possible to
> solve the warning problem.

That's fine too.


 ide-timing.h    |   52 +++++++++++++++++++++++++++++++---------------------
 pci/amd74xx.c   |   14 +++++++-------
 pci/via82cxxx.c |   14 +++++++-------
 3 files changed, 45 insertions(+), 35 deletions(-)


diff -Nur a/drivers/ide/ide-timing.h b/drivers/ide/ide-timing.h
--- a/drivers/ide/ide-timing.h	2004-07-11 00:27:38 +02:00
+++ b/drivers/ide/ide-timing.h	2004-07-11 10:59:23 +02:00
@@ -27,6 +27,7 @@
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
+#include <linux/kernel.h>
 #include <linux/hdreg.h>
 
 #define XFER_PIO_5		0x0d
@@ -96,11 +97,20 @@
 #define IDE_TIMING_UDMA		0x80
 #define IDE_TIMING_ALL		0xff
 
-#define MIN(a,b)	((a)<(b)?(a):(b))
-#define MAX(a,b)	((a)>(b)?(a):(b))
-#define FIT(v,min,max)	MAX(MIN(v,max),min)
-#define ENOUGH(v,unit)	(((v)-1)/(unit)+1)
-#define EZ(v,unit)	((v)?ENOUGH(v,unit):0)
+static inline short fit(short val, short min, short max)
+{
+	return max_t(short, min_t(short, val, max), min);
+}
+
+static inline short enough(short val, short unit)
+{
+	return (val-1)/(unit+1);
+}
+
+static inline short enough_zero(short val, short unit)
+{
+	return val ? enough(val, unit) : 0;
+}
 
 #define XFER_MODE	0xf0
 #define XFER_UDMA_133	0x48
@@ -176,26 +186,26 @@
 
 static void ide_timing_quantize(struct ide_timing *t, struct ide_timing *q, int T, int UT)
 {
-	q->setup   = EZ(t->setup   * 1000,  T);
-	q->act8b   = EZ(t->act8b   * 1000,  T);
-	q->rec8b   = EZ(t->rec8b   * 1000,  T);
-	q->cyc8b   = EZ(t->cyc8b   * 1000,  T);
-	q->active  = EZ(t->active  * 1000,  T);
-	q->recover = EZ(t->recover * 1000,  T);
-	q->cycle   = EZ(t->cycle   * 1000,  T);
-	q->udma    = EZ(t->udma    * 1000, UT);
+	q->setup   = enough_zero(t->setup   * 1000,  T);
+	q->act8b   = enough_zero(t->act8b   * 1000,  T);
+	q->rec8b   = enough_zero(t->rec8b   * 1000,  T);
+	q->cyc8b   = enough_zero(t->cyc8b   * 1000,  T);
+	q->active  = enough_zero(t->active  * 1000,  T);
+	q->recover = enough_zero(t->recover * 1000,  T);
+	q->cycle   = enough_zero(t->cycle   * 1000,  T);
+	q->udma    = enough_zero(t->udma    * 1000, UT);
 }
 
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
diff -Nur a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
--- a/drivers/ide/pci/amd74xx.c	2004-07-11 00:27:38 +02:00
+++ b/drivers/ide/pci/amd74xx.c	2004-07-11 11:00:06 +02:00
@@ -205,20 +205,20 @@
 	unsigned char t;
 
 	pci_read_config_byte(dev, AMD_ADDRESS_SETUP, &t);
-	t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
+	t = (t & ~(3 << ((3 - dn) << 1))) | ((fit(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
 	pci_write_config_byte(dev, AMD_ADDRESS_SETUP, t);
 
 	pci_write_config_byte(dev, AMD_8BIT_TIMING + (1 - (dn >> 1)),
-		((FIT(timing->act8b, 1, 16) - 1) << 4) | (FIT(timing->rec8b, 1, 16) - 1));
+		((fit(timing->act8b, 1, 16) - 1) << 4) | (fit(timing->rec8b, 1, 16) - 1));
 
 	pci_write_config_byte(dev, AMD_DRIVE_TIMING + (3 - dn),
-		((FIT(timing->active, 1, 16) - 1) << 4) | (FIT(timing->recover, 1, 16) - 1));
+		((fit(timing->active, 1, 16) - 1) << 4) | (fit(timing->recover, 1, 16) - 1));
 
 	switch (amd_config->flags & AMD_UDMA) {
-		case AMD_UDMA_33:  t = timing->udma ? (0xc0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
-		case AMD_UDMA_66:  t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 2, 10)]) : 0x03; break;
-		case AMD_UDMA_100: t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 1, 10)]) : 0x03; break;
-		case AMD_UDMA_133: t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 1, 15)]) : 0x03; break;
+		case AMD_UDMA_33:  t = timing->udma ? (0xc0 | (fit(timing->udma, 2, 5) - 2)) : 0x03; break;
+		case AMD_UDMA_66:  t = timing->udma ? (0xc0 | amd_cyc2udma[fit(timing->udma, 2, 10)]) : 0x03; break;
+		case AMD_UDMA_100: t = timing->udma ? (0xc0 | amd_cyc2udma[fit(timing->udma, 1, 10)]) : 0x03; break;
+		case AMD_UDMA_133: t = timing->udma ? (0xc0 | amd_cyc2udma[fit(timing->udma, 1, 15)]) : 0x03; break;
 		default: return;
 	}
 
diff -Nur a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c	2004-07-11 00:27:38 +02:00
+++ b/drivers/ide/pci/via82cxxx.c	2004-07-11 10:59:51 +02:00
@@ -291,21 +291,21 @@
 
 	if (~via_config->flags & VIA_BAD_AST) {
 		pci_read_config_byte(dev, VIA_ADDRESS_SETUP, &t);
-		t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
+		t = (t & ~(3 << ((3 - dn) << 1))) | ((fit(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
 		pci_write_config_byte(dev, VIA_ADDRESS_SETUP, t);
 	}
 
 	pci_write_config_byte(dev, VIA_8BIT_TIMING + (1 - (dn >> 1)),
-		((FIT(timing->act8b, 1, 16) - 1) << 4) | (FIT(timing->rec8b, 1, 16) - 1));
+		((fit(timing->act8b, 1, 16) - 1) << 4) | (fit(timing->rec8b, 1, 16) - 1));
 
 	pci_write_config_byte(dev, VIA_DRIVE_TIMING + (3 - dn),
-		((FIT(timing->active, 1, 16) - 1) << 4) | (FIT(timing->recover, 1, 16) - 1));
+		((fit(timing->active, 1, 16) - 1) << 4) | (fit(timing->recover, 1, 16) - 1));
 
 	switch (via_config->flags & VIA_UDMA) {
-		case VIA_UDMA_33:  t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
-		case VIA_UDMA_66:  t = timing->udma ? (0xe8 | (FIT(timing->udma, 2, 9) - 2)) : 0x0f; break;
-		case VIA_UDMA_100: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 9) - 2)) : 0x07; break;
-		case VIA_UDMA_133: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 9) - 2)) : 0x07; break;
+		case VIA_UDMA_33:  t = timing->udma ? (0xe0 | (fit(timing->udma, 2, 5) - 2)) : 0x03; break;
+		case VIA_UDMA_66:  t = timing->udma ? (0xe8 | (fit(timing->udma, 2, 9) - 2)) : 0x0f; break;
+		case VIA_UDMA_100: t = timing->udma ? (0xe0 | (fit(timing->udma, 2, 9) - 2)) : 0x07; break;
+		case VIA_UDMA_133: t = timing->udma ? (0xe0 | (fit(timing->udma, 2, 9) - 2)) : 0x07; break;
 		default: return;
 	}
 
