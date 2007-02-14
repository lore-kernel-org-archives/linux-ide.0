From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/8] ide: fix ide.c
Date: Wed, 14 Feb 2007 02:57:19 +0100
Message-ID: <20070214015719.4619.87962.sendpatchset@localhost.localdomain>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:47958 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbXBNBvl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2007 20:51:41 -0500
Received: by ug-out-1314.google.com with SMTP id 44so28283uga
        for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2007 17:51:37 -0800 (PST)
In-Reply-To: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[PATCH] ide: fix ide.c #ifdef madness

=46or some built-in host driver we need to take care of the order in wh=
ich they
are probed.  Do this during link time and remove all ugly #ifdefs from =
ide.c.

[ We can probe m68k specific drivers before PCI drivers (no PCI on m68k=
 except
  broken for ages HADES), ide-cris (cris arch specific), cmd640 (x86 sp=
ecific)
  and pmac (powerpc specific). ]

While at it add missing __init tags to macide/q40ide drivers, fix non-a=
scii
character in q40ide and remove bogus comment from ide.c.

[ To test this patch I tested some strange combinations of host drivers
  (i.e. ali14xx vs setup-pci vs cmd640) and the probe order is preserve=
d
  as it should be. ]

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/Makefile           |   52 +++++++++++-------
 drivers/ide/cris/ide-cris.c    |   13 +++-
 drivers/ide/h8300/Makefile     |    2=20
 drivers/ide/h8300/ide-h8300.c  |   12 +++-
 drivers/ide/ide-pnp.c          |    6 +-
 drivers/ide/ide.c              |  116 +-------------------------------=
---------
 drivers/ide/legacy/Makefile    |   17 ++++--
 drivers/ide/legacy/ali14xx.c   |    6 --
 drivers/ide/legacy/buddha.c    |   12 +++-
 drivers/ide/legacy/dtc2278.c   |    6 --
 drivers/ide/legacy/falconide.c |   12 +++-
 drivers/ide/legacy/gayle.c     |   12 +++-
 drivers/ide/legacy/ht6560b.c   |    5 -
 drivers/ide/legacy/macide.c    |   12 +++-
 drivers/ide/legacy/q40ide.c    |   13 +++-
 drivers/ide/legacy/qd65xx.c    |    6 --
 drivers/ide/legacy/umc8672.c   |    6 --
 drivers/ide/pci/cmd640.c       |   14 ++++
 drivers/ide/ppc/Makefile       |    2=20
 drivers/ide/ppc/pmac.c         |   13 +++-
 drivers/ide/setup-pci.c        |   15 ++++-
 include/linux/ide.h            |    1=20
 22 files changed, 178 insertions(+), 175 deletions(-)

Index: b/drivers/ide/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -15,33 +15,35 @@ obj-$(CONFIG_BLK_DEV_IDE)		+=3D pci/
=20
 ide-core-y +=3D ide.o ide-io.o ide-iops.o ide-lib.o ide-probe.o ide-ta=
skfile.o
=20
-ide-core-$(CONFIG_BLK_DEV_CMD640)	+=3D pci/cmd640.o
-
-# Core IDE code - must come before legacy
-ide-core-$(CONFIG_BLK_DEV_IDEPCI)	+=3D setup-pci.o
 ide-core-$(CONFIG_BLK_DEV_IDEDMA)	+=3D ide-dma.o
-ide-core-$(CONFIG_IDE_PROC_FS)		+=3D ide-proc.o
-ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+=3D ide-pnp.o
 ide-core-$(CONFIG_BLK_DEV_IDEACPI)	+=3D ide-acpi.o
+ide-core-$(CONFIG_IDE_PROC_FS)		+=3D ide-proc.o
=20
 # built-in only drivers from arm/
 ide-core-$(CONFIG_IDE_ARM)		+=3D arm/ide_arm.o
