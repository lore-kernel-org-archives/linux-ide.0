From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH 6/6] IDE: Coding Style fixes to drivers/ide/pci/cmd640.c
Date: Sat, 23 Feb 2008 18:38:44 +0100
Message-ID: <20080223183844.6b20c7d6@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:23914 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758397AbYBWRit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 12:38:49 -0500
Received: by ug-out-1314.google.com with SMTP id z38so200122ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 09:38:48 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

Fix all the errors and a few warnings.
Compile tested.


Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 drivers/ide/pci/cmd640.c |   90 +++++++++++++++++++++++-----------------------
 1 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/ide/pci/cmd640.c b/drivers/ide/pci/cmd640.c
index 77537b2..70bc3fe 100644
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -4,7 +4,7 @@
 
 /*
  *  Original authors:	abramov@cecmow.enet.dec.com (Igor Abramov)
- *  			mlord@pobox.com (Mark Lord)
+ *			mlord@pobox.com (Mark Lord)
  *
  *  See linux/MAINTAINERS for address of current maintainer.
  *
@@ -98,7 +98,7 @@
 
 #define CMD640_PREFETCH_MASKS 1
 
-//#define CMD640_DUMP_REGS
+/*#define CMD640_DUMP_REGS */
 
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -112,7 +112,7 @@
 /*
  * This flag is set in ide.c by the parameter:  ide0=cmd640_vlb
  */
-int cmd640_vlb = 0;
+int cmd640_vlb;
 
 /*
  * CMD640 specific registers definition.
@@ -206,13 +206,13 @@ static unsigned int cmd640_chip_version;
 
 /* PCI method 1 access */
 
-static void put_cmd640_reg_pci1 (u16 reg, u8 val)
+static void put_cmd640_reg_pci1(u16 reg, u8 val)
 {
 	outl_p((reg & 0xfc) | cmd640_key, 0xcf8);
 	outb_p(val, (reg & 3) | 0xcfc);
 }
 
