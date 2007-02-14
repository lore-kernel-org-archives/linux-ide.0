From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/8] ide: add ide_proc_register_port()
Date: Wed, 14 Feb 2007 02:57:06 +0100
Message-ID: <20070214015706.4619.84820.sendpatchset@localhost.localdomain>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:47958 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbXBNBv0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2007 20:51:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so28283uga
        for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2007 17:51:24 -0800 (PST)
In-Reply-To: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[PATCH] ide: add ide_proc_register_port()

* create_proc_ide_interfaces() tries to add /proc entries for every probed
  and initialized IDE port, replace it by ide_proc_register_port() which does
  it only for the given port (also rename destroy_proc_ide_interface() to
  ide_proc_unregister_port() for consistency)
  
* convert {create,destroy}_proc_ide_interface[s]() users to use new functions

* pmac driver depended on proc_ide_create() to add /proc port entries, fix it
  
* au1xxx-ide, swarm and cs5520 drivers depended indirectly on ide-generic
  driver (CONFIG_IDE_GENERIC=y) to add port /proc entries, fix them

* there is now no need to add /proc entries for IDE ports in proc_ide_create()
  so don't do it

* proc_ide_create() needs now to be called before drivers are probed - fix it,
  while at it make proc_ide_create() create /proc "ide" directory

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/arm/icside.c      |    7 +++++--
 drivers/ide/arm/rapide.c      |    2 +-
 drivers/ide/ide-generic.c     |    2 --
 drivers/ide/ide-probe.c       |    3 +++
 drivers/ide/ide-proc.c        |   34 +++++++++++++++++-----------------
 drivers/ide/ide.c             |   14 +++-----------
 drivers/ide/legacy/ali14xx.c  |    3 ++-
 drivers/ide/legacy/dtc2278.c  |    3 ++-
 drivers/ide/legacy/ht6560b.c  |    3 ++-
 drivers/ide/legacy/qd65xx.c   |    7 ++++---
 drivers/ide/legacy/umc8672.c  |    3 ++-
 drivers/ide/mips/au1xxx-ide.c |    3 +++
 drivers/ide/mips/swarm.c      |    3 +++
 drivers/ide/pci/cs5520.c      |   20 ++++++++++++++++----
 drivers/ide/pci/sgiioc4.c     |    2 +-
 drivers/ide/ppc/pmac.c        |    2 ++
 drivers/ide/setup-pci.c       |   25 +++++++++++++++++++++----
 include/linux/ide.h           |   10 ++++------
 18 files changed, 91 insertions(+), 55 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -602,7 +602,8 @@ icside_register_v5(struct icside_state *
 	state->hwif[0] = hwif;
 
 	probe_hwif_init(hwif);
-	create_proc_ide_interfaces();
+
+	ide_proc_register_port(hwif);
 
 	return 0;
 }
@@ -690,7 +691,9 @@ icside_register_v6(struct icside_state *
 
 	probe_hwif_init(hwif);
 	probe_hwif_init(mate);
-	create_proc_ide_interfaces();
+
+	ide_proc_register_port(hwif);
+	ide_proc_register_port(mate);
 
 	return 0;
 
Index: b/drivers/ide/arm/rapide.c
===================================================================
--- a/drivers/ide/arm/rapide.c
+++ b/drivers/ide/arm/rapide.c
@@ -76,7 +76,7 @@ rapide_probe(struct expansion_card *ec, 
 		hwif->gendev.parent = &ec->dev;
 		hwif->noprobe = 0;
 		probe_hwif_init(hwif);
-		create_proc_ide_interfaces();
+		ide_proc_register_port(hwif);
 		ecard_set_drvdata(ec, hwif);
 		goto out;
 	}
Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -22,8 +22,6 @@ static int __init ide_generic_init(void)
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
 		ide_release_lock();	/* for atari only */
 
-	create_proc_ide_interfaces();
-
 	return 0;
 }
 
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1429,6 +1429,9 @@ int ideprobe_init (void)
 				}
 		}
 	}
+	for (index = 0; index < MAX_HWIFS; ++index)
+		if (probe[index])
+			ide_proc_register_port(&ide_hwifs[index]);
 	return 0;
 }
 
