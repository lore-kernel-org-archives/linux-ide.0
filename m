From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git pull] IDE fixes (updated)
Date: Thu, 23 Apr 2009 23:08:58 +0200
Message-ID: <200904232308.58473.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:39854 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbZDWVGi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Apr 2009 17:06:38 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


The pull request from yesterday updated with more palm_bk3710 bug fixes
from David Brownell and a little CodingStyle fixup (noticed by Joe Perc=
hes).

I also updated MAINTAINERS file to reflect conversion of the IDE tree
from quilt to git (done based on a popular demand :).

Linus, please pull from 'for-linus' branch of:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git for-linus

to receive the following updates:

 MAINTAINERS                  |    2 +-
 drivers/ide/ide-cd.c         |    2 +-
 drivers/ide/ide-gd.c         |   17 +++++++-
 drivers/ide/palm_bk3710.c    |   93 +++++++++++++---------------------=
-------
 drivers/macintosh/mediabay.c |    1 -
 5 files changed, 48 insertions(+), 67 deletions(-)


Bartlomiej Zolnierkiewicz (3):
      mediabay: fix build for CONFIG_BLOCK=3Dn
      palm_bk3710: palm_bk3710_udmatimings[] CodingStyle fixup
      MAINTAINERS: update IDE entry

Bruno Pr=E9mont (1):
      ide: Stop disks on reboot for laptop which cuts power

David Brownell (2):
      palm_bk3710: UDMA performance fix
      palm_bk3710: those registers/bitfields don't exist

Helge Deller (1):
      ide-cd: fix kernel crash on hppa regression


diff --git a/MAINTAINERS b/MAINTAINERS
index 0beac8a..2431b05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2743,7 +2743,7 @@ IDE SUBSYSTEM
 P:	Bartlomiej Zolnierkiewicz
 M:	bzolnier@gmail.com
 L:	linux-ide@vger.kernel.org
-T:	quilt kernel.org/pub/linux/kernel/people/bart/pata-2.6/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bart/ide-2.6.git
 S:	Maintained
 F:	Documentation/ide/
 F:	drivers/ide/
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 3aec19d..3d4e099 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -609,7 +609,7 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t=
 *drive)
 	struct request *rq =3D hwif->rq;
 	ide_expiry_t *expiry =3D NULL;
 	int dma_error =3D 0, dma, thislen, uptodate =3D 0;
-	int write =3D (rq_data_dir(rq) =3D=3D WRITE) ? 1 : 0, rc, nsectors;
+	int write =3D (rq_data_dir(rq) =3D=3D WRITE) ? 1 : 0, rc =3D 0, nsect=
ors;
 	int sense =3D blk_sense_request(rq);
 	unsigned int timeout;
 	u16 len;
diff --git a/drivers/ide/ide-gd.c b/drivers/ide/ide-gd.c
index 1aebdf1..4b6b71e 100644
--- a/drivers/ide/ide-gd.c
+++ b/drivers/ide/ide-gd.c
@@ -7,6 +7,7 @@
 #include <linux/mutex.h>
 #include <linux/ide.h>
 #include <linux/hdreg.h>
+#include <linux/dmi.h>
=20
 #if !defined(CONFIG_DEBUG_BLOCK_EXT_DEVT)
 #define IDE_DISK_MINORS		(1 << PARTN_BITS)
@@ -99,6 +100,19 @@ static void ide_gd_resume(ide_drive_t *drive)
 		(void)drive->disk_ops->get_capacity(drive);
 }
