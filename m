From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.30-rc2 1/2] palm_bk3710: those registers/bitfields don't
	exist
Date: Mon, 20 Apr 2009 18:19:56 -0700
Message-ID: <200904201819.56559.david-b@pacbell.net>
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

Bugfixes noted by checking the code against the controller
documentation (TI document number SPRUE21):

 - Remove declarations for eight non-existent registers (!);
   and remove accesses to two of them.

 - Remove access to various non-existent bitfields in some of
   the registers which *do* exist (those fields must-be-zero).

 - Provide comment to replace bogus reset logic (removed above,
   it relied on non-existent bitfields).  Resets require GPIO
   help; this driver doesn't currently know about that.

With some minor cleanup:  relocate a comment, avoid an extra
lookup of the PIO timings.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/ide/palm_bk3710.c |   67 +++++++++++---------------------------------
 1 file changed, 18 insertions(+), 49 deletions(-)

--- a/drivers/ide/palm_bk3710.c
+++ b/drivers/ide/palm_bk3710.c
@@ -50,16 +50,9 @@ struct palm_bk3710_udmatiming {
 #define BK3710_BMICP		0x00
 #define BK3710_BMISP		0x02
 #define BK3710_BMIDTP		0x04
-#define BK3710_BMICS		0x08
-#define BK3710_BMISS		0x0A
-#define BK3710_BMIDTS		0x0C
 #define BK3710_IDETIMP		0x40
-#define BK3710_IDETIMS		0x42
-#define BK3710_SIDETIM		0x44
-#define BK3710_SLEWCTL		0x45
 #define BK3710_IDESTATUS	0x47
 #define BK3710_UDMACTL		0x48
-#define BK3710_UDMATIM		0x4A
 #define BK3710_MISCCTL		0x50
 #define BK3710_REGSTB		0x54
 #define BK3710_REGRCVR		0x58
@@ -71,7 +64,6 @@ struct palm_bk3710_udmatiming {
 #define BK3710_UDMATRP		0x70
 #define BK3710_UDMAENV		0x74
 #define BK3710_IORDYTMP		0x78
-#define BK3710_IORDYTMS		0x7C
 
 static unsigned ideclk_period; /* in nanoseconds */
 
@@ -98,11 +90,6 @@ static void palm_bk3710_setudmamode(void
 	trp = DIV_ROUND_UP(palm_bk3710_udmatimings[mode].rptime,
 			   ideclk_period) - 1;
 
-	/* udmatim Register */
-	val16 = readw(base + BK3710_UDMATIM) & (dev ? 0xFF0F : 0xFFF0);
-	val16 |= (mode << (dev ? 4 : 0));
-	writew(val16, base + BK3710_UDMATIM);
-
 	/* udmastb Ultra DMA Access Strobe Width */
 	val32 = readl(base + BK3710_UDMASTB) & (0xFF << (dev ? 0 : 8));
 	val32 |= (t0 << (dev ? 8 : 0));
@@ -163,10 +150,11 @@ static void palm_bk3710_setpiomode(void 
 	u32 val32;
 	struct ide_timing *t;
 
+	t = ide_timing_find_mode(XFER_PIO_0 + mode);
+
 	/* PIO Data Setup */
 	t0 = DIV_ROUND_UP(cycletime, ideclk_period);
-	t2 = DIV_ROUND_UP(ide_timing_find_mode(XFER_PIO_0 + mode)->active,
-			  ideclk_period);
+	t2 = DIV_ROUND_UP(t->active, ideclk_period);
 
 	t2i = t0 - t2 - 1;
 	t2 -= 1;
@@ -187,7 +175,6 @@ static void palm_bk3710_setpiomode(void 
 	}
 
 	/* TASKFILE Setup */
-	t = ide_timing_find_mode(XFER_PIO_0 + mode);
 	t0 = DIV_ROUND_UP(t->cyc8b, ideclk_period);
 	t2 = DIV_ROUND_UP(t->act8b, ideclk_period);
 
@@ -236,42 +223,23 @@ static void palm_bk3710_set_pio_mode(ide
 static void __devinit palm_bk3710_chipinit(void __iomem *base)
 {
 	/*
-	 * enable the reset_en of ATA controller so that when ata signals
-	 * are brought out, by writing into device config. at that
-	 * time por_n signal should not be 'Z' and have a stable value.
+	 * REVISIT:  the ATA reset signal needs to be managed through a
+	 * GPIO, which means it should come from platform_data.  Until
+	 * we get and use such information, we have to trust that things
+	 * have been reset before we get here.
 	 */
-	writel(0x0300, base + BK3710_MISCCTL);
-
-	/* wait for some time and deassert the reset of ATA Device. */
-	mdelay(100);
-
-	/* Deassert the Reset */
-	writel(0x0200, base + BK3710_MISCCTL);
 
 	/*
 	 * Program the IDETIMP Register Value based on the following assumptions
 	 *
 	 * (ATA_IDETIMP_IDEEN		, ENABLE ) |
-	 * (ATA_IDETIMP_SLVTIMEN	, DISABLE) |
-	 * (ATA_IDETIMP_RDYSMPL		, 70NS)    |
-	 * (ATA_IDETIMP_RDYRCVRY	, 50NS)    |
-	 * (ATA_IDETIMP_DMAFTIM1	, PIOCOMP) |
 	 * (ATA_IDETIMP_PREPOST1	, DISABLE) |
-	 * (ATA_IDETIMP_RDYSEN1		, DISABLE) |
-	 * (ATA_IDETIMP_PIOFTIM1	, DISABLE) |
-	 * (ATA_IDETIMP_DMAFTIM0	, PIOCOMP) |
 	 * (ATA_IDETIMP_PREPOST0	, DISABLE) |
-	 * (ATA_IDETIMP_RDYSEN0		, DISABLE) |
-	 * (ATA_IDETIMP_PIOFTIM0	, DISABLE)
-	 */
-	writew(0xB388, base + BK3710_IDETIMP);
-
-	/*
-	 * Configure  SIDETIM  Register
-	 * (ATA_SIDETIM_RDYSMPS1	,120NS ) |
-	 * (ATA_SIDETIM_RDYRCYS1	,120NS )
+	 *
+	 * DM6446 silicon rev 2.1 and earlier have no observed net benefit
+	 * from enabling prefetch/postwrite.
 	 */
-	writeb(0, base + BK3710_SIDETIM);
+	writew(BIT(15), base + BK3710_IDETIMP);
 
 	/*
 	 * UDMACTL Ultra-ATA DMA Control
@@ -283,11 +251,11 @@ static void __devinit palm_bk3710_chipin
 
 	/*
 	 * MISCCTL Miscellaneous Conrol Register
-	 * (ATA_MISCCTL_RSTMODEP	, 1) |
-	 * (ATA_MISCCTL_RESETP		, 0) |
+	 * (ATA_MISCCTL_HWNHLD1P	, 1 cycle)
+	 * (ATA_MISCCTL_HWNHLD0P	, 1 cycle)
 	 * (ATA_MISCCTL_TIMORIDE	, 1)
 	 */
-	writel(0x201, base + BK3710_MISCCTL);
+	writel(0x001, base + BK3710_MISCCTL);
 
 	/*
 	 * IORDYTMP IORDY Timer for Primary Register
@@ -357,10 +325,9 @@ static int __init palm_bk3710_probe(stru
 
 	clk_enable(clk);
 	rate = clk_get_rate(clk);
-	ideclk_period = 1000000000UL / rate;
 
-	/* Register the IDE interface with Linux ATA Interface */
-	memset(&hw, 0, sizeof(hw));
+	/* NOTE:  round *down* to meet minimum timings; we count in clocks */
+	ideclk_period = 1000000000UL / rate;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (mem == NULL) {
@@ -390,6 +357,7 @@ static int __init palm_bk3710_probe(stru
 	/* Configure the Palm Chip controller */
 	palm_bk3710_chipinit(base);
 
+	memset(&hw, 0, sizeof(hw));
 	for (i = 0; i < IDE_NR_PORTS - 2; i++)
 		hw.io_ports_array[i] = (unsigned long)
 				(base + IDE_PALM_ATA_PRI_REG_OFFSET + i);
@@ -402,6 +370,7 @@ static int __init palm_bk3710_probe(stru
 	palm_bk3710_port_info.udma_mask = rate < 100000000 ? ATA_UDMA4 :
 							     ATA_UDMA5;
 
+	/* Register the IDE interface with Linux */
 	rc = ide_host_add(&palm_bk3710_port_info, hws, NULL);
 	if (rc)
 		goto out;