Index: b/drivers/ide/ide-proc.c
===================================================================
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -40,6 +40,8 @@
 
 #include <asm/io.h>
 
+static struct proc_dir_entry *proc_ide_root;
+
 static int proc_ide_read_imodel
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
@@ -789,26 +791,24 @@ static ide_proc_entry_t hwif_entries[] =
 	{ NULL,	0, NULL, NULL }
 };
 
-void create_proc_ide_interfaces(void)
+void ide_proc_register_port(ide_hwif_t *hwif)
 {
-	int	h;
+	if (!hwif->present)
+		return;
 
-	for (h = 0; h < MAX_HWIFS; h++) {
-		ide_hwif_t *hwif = &ide_hwifs[h];
+	if (!hwif->proc) {
+		hwif->proc = proc_mkdir(hwif->name, proc_ide_root);
 
-		if (!hwif->present)
-			continue;
-		if (!hwif->proc) {
-			hwif->proc = proc_mkdir(hwif->name, proc_ide_root);
-			if (!hwif->proc)
-				return;
-			ide_add_proc_entries(hwif->proc, hwif_entries, hwif);
-		}
-		create_proc_ide_drives(hwif);
+		if (!hwif->proc)
+			return;
+
+		ide_add_proc_entries(hwif->proc, hwif_entries, hwif);
 	}
+
+	create_proc_ide_drives(hwif);
 }
 
-EXPORT_SYMBOL(create_proc_ide_interfaces);
+EXPORT_SYMBOL_GPL(ide_proc_register_port);
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
 void ide_pci_create_host_proc(const char *name, get_info_t *get_info)
@@ -819,7 +819,7 @@ void ide_pci_create_host_proc(const char
 EXPORT_SYMBOL_GPL(ide_pci_create_host_proc);
 #endif
 
-void destroy_proc_ide_interface(ide_hwif_t *hwif)
+void ide_proc_unregister_port(ide_hwif_t *hwif)
 {
 	if (hwif->proc) {
 		destroy_proc_ide_drives(hwif);
@@ -866,11 +866,11 @@ void proc_ide_create(void)
 {
 	struct proc_dir_entry *entry;
 
+	proc_ide_root = proc_mkdir("ide", NULL);
+
 	if (!proc_ide_root)
 		return;
 
-	create_proc_ide_interfaces();
-
 	entry = create_proc_entry("drivers", 0, proc_ide_root);
 	if (entry)
 		entry->proc_fops = &ide_drivers_operations;
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -353,10 +353,6 @@ static int ide_system_bus_speed(void)
 	return system_bus_speed;
 }
 
-#ifdef CONFIG_IDE_PROC_FS
-struct proc_dir_entry *proc_ide_root;
-#endif
-
 static struct resource* hwif_request_region(ide_hwif_t *hwif,
 					    unsigned long addr, int num)
 {
@@ -600,7 +596,7 @@ void ide_unregister(unsigned int index)
 
 	spin_unlock_irq(&ide_lock);
 
-	destroy_proc_ide_interface(hwif);
+	ide_proc_unregister_port(hwif);
 
 	hwgroup = hwif->hwgroup;
 	/*
@@ -805,7 +801,7 @@ found:
 
 	if (!initializing) {
 		probe_hwif_init_with_fixup(hwif, fixup);
-		create_proc_ide_interfaces();
+		ide_proc_register_port(hwif);
 	}
 
 	if (hwifp)
@@ -1767,9 +1763,7 @@ static int __init ide_init(void)
 
 	init_ide_data();
 
-#ifdef CONFIG_IDE_PROC_FS
-	proc_ide_root = proc_mkdir("ide", NULL);
-#endif
+	proc_ide_create();
 
 #ifdef CONFIG_BLK_DEV_ALI14XX
 	if (probe_ali14xx)
@@ -1795,8 +1789,6 @@ static int __init ide_init(void)
 	/* Probe for special PCI and other "known" interface chipsets. */
 	probe_for_hwifs();
 
-	proc_ide_create();
-
 	return 0;
 }
 
Index: b/drivers/ide/legacy/ali14xx.c
===================================================================
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -225,7 +225,8 @@ static int __init ali14xx_probe(void)
 	probe_hwif_init(hwif);
 	probe_hwif_init(mate);
 
-	create_proc_ide_interfaces();
+	ide_proc_register_port(hwif);
+	ide_proc_register_port(mate);
 
 	return 0;
 }
Index: b/drivers/ide/legacy/dtc2278.c
===================================================================
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -140,7 +140,8 @@ static int __init probe_dtc2278(void)
 	probe_hwif_init(hwif);
 	probe_hwif_init(mate);
 
-	create_proc_ide_interfaces();
+	ide_proc_register_port(hwif);
+	ide_proc_register_port(mate);
 
 	return 0;
 }
Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -351,7 +351,8 @@ int __init ht6560b_init(void)
 	probe_hwif_init(hwif);
 	probe_hwif_init(mate);
 
-	create_proc_ide_interfaces();
+	ide_proc_register_port(hwif);
+	ide_proc_register_port(mate);
 
 	return 0;
 
Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -429,7 +429,7 @@ static int __init qd_probe(int base)
 		qd_setup(hwif, base, config, QD6500_DEF_DATA, QD6500_DEF_DATA,
 			 &qd6500_tune_drive);
 
-		create_proc_ide_interfaces();
+		ide_proc_register_port(hwif);
 
 		return 1;
 	}
@@ -461,7 +461,7 @@ static int __init qd_probe(int base)
 				 &qd6580_tune_drive);
 			qd_write_reg(QD_DEF_CONTR,QD_CONTROL_PORT);
 