=20
-# built-in only drivers from legacy/
-ide-core-$(CONFIG_BLK_DEV_BUDDHA)	+=3D legacy/buddha.o
-ide-core-$(CONFIG_BLK_DEV_FALCON_IDE)	+=3D legacy/falconide.o
-ide-core-$(CONFIG_BLK_DEV_GAYLE)	+=3D legacy/gayle.o
-ide-core-$(CONFIG_BLK_DEV_MAC_IDE)	+=3D legacy/macide.o
-ide-core-$(CONFIG_BLK_DEV_Q40IDE)	+=3D legacy/q40ide.o
-
 # built-in only drivers from ppc/
 ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+=3D ppc/mpc8xx.o
-ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+=3D ppc/pmac.o
-
-# built-in only drivers from h8300/
-ide-core-$(CONFIG_H8300)		+=3D h8300/ide-h8300.o
=20
 obj-$(CONFIG_BLK_DEV_IDE)		+=3D ide-core.o
+
+#
+# if the host drivers are built-in we need to take care of the order
+# in which they are probed - this is handled during link time
+#
+
+obj-$(CONFIG_BLK_DEV_IDE)		+=3D legacy/
+obj-$(CONFIG_BLK_DEV_IDEPCI)		+=3D setup-pci.o
+obj-$(CONFIG_ETRAX_IDE)			+=3D cris/
+# no other way to preserve order without moving pci/cmd640.c around
+ifeq ($(CONFIG_BLK_DEV_CMD640), y)
+	cmd640-core-y +=3D pci/cmd640.o
+	obj-y +=3D cmd640-core.o
+endif
+obj-$(CONFIG_BLK_DEV_IDE_PMAC)		+=3D ppc/
+obj-$(CONFIG_BLK_DEV_IDEPNP)		+=3D ide-pnp.o
+obj-$(CONFIG_H8300)			+=3D h8300/
+
 obj-$(CONFIG_IDE_GENERIC)		+=3D ide-generic.o
=20
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+=3D ide-disk.o
@@ -49,6 +51,16 @@ obj-$(CONFIG_BLK_DEV_IDECD)		+=3D ide-cd.o
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+=3D ide-tape.o
 obj-$(CONFIG_BLK_DEV_IDEFLOPPY)		+=3D ide-floppy.o
=20
-obj-$(CONFIG_BLK_DEV_IDE)		+=3D legacy/ arm/ mips/
-obj-$(CONFIG_BLK_DEV_HD)		+=3D legacy/
-obj-$(CONFIG_ETRAX_IDE)		+=3D cris/
+# no other way to preserve order without moving legacy/ide-cs.c around
+ifeq ($(CONFIG_BLK_DEV_IDECS), y)
+	ide-cs-core-y +=3D legacy/ide-cs.o
+	obj-y +=3D ide-cs-core.o
+endif
+
+obj-$(CONFIG_BLK_DEV_IDE)		+=3D arm/ mips/
+
+# old hd driver must be last
+ifeq ($(CONFIG_BLK_DEV_HD), y)
+	hd-core-y +=3D legacy/hd.o
+	obj-y +=3D hd-core.o
+endif
Index: b/drivers/ide/cris/ide-cris.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -773,8 +773,8 @@ static int speed_cris_ide(ide_drive_t *d
 	return 0;
 }
=20
-void __init
-init_e100_ide (void)
+/* TODO: return error values */
+static void __init init_e100_ide(void)
 {
 	hw_regs_t hw;
 	int ide_offsets[IDE_NR_PORTS];
@@ -1098,3 +1098,12 @@ static void cris_dma_start(ide_drive_t *
 		LED_DISK_READ(1);
 	}
 }
+
+static int __init ide_cris_init(void)
+{
+	init_e100_ide();
+
+	return 0;
+}
+
+module_init(ide_cris_init);
Index: b/drivers/ide/h8300/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/ide/h8300/Makefile
@@ -0,0 +1,2 @@
+
+obj-$(CONFIG_H8300)			+=3D ide-h8300.o
Index: b/drivers/ide/h8300/ide-h8300.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -85,7 +85,8 @@ static inline void hwif_setup(ide_hwif_t
 	hwif->INSL  =3D NULL;
 }