-static u8 get_cmd640_reg_pci1 (u16 reg)
+static u8 get_cmd640_reg_pci1(u16 reg)
 {
 	outl_p((reg & 0xfc) | cmd640_key, 0xcf8);
 	return inb_p((reg & 3) | 0xcfc);
@@ -220,14 +220,14 @@ static u8 get_cmd640_reg_pci1 (u16 reg)
 
 /* PCI method 2 access (from CMD datasheet) */
 
-static void put_cmd640_reg_pci2 (u16 reg, u8 val)
+static void put_cmd640_reg_pci2(u16 reg, u8 val)
 {
 	outb_p(0x10, 0xcf8);
 	outb_p(val, cmd640_key + reg);
 	outb_p(0, 0xcf8);
 }
 
-static u8 get_cmd640_reg_pci2 (u16 reg)
+static u8 get_cmd640_reg_pci2(u16 reg)
 {
 	u8 b;
 
@@ -239,13 +239,13 @@ static u8 get_cmd640_reg_pci2 (u16 reg)
 
 /* VLB access */
 
-static void put_cmd640_reg_vlb (u16 reg, u8 val)
+static void put_cmd640_reg_vlb(u16 reg, u8 val)
 {
 	outb_p(reg, cmd640_key);
 	outb_p(val, cmd640_key + 4);
 }
 
-static u8 get_cmd640_reg_vlb (u16 reg)
+static u8 get_cmd640_reg_vlb(u16 reg)
 {
 	outb_p(reg, cmd640_key);
 	return inb_p(cmd640_key + 4);
@@ -267,11 +267,11 @@ static void put_cmd640_reg(u16 reg, u8 val)
 	unsigned long flags;
 
 	spin_lock_irqsave(&cmd640_lock, flags);
-	__put_cmd640_reg(reg,val);
+	__put_cmd640_reg(reg, val);
 	spin_unlock_irqrestore(&cmd640_lock, flags);
 }
 
-static int __init match_pci_cmd640_device (void)
+static int __init match_pci_cmd640_device(void)
 {
 	const u8 ven_dev[4] = {0x95, 0x10, 0x40, 0x06};
 	unsigned int i;
@@ -291,7 +291,7 @@ static int __init match_pci_cmd640_device (void)
 /*
  * Probe for CMD640x -- pci method 1
  */
-static int __init probe_for_cmd640_pci1 (void)
+static int __init probe_for_cmd640_pci1(void)
 {
 	__get_cmd640_reg = get_cmd640_reg_pci1;
 	__put_cmd640_reg = put_cmd640_reg_pci1;
@@ -307,7 +307,7 @@ static int __init probe_for_cmd640_pci1 (void)
 /*
  * Probe for CMD640x -- pci method 2
  */
-static int __init probe_for_cmd640_pci2 (void)
+static int __init probe_for_cmd640_pci2(void)
 {
 	__get_cmd640_reg = get_cmd640_reg_pci2;
 	__put_cmd640_reg = put_cmd640_reg_pci2;
@@ -321,7 +321,7 @@ static int __init probe_for_cmd640_pci2 (void)
 /*
  * Probe for CMD640x -- vlb
  */
-static int __init probe_for_cmd640_vlb (void)
+static int __init probe_for_cmd640_vlb(void)
 {
 	u8 b;
 
@@ -342,7 +342,7 @@ static int __init probe_for_cmd640_vlb (void)
  *  Returns 1 if an IDE interface/drive exists at 0x170,
  *  Returns 0 otherwise.
  */
-static int __init secondary_port_responding (void)
+static int __init secondary_port_responding(void)
 {
 	unsigned long flags;
 
@@ -366,7 +366,7 @@ static int __init secondary_port_responding (void)
 /*
  * Dump out all cmd640 registers.  May be called from ide.c
  */
-static void cmd640_dump_regs (void)
+static void cmd640_dump_regs(void)
 {
 	unsigned int reg = cmd640_vlb ? 0x50 : 0x00;
 
@@ -435,7 +435,7 @@ static void set_prefetch_mode(ide_drive_t *drive, unsigned int index, int mode)
 /*
  * Dump out current drive clocks settings
  */
-static void display_clocks (unsigned int index)
+static void display_clocks(unsigned int index)
 {
 	u8 active_count, recovery_count;
 
@@ -454,7 +454,7 @@ static void display_clocks (unsigned int index)
  * Pack active and recovery counts into single byte representation
  * used by controller
  */
-static inline u8 pack_nibbles (u8 upper, u8 lower)
+static inline u8 pack_nibbles(u8 upper, u8 lower)
 {
 	return ((upper & 0x0f) << 4) | (lower & 0x0f);
 }
@@ -462,7 +462,7 @@ static inline u8 pack_nibbles (u8 upper, u8 lower)
 /*
  * This routine retrieves the initial drive timings from the chipset.
  */
-static void __init retrieve_drive_counts (unsigned int index)
+static void __init retrieve_drive_counts(unsigned int index)
 {
 	u8 b;
 
@@ -471,10 +471,10 @@ static void __init retrieve_drive_counts (unsigned int index)
 	 */
 	b = get_cmd640_reg(arttim_regs[index]) & ~0x3f;
 	switch (b) {
-		case 0x00: b = 4; break;
-		case 0x80: b = 3; break;
-		case 0x40: b = 2; break;
-		default:   b = 5; break;
+	case 0x00: b = 4; break;
+	case 0x80: b = 3; break;
+	case 0x40: b = 2; break;
+	default:   b = 5; break;
 	}
 	setup_counts[index] = b;
 
@@ -523,11 +523,11 @@ static void program_drive_counts(ide_drive_t *drive, unsigned int index)
 	 * Convert setup_count to internal chipset representation
 	 */
 	switch (setup_count) {
-		case 4:	 setup_count = 0x00; break;
-		case 3:	 setup_count = 0x80; break;
-		case 1:
-		case 2:	 setup_count = 0x40; break;
-		default: setup_count = 0xc0; /* case 5 */
+	case 4:	 setup_count = 0x00; break;
+	case 3:	 setup_count = 0x80; break;
+	case 1:
+	case 2:	 setup_count = 0x40; break;
+	default: setup_count = 0xc0; /* case 5 */
 	}
 
 	/*
@@ -607,20 +607,20 @@ static void cmd640_set_pio_mode(ide_drive_t *drive, const u8 pio)
 	u8 b;
 
 	switch (pio) {
-		case 6: /* set fast-devsel off */
-		case 7: /* set fast-devsel on */
-			b = get_cmd640_reg(CNTRL) & ~0x27;
-			if (pio & 1)
-				b |= 0x27;
-			put_cmd640_reg(CNTRL, b);
-			printk("%s: %sabled cmd640 fast host timing (devsel)\n", drive->name, (pio & 1) ? "en" : "dis");
-			return;
-
-		case 8: /* set prefetch off */
-		case 9: /* set prefetch on */
-			set_prefetch_mode(drive, index, pio & 1);
-			printk("%s: %sabled cmd640 prefetch\n", drive->name, (pio & 1) ? "en" : "dis");
-			return;
+	case 6: /* set fast-devsel off */
+	case 7: /* set fast-devsel on */
+		b = get_cmd640_reg(CNTRL) & ~0x27;
+		if (pio & 1)
+			b |= 0x27;
+		put_cmd640_reg(CNTRL, b);
+		printk("%s: %sabled cmd640 fast host timing (devsel)\n", drive->name, (pio & 1) ? "en" : "dis");
+		return;
+
+	case 8: /* set prefetch off */
+	case 9: /* set prefetch on */
+		set_prefetch_mode(drive, index, pio & 1);
+		printk("%s: %sabled cmd640 prefetch\n", drive->name, (pio & 1) ? "en" : "dis");
+		return;
 	}
 
 	cycle_time = ide_pio_cycle_time(drive, pio);
@@ -729,7 +729,7 @@ static int __init cmd640x_init(void)
 	cfr = get_cmd640_reg(CFR);
 	cmd640_chip_version = cfr & CFR_DEVREV;
 	if (cmd640_chip_version == 0) {
-		printk ("ide: bad cmd640 revision: %d\n", cmd640_chip_version);
+		printk("ide: bad cmd640 revision: %d\n", cmd640_chip_version);
 		return 0;
 	}
 
@@ -836,8 +836,8 @@ static int __init cmd640x_init(void)
 
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 		if (drive->autotune || ((index > 1) && second_port_toggled)) {
-	 		/*
-	 		 * Reset timing to the slowest speed and turn off prefetch.
+			/*
+			 * Reset timing to the slowest speed and turn off prefetch.
 			 * This way, the drive identify code has a better chance.
 			 */
 			setup_counts    [index] = 4;	/* max possible */
-- 
1.5.4.2.316.gf7a7