-			create_proc_ide_interfaces();
+			ide_proc_register_port(hwif);
 
 			return 1;
 		} else {
@@ -481,7 +481,8 @@ static int __init qd_probe(int base)
 				 &qd6580_tune_drive);
 			qd_write_reg(QD_DEF_CONTR,QD_CONTROL_PORT);
 
-			create_proc_ide_interfaces();
+			ide_proc_register_port(hwif);
+			ide_proc_register_port(mate);
 
 			return 0; /* no other qd65xx possible */
 		}
Index: b/drivers/ide/legacy/umc8672.c
===================================================================
--- a/drivers/ide/legacy/umc8672.c
+++ b/drivers/ide/legacy/umc8672.c
@@ -160,7 +160,8 @@ static int __init umc8672_probe(void)
 	probe_hwif_init(hwif);
 	probe_hwif_init(mate);
 
-	create_proc_ide_interfaces();
+	ide_proc_register_port(hwif);
+	ide_proc_register_port(mate);
 
 	return 0;
 }
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -761,6 +761,9 @@ static int au_ide_probe(struct device *d
 #endif
 
 	probe_hwif_init(hwif);
+
+	ide_proc_register_port(hwif);
+
 	dev_set_drvdata(dev, hwif);
 
 	printk(KERN_INFO "Au1xxx IDE(builtin) configured for %s\n", mode );
Index: b/drivers/ide/mips/swarm.c
===================================================================
--- a/drivers/ide/mips/swarm.c
+++ b/drivers/ide/mips/swarm.c
@@ -129,6 +129,9 @@ static int __devinit swarm_ide_probe(str
 	hwif->irq = hwif->hw.irq;
 
 	probe_hwif_init(hwif);
+
+	ide_proc_register_port(hwif);
+
 	dev_set_drvdata(dev, hwif);
 
 	return 0;
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -213,6 +213,7 @@ static ide_pci_device_t cyrix_chipsets[]
  
 static int __devinit cs5520_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	ide_hwif_t *hwif = NULL, *mate = NULL;
 	ata_index_t index;
 	ide_pci_device_t *d = &cyrix_chipsets[id->driver_data];
 
@@ -239,10 +240,21 @@ static int __devinit cs5520_init_one(str
 
 	ide_pci_setup_ports(dev, d, 14, &index);
 
-	if((index.b.low & 0xf0) != 0xf0)
-		probe_hwif_init(&ide_hwifs[index.b.low]);
-	if((index.b.high & 0xf0) != 0xf0)
-		probe_hwif_init(&ide_hwifs[index.b.high]);
+	if ((index.b.low & 0xf0) != 0xf0)
+		hwif = &ide_hwifs[index.b.low];
+	if ((index.b.high & 0xf0) != 0xf0)
+		mate = &ide_hwifs[index.b.high];
+
+	if (hwif)
+		probe_hwif_init(hwif);
+	if (mate)
+		probe_hwif_init(mate);
+
+	if (hwif)
+		ide_proc_register_port(hwif);
+	if (mate)
+		ide_proc_register_port(mate);
+
 	return 0;
 }
 
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -692,7 +692,7 @@ sgiioc4_ide_setup_pci_device(struct pci_
 		return -EIO;
 
 	/* Create /proc/ide entries */
-	create_proc_ide_interfaces();
+	ide_proc_register_port(hwif);
 
 	return 0;
 }
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1277,6 +1277,8 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	/* We probe the hwif now */
 	probe_hwif_init(hwif);
 
+	ide_proc_register_port(hwif);
+
 	return 0;
 }
 
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -707,6 +707,7 @@ out:
 
 int ide_setup_pci_device(struct pci_dev *dev, ide_pci_device_t *d)
 {
+	ide_hwif_t *hwif = NULL, *mate = NULL;
 	ata_index_t index_list;
 	int ret;
 
@@ -715,11 +716,19 @@ int ide_setup_pci_device(struct pci_dev 
 		goto out;
 
 	if ((index_list.b.low & 0xf0) != 0xf0)
-		probe_hwif_init_with_fixup(&ide_hwifs[index_list.b.low], d->fixup);
+		hwif = &ide_hwifs[index_list.b.low];
 	if ((index_list.b.high & 0xf0) != 0xf0)
-		probe_hwif_init_with_fixup(&ide_hwifs[index_list.b.high], d->fixup);
+		mate = &ide_hwifs[index_list.b.high];
 
-	create_proc_ide_interfaces();
+	if (hwif)
+		probe_hwif_init_with_fixup(hwif, d->fixup);
+	if (mate)
+		probe_hwif_init_with_fixup(mate, d->fixup);
+
+	if (hwif)
+		ide_proc_register_port(hwif);
+	if (mate)
+		ide_proc_register_port(mate);
 out:
 	return ret;
 }
@@ -753,7 +762,15 @@ int ide_setup_pci_devices(struct pci_dev
 		}
 	}
 
-	create_proc_ide_interfaces();
+	for (i = 0; i < 2; i++) {
+		u8 idx[2] = { index_list[i].b.low, index_list[i].b.high };
+		int j;
+
+		for (j = 0; j < 2; j++) {
+			if ((idx[j] & 0xf0) != 0xf0)
+				ide_proc_register_port(ide_hwifs + idx[j]);
+		}
+	}
 out:
 	return ret;
 }
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -907,12 +907,10 @@ typedef struct {
 	write_proc_t	*write_proc;
 } ide_proc_entry_t;
 