=20
-void __init h8300_ide_init(void)
+/* TODO: return error values */
+static void __init h8300_ide_probe(void)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
@@ -114,3 +115,12 @@ void __init h8300_ide_init(void)
 out_busy:
 	printk(KERN_ERR "ide-h8300: IDE I/F resource already used.\n");
 }
+
+static int __init h8300_ide_init(void)
+{
+	h8300_ide_probe();
+
+	return 0;
+}
+
+module_init(h8300_ide_init);
Index: b/drivers/ide/ide-pnp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-pnp.c
+++ b/drivers/ide/ide-pnp.c
@@ -69,12 +69,14 @@ static struct pnp_driver idepnp_driver =3D
 	.remove		=3D idepnp_remove,
 };
=20
-void __init pnpide_init(void)
+static int __init pnpide_init(void)
 {
-	pnp_register_driver(&idepnp_driver);
+	return pnp_register_driver(&idepnp_driver);
 }
=20
 void __exit pnpide_exit(void)
 {
 	pnp_unregister_driver(&idepnp_driver);
 }
+
+module_init(pnpide_init);
Index: b/drivers/ide/ide.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -175,7 +175,7 @@ DECLARE_MUTEX(ide_cfg_sem);
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(ide_lock);
=20
 #ifdef CONFIG_BLK_DEV_IDEPCI
-static int ide_scan_direction; /* THIS was formerly 2.2.x pci=3Drevers=
e */
+int ide_scan_direction; /* THIS was formerly 2.2.x pci=3Dreverse */
 #endif
=20
 #ifdef CONFIG_IDEDMA_AUTO
@@ -1247,26 +1247,11 @@ static int __init match_parm (char *s, c
 	return 0;	/* zero =3D nothing matched */
 }
=20
-#ifdef CONFIG_BLK_DEV_ALI14XX
 extern int probe_ali14xx;
-extern int ali14xx_init(void);
-#endif
-#ifdef CONFIG_BLK_DEV_UMC8672
 extern int probe_umc8672;
-extern int umc8672_init(void);
-#endif
-#ifdef CONFIG_BLK_DEV_DTC2278
 extern int probe_dtc2278;
-extern int dtc2278_init(void);
-#endif
-#ifdef CONFIG_BLK_DEV_HT6560B
 extern int probe_ht6560b;
-extern int ht6560b_init(void);
-#endif
-#ifdef CONFIG_BLK_DEV_QD65XX
 extern int probe_qd65xx;
-extern int qd65xx_init(void);
-#endif
=20
 static int __initdata is_chipset_set[MAX_HWIFS];
=20
@@ -1565,79 +1550,6 @@ done:
 	return 1;
 }
=20
-extern void __init pnpide_init(void);
-extern void __exit pnpide_exit(void);
-extern void __init h8300_ide_init(void);
-
-/*
- * probe_for_hwifs() finds/initializes "known" IDE interfaces
- */
-static void __init probe_for_hwifs (void)
-{
-#ifdef CONFIG_BLK_DEV_IDEPCI
-	ide_scan_pcibus(ide_scan_direction);
-#endif /* CONFIG_BLK_DEV_IDEPCI */
-
-#ifdef CONFIG_ETRAX_IDE
-	{
-		extern void init_e100_ide(void);
-		init_e100_ide();
-	}
-#endif /* CONFIG_ETRAX_IDE */
-#ifdef CONFIG_BLK_DEV_CMD640
-	{
-		extern void ide_probe_for_cmd640x(void);
-		ide_probe_for_cmd640x();
-	}
-#endif /* CONFIG_BLK_DEV_CMD640 */
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
-	{
-		extern void pmac_ide_probe(void);
-		pmac_ide_probe();
-	}
-#endif /* CONFIG_BLK_DEV_IDE_PMAC */
-#ifdef CONFIG_BLK_DEV_GAYLE
-	{
-		extern void gayle_init(void);
-		gayle_init();
-	}
-#endif /* CONFIG_BLK_DEV_GAYLE */
-#ifdef CONFIG_BLK_DEV_FALCON_IDE
-	{
-		extern void falconide_init(void);
-		falconide_init();
-	}
-#endif /* CONFIG_BLK_DEV_FALCON_IDE */
-#ifdef CONFIG_BLK_DEV_MAC_IDE
-	{
-		extern void macide_init(void);
-		macide_init();
-	}
-#endif /* CONFIG_BLK_DEV_MAC_IDE */
-#ifdef CONFIG_BLK_DEV_Q40IDE
-	{
-		extern void q40ide_init(void);
-		q40ide_init();
-	}
-#endif /* CONFIG_BLK_DEV_Q40IDE */
-#ifdef CONFIG_BLK_DEV_BUDDHA
-	{
-		extern void buddha_init(void);
-		buddha_init();
-	}
-#endif /* CONFIG_BLK_DEV_BUDDHA */
-#ifdef CONFIG_BLK_DEV_IDEPNP
-	pnpide_init();
-#endif
-#ifdef CONFIG_H8300
-	h8300_ide_init();
-#endif
-}
-
-/*
- * Probe module
- */
-
 EXPORT_SYMBOL(ide_lock);
