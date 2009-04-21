From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.30-rc2 2/2] palm_bk3710:  UDMA performance fix
Date: Mon, 20 Apr 2009 18:41:10 -0700
Message-ID: <200904201841.10989.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Bartlomiej Zolnierkiewicz <bzolnier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, DaVinci <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Fix UDMA throughput bug:  tCYC averages t2CYCTYP/2, but the code
previously assumed it was the same as t2CYCTYP.  (That is, it was
using just one clock edge, not both.)  Move the table's type
declaration so it's adjacent to the table, making it more clear
what those numbers mean.

On one system this change increased throughput by almost 4x: UDMA/66
sometimes topped 23 MB/sec (on a drive known to do much better).  On
another system it was around a 10% win (UDMA/66 up to 7+ MB/sec).

The difference might be caused by the ratio between memory and IDE
clocks.  In the system with large speedup, this was exactly 2 (as a
workaround for a rev 1.1 silicon bug).  The other system used a more
standard ratio of 1.63 (and rev 2.1 silicon) ... clock domain synch
might have some issues, they're not unheard-of.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/ide/palm_bk3710.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

--- a/drivers/ide/palm_bk3710.c
+++ b/drivers/ide/palm_bk3710.c
@@ -39,14 +39,6 @@
 /* Primary Control Offset */
 #define IDE_PALM_ATA_PRI_CTL_OFFSET 0x3F6
 
-/*
- * PalmChip 3710 IDE Controller UDMA timing structure Definition
- */
-struct palm_bk3710_udmatiming {
-	unsigned int rptime;	/* Ready to pause time  */
-	unsigned int cycletime;	/* Cycle Time           */
-};
-
 #define BK3710_BMICP		0x00
 #define BK3710_BMISP		0x02
 #define BK3710_BMIDTP		0x04
@@ -67,13 +59,19 @@ struct palm_bk3710_udmatiming {
 
 static unsigned ideclk_period; /* in nanoseconds */
 
+struct palm_bk3710_udmatiming {
+	unsigned int rptime;	/* tRP -- Ready to pause time (nsec) */
+	unsigned int cycletime;	/* tCYCTYP2/2 -- avg Cycle Time (nsec) */
+				/* tENV is always a minimum of 20 nsec */
+};
+
 static const struct palm_bk3710_udmatiming palm_bk3710_udmatimings[6] = {
-	{160, 240},		/* UDMA Mode 0 */
-	{125, 160},		/* UDMA Mode 1 */
-	{100, 120},		/* UDMA Mode 2 */
-	{100, 90},		/* UDMA Mode 3 */
-	{100, 60},		/* UDMA Mode 4 */
-	{85,  40},		/* UDMA Mode 5 */
+	{160, 240 / 2,},	/* UDMA Mode 0 */
+	{125, 160 / 2,},	/* UDMA Mode 1 */
+	{100, 120 / 2,},	/* UDMA Mode 2 */
+	{100, 90 / 2,},		/* UDMA Mode 3 */
+	{100, 60 / 2,},		/* UDMA Mode 4 */
+	{85,  40 / 2,},		/* UDMA Mode 5 */
 };
 
 static void palm_bk3710_setudmamode(void __iomem *base, unsigned int dev,
