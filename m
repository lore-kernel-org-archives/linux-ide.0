From: Vojtech Pavlik <vojtech@suse.cz>
Subject: [Kernel-janitors] Re: [patch] MIN/MAX in ide-timing.h
Date: Thu, 29 Jul 2004 16:48:09 +0200
Sender: kernel-janitors-bounces@lists.osdl.org
Message-ID: <20040729144809.GP19452@ucw.cz>
References: <20040708181843.GA1370@moley.homelinux.net>
	<20040710140337.GA1238@ucw.cz>
	<20040710224329.GF1991@moley.homelinux.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============34516330995913869=="
Return-path: <kernel-janitors-bounces@lists.osdl.org>
In-Reply-To: <20040710224329.GF1991@moley.homelinux.net>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/kernel-janitors>
List-Post: <mailto:kernel-janitors@lists.osdl.org>
List-Help: <mailto:kernel-janitors-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.osdl.org?subject=subscribe>
Errors-To: kernel-janitors-bounces@lists.osdl.org
To: Clemens Buchacher <drizzd@aon.at>, B.Zolnierkiewicz@elka.pw.edu.pl
Cc: Linux-ide list <linux-ide@vger.kernel.org>, kernel janitors list <kernel-janitors@lists.osdl.org>
List-Id: linux-ide@vger.kernel.org

--===============34516330995913869==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 11, 2004 at 12:43:29AM +0200, Clemens Buchacher wrote:

> On Sat, Jul 10, 2004 at 04:03:37PM +0200, Vojtech Pavlik wrote:
> > How about if you used the "min_t" and "max_t" macros inside FIT? That
> > could help get rid of the casts completely (assuming the second and
> > third parameters to FIT are expected to be constants).
> 
> Yes, that's better. It reduces the necessary changes to a minimum.

Bartolomiej, please apply this patch. Thanks.

diff -Nur a/drivers/ide/ide-timing.h b/drivers/ide/ide-timing.h
--- a/drivers/ide/ide-timing.h	2004-07-11 00:27:38 +02:00
+++ b/drivers/ide/ide-timing.h	2004-07-11 00:27:01 +02:00
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
+#define FIT(v,vmin,vmax)	max_t(short,min_t(short,v,vmax),vmin)
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

--  
Vojtech Pavlik
SuSE Labs, SuSE CR

--===============34516330995913869==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Kernel-janitors mailing list
Kernel-janitors@lists.osdl.org
http://lists.osdl.org/mailman/listinfo/kernel-janitors

--===============34516330995913869==--