=20
 static int ide_bus_match(struct device *dev, struct device_driver *drv=
)
@@ -1765,30 +1677,6 @@ static int __init ide_init(void)
=20
 	proc_ide_create();
=20
-#ifdef CONFIG_BLK_DEV_ALI14XX
-	if (probe_ali14xx)
-		(void)ali14xx_init();
-#endif
-#ifdef CONFIG_BLK_DEV_UMC8672
-	if (probe_umc8672)
-		(void)umc8672_init();
-#endif
-#ifdef CONFIG_BLK_DEV_DTC2278
-	if (probe_dtc2278)
-		(void)dtc2278_init();
-#endif
-#ifdef CONFIG_BLK_DEV_HT6560B
-	if (probe_ht6560b)
-		(void)ht6560b_init();
-#endif
-#ifdef CONFIG_BLK_DEV_QD65XX
-	if (probe_qd65xx)
-		(void)qd65xx_init();
-#endif
-
-	/* Probe for special PCI and other "known" interface chipsets. */
-	probe_for_hwifs();
-
 	return 0;
 }
=20
@@ -1817,6 +1705,8 @@ int __init init_module (void)
 	return ide_init();
 }
=20
+extern void __exit pnpide_exit(void);
+
 void __exit cleanup_module (void)
 {
 	int index;
Index: b/drivers/ide/legacy/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/legacy/Makefile
+++ b/drivers/ide/legacy/Makefile
@@ -1,13 +1,22 @@
=20
+#
+# link order is important here
+#
+
 obj-$(CONFIG_BLK_DEV_ALI14XX)		+=3D ali14xx.o
+obj-$(CONFIG_BLK_DEV_UMC8672)		+=3D umc8672.o
 obj-$(CONFIG_BLK_DEV_DTC2278)		+=3D dtc2278.o
 obj-$(CONFIG_BLK_DEV_HT6560B)		+=3D ht6560b.o
 obj-$(CONFIG_BLK_DEV_QD65XX)		+=3D qd65xx.o
-obj-$(CONFIG_BLK_DEV_UMC8672)		+=3D umc8672.o
=20
-obj-$(CONFIG_BLK_DEV_IDECS)		+=3D ide-cs.o
+obj-$(CONFIG_BLK_DEV_GAYLE)		+=3D gayle.o
+obj-$(CONFIG_BLK_DEV_FALCON_IDE)	+=3D falconide.o
+obj-$(CONFIG_BLK_DEV_MAC_IDE)		+=3D macide.o
+obj-$(CONFIG_BLK_DEV_Q40IDE)		+=3D q40ide.o
+obj-$(CONFIG_BLK_DEV_BUDDHA)		+=3D buddha.o
=20
-# Last of all
-obj-$(CONFIG_BLK_DEV_HD)		+=3D hd.o
+ifeq ($(CONFIG_BLK_DEV_IDECS), m)
+	obj-m +=3D ide-cs.o
+endif
=20
 EXTRA_CFLAGS	:=3D -Idrivers/ide
Index: b/drivers/ide/legacy/ali14xx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -197,6 +197,7 @@ static int __init initRegisters (void) {
 	return t;
 }
=20
+/* TODO: return error values */
 static int __init ali14xx_probe(void)
 {
 	ide_hwif_t *hwif, *mate;
@@ -236,8 +237,7 @@ int probe_ali14xx =3D 0;
 module_param_named(probe, probe_ali14xx, bool, 0);
 MODULE_PARM_DESC(probe, "probe for ALI M14xx chipsets");
=20
-/* Can be called directly from ide.c. */
-int __init ali14xx_init(void)
+static int __init ali14xx_init(void)
 {
 	if (probe_ali14xx =3D=3D 0)
 		goto out;
@@ -253,9 +253,7 @@ out:
 	return -ENODEV;
 }
=20
-#ifdef MODULE
 module_init(ali14xx_init);
-#endif
=20
 MODULE_AUTHOR("see local file");
 MODULE_DESCRIPTION("support of ALI 14XX IDE chipsets");
Index: b/drivers/ide/legacy/buddha.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/legacy/buddha.c
+++ b/drivers/ide/legacy/buddha.c
@@ -143,7 +143,8 @@ static int xsurf_ack_intr(ide_hwif_t *hw
      *  Probe for a Buddha or Catweasel IDE interface
      */
=20
-void __init buddha_init(void)
+/* TODO: return error values */
+static void __init buddha_ide_probe(void)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
@@ -233,3 +234,12 @@ fail_base2:
 		}
 	}
 }
