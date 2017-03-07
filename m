From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Tue, 07 Mar 2017 18:51:58 +0100
Message-ID: <1709119.SQyio4Ct6n@amdc3058>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20161212135537epcas5p440bbb93d40f0c41b3754635733b09879@epcas5p4.samsung.com>
 <8ea5971a-338d-e8b9-6be8-8fe2658fc04d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <8ea5971a-338d-e8b9-6be8-8fe2658fc04d@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Monday, December 12, 2016 07:24:47 PM Sekhar Nori wrote:
> Hi Bartlomiej,
> 
> On Monday 12 December 2016 06:15 PM, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Monday, July 18, 2016 08:15:08 PM Sekhar Nori wrote:
> >> On Friday 15 July 2016 08:45 PM, Kevin Hilman wrote:
> >>> Arnd Bergmann <arnd@arndb.de> writes:
> >>>
> >>>> On Wednesday, July 13, 2016 12:59:23 PM CEST Bartlomiej Zolnierkiewicz wrote:
> >>>>>
> >>>>> On Friday, July 08, 2016 10:23:48 PM Arnd Bergmann wrote:
> >>>>>> On Friday, July 8, 2016 5:24:41 PM CEST Bartlomiej Zolnierkiewicz wrote:
> >>>>>>> This patch disables deprecated IDE subsystem in assabet_defconfig
> >>>>>>> (no IDE host drivers are selected in this config so there is no
> >>>>>>> valid reason to enable IDE subsystem itself).
> >>>>>>>
> >>>>>>> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >>>>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >>>>>>
> >>>>>> I think the series makes a lot of sense. I have checked your assertions
> >>>>>> in the changelogs and found no flaws in your logic, so I think we should
> >>>>>> take them all through arm-soc unless there are other concerns.
> >>>>>
> >>>>> Thank you.
> >>>>>
> >>>>> Should I resend everything or just patches that were not reposted yet
> >>>>> (the ones that were marked as RFT initially and got no feedback)?
> >>>>
> >>>> I'd be fine with just getting a pull request with all the patches that
> >>>> had no negative feedback and that were not already applied (if any).
> >>>>
> >>>>>> Do you have a list of ARM defconfigs that keep using CONFIG_IDE and
> >>>>>> how you determined that they need it?
> >>>>>
> >>>>> The only such defconfig is davinci_all_defconfig which uses
> >>>>> palm_bk3710 host driver (CONFIG_BLK_DEV_PALMCHIP_BK3710).
> >>>>>
> >>>>>> I know that ARCH_RPC/ARCH_ACORN has a couple of special drivers that
> >>>>>> have no libata replacement, are there any others like that, or are
> >>>>>> they all platforms that should in theory work with libata but need
> >>>>>> testing?
> >>>>>
> >>>>> All platforms except ARCH_ACORN, ARCH_DAVINCI & ARCH_RPC should work
> >>>>> with libata.
> >>>>
> >>>> Adding Sekhar and Kevin for DaVinci: At first sight, palm_bk3710 looks
> >>>> fairly straightforward (meaning someone has to do a few day's work)
> >>>> to convert into a libata driver.
> >>>>
> >>>> As this is on on-chip controller that is part of a dm644x and dm646x,
> >>>> it should also not be hard to test (as long as someone can find
> >>>> a hard drive to plug in).
> >>>
> >>> I have a hard drive, but don't have any dm64xx hardware anymore to test
> >>> this.  My last working dm644x board died last year.
> >>
> >> I have a working DM6446 EVM. I was able to connect a hard drive to it
> >> and do some basic tests with v4.6 kernel.
> >>
> >> I will look into converting the driver to libata. Might take some time
> >> because this is unfamiliar territory for me.
> > 
> > Do you need some help with it?
> > 
> > I can provide you with draft driver patch if you want.
> 
> A draft driver patch will really help. I can test/debug. Otherwise, not
> sure when I will really be able to get to this.

It took a while to get to it but here is the draft driver patch
against v4.11-rc1.  Please test.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] arm/ata: add Palmchip BK3710 PATA controller driver (v0.1)

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-davinci/devices.c |    2 
 arch/arm/mach-davinci/dm644x.c  |    2 
 arch/arm/mach-davinci/dm646x.c  |    2 
 drivers/ata/Kconfig             |    9 
 drivers/ata/Makefile            |    1 
 drivers/ata/pata_bk3710.c       |  395 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 408 insertions(+), 3 deletions(-)