-extern struct proc_dir_entry *proc_ide_root;
-
 void proc_ide_create(void);
 void proc_ide_destroy(void);
-void create_proc_ide_interfaces(void);
-void destroy_proc_ide_interface(ide_hwif_t *);
+void ide_proc_register_port(ide_hwif_t *);
+void ide_proc_unregister_port(ide_hwif_t *);
 void ide_proc_register_driver(ide_drive_t *, ide_driver_t *);
 void ide_proc_unregister_driver(ide_drive_t *, ide_driver_t *);
 
@@ -943,8 +941,8 @@ void ide_pci_create_host_proc(const char
 #else
 static inline void proc_ide_create(void) { ; }
 static inline void proc_ide_destroy(void) { ; }
-static inline void create_proc_ide_interfaces(void) { ; }
-static inline void destroy_proc_ide_interface(ide_hwif_t *hwif) { ; }
+static inline void ide_proc_register_port(ide_hwif_t *hwif) { ; }
+static inline void ide_proc_unregister_port(ide_hwif_t *hwif) { ; }
 static inline void ide_proc_register_driver(ide_drive_t *drive, ide_driver_t *driver) { ; }
 static inline void ide_proc_unregister_driver(ide_drive_t *drive, ide_driver_t *driver) { ; }
 static inline void ide_add_generic_settings(ide_drive_t *drive) { ; }