+
+static int __init buddha_ide_init(void)
+{
+	buddha_ide_probe();
+
+	return 0;
+}
+
+module_init(buddha_ide_init);
Index: b/drivers/ide/legacy/dtc2278.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -94,6 +94,7 @@ static void tune_dtc2278 (ide_drive_t *d
 	HWIF(drive)->drives[!drive->select.b.unit].io_32bit =3D 1;
 }
=20
+/* TODO: return error values */
 static int __init dtc2278_probe(void)
 {
 	unsigned long flags;
@@ -151,8 +152,7 @@ int probe_dtc2278 =3D 0;
 module_param_named(probe, probe_dtc2278, bool, 0);
 MODULE_PARM_DESC(probe, "probe for DTC2278xx chipsets");
=20
-/* Can be called directly from ide.c. */
-int __init dtc2278_init(void)
+static int __init dtc2278_init(void)
 {
 	if (probe_dtc2278 =3D=3D 0)
 		return -ENODEV;
@@ -164,9 +164,7 @@ int __init dtc2278_init(void)
 	return 0;
 }
=20
-#ifdef MODULE
 module_init(dtc2278_init);
-#endif
=20
 MODULE_AUTHOR("See Local File");
 MODULE_DESCRIPTION("support of DTC-2278 VLB IDE chipsets");
Index: b/drivers/ide/legacy/falconide.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/legacy/falconide.c
+++ b/drivers/ide/legacy/falconide.c
@@ -60,7 +60,8 @@ int falconide_intr_lock;
      *  Probe for a Falcon IDE interface
      */
=20
-void __init falconide_init(void)
+/* TODO: return error values */
+static void __init falcon_ide_probe(void)
 {
     if (MACH_IS_ATARI && ATARIHW_PRESENT(IDE)) {
 	hw_regs_t hw;
@@ -76,3 +77,12 @@ void __init falconide_init(void)
 	    printk("ide%d: Falcon IDE interface\n", index);
     }
 }
+
+static int __init falcon_ide_init(void)
+{
+	falcon_ide_probe();
+
+	return 0;
+}
+
+module_init(falcon_ide_init);
Index: b/drivers/ide/legacy/gayle.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/legacy/gayle.c
+++ b/drivers/ide/legacy/gayle.c
@@ -110,7 +110,8 @@ static int gayle_ack_intr_a1200(ide_hwif
      *  Probe for a Gayle IDE interface (and optionally for an IDE dou=
bler)
      */
=20
-void __init gayle_init(void)
+/* TODO: return error values */
+static void __init gayle_ide_probe(void)
 {
     int a4000, i;
=20
@@ -183,3 +184,12 @@ found:
 	    release_mem_region(res_start, res_n);
     }
 }
+
+static int __init gayle_ide_init(void)
+{
+	gayle_ide_probe();
+
+	return 0;
+}
+
+module_init(gayle_ide_init);
Index: b/drivers/ide/legacy/ht6560b.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -308,8 +308,7 @@ int probe_ht6560b =3D 0;
 module_param_named(probe, probe_ht6560b, bool, 0);
 MODULE_PARM_DESC(probe, "probe for HT6560B chipset");
=20
-/* Can be called directly from ide.c. */
-int __init ht6560b_init(void)
+static int __init ht6560b_init(void)
 {
 	ide_hwif_t *hwif, *mate;
 	int t;
@@ -369,9 +368,7 @@ release_region:
 	return -ENODEV;
 }
=20
-#ifdef MODULE
 module_init(ht6560b_init);
-#endif
=20
 MODULE_AUTHOR("See Local File");
 MODULE_DESCRIPTION("HT-6560B EIDE-controller support");
Index: b/drivers/ide/legacy/macide.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/legacy/macide.c
+++ b/drivers/ide/legacy/macide.c
@@ -90,7 +90,8 @@ static void macide_mediabay_interrupt(in
  * Probe for a Macintosh IDE interface
  */
=20
-void macide_init(void)
+/* TODO: return error values */
+static void __init mac_ide_probe(void)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
@@ -152,3 +153,12 @@ void macide_init(void)
 			printk(KERN_INFO "ide%d: Unknown Macintosh IDE interface\n", index)=
;
 	}
 }
