From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 09/14] m68k: amiga - Amiga Gayle IDE platform device
	conversion
Date: Fri, 23 Apr 2010 10:32:26 +0200
Message-ID: <t2z10f740e81004230132w9d9caccbjf3c83e1aa3e45a23@mail.gmail.com>
References: <1272009635-6504-1-git-send-email-geert@linux-m68k.org>
	 <1272009635-6504-2-git-send-email-geert@linux-m68k.org>
	 <1272009635-6504-3-git-send-email-geert@linux-m68k.org>
	 <1272009635-6504-4-git-send-email-geert@linux-m68k.org>
	 <1272009635-6504-5-git-send-email-geert@linux-m68k.org>
	 <1272009635-6504-6-git-send-email-geert@linux-m68k.org>
	 <1272009635-6504-7-git-send-email-geert@linux-m68k.org>
	 <1272009635-6504-8-git-send-email-geert@linux-m68k.org>
	 <1272009635-6504-9-git-send-email-geert@linux-m68k.org>
	 <1272009635-6504-10-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1272009635-6504-10-git-send-email-geert@linux-m68k.org>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-m68k@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Apr 23, 2010 at 10:00, Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-ide@vger.kernel.org
> ---
> =C2=A0arch/m68k/amiga/platform.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 63 +++=
+++++++++++++-
> =C2=A0arch/m68k/include/asm/amigayle.h | =C2=A0 =C2=A06 ++
> =C2=A0drivers/ide/gayle.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0150 +++++++++++++++++++++----------------
> =C2=A03 files changed, 153 insertions(+), 66 deletions(-)

> --- a/drivers/ide/gayle.c
> +++ b/drivers/ide/gayle.c

> +{
> + =C2=A0 =C2=A0 =C2=A0 // FIXME
> + =C2=A0 =C2=A0 =C2=A0 if (pdata->explicit_ack)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d.port_ops =3D &ga=
yle_a1200_port_ops;
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d.port_ops =3D &ga=
yle_a4000_port_ops;
> +}

Sorry, that was the wrong one. The FIXME and braces should have been re=
moved.
Updated patch below.

=46rom 8dc07b6150772f3ff17b597424cf29d8fc4912f7 Mon Sep 17 00:00:00 200=
1
=46rom: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Dec 2009 20:12:20 +0100
Subject: [PATCH] m68k: amiga - Amiga Gayle IDE platform device conversi=
on

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/amiga/platform.c       |   63 ++++++++++++++++-
 arch/m68k/include/asm/amigayle.h |    6 ++
 drivers/ide/gayle.c              |  147 +++++++++++++++++++++---------=
--------
 3 files changed, 150 insertions(+), 66 deletions(-)

diff --git a/arch/m68k/amiga/platform.c b/arch/m68k/amiga/platform.c
index 027e4ca..907f6f5 100644
--- a/arch/m68k/amiga/platform.c
+++ b/arch/m68k/amiga/platform.c
@@ -11,6 +11,7 @@
 #include <linux/zorro.h>

 #include <asm/amigahw.h>
+#include <asm/amigayle.h>


 #ifdef CONFIG_ZORRO
@@ -55,7 +56,24 @@ static int __init amiga_init_bus(void)

 subsys_initcall(amiga_init_bus);

