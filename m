From: janitor@sternwelten.at
Subject: [patch 1/5]  MIN/MAX in ide-timing.h
Date: Thu, 02 Sep 2004 01:19:18 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <E1C2eNq-0003bW-Bu@sputnik>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:51390 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268026AbUIAXTT
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Sep 2004 19:19:19 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, alan@redhat.com, janitor@sternwelten.at



I replaced the custom MIN/MAX macros with the type safe min/max macros
from linux/kernel.h.

On Sat, Jul 10, 2004 at 04:03:37PM +0200, Vojtech Pavlik wrote:
> How about if you used the "min_t" and "max_t" macros inside FIT? That
> could help get rid of the casts completely (assuming the second and
> third parameters to FIT are expected to be constants).

Yes, that's better. It reduces the necessary changes to a minimum.

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>




---

 linux-2.6.9-rc1-bk7-max/drivers/ide/ide-timing.h |   25 +++++++++++------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff -puN drivers/ide/ide-timing.h~min-max-ide_ide-timing.h drivers/ide/ide-timing.h
--- linux-2.6.9-rc1-bk7/drivers/ide/ide-timing.h~min-max-ide_ide-timing.h	2004-09-01 19:34:21.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/ide/ide-timing.h	2004-09-01 19:34:21.000000000 +0200
@@ -27,6 +27,7 @@
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
+#include <linux/kernel.h>
 #include <linux/hdreg.h>
 
 #define XFER_PIO_5		0x0d
@@ -96,11 +97,9 @@ static struct ide_timing ide_timing[] = 
 #define IDE_TIMING_UDMA		0x80
 #define IDE_TIMING_ALL		0xff
 
-#define MIN(a,b)	((a)<(b)?(a):(b))
-#define MAX(a,b)	((a)>(b)?(a):(b))
-#define FIT(v,min,max)	MAX(MIN(v,max),min)
-#define ENOUGH(v,unit)	(((v)-1)/(unit)+1)
-#define EZ(v,unit)	((v)?ENOUGH(v,unit):0)
+#define FIT(v,vmin,vmax)	max_t(short,min_t(short,v,vmax),vmin)
+#define ENOUGH(v,unit)		(((v)-1)/(unit)+1)
+#define EZ(v,unit)		((v)?ENOUGH(v,unit):0)
 
 #define XFER_MODE	0xf0
 #define XFER_UDMA_133	0x48
@@ -188,14 +187,14 @@ static void ide_timing_quantize(struct i
 
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

_