Index: b/arch/arm/mach-davinci/devices.c
===================================================================
--- a/arch/arm/mach-davinci/devices.c	2017-03-07 18:42:28.814784061 +0100
+++ b/arch/arm/mach-davinci/devices.c	2017-03-07 18:42:28.810784061 +0100
@@ -94,7 +94,7 @@ static struct resource ide_resources[] =
 static u64 ide_dma_mask = DMA_BIT_MASK(32);
 
 static struct platform_device ide_device = {
-	.name           = "palm_bk3710",
+	.name           = "pata_bk3710",
 	.id             = -1,
 	.resource       = ide_resources,
 	.num_resources  = ARRAY_SIZE(ide_resources),
Index: b/arch/arm/mach-davinci/dm644x.c
===================================================================
--- a/arch/arm/mach-davinci/dm644x.c	2017-03-07 18:42:28.814784061 +0100
+++ b/arch/arm/mach-davinci/dm644x.c	2017-03-07 18:42:28.810784061 +0100
@@ -310,7 +310,7 @@ static struct clk_lookup dm644x_clks[] =
 	CLK("davinci_emac.1", NULL, &emac_clk),
 	CLK("davinci_mdio.0", "fck", &emac_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK("palm_bk3710", NULL, &ide_clk),
+	CLK("pata_bk3710", NULL, &ide_clk),
 	CLK("davinci-mcbsp", NULL, &asp_clk),
 	CLK("dm6441-mmc.0", NULL, &mmcsd_clk),
 	CLK(NULL, "spi", &spi_clk),
Index: b/arch/arm/mach-davinci/dm646x.c
===================================================================
--- a/arch/arm/mach-davinci/dm646x.c	2017-03-07 18:42:28.814784061 +0100
+++ b/arch/arm/mach-davinci/dm646x.c	2017-03-07 18:42:28.810784061 +0100
@@ -358,7 +358,7 @@ static struct clk_lookup dm646x_clks[] =
 	CLK(NULL, "timer0", &timer0_clk),
 	CLK(NULL, "timer1", &timer1_clk),
 	CLK("davinci-wdt", NULL, &timer2_clk),
-	CLK("palm_bk3710", NULL, &ide_clk),
+	CLK("pata_bk3710", NULL, &ide_clk),
 	CLK(NULL, "vpif0", &vpif0_clk),
 	CLK(NULL, "vpif1", &vpif1_clk),
 	CLK(NULL, NULL, NULL),
Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2017-03-07 18:42:28.814784061 +0100
+++ b/drivers/ata/Kconfig	2017-03-07 18:42:28.810784061 +0100
@@ -509,6 +509,15 @@ config PATA_BF54X
 
 	  If unsure, say N.
 
+config PATA_BK3710
+	tristate "Palmchip BK3710 PATA support"
+	depends on ARCH_DAVINCI
+	help
+	  This option enables support for the integrated IDE controller on
+	  the TI DaVinci SoC.
+
+	  If unsure, say N.
+
 config PATA_CMD64X
 	tristate "CMD64x PATA support"
 	depends on PCI
Index: b/drivers/ata/Makefile
===================================================================
--- a/drivers/ata/Makefile	2017-03-07 18:42:28.814784061 +0100
+++ b/drivers/ata/Makefile	2017-03-07 18:42:28.810784061 +0100
@@ -50,6 +50,7 @@ obj-$(CONFIG_PATA_ARTOP)	+= pata_artop.o
 obj-$(CONFIG_PATA_ATIIXP)	+= pata_atiixp.o
 obj-$(CONFIG_PATA_ATP867X)	+= pata_atp867x.o
 obj-$(CONFIG_PATA_BF54X)	+= pata_bf54x.o
+obj-$(CONFIG_PATA_BK3710)	+= pata_bk3710.o
 obj-$(CONFIG_PATA_CMD64X)	+= pata_cmd64x.o
 obj-$(CONFIG_PATA_CS5520)	+= pata_cs5520.o
 obj-$(CONFIG_PATA_CS5530)	+= pata_cs5530.o
Index: b/drivers/ata/pata_bk3710.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/ata/pata_bk3710.c	2017-03-07 18:45:01.758787912 +0100
@@ -0,0 +1,395 @@
+/*
+ * Palmchip BK3710 PATA controller driver
+ *
+ * Copyright (c) 2017 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Based on palm_bk3710.c:
+ *
+ * Copyright (C) 2006 Texas Instruments.
+ * Copyright (C) 2007 MontaVista Software, Inc., <source@mvista.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/ata.h>
+#include <linux/libata.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+
+#define DRV_NAME "pata_bk3710"
+#define DRV_VERSION "0.1.0"
+
+#define BK3710_REG_OFFSET	0x1F0
+#define BK3710_CTL_OFFSET	0x3F6
+
+#define BK3710_BMISP		0x02
+#define BK3710_IDETIMP		0x40
+#define BK3710_UDMACTL		0x48
+#define BK3710_MISCCTL		0x50
+#define BK3710_REGSTB		0x54
+#define BK3710_REGRCVR		0x58
+#define BK3710_DATSTB		0x5C
+#define BK3710_DATRCVR		0x60
+#define BK3710_DMASTB		0x64
+#define BK3710_DMARCVR		0x68
+#define BK3710_UDMASTB		0x6C
+#define BK3710_UDMATRP		0x70
+#define BK3710_UDMAENV		0x74
+#define BK3710_IORDYTMP		0x78
+
+static struct scsi_host_template pata_bk3710_sht = {
+	ATA_BMDMA_SHT(DRV_NAME),
+};
+
+static unsigned int ideclk_period; /* in nanoseconds */
+
+struct pata_bk3710_udmatiming {
+	unsigned int rptime;	/* tRP -- Ready to pause time (nsec) */
+	unsigned int cycletime;	/* tCYCTYP2/2 -- avg Cycle Time (nsec) */
+				/* tENV is always a minimum of 20 nsec */
+};
+
+static const struct pata_bk3710_udmatiming pata_bk3710_udmatimings[6] = {
+	{ 160, 240 / 2 },	/* UDMA Mode 0 */
+	{ 125, 160 / 2 },	/* UDMA Mode 1 */
+	{ 100, 120 / 2 },	/* UDMA Mode 2 */
+	{ 100,  90 / 2 },	/* UDMA Mode 3 */
+	{ 100,  60 / 2 },	/* UDMA Mode 4 */
+	{  85,  40 / 2 },	/* UDMA Mode 5 */
+};
+
+static void pata_bk3710_setudmamode(void __iomem *base, unsigned int dev,
+				    unsigned int mode)
+{
+	u32 val32;
+	u16 val16;
+	u8 tenv, trp, t0;
+
+	/* DMA Data Setup */
+	t0 = DIV_ROUND_UP(pata_bk3710_udmatimings[mode].cycletime,
+			  ideclk_period) - 1;
+	tenv = DIV_ROUND_UP(20, ideclk_period) - 1;
+	trp = DIV_ROUND_UP(pata_bk3710_udmatimings[mode].rptime,
+			   ideclk_period) - 1;
+
+	/* udmastb Ultra DMA Access Strobe Width */
+	val32 = ioread32(base + BK3710_UDMASTB) & (0xFF << (dev ? 0 : 8));
+	val32 |= (t0 << (dev ? 8 : 0));
+	iowrite32(val32, base + BK3710_UDMASTB);
+
+	/* udmatrp Ultra DMA Ready to Pause Time */
+	val32 = ioread32(base + BK3710_UDMATRP) & (0xFF << (dev ? 0 : 8));
+	val32 |= (trp << (dev ? 8 : 0));
+	iowrite32(val32, base + BK3710_UDMATRP);
+
+	/* udmaenv Ultra DMA envelop Time */
+	val32 = ioread32(base + BK3710_UDMAENV) & (0xFF << (dev ? 0 : 8));
+	val32 |= (tenv << (dev ? 8 : 0));
+	iowrite32(val32, base + BK3710_UDMAENV);
+
+	/* Enable UDMA for Device */
+	val16 = ioread16(base + BK3710_UDMACTL) | (1 << dev);
+	iowrite16(val16, base + BK3710_UDMACTL);
+}
+
+static void pata_bk3710_setdmamode(void __iomem *base, unsigned int dev,
+				   unsigned short min_cycle,
+				   unsigned int mode)
+{
+	const struct ata_timing *t;
+	int cycletime;
+	u32 val32;
+	u16 val16;
+	u8 td, tkw, t0;
+
+	t = ata_timing_find_mode(mode);
+	cycletime = max_t(int, t->cycle, min_cycle);
+
+	/* DMA Data Setup */
+	t0 = DIV_ROUND_UP(cycletime, ideclk_period);
+	td = DIV_ROUND_UP(t->active, ideclk_period);
+	tkw = t0 - td - 1;
+	td -= 1;
+
+	val32 = ioread32(base + BK3710_DMASTB) & (0xFF << (dev ? 0 : 8));
+	val32 |= (td << (dev ? 8 : 0));
+	iowrite32(val32, base + BK3710_DMASTB);
+
+	val32 = ioread32(base + BK3710_DMARCVR) & (0xFF << (dev ? 0 : 8));
+	val32 |= (tkw << (dev ? 8 : 0));
+	iowrite32(val32, base + BK3710_DMARCVR);
+
+	/* Disable UDMA for Device */
+	val16 = ioread16(base + BK3710_UDMACTL) & ~(1 << dev);
+	iowrite16(val16, base + BK3710_UDMACTL);
+}
+
+static void pata_bk3710_set_dmamode(struct ata_port *ap,
+				    struct ata_device *adev)
+{
+	void __iomem *base = (void __iomem *)ap->ioaddr.bmdma_addr;
+	int is_slave = adev->devno;
+	const u8 xferspeed = adev->dma_mode;
+
+	if (xferspeed >= XFER_UDMA_0)
+		pata_bk3710_setudmamode(base, is_slave,
+					xferspeed - XFER_UDMA_0);
+	else
+		pata_bk3710_setdmamode(base, is_slave,
+				       adev->id[ATA_ID_EIDE_DMA_MIN],
+				       xferspeed);
+}
+
+static void pata_bk3710_setpiomode(void __iomem *base, struct ata_device *pair,
+				   unsigned int dev, unsigned int cycletime,
+				   unsigned int mode)
+{
+	const struct ata_timing *t;
+	u32 val32;
+	u8 t2, t2i, t0;
+
+	t = ata_timing_find_mode(XFER_PIO_0 + mode);
+
+	/* PIO Data Setup */
+	t0 = DIV_ROUND_UP(cycletime, ideclk_period);
+	t2 = DIV_ROUND_UP(t->active, ideclk_period);
+
+	t2i = t0 - t2 - 1;
+	t2 -= 1;
+
+	val32 = ioread32(base + BK3710_DATSTB) & (0xFF << (dev ? 0 : 8));
+	val32 |= (t2 << (dev ? 8 : 0));
+	iowrite32(val32, base + BK3710_DATSTB);
+
+	val32 = ioread32(base + BK3710_DATRCVR) & (0xFF << (dev ? 0 : 8));
+	val32 |= (t2i << (dev ? 8 : 0));
+	iowrite32(val32, base + BK3710_DATRCVR);
+
+	/* FIXME: this is broken also in the old driver */
+	if (pair) {
+		u8 mode2 = pair->pio_mode - XFER_PIO_0;
+
+		if (mode2 < mode)
+			mode = mode2;
+	}
+
+	/* TASKFILE Setup */
+	t0 = DIV_ROUND_UP(t->cyc8b, ideclk_period);
+	t2 = DIV_ROUND_UP(t->act8b, ideclk_period);
+
+	t2i = t0 - t2 - 1;
+	t2 -= 1;
+
+	val32 = ioread32(base + BK3710_REGSTB) & (0xFF << (dev ? 0 : 8));
+	val32 |= (t2 << (dev ? 8 : 0));
+	iowrite32(val32, base + BK3710_REGSTB);
+
+	val32 = ioread32(base + BK3710_REGRCVR) & (0xFF << (dev ? 0 : 8));
+	val32 |= (t2i << (dev ? 8 : 0));
+	iowrite32(val32, base + BK3710_REGRCVR);
+}
+
+static void pata_bk3710_set_piomode(struct ata_port *ap,
+				    struct ata_device *adev)
+{
+	void __iomem *base = (void __iomem *)ap->ioaddr.bmdma_addr;
+	struct ata_device *pair = ata_dev_pair(adev);
+	const struct ata_timing *t = ata_timing_find_mode(adev->pio_mode);
+	const u16 *id = adev->id;
+	unsigned int cycle_time;
+	int is_slave = adev->devno;
+	const u8 pio = adev->pio_mode - XFER_PIO_0;
+
+	if (id[ATA_ID_FIELD_VALID] & 2) {
+		if (ata_id_has_iordy(id))
+			cycle_time = id[ATA_ID_EIDE_PIO_IORDY];
+		else
+			cycle_time = id[ATA_ID_EIDE_PIO];
+
+		/* conservative "downgrade" for all pre-ATA2 drives */
+		if (pio < 3 && cycle_time < t->cycle)
+			cycle_time = 0; /* use standard timing */
+	}
+
+	if (!cycle_time)
+		cycle_time = t->cycle;
+
+	pata_bk3710_setpiomode(base, pair, is_slave, cycle_time, pio);
+}
+
+static void pata_bk3710_chipinit(void __iomem *base)
+{
+	/*
+	 * REVISIT:  the ATA reset signal needs to be managed through a
+	 * GPIO, which means it should come from platform_data.  Until
+	 * we get and use such information, we have to trust that things
+	 * have been reset before we get here.
+	 */
+
+	/*
+	 * Program the IDETIMP Register Value based on the following assumptions
+	 *
+	 * (ATA_IDETIMP_IDEEN		, ENABLE ) |
+	 * (ATA_IDETIMP_PREPOST1	, DISABLE) |
+	 * (ATA_IDETIMP_PREPOST0	, DISABLE) |
+	 *
+	 * DM6446 silicon rev 2.1 and earlier have no observed net benefit
+	 * from enabling prefetch/postwrite.
+	 */
+	iowrite16(BIT(15), base + BK3710_IDETIMP);
+
+	/*
+	 * UDMACTL Ultra-ATA DMA Control
+	 * (ATA_UDMACTL_UDMAP1	, 0 ) |
+	 * (ATA_UDMACTL_UDMAP0	, 0 )
+	 *
+	 */
+	iowrite16(0, base + BK3710_UDMACTL);
+
+	/*
+	 * MISCCTL Miscellaneous Conrol Register
+	 * (ATA_MISCCTL_HWNHLD1P	, 1 cycle)
+	 * (ATA_MISCCTL_HWNHLD0P	, 1 cycle)
+	 * (ATA_MISCCTL_TIMORIDE	, 1)
+	 */
+	iowrite32(0x001, base + BK3710_MISCCTL);
+
+	/*
+	 * IORDYTMP IORDY Timer for Primary Register
+	 * (ATA_IORDYTMP_IORDYTMP     , 0xffff  )
+	 */
+	iowrite32(0xFFFF, base + BK3710_IORDYTMP);
+
+	/*
+	 * Configure BMISP Register
+	 * (ATA_BMISP_DMAEN1	, DISABLE )	|
+	 * (ATA_BMISP_DMAEN0	, DISABLE )	|
+	 * (ATA_BMISP_IORDYINT	, CLEAR)	|
+	 * (ATA_BMISP_INTRSTAT	, CLEAR)	|
+	 * (ATA_BMISP_DMAERROR	, CLEAR)
+	 */
+	iowrite16(0, base + BK3710_BMISP);
+
+	pata_bk3710_setpiomode(base, NULL, 0, 600, 0);
+	pata_bk3710_setpiomode(base, NULL, 1, 600, 0);
+}
+
+static struct ata_port_operations pata_bk3710_ports_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+	.cable_detect		= ata_cable_80wire,
+
+	.set_piomode		= pata_bk3710_set_piomode,
+	.set_dmamode		= pata_bk3710_set_dmamode,
+};
+
+static int __init pata_bk3710_probe(struct platform_device *pdev)
+{
+	struct clk *clk;
+	struct resource *mem, *irq;
+	struct ata_host *host;
+	struct ata_port *ap;
+	void __iomem *base;
+	unsigned long rate, mem_size;
+
+	clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return -ENODEV;
+
+	clk_enable(clk);
+	rate = clk_get_rate(clk);
+	if (!rate)
+		return -EINVAL;
+
+	/* NOTE:  round *down* to meet minimum timings; we count in clocks */
+	ideclk_period = 1000000000UL / rate;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (mem == NULL) {
+		pr_err(DRV_NAME ": failed to get memory region resource\n");
+		return -ENODEV;
+	}
+
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (irq == NULL) {
+		pr_err(DRV_NAME ": failed to get IRQ resource\n");
+		return -ENODEV;
+	}
+
+	mem_size = resource_size(mem);
+	if (!devm_request_mem_region(&pdev->dev, mem->start, mem_size,
+				     DRV_NAME)) {
+		pr_err(DRV_NAME ": failed to request memory region\n");
+		return -EBUSY;
+	}
+
+	base = ioremap(mem->start, mem_size);
+	if (!base) {
+		pr_err(DRV_NAME ": failed to map IO memory\n");
+		return -ENOMEM;
+	}
+
+	/* Configure the Palm Chip controller */
+	pata_bk3710_chipinit(base);
+
+	/* allocate host */
+	host = ata_host_alloc(&pdev->dev, 1);
+	if (!host)
+		return -ENOMEM;
+	ap = host->ports[0];
+
+	ap->ops = &pata_bk3710_ports_ops;
+	ap->pio_mask = ATA_PIO4;
+	ap->mwdma_mask = ATA_MWDMA2;
+	ap->udma_mask = rate < 100000000 ? ATA_UDMA4 : ATA_UDMA5;
+	ap->flags |= ATA_FLAG_SLAVE_POSS;
+
+	ap->ioaddr.data_addr		= base + BK3710_REG_OFFSET;
+	ap->ioaddr.error_addr		= base + BK3710_REG_OFFSET + 1;
+	ap->ioaddr.feature_addr		= base + BK3710_REG_OFFSET + 1;
+	ap->ioaddr.nsect_addr		= base + BK3710_REG_OFFSET + 2;
+	ap->ioaddr.lbal_addr		= base + BK3710_REG_OFFSET + 3;
+	ap->ioaddr.lbam_addr		= base + BK3710_REG_OFFSET + 4;
+	ap->ioaddr.lbah_addr		= base + BK3710_REG_OFFSET + 5;
+	ap->ioaddr.device_addr		= base + BK3710_REG_OFFSET + 6;
+	ap->ioaddr.status_addr		= base + BK3710_REG_OFFSET + 7;
+	ap->ioaddr.command_addr		= base + BK3710_REG_OFFSET + 7;
+
+	ap->ioaddr.altstatus_addr	= base + BK3710_CTL_OFFSET;
+	ap->ioaddr.ctl_addr		= base + BK3710_CTL_OFFSET;
+
+	ap->ioaddr.bmdma_addr		= base;
+
+	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
+		      (unsigned long)base + BK3710_REG_OFFSET,
+		      (unsigned long)base + BK3710_CTL_OFFSET);
+
+	/* activate */
+	return ata_host_activate(host, irq->start, ata_sff_interrupt, 0,
+				 &pata_bk3710_sht);
+}
+
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:pata_bk3710");
+
+static struct platform_driver pata_bk3710_driver = {
+	.driver = {
+		.name = "pata_bk3710",
+	},
+};
+
+static int __init pata_bk3710_init(void)
+{
+	return platform_driver_probe(&pata_bk3710_driver, pata_bk3710_probe);
+}
+
+module_init(pata_bk3710_init);
+MODULE_LICENSE("GPL");
