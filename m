From: Taral <taral@taral.net>
Subject: Modular IDE
Date: Sun, 11 May 2003 23:39:51 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030512043951.GA26526@taral.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adsl-66-141-53-185.dsl.austtx.swbell.net ([66.141.53.185]:44160
	"EHLO dragon.taral.net") by vger.kernel.org with ESMTP
	id S261892AbTELE1N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 May 2003 00:27:13 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've managed to shoe-horn IDE into compiling itself as a module... Patch
is attached. Any comments?

--=20
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Most parents have better things to do with their time than take care of
their children." -- Me

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-mod.patch"
Content-Transfer-Encoding: quoted-printable

diff -Nru a/drivers/ide/Makefile b/drivers/ide/Makefile
--- a/drivers/ide/Makefile	Sun May 11 15:26:06 2003
+++ b/drivers/ide/Makefile	Sun May 11 15:26:06 2003
@@ -12,19 +12,23 @@
=20
 # Core IDE code - must come before legacy
=20
-obj-$(CONFIG_BLK_DEV_IDE)		+=3D ide-io.o ide-probe.o ide-geometry.o ide-io=
ps.o ide-taskfile.o ide.o ide-lib.o ide-default.o
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+=3D ide-disk.o
 obj-$(CONFIG_BLK_DEV_IDECD)		+=3D ide-cd.o
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+=3D ide-tape.o
 obj-$(CONFIG_BLK_DEV_IDEFLOPPY)		+=3D ide-floppy.o
=20
-obj-$(CONFIG_BLK_DEV_IDEPCI)		+=3D setup-pci.o
-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+=3D ide-dma.o
-obj-$(CONFIG_BLK_DEV_IDE_TCQ)		+=3D ide-tcq.o
-obj-$(CONFIG_BLK_DEV_IDEPNP)		+=3D ide-pnp.o
-
+ide-mod-y					:=3D ide-probe.o ide-io.o ide-geometry.o ide-iops.o ide-task=
file.o ide.o ide-lib.o ide-default.o
+ide-mod-n					:=3D
+ide-mod-$(CONFIG_PROC_FS)			+=3D ide-proc.o
+ide-mod-$(CONFIG_BLK_DEV_IDEPCI)		+=3D setup-pci.o
+ide-mod-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+=3D ide-dma.o
+ide-mod-$(CONFIG_BLK_DEV_IDE_TCQ)		+=3D ide-tcq.o
+ide-mod-$(CONFIG_BLK_DEV_IDEPNP)		+=3D ide-pnp.o
 ifeq ($(CONFIG_BLK_DEV_IDE),y)
-obj-$(CONFIG_PROC_FS)			+=3D ide-proc.o
+obj-y +=3D $(ide-mod-y)
+endif
+ifeq ($(CONFIG_BLK_DEV_IDE),m)
+obj-m +=3D ide-mod.o
 endif
=20
 obj-$(CONFIG_BLK_DEV_IDE)		+=3D legacy/ ppc/ arm/
diff -Nru a/drivers/ide/ide-default.c b/drivers/ide/ide-default.c
--- a/drivers/ide/ide-default.c	Sun May 11 15:26:06 2003
+++ b/drivers/ide/ide-default.c	Sun May 11 15:26:06 2003
@@ -65,7 +65,3 @@
 	}
 	return 0;
 }
-
-MODULE_DESCRIPTION("IDE Default Driver");
-
-MODULE_LICENSE("GPL");
diff -Nru a/drivers/ide/ide-geometry.c b/drivers/ide/ide-geometry.c
--- a/drivers/ide/ide-geometry.c	Sun May 11 15:26:06 2003
+++ b/drivers/ide/ide-geometry.c	Sun May 11 15:26:06 2003
@@ -2,6 +2,7 @@
  * linux/drivers/ide/ide-geometry.c
  */
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/ide.h>
 #include <linux/mc146818rtc.h>
 #include <asm/io.h>
