From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/21] ide: merge ->fixup and ->quirkproc methods
Date: Sun, 18 Nov 2007 23:11:35 +0100
Message-ID: <200711182311.35962.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:48819 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbXKRWga (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:30 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873018ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:29 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Assign drive->quirk_list in ->quirkproc implementations:
  - hpt366.c::hpt3xx_quirkproc()
  - pdc202xx_new.c::pdcnew_quirkproc()
  - pdc202xx_old.c::pdc202xx_quirkproc()

* Make ->quirkproc void.

* Move calling ->quirkproc from do_identify() to probe_hwif().

* Convert it821x_fixups() to it821x_quirkproc() in it821x.c.

* Convert siimage_fixup() to sil_quirkproc() in siimage.c, also remove
  no longer needed drive->present check from is_dev_seagate_sata().

* Convert ide_undecoded_slave() to accept 'drive' instead of 'hwif'
  as an argument.  Then convert ide_register_hw() to accept 'quirkproc'
  argument instead of 'fixup' one.

* Remove no longer needed ->fixup method.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c        |   20 ++++++++++----------
 drivers/ide/ide.c              |    8 +++-----
 drivers/ide/pci/hpt366.c       |   11 +++++++----
 drivers/ide/pci/it821x.c       |   37 ++++++++++++-------------------------
 drivers/ide/pci/pdc202xx_new.c |   11 +++++++----
 drivers/ide/pci/pdc202xx_old.c |   11 +++++++----
 drivers/ide/pci/siimage.c      |   15 +++++++--------
 drivers/ide/setup-pci.c        |    2 --
 include/linux/ide.h            |   10 ++++------
 9 files changed, 57 insertions(+), 68 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -249,9 +249,6 @@ static inline void do_identify (ide_driv
 	drive->media = ide_disk;
 	printk("%s DISK drive\n", (id->config == 0x848a) ? "CFA" : "ATA" );
 
-	if (hwif->quirkproc)
-		drive->quirk_list = hwif->quirkproc(drive);
-
 	return;
 
 err_misc:
@@ -683,19 +680,18 @@ static int wait_hwif_ready(ide_hwif_t *h
 
 /**
  *	ide_undecoded_slave	-	look for bad CF adapters
- *	@hwif: interface
+ *	@drive1: drive
  *
  *	Analyse the drives on the interface and attempt to decide if we
  *	have the same drive viewed twice. This occurs with crap CF adapters
  *	and PCMCIA sometimes.
  */
 
-void ide_undecoded_slave(ide_hwif_t *hwif)
+void ide_undecoded_slave(ide_drive_t *drive1)
 {
-	ide_drive_t *drive0 = &hwif->drives[0];
-	ide_drive_t *drive1 = &hwif->drives[1];
+	ide_drive_t *drive0 = &drive1->hwif->drives[0];
 
-	if (drive0->present == 0 || drive1->present == 0)
+	if ((drive1->dn & 1) == 0 || drive0->present == 0)
 		return;
 
 	/* If the models don't match they are not the same product */
@@ -824,8 +820,12 @@ static void probe_hwif(ide_hwif_t *hwif)
 		return;
 	}
 
-	if (hwif->fixup)
-		hwif->fixup(hwif);
+	for (unit = 0; unit < MAX_DRIVES; unit++) {
+		ide_drive_t *drive = &hwif->drives[unit];
+
+		if (drive->present && hwif->quirkproc)
+			hwif->quirkproc(drive);
+	}
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -414,8 +414,6 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->cds			= tmp_hwif->cds;
 #endif
 
-	hwif->fixup			= tmp_hwif->fixup;
-
 	hwif->set_pio_mode		= tmp_hwif->set_pio_mode;
 	hwif->set_dma_mode		= tmp_hwif->set_dma_mode;
 	hwif->mdma_filter		= tmp_hwif->mdma_filter;
@@ -680,7 +678,7 @@ void ide_setup_ports (	hw_regs_t *hw,
 /**
  *	ide_register_hw		-	register IDE interface
  *	@hw: hardware registers
- *	@fixup: fixup function
+ *	@quirkproc: quirkproc function
  *	@initializing: set while initializing built-in drivers
  *	@hwifp: pointer to returned hwif
  *
@@ -690,7 +688,7 @@ void ide_setup_ports (	hw_regs_t *hw,
  *	Returns -1 on error.
  */
 
-int ide_register_hw(hw_regs_t *hw, void (*fixup)(ide_hwif_t *),
+int ide_register_hw(hw_regs_t *hw, void (*quirkproc)(ide_drive_t *),
 		    int initializing, ide_hwif_t **hwifp)
 {
 	int index, retry = 1;
@@ -726,7 +724,7 @@ found:
 	memcpy(hwif->io_ports, hw->io_ports, sizeof(hwif->io_ports));
 	hwif->irq = hw->irq;
 	hwif->noprobe = 0;
-	hwif->fixup = fixup;
+	hwif->quirkproc = quirkproc;
 	hwif->chipset = hw->chipset;
 	hwif->gendev.parent = hw->dev;
 	hwif->ack_intr = hw->ack_intr;
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -676,15 +676,18 @@ static void hpt3xx_set_pio_mode(ide_driv
 	hpt3xx_set_mode(drive, XFER_PIO_0 + pio);
 }
 
-static int hpt3xx_quirkproc(ide_drive_t *drive)
+static void hpt3xx_quirkproc(ide_drive_t *drive)
 {
 	struct hd_driveid *id	= drive->id;
 	const  char **list	= quirk_drives;
 
 	while (*list)
-		if (strstr(id->model, *list++))
-			return 1;
-	return 0;
+		if (strstr(id->model, *list++)) {
+			drive->quirk_list = 1;
+			return;
+		}
+
+	drive->quirk_list = 0;
 }
 
 static void hpt3xx_maskproc(ide_drive_t *drive, int mask)
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -431,33 +431,29 @@ static u8 __devinit ata66_it821x(ide_hwi
 }
 
 /**
- *	it821x_fixup	-	post init callback
- *	@hwif: interface
+ *	it821x_quirkproc	-	post init callback
+ *	@drive: drive
  *
- *	This callback is run after the drives have been probed but
+ *	This callback is run after the drive has been probed but
  *	before anything gets attached. It allows drivers to do any
  *	final tuning that is needed, or fixups to work around bugs.
  */
 
-static void __devinit it821x_fixups(ide_hwif_t *hwif)
+static void __devinit it821x_quirkproc(ide_drive_t *drive)
 {
-	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
-	int i;
+	struct it821x_dev *itdev = ide_get_hwifdata(drive->hwif);
+	struct hd_driveid *id = drive->id;
+	u16 *idbits = (u16 *)drive->id;
 
-	if(!itdev->smart) {
+	if (!itdev->smart) {
 		/*
 		 *	If we are in pass through mode then not much
 		 *	needs to be done, but we do bother to clear the
 		 *	IRQ mask as we may well be in PIO (eg rev 0x10)
 		 *	for now and we know unmasking is safe on this chipset.
 		 */
-		for (i = 0; i < 2; i++) {
-			ide_drive_t *drive = &hwif->drives[i];
-			if(drive->present)
-				drive->unmask = 1;
-		}
-		return;
-	}
+		drive->unmask = 1;
+	} else {
 	/*
 	 *	Perform fixups on smart mode. We need to "lose" some
 	 *	capabilities the firmware lacks but does not filter, and
@@ -465,16 +461,6 @@ static void __devinit it821x_fixups(ide_
 	 *	in RAID mode.
 	 */
 
-	for(i = 0; i < 2; i++) {
-		ide_drive_t *drive = &hwif->drives[i];
-		struct hd_driveid *id;
-		u16 *idbits;
-
-		if(!drive->present)
-			continue;
-		id = drive->id;
-		idbits = (u16 *)drive->id;
-
 		/* Check for RAID v native */
 		if(strstr(id->model, "Integrated Technology Express")) {
 			/* In raid mode the ident block is slightly buggy
@@ -537,6 +523,8 @@ static void __devinit init_hwif_it821x(i
 	struct it821x_dev *idev = kzalloc(sizeof(struct it821x_dev), GFP_KERNEL);
 	u8 conf;
 
+	hwif->quirkproc = &it821x_quirkproc;
+
 	if (idev == NULL) {
 		printk(KERN_ERR "it821x: out of memory, falling back to legacy behaviour.\n");
 		return;
@@ -633,7 +621,6 @@ static unsigned int __devinit init_chips
 		.name		= name_str,		\
 		.init_chipset	= init_chipset_it821x,	\
 		.init_hwif	= init_hwif_it821x,	\
-		.fixup	 	= it821x_fixups,	\
 		.host_flags	= IDE_HFLAG_BOOTABLE,	\
 		.pio_mask	= ATA_PIO4,		\
 	}
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -203,14 +203,17 @@ static u8 pdcnew_cable_detect(ide_hwif_t
 		return ATA_CBL_PATA80;
 }
 
-static int pdcnew_quirkproc(ide_drive_t *drive)
+static void pdcnew_quirkproc(ide_drive_t *drive)
 {
 	const char **list, *model = drive->id->model;
 
 	for (list = pdc_quirk_drives; *list != NULL; list++)
-		if (strstr(model, *list) != NULL)
-			return 2;
-	return 0;
+		if (strstr(model, *list) != NULL) {
+			drive->quirk_list = 2;
+			return;
+		}
+
+	drive->quirk_list = 0;
 }
 
 static void pdcnew_reset(ide_drive_t *drive)
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -176,14 +176,17 @@ static void pdc_old_disable_66MHz_clock(
 	outb(clock & ~(hwif->channel ? 0x08 : 0x02), clock_reg);
 }
 
-static int pdc202xx_quirkproc (ide_drive_t *drive)
+static void pdc202xx_quirkproc(ide_drive_t *drive)
 {
 	const char **list, *model = drive->id->model;
 
 	for (list = pdc_quirk_drives; *list != NULL; list++)
-		if (strstr(model, *list) != NULL)
-			return 2;
-	return 0;
+		if (strstr(model, *list) != NULL) {
+			drive->quirk_list = 2;
+			return;
+		}
+
+	drive->quirk_list = 0;
 }
 
 static void pdc202xx_old_ide_dma_start(ide_drive_t *drive)
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -713,9 +713,6 @@ static int is_dev_seagate_sata(ide_drive
 	const char *s = &drive->id->model[0];
 	unsigned len;
 
-	if (!drive->present)
-		return 0;
-
 	len = strnlen(s, sizeof(drive->id->model));
 
 	if ((len > 4) && (!memcmp(s, "ST", 2))) {
@@ -730,18 +727,20 @@ static int is_dev_seagate_sata(ide_drive
 }
 
 /**
- *	siimage_fixup		-	post probe fixups
- *	@hwif: interface to fix up
+ *	sil_quirkproc		-	post probe fixups
+ *	@drive: drive
  *
  *	Called after drive probe we use this to decide whether the
  *	Seagate fixup must be applied. This used to be in init_iops but
  *	that can occur before we know what drives are present.
  */
 
-static void __devinit siimage_fixup(ide_hwif_t *hwif)
+static void __devinit sil_quirkproc(ide_drive_t *drive)
 {
+	ide_hwif_t *hwif = drive->hwif;
+
 	/* Try and raise the rqsize */
-	if (!is_sata(hwif) || !is_dev_seagate_sata(&hwif->drives[0]))
+	if (!is_sata(hwif) || !is_dev_seagate_sata(drive))
 		hwif->rqsize = 128;
 }
 
@@ -804,6 +803,7 @@ static void __devinit init_hwif_siimage(
 
 	hwif->set_pio_mode = &sil_set_pio_mode;
 	hwif->set_dma_mode = &sil_set_dma_mode;
+	hwif->quirkproc = &sil_quirkproc;
 
 	if (sata) {
 		static int first = 1;
@@ -842,7 +842,6 @@ static void __devinit init_hwif_siimage(
 		.init_chipset	= init_chipset_siimage,	\
 		.init_iops	= init_iops_siimage,	\
 		.init_hwif	= init_hwif_siimage,	\
-		.fixup		= siimage_fixup,	\
 		.host_flags	= IDE_HFLAG_BOOTABLE,	\
 		.pio_mask	= ATA_PIO4,		\
 		.mwdma_mask	= ATA_MWDMA2,		\
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -555,8 +555,6 @@ void ide_pci_setup_ports(struct pci_dev 
 		    (d->host_flags & IDE_HFLAG_FORCE_LEGACY_IRQS))
 			hwif->irq = port ? 15 : 14;
 
-		hwif->fixup = d->fixup;
-
 		hwif->host_flags = d->host_flags;
 		hwif->pio_mask = d->pio_mask;
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -199,7 +199,8 @@ typedef struct hw_regs_s {
 
 struct hwif_s * ide_find_port(unsigned long);
 
-int ide_register_hw(hw_regs_t *, void (*)(struct hwif_s *), int,
+struct ide_drive_s;
+int ide_register_hw(hw_regs_t *, void (*)(struct ide_drive_s *), int,
 		    struct hwif_s **);
 
 void ide_setup_ports(	hw_regs_t *hw,
@@ -527,15 +528,13 @@ typedef struct hwif_s {
 	/* special host masking for drive selection */
 	void	(*maskproc)(ide_drive_t *, int);
 	/* check host's drive quirk list */
-	int	(*quirkproc)(ide_drive_t *);
+	void	(*quirkproc)(ide_drive_t *);
 	/* driver soft-power interface */
 	int	(*busproc)(ide_drive_t *, int);
 #endif
 	u8 (*mdma_filter)(ide_drive_t *);
 	u8 (*udma_filter)(ide_drive_t *);
 
-	void (*fixup)(struct hwif_s *);
-
 	void (*ata_input_data)(ide_drive_t *, void *, u32);
 	void (*ata_output_data)(ide_drive_t *, void *, u32);
 
@@ -1108,7 +1107,6 @@ struct ide_port_info {
 	void			(*init_iops)(ide_hwif_t *);
 	void                    (*init_hwif)(ide_hwif_t *);
 	void			(*init_dma)(ide_hwif_t *, unsigned long);
-	void			(*fixup)(ide_hwif_t *);
 	ide_pci_enablebit_t	enablebits[2];
 	hwif_chipset_t		chipset;
 	u8			extra;
@@ -1202,7 +1200,7 @@ extern void ide_unregister (unsigned int
 void ide_register_region(struct gendisk *);
 void ide_unregister_region(struct gendisk *);
 
-void ide_undecoded_slave(ide_hwif_t *);
+void ide_undecoded_slave(ide_drive_t *);
 
 int ide_device_add(u8 idx[4]);
 