=20
+static const struct dmi_system_id ide_coldreboot_table[] =3D {
+	{
+		/* Acer TravelMate 66x cuts power during reboot */
+		.ident   =3D "Acer TravelMate 660",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 660"),
+		},
+	},
+
+	{ }	/* terminate list */
+};
+
 static void ide_gd_shutdown(ide_drive_t *drive)
 {
 #ifdef	CONFIG_ALPHA
@@ -115,7 +129,8 @@ static void ide_gd_shutdown(ide_drive_t *drive)
 	   the disk to expire its write cache. */
 	if (system_state !=3D SYSTEM_POWER_OFF) {
 #else
-	if (system_state =3D=3D SYSTEM_RESTART) {
+	if (system_state =3D=3D SYSTEM_RESTART &&
+		!dmi_check_system(ide_coldreboot_table)) {
 #endif
 		drive->disk_ops->flush(drive);
 		return;
diff --git a/drivers/ide/palm_bk3710.c b/drivers/ide/palm_bk3710.c
index c7acca0..09d813d 100644
--- a/drivers/ide/palm_bk3710.c
+++ b/drivers/ide/palm_bk3710.c
@@ -39,27 +39,12 @@
 /* Primary Control Offset */
 #define IDE_PALM_ATA_PRI_CTL_OFFSET 0x3F6
=20
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
@@ -71,17 +56,22 @@ struct palm_bk3710_udmatiming {
 #define BK3710_UDMATRP		0x70
 #define BK3710_UDMAENV		0x74
 #define BK3710_IORDYTMP		0x78
-#define BK3710_IORDYTMS		0x7C
=20
 static unsigned ideclk_period; /* in nanoseconds */
=20
+struct palm_bk3710_udmatiming {
+	unsigned int rptime;	/* tRP -- Ready to pause time (nsec) */
+	unsigned int cycletime;	/* tCYCTYP2/2 -- avg Cycle Time (nsec) */
+				/* tENV is always a minimum of 20 nsec */
+};
+
 static const struct palm_bk3710_udmatiming palm_bk3710_udmatimings[6] =
=3D {
-	{160, 240},		/* UDMA Mode 0 */
-	{125, 160},		/* UDMA Mode 1 */
-	{100, 120},		/* UDMA Mode 2 */
-	{100, 90},		/* UDMA Mode 3 */
-	{100, 60},		/* UDMA Mode 4 */
-	{85,  40},		/* UDMA Mode 5 */
+	{ 160, 240 / 2 },	/* UDMA Mode 0 */
+	{ 125, 160 / 2 },	/* UDMA Mode 1 */
+	{ 100, 120 / 2 },	/* UDMA Mode 2 */
+	{ 100,  90 / 2 },	/* UDMA Mode 3 */
+	{ 100,  60 / 2 },	/* UDMA Mode 4 */
+	{  85,  40 / 2 },	/* UDMA Mode 5 */
 };
=20
 static void palm_bk3710_setudmamode(void __iomem *base, unsigned int d=
ev,
@@ -98,11 +88,6 @@ static void palm_bk3710_setudmamode(void __iomem *ba=
se, unsigned int dev,
 	trp =3D DIV_ROUND_UP(palm_bk3710_udmatimings[mode].rptime,
 			   ideclk_period) - 1;
=20
-	/* udmatim Register */
-	val16 =3D readw(base + BK3710_UDMATIM) & (dev ? 0xFF0F : 0xFFF0);
-	val16 |=3D (mode << (dev ? 4 : 0));
-	writew(val16, base + BK3710_UDMATIM);
-
 	/* udmastb Ultra DMA Access Strobe Width */
 	val32 =3D readl(base + BK3710_UDMASTB) & (0xFF << (dev ? 0 : 8));
 	val32 |=3D (t0 << (dev ? 8 : 0));
@@ -163,10 +148,11 @@ static void palm_bk3710_setpiomode(void __iomem *=
base, ide_drive_t *mate,
 	u32 val32;
 	struct ide_timing *t;
=20
+	t =3D ide_timing_find_mode(XFER_PIO_0 + mode);
+
 	/* PIO Data Setup */
 	t0 =3D DIV_ROUND_UP(cycletime, ideclk_period);
-	t2 =3D DIV_ROUND_UP(ide_timing_find_mode(XFER_PIO_0 + mode)->active,
-			  ideclk_period);
+	t2 =3D DIV_ROUND_UP(t->active, ideclk_period);
=20
 	t2i =3D t0 - t2 - 1;
 	t2 -=3D 1;
@@ -187,7 +173,6 @@ static void palm_bk3710_setpiomode(void __iomem *ba=
se, ide_drive_t *mate,
 	}
=20
 	/* TASKFILE Setup */
-	t =3D ide_timing_find_mode(XFER_PIO_0 + mode);
 	t0 =3D DIV_ROUND_UP(t->cyc8b, ideclk_period);
 	t2 =3D DIV_ROUND_UP(t->act8b, ideclk_period);
=20
@@ -236,42 +221,23 @@ static void palm_bk3710_set_pio_mode(ide_drive_t =
*drive, u8 pio)
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
=20
 	/*
 	 * Program the IDETIMP Register Value based on the following assumpti=
ons
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
=20
 	/*
 	 * UDMACTL Ultra-ATA DMA Control
@@ -283,11 +249,11 @@ static void __devinit palm_bk3710_chipinit(void _=
_iomem *base)
=20
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
=20
 	/*
 	 * IORDYTMP IORDY Timer for Primary Register
@@ -357,10 +323,9 @@ static int __init palm_bk3710_probe(struct platfor=
m_device *pdev)
=20
 	clk_enable(clk);
 	rate =3D clk_get_rate(clk);
-	ideclk_period =3D 1000000000UL / rate;
=20
-	/* Register the IDE interface with Linux ATA Interface */
-	memset(&hw, 0, sizeof(hw));
+	/* NOTE:  round *down* to meet minimum timings; we count in clocks */
+	ideclk_period =3D 1000000000UL / rate;
=20
 	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (mem =3D=3D NULL) {
@@ -390,6 +355,7 @@ static int __init palm_bk3710_probe(struct platform=
_device *pdev)
 	/* Configure the Palm Chip controller */
 	palm_bk3710_chipinit(base);
=20
+	memset(&hw, 0, sizeof(hw));
 	for (i =3D 0; i < IDE_NR_PORTS - 2; i++)
 		hw.io_ports_array[i] =3D (unsigned long)
 				(base + IDE_PALM_ATA_PRI_REG_OFFSET + i);
@@ -402,6 +368,7 @@ static int __init palm_bk3710_probe(struct platform=
_device *pdev)
 	palm_bk3710_port_info.udma_mask =3D rate < 100000000 ? ATA_UDMA4 :
 							     ATA_UDMA5;
=20
+	/* Register the IDE interface with Linux */
 	rc =3D ide_host_add(&palm_bk3710_port_info, hws, NULL);
 	if (rc)
 		goto out;
diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.=
c
index d7e46d3..eca55ef 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -18,7 +18,6 @@
 #include <linux/timer.h>
 #include <linux/stddef.h>
 #include <linux/init.h>
-#include <linux/ide.h>
 #include <linux/kthread.h>
 #include <linux/mutex.h>
 #include <asm/prom.h>