@@ -69,7 +70,7 @@
  * Returns 1 if the geometry translation was successful.
  */
=20
-int ide_xlate_1024 (struct block_device *bdev, int xparm, int ptheads, con=
st char *msg)
+int ide_xlate_1024(struct block_device *bdev, int xparm, int ptheads, cons=
t char *msg)
 {
 	ide_drive_t *drive =3D bdev->bd_disk->private_data;
 	const char *msg1 =3D "";
@@ -133,3 +134,4 @@
 		       drive->bios_cyl, drive->bios_head, drive->bios_sect);
 	return ret;
 }
+EXPORT_SYMBOL(ide_xlate_1024);
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	Sun May 11 15:26:06 2003
+++ b/drivers/ide/ide-io.c	Sun May 11 15:26:06 2003
@@ -577,7 +577,7 @@
  *	FIXME: this function needs a rename
  */
 =20
-ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
+static ide_startstop_t start_request (ide_drive_t *drive, struct request *=
rq)
 {
 	ide_startstop_t startstop;
 	unsigned long block;
@@ -633,8 +633,6 @@
 	return ide_stopped;
 }
=20
-EXPORT_SYMBOL(start_request);
-
 /**
  *	ide_stall_queue		-	pause an IDE device
  *	@drive: drive to stall
@@ -867,14 +865,6 @@
 }
=20
 EXPORT_SYMBOL(ide_do_request);
-
-/*
- * Passes the stuff to ide_do_request
- */
-void do_ide_request(request_queue_t *q)
-{
-	ide_do_request(q->queuedata, IDE_NO_IRQ);
-}
=20
 /*
  * un-busy the hwgroup etc, and clear any pending DMA status. we want to
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Sun May 11 15:26:06 2003
+++ b/drivers/ide/ide-probe.c	Sun May 11 15:26:06 2003
@@ -683,8 +683,6 @@
 	return(addr_errs);
 }
=20
-//EXPORT_SYMBOL(hwif_check_regions);
-
 #define hwif_request_region(addr, num, name)	\
 	((hwif->mmio) ? request_mem_region((addr),(num),(name)) : request_region(=
(addr),(num),(name)))
=20
@@ -721,8 +719,6 @@
 		hwif_request_region(hwif->io_ports[i], 1, hwif->name);
 }
=20
-//EXPORT_SYMBOL(hwif_register);
-
 /* Enable code below on all archs later, for now, I want it on PPC
  */
 #ifdef CONFIG_PPC
@@ -976,7 +972,7 @@
  *
  * This routine detects and reports such situations, but does not fix them.
  */
-void save_match (ide_hwif_t *hwif, ide_hwif_t *new, ide_hwif_t **match)
+static void save_match (ide_hwif_t *hwif, ide_hwif_t *new, ide_hwif_t **ma=
tch)
 {
 	ide_hwif_t *m =3D *match;
=20
@@ -989,10 +985,17 @@
 	if (!m || m->irq !=3D hwif->irq) /* don't undo a prior perfect match */
 		*match =3D new;
 }
-EXPORT_SYMBOL(save_match);
 #endif /* MAX_HWIFS > 1 */
=20
 /*
+ * Passes the stuff to ide_do_request
+ */
+static void do_ide_request(request_queue_t *q)
+{
+	ide_do_request(q->queuedata, IDE_NO_IRQ);
+}
+
+/*
  * init request queue
  */
 static void ide_init_queue(ide_drive_t *drive)
@@ -1309,8 +1312,6 @@
 			THIS_MODULE, ata_probe, ata_lock, hwif);
 }