+
+static int __init mac_ide_init(void)
+{
+	mac_ide_probe();
+
+	return 0;
+}
+
+module_init(mac_ide_init);
Index: b/drivers/ide/legacy/q40ide.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/legacy/q40ide.c
+++ b/drivers/ide/legacy/q40ide.c
@@ -102,7 +102,7 @@ void q40_ide_setup_ports ( hw_regs_t *hw
=20
 /*=20
  * the static array is needed to have the name reported in /proc/iopor=
ts,
- * hwif->name unfortunately isn=B4t available yet
+ * hwif->name unfortunately isn't available yet
  */
 static const char *q40_ide_names[Q40IDE_NUM_HWIFS]=3D{
 	"ide0", "ide1"
@@ -112,7 +112,8 @@ static const char *q40_ide_names[Q40IDE_
  *  Probe for Q40 IDE interfaces
  */
=20
-void q40ide_init(void)
+/* TODO: return error values */
+static void __init q40_ide_probe(void)
 {
     int i;
     ide_hwif_t *hwif;
@@ -149,3 +150,11 @@ void q40ide_init(void)
     }
 }
=20
+static int __init q40_ide_init(void)
+{
+	q40_ide_probe();
+
+	return 0;
+}
+
+module_init(q40_ide_init);
Index: b/drivers/ide/legacy/qd65xx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -397,6 +397,7 @@ static void __exit qd_unsetup(ide_hwif_t
  * return 1 if another qd may be probed
  */
=20
+/* TODO: return error values */
 static int __init qd_probe(int base)
 {
 	ide_hwif_t *hwif;
@@ -496,8 +497,7 @@ int probe_qd65xx =3D 0;
 module_param_named(probe, probe_qd65xx, bool, 0);
 MODULE_PARM_DESC(probe, "probe for QD65xx chipsets");
=20
-/* Can be called directly from ide.c. */
-int __init qd65xx_init(void)
+static int __init qd65xx_init(void)
 {
 	if (probe_qd65xx =3D=3D 0)
 		return -ENODEV;
@@ -510,9 +510,7 @@ int __init qd65xx_init(void)
 	return 0;
 }
=20
-#ifdef MODULE
 module_init(qd65xx_init);
-#endif
=20
 MODULE_AUTHOR("Samuel Thibault");
 MODULE_DESCRIPTION("support of qd65xx vlb ide chipset");
Index: b/drivers/ide/legacy/umc8672.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/legacy/umc8672.c
+++ b/drivers/ide/legacy/umc8672.c
@@ -123,6 +123,7 @@ static void tune_umc (ide_drive_t *drive
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
=20
+/* TODO: return error values */
 static int __init umc8672_probe(void)
 {
 	unsigned long flags;
@@ -171,8 +172,7 @@ int probe_umc8672 =3D 0;
 module_param_named(probe, probe_umc8672, bool, 0);
 MODULE_PARM_DESC(probe, "probe for UMC8672 chipset");
=20
-/* Can be called directly from ide.c. */
-int __init umc8672_init(void)
+static int __init umc8672_init(void)
 {
 	if (probe_umc8672 =3D=3D 0)
 		goto out;
@@ -183,9 +183,7 @@ out:
 	return -ENODEV;;
 }
=20
-#ifdef MODULE
 module_init(umc8672_init);
-#endif
=20
 MODULE_AUTHOR("Wolfram Podien");
 MODULE_DESCRIPTION("Support for UMC 8672 IDE chipset");
Index: b/drivers/ide/pci/cmd640.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -713,9 +713,11 @@ static int pci_conf2(void)
 }
=20
 /*
- * Probe for a cmd640 chipset, and initialize it if found.  Called fro=
m ide.c
+ * Probe for a cmd640 chipset, and initialize it if found.
+ *
+ * TODO: return error values
  */
-int __init ide_probe_for_cmd640x (void)
+static int __init cmd640x_probe(void)
 {
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 	int second_port_toggled =3D 0;
@@ -876,3 +878,11 @@ int __init ide_probe_for_cmd640x (void)
 	return 1;
 }
=20
+static int __init cmd640x_init(void)
+{
+	(void)cmd640x_probe();
+
+	return 0;
+}
+
+module_init(cmd640x_init);
Index: b/drivers/ide/ppc/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/ide/ppc/Makefile
@@ -0,0 +1,2 @@
+
+obj-$(CONFIG_BLK_DEV_IDE_PMAC)		+=3D pmac.o
Index: b/drivers/ide/ppc/pmac.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1554,8 +1554,8 @@ static struct pci_driver pmac_ide_pci_dr
 };
 MODULE_DEVICE_TABLE(pci, pmac_ide_pci_match);
=20
-void __init
-pmac_ide_probe(void)
+/* TODO: return error values */
+static void __init pmac_ide_probe(void)
 {
 	if (!machine_is(powermac))
 		return;
@@ -2073,3 +2073,12 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 }
=20
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
+
+static int __init pmac_ide_init(void)
+{
+	pmac_ide_probe();
+
+	return 0;
+}
+
+module_init(pmac_ide_init);
Index: b/drivers/ide/setup-pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -853,8 +853,8 @@ static int __init ide_scan_pcidev(struct
  *	PCI drivers. After this all IDE pci handling becomes standard
  *	module ordering not traditionally ordered.
  */
- =09
-void __init ide_scan_pcibus (int scan_direction)
+
+static void __init ide_scan_pcibus(int scan_direction)
 {
 	struct pci_dev *dev =3D NULL;
 	struct pci_driver *d;
@@ -883,3 +883,14 @@ void __init ide_scan_pcibus (int scan_di
 		__pci_register_driver(d, d->driver.owner, d->driver.mod_name);
 	}
 }
+
+extern int ide_scan_direction;
+
+static int __init ide_pci_init(void)
+{
+	ide_scan_pcibus(ide_scan_direction);
+
+	return 0;
+}
+
+module_init(ide_pci_init);
Index: b/include/linux/ide.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1203,7 +1203,6 @@ void ide_init_disk(struct gendisk *, ide
=20
 extern int ideprobe_init(void);
=20
-extern void ide_scan_pcibus(int scan_direction) __init;
 extern int __ide_pci_register_driver(struct pci_driver *driver, struct=
 module *owner, const char *mod_name);
 #define ide_pci_register_driver(d) __ide_pci_register_driver(d, THIS_M=
ODULE, KBUILD_MODNAME)
 void ide_pci_setup_ports(struct pci_dev *, struct ide_pci_device_s *, =
int, ata_index_t *);
