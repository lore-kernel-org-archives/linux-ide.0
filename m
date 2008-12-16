From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/9] ide: remove 'byte' typedef
Date: Tue, 16 Dec 2008 20:32:10 +0100
Message-ID: <20081216193210.3959.92852.sendpatchset@localhost.localdomain>
References: <20081216193137.3959.70339.sendpatchset@localhost.localdomain>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758672AbYLPTds@vger.kernel.org>
In-Reply-To: <20081216193137.3959.70339.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove 'byte' typedef

Just use u8 instead, also s/__u8/u8/ in ide-cd.h while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.h |   26 +++++++++++++-------------
 drivers/ide/it821x.c |    4 ++--
 drivers/ide/qd65xx.h |    4 ++--
 drivers/ide/sc1200.c |    2 +-
 include/linux/ide.h  |    4 +---
 5 files changed, 19 insertions(+), 21 deletions(-)

Index: b/drivers/ide/ide-cd.h
===================================================================
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -33,33 +33,33 @@
 
 /* Structure of a MSF cdrom address. */
 struct atapi_msf {
-	byte reserved;
-	byte minute;
-	byte second;
-	byte frame;
+	u8 reserved;
+	u8 minute;
+	u8 second;
+	u8 frame;
 };
 
 /* Space to hold the disk TOC. */
 #define MAX_TRACKS 99
 struct atapi_toc_header {
 	unsigned short toc_length;
-	byte first_track;
-	byte last_track;
+	u8 first_track;
+	u8 last_track;
 };
 
 struct atapi_toc_entry {
-	byte reserved1;
+	u8 reserved1;
 #if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 adr     : 4;
-	__u8 control : 4;
+	u8 adr     : 4;
+	u8 control : 4;
 #elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 control : 4;
-	__u8 adr     : 4;
+	u8 control : 4;
+	u8 adr     : 4;
 #else
 #error "Please fix <asm/byteorder.h>"
 #endif
-	byte track;
-	byte reserved2;
+	u8 track;
+	u8 reserved2;
 	union {
 		unsigned lba;
 		struct atapi_msf msf;
Index: b/drivers/ide/it821x.c
===================================================================
--- a/drivers/ide/it821x.c
+++ b/drivers/ide/it821x.c
@@ -279,7 +279,7 @@ static void it821x_set_pio_mode(ide_driv
  *	the shared MWDMA/PIO timing register.
  */
 
-static void it821x_tune_mwdma (ide_drive_t *drive, byte mode_wanted)
+static void it821x_tune_mwdma(ide_drive_t *drive, u8 mode_wanted)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
@@ -316,7 +316,7 @@ static void it821x_tune_mwdma (ide_drive
  *	controller when doing UDMA modes in pass through.
  */
 
-static void it821x_tune_udma (ide_drive_t *drive, byte mode_wanted)
+static void it821x_tune_udma(ide_drive_t *drive, u8 mode_wanted)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
Index: b/drivers/ide/qd65xx.h
===================================================================
--- a/drivers/ide/qd65xx.h
+++ b/drivers/ide/qd65xx.h
@@ -31,8 +31,8 @@
 
 #define QD_CONFIG(hwif)		((hwif)->config_data & 0x00ff)
 
-#define QD_TIMING(drive)	(byte)(((drive)->drive_data) & 0x00ff)
-#define QD_TIMREG(drive)	(byte)((((drive)->drive_data) & 0xff00) >> 8)
+#define QD_TIMING(drive)	(u8)(((drive)->drive_data) & 0x00ff)
+#define QD_TIMREG(drive)	(u8)((((drive)->drive_data) & 0xff00) >> 8)
 
 #define QD6500_DEF_DATA		((QD_TIM1_PORT<<8) | (QD_ID3 ? 0x0c : 0x08))
 #define QD6580_DEF_DATA		((QD_TIM1_PORT<<8) | (QD_ID3 ? 0x0a : 0x00))
Index: b/drivers/ide/sc1200.c
===================================================================
--- a/drivers/ide/sc1200.c
+++ b/drivers/ide/sc1200.c
@@ -171,7 +171,7 @@ static int sc1200_dma_end(ide_drive_t *d
 {
 	ide_hwif_t *hwif = drive->hwif;
 	unsigned long dma_base = hwif->dma_base;
-	byte dma_stat;
+	u8 dma_stat;
 
 	dma_stat = inb(dma_base+2);		/* get DMA status */
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -32,8 +32,6 @@
 # define SUPPORT_VLB_SYNC 1
 #endif
 
-typedef unsigned char	byte;	/* used everywhere */
-
 /*
  * Probably not wise to fiddle with these
  */
@@ -1162,7 +1160,7 @@ void ide_pad_transfer(ide_drive_t *, int
 
 ide_startstop_t __ide_error(ide_drive_t *, struct request *, u8, u8);
 
-ide_startstop_t ide_error (ide_drive_t *drive, const char *msg, byte stat);
+ide_startstop_t ide_error(ide_drive_t *, const char *, u8);
 
 void ide_fix_driveid(u16 *);
 