=20
-EXPORT_SYMBOL(init_gendisk);
-
 int hwif_init (ide_hwif_t *hwif)
 {
 	int old_irq, unit;
@@ -1381,21 +1382,6 @@
=20
 EXPORT_SYMBOL(hwif_init);
=20
-void export_ide_init_queue (ide_drive_t *drive)
-{
-	ide_init_queue(drive);
-	ide_init_drive(drive);
-}
-
-EXPORT_SYMBOL(export_ide_init_queue);
-
-u8 export_probe_for_drive (ide_drive_t *drive)
-{
-	return probe_for_drive(drive);
-}
-
-EXPORT_SYMBOL(export_probe_for_drive);
-
 int ideprobe_init (void);
 static ide_module_t ideprobe_module =3D {
 	IDE_PROBE_MODULE,
@@ -1438,26 +1424,3 @@
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
-
-#ifdef MODULE
-extern int (*ide_xlate_1024_hook)(struct block_device *, int, int, const c=
har *);
-
-int init_module (void)
-{
-	unsigned int index;
-=09
-	for (index =3D 0; index < MAX_HWIFS; ++index)
-		ide_unregister(index);
-	ideprobe_init();
-	create_proc_ide_interfaces();
-	ide_xlate_1024_hook =3D ide_xlate_1024;
-	return 0;
-}
-
-void cleanup_module (void)
-{
-	ide_probe =3D NULL;
-	ide_xlate_1024_hook =3D 0;
-}
-MODULE_LICENSE("GPL");
-#endif /* MODULE */
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Sun May 11 15:26:06 2003
+++ b/drivers/ide/ide.c	Sun May 11 15:26:06 2003
@@ -178,6 +178,7 @@
 static int initializing;	/* set while initializing built-in drivers */
=20
 DECLARE_MUTEX(ide_cfg_sem);
+EXPORT_SYMBOL(ide_cfg_sem);
 spinlock_t ide_lock __cacheline_aligned_in_smp =3D SPIN_LOCK_UNLOCKED;
=20
 static int ide_scan_direction; /* THIS was formerly 2.2.x pci=3Dreverse */
@@ -1355,6 +1356,7 @@
 	if (drive->media !=3D ide_disk)
 		ide_add_setting(drive,	"ide-scsi",		SETTING_RW,					-1,		HDIO_SET_IDE_SC=
SI,		TYPE_BYTE,	0,	1,				1,		1,		&drive->scsi,			ide_atapi_to_scsi);
 }
+EXPORT_SYMBOL(ide_add_generic_settings);
=20
 /*
  * Delay for *at least* 50ms.  As we don't know how much time is left
@@ -2185,7 +2187,6 @@
 	 */
 	probe_for_hwifs ();
=20
-#ifdef CONFIG_BLK_DEV_IDE
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
 		ide_get_lock(NULL, NULL); /* for atari only */
=20
@@ -2193,7 +2194,6 @@
=20
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
 		ide_release_lock();	/* for atari only */
-#endif /* CONFIG_BLK_DEV_IDE */
=20
 #ifdef CONFIG_PROC_FS
 	proc_ide_create();
@@ -2456,6 +2456,7 @@
 struct bus_type ide_bus_type =3D {
 	.name		=3D "ide",
 };
+EXPORT_SYMBOL(ide_bus_type);
=20
 /*
  * This is gets invoked once during initialization, to set *everything* up
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Sun May 11 15:26:06 2003
+++ b/drivers/pci/pci.c	Sun May 11 15:26:06 2003
@@ -736,6 +736,7 @@
 EXPORT_SYMBOL(isa_bridge);
 #endif
=20
+EXPORT_SYMBOL(pci_enable_device_bars);
 EXPORT_SYMBOL(pci_enable_device);
 EXPORT_SYMBOL(pci_disable_device);
 EXPORT_SYMBOL(pci_max_busnr);

--pf9I7BMVVzbSWLtt--

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+vyWXoQQF8xCPwJQRAv2BAJ4qHWKY+m2eHcb4mDjn9BScoPeGTQCeJzwE
cbCGY26JMcs5mKXBX96hTCE=
=k3V5
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