-#endif /* CONFIG_ZORRO */
+
+static int z_dev_present(zorro_id id)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < zorro_num_autocon; i++)
+		if (zorro_autocon[i].rom.er_Manufacturer =3D=3D ZORRO_MANUF(id) &&
+		    zorro_autocon[i].rom.er_Product =3D=3D ZORRO_PROD(id))
+			return 1;
+
+	return 0;
+}
+
+#else /* !CONFIG_ZORRO */
+
+static inline int z_dev_present(zorro_id id) { return 0; }
+
+#endif /* !CONFIG_ZORRO */


 static const struct resource a3000_scsi_resource __initconst =3D {
@@ -72,8 +90,36 @@ static const struct resource a4000t_scsi_resource
__initconst =3D {
 };


+static const struct resource a1200_ide_resource __initconst =3D {
+	.start	=3D 0xda0000,
+	.end	=3D 0xda1fff,
+	.flags	=3D IORESOURCE_MEM,
+};
+
+static const struct gayle_ide_platform_data a1200_ide_pdata __initcons=
t =3D {
+	.base		=3D 0xda0000,
+	.irqport	=3D 0xda9000,
+	.explicit_ack	=3D 1,
+};
+
+
+static const struct resource a4000_ide_resource __initconst =3D {
+	.start	=3D 0xdd2000,
+	.end	=3D 0xdd3fff,
+	.flags	=3D IORESOURCE_MEM,
+};
+
+static const struct gayle_ide_platform_data a4000_ide_pdata __initcons=
t =3D {
+	.base		=3D 0xdd2020,
+	.irqport	=3D 0xdd3020,
+	.explicit_ack	=3D 0,
+};
+
+
 static int __init amiga_init_devices(void)
 {
+	struct platform_device *pdev;
+
 	if (!MACH_IS_AMIGA)
 		return -ENODEV;

@@ -99,6 +145,21 @@ static int __init amiga_init_devices(void)
 		platform_device_register_simple("amiga-a4000t-scsi", -1,
 						&a4000t_scsi_resource, 1);

+	if (AMIGAHW_PRESENT(A1200_IDE) ||
+	    z_dev_present(ZORRO_PROD_MTEC_VIPER_MK_V_E_MATRIX_530_SCSI_IDE)) =
{
+		pdev =3D platform_device_register_simple("amiga-gayle-ide", -1,
+						       &a1200_ide_resource, 1);
+		platform_device_add_data(pdev, &a1200_ide_pdata,
+					 sizeof(a1200_ide_pdata));
+	}
+
+	if (AMIGAHW_PRESENT(A4000_IDE)) {
+		pdev =3D platform_device_register_simple("amiga-gayle-ide", -1,
+						       &a4000_ide_resource, 1);
+		platform_device_add_data(pdev, &a4000_ide_pdata,
+					 sizeof(a4000_ide_pdata));
+	}
+
 	return 0;
 }

diff --git a/arch/m68k/include/asm/amigayle.h b/arch/m68k/include/asm/a=
migayle.h
index bb5a6aa..a01453d 100644
--- a/arch/m68k/include/asm/amigayle.h
+++ b/arch/m68k/include/asm/amigayle.h
@@ -104,4 +104,10 @@ struct GAYLE {
 #define GAYLE_CFG_250NS		0x00
 #define GAYLE_CFG_720NS		0x0c

+struct gayle_ide_platform_data {
+	unsigned long base;
+	unsigned long irqport;
+	int explicit_ack;	/* A1200 IDE needs explicit ack */
+};
+
 #endif /* asm-m68k/amigayle.h */
diff --git a/drivers/ide/gayle.c b/drivers/ide/gayle.c
index b9e517d..3feaa26 100644
--- a/drivers/ide/gayle.c
+++ b/drivers/ide/gayle.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/zorro.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>

 #include <asm/setup.h>
 #include <asm/amigahw.h>
@@ -24,15 +25,6 @@


     /*
-     *  Bases of the IDE interfaces
-     */
-
-#define GAYLE_BASE_4000	0xdd2020	/* A4000/A4000T */
-#define GAYLE_BASE_1200	0xda0000	/* A1200/A600 and E-Matrix 530 */
-
-#define GAYLE_IDEREG_SIZE	0x2000
-
-    /*
      *  Offsets from one of the above bases
      */

@@ -68,20 +60,20 @@ MODULE_PARM_DESC(doubler, "enable support for IDE
doublers");

 static int gayle_test_irq(ide_hwif_t *hwif)
 {
-    unsigned char ch;
+	unsigned char ch;

-    ch =3D z_readb(hwif->io_ports.irq_addr);
-    if (!(ch & GAYLE_IRQ_IDE))
-	return 0;
-    return 1;
+	ch =3D z_readb(hwif->io_ports.irq_addr);
+	if (!(ch & GAYLE_IRQ_IDE))
+		return 0;
+	return 1;
 }

 static void gayle_a1200_clear_irq(ide_drive_t *drive)
 {
-    ide_hwif_t *hwif =3D drive->hwif;
+	ide_hwif_t *hwif =3D drive->hwif;

-    (void)z_readb(hwif->io_ports.status_addr);
-    z_writeb(0x7c, hwif->io_ports.irq_addr);
+	(void)z_readb(hwif->io_ports.status_addr);
+	z_writeb(0x7c, hwif->io_ports.irq_addr);
 }

 static void __init gayle_setup_ports(struct ide_hw *hw, unsigned long =
base,
@@ -122,64 +114,89 @@ static const struct ide_port_info gayle_port_info=
 =3D {
      *  Probe for a Gayle IDE interface (and optionally for an IDE dou=
bler)
      */

-static int __init gayle_init(void)
+static int __init amiga_gayle_ide_probe(struct platform_device *pdev)
 {
-    unsigned long phys_base, res_start, res_n;
-    unsigned long base, ctrlport, irqport;
-    int a4000, i, rc;
-    struct ide_hw hw[GAYLE_NUM_HWIFS], *hws[GAYLE_NUM_HWIFS];
-    struct ide_port_info d =3D gayle_port_info;
-
-    if (!MACH_IS_AMIGA)
-	return -ENODEV;
-
-    if ((a4000 =3D AMIGAHW_PRESENT(A4000_IDE)) || AMIGAHW_PRESENT(A120=
0_IDE))
-	goto found;
-
-#ifdef CONFIG_ZORRO
-    if (zorro_find_device(ZORRO_PROD_MTEC_VIPER_MK_V_E_MATRIX_530_SCSI=
_IDE,
-			  NULL))
-	goto found;
-#endif
-    return -ENODEV;
-
-found:
-	printk(KERN_INFO "ide: Gayle IDE controller (A%d style%s)\n",
-			 a4000 ? 4000 : 1200,
-			 ide_doubler ? ", IDE doubler" : "");
-
-	if (a4000) {
-	    phys_base =3D GAYLE_BASE_4000;
-	    irqport =3D (unsigned long)ZTWO_VADDR(GAYLE_IRQ_4000);
-	    d.port_ops =3D &gayle_a4000_port_ops;
-	} else {
-	    phys_base =3D GAYLE_BASE_1200;
-	    irqport =3D (unsigned long)ZTWO_VADDR(GAYLE_IRQ_1200);
-	    d.port_ops =3D &gayle_a1200_port_ops;
+	struct resource *res;
+	struct gayle_ide_platform_data *pdata;
+	unsigned long base, ctrlport, irqport;
+	unsigned int i;
+	int error;
+	struct ide_hw hw[GAYLE_NUM_HWIFS], *hws[GAYLE_NUM_HWIFS];
+	struct ide_port_info d =3D gayle_port_info;
+	struct ide_host *host;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	if (!request_mem_region(res->start, resource_size(res), "IDE"))
+		return -EBUSY;
+
+	pdata =3D pdev->dev.platform_data;
+	pr_info("ide: Gayle IDE controller (A%u style%s)\n",
+		pdata->explicit_ack ? 1200 : 4000,
+		ide_doubler ? ", IDE doubler" : "");
+
+	base =3D (unsigned long)ZTWO_VADDR(pdata->base);
+	ctrlport =3D 0;
+	irqport =3D (unsigned long)ZTWO_VADDR(pdata->irqport);
+	if (pdata->explicit_ack)
+		d.port_ops =3D &gayle_a1200_port_ops;
+	else
+		d.port_ops =3D &gayle_a4000_port_ops;
+
+	for (i =3D 0; i < GAYLE_NUM_PROBE_HWIFS; i++, base +=3D GAYLE_NEXT_PO=
RT) {
+		if (GAYLE_HAS_CONTROL_REG)
+			ctrlport =3D base + GAYLE_CONTROL;
+
+		gayle_setup_ports(&hw[i], base, ctrlport, irqport);
+		hws[i] =3D &hw[i];
 	}

-	res_start =3D ((unsigned long)phys_base) & ~(GAYLE_NEXT_PORT-1);
-	res_n =3D GAYLE_IDEREG_SIZE;
+	error =3D ide_host_add(&d, hws, i, &host);
+	if (error)
+		goto out;

-	if (!request_mem_region(res_start, res_n, "IDE"))
-		return -EBUSY;
+	platform_set_drvdata(pdev, host);
+	return 0;

-    for (i =3D 0; i < GAYLE_NUM_PROBE_HWIFS; i++) {
-	base =3D (unsigned long)ZTWO_VADDR(phys_base + i * GAYLE_NEXT_PORT);
-	ctrlport =3D GAYLE_HAS_CONTROL_REG ? (base + GAYLE_CONTROL) : 0;
+out:
+	release_mem_region(res->start, resource_size(res));
+	return error;
+}
+
+static int __exit amiga_gayle_ide_remove(struct platform_device *pdev)
+{
+	struct ide_host *host =3D platform_get_drvdata(pdev);
+	struct resource *res =3D platform_get_resource(pdev, IORESOURCE_MEM, =
0);
+
+	ide_host_remove(host);
+	release_mem_region(res->start, resource_size(res));
+	return 0;
+}

-	gayle_setup_ports(&hw[i], base, ctrlport, irqport);
+static struct platform_driver amiga_gayle_ide_driver =3D {
+	.remove =3D __exit_p(amiga_gayle_ide_remove),
+	.driver   =3D {
+		.name	=3D "amiga-gayle-ide",
+		.owner	=3D THIS_MODULE,
+	},
+};

-	hws[i] =3D &hw[i];
-    }
+static int __init amiga_gayle_ide_init(void)
+{
+	return platform_driver_probe(&amiga_gayle_ide_driver,
+				     amiga_gayle_ide_probe);
+}

-    rc =3D ide_host_add(&d, hws, i, NULL);
-    if (rc)
-	release_mem_region(res_start, res_n);
+module_init(amiga_gayle_ide_init);

-    return rc;
+static void __exit amiga_gayle_ide_exit(void)
+{
+	platform_driver_unregister(&amiga_gayle_ide_driver);
 }

-module_init(gayle_init);
+module_exit(amiga_gayle_ide_exit);

 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:amiga-gayle-ide");
--=20
1.6.0.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
