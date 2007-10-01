From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/15] cmd640: fix deadlock on error handling
Date: Mon, 1 Oct 2007 23:35:14 +0200
Message-ID: <200710012335.14886.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:61479 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757176AbXJAVjm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:42 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1977012ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:41 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Stop abusing ide_lock lock (switch to a private locking).

Fixes same issue as fixed by Alan Cox in atiixp host driver with
commit 6c5f8cc33eb2e10b6ab788bbe259fc142a068627.

cmd640 is a bit special cause we still need to leave ide_lock for
->set_pio_mode with 'pio' argument == 8/9 (prefetch disable/enable).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cmd640.c |   48 +++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

Index: b/drivers/ide/pci/cmd640.c
===================================================================
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -185,6 +185,8 @@ static u8 recovery_counts[4] = {16, 16, 
 
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
 
+static DEFINE_SPINLOCK(cmd640_lock);
+
 /*
  * These are initialized to point at the devices we control
  */
@@ -258,12 +260,12 @@ static u8 get_cmd640_reg_vlb (u16 reg)
 
 static u8 get_cmd640_reg(u16 reg)
 {
-	u8 b;
 	unsigned long flags;
+	u8 b;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&cmd640_lock, flags);
 	b = __get_cmd640_reg(reg);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 	return b;
 }
 
@@ -271,9 +273,9 @@ static void put_cmd640_reg(u16 reg, u8 v
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&cmd640_lock, flags);
 	__put_cmd640_reg(reg,val);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 }
 
 static int __init match_pci_cmd640_device (void)
@@ -351,7 +353,7 @@ static int __init secondary_port_respond
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&cmd640_lock, flags);
 
 	outb_p(0x0a, 0x170 + IDE_SELECT_OFFSET);	/* select drive0 */
 	udelay(100);
@@ -359,11 +361,11 @@ static int __init secondary_port_respond
 		outb_p(0x1a, 0x170 + IDE_SELECT_OFFSET); /* select drive1 */
 		udelay(100);
 		if ((inb_p(0x170 + IDE_SELECT_OFFSET) & 0x1f) != 0x1a) {
-			spin_unlock_irqrestore(&ide_lock, flags);
+			spin_unlock_irqrestore(&cmd640_lock, flags);
 			return 0; /* nothing responded */
 		}
 	}
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 	return 1; /* success */
 }
 
@@ -440,11 +442,11 @@ static void __init setup_device_ptrs (vo
 static void set_prefetch_mode (unsigned int index, int mode)
 {
 	ide_drive_t *drive = cmd_drives[index];
+	unsigned long flags;
 	int reg = prefetch_regs[index];
 	u8 b;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&cmd640_lock, flags);
 	b = __get_cmd640_reg(reg);
 	if (mode) {	/* want prefetch on? */
 #if CMD640_PREFETCH_MASKS
@@ -460,7 +462,7 @@ static void set_prefetch_mode (unsigned 
 		b |= prefetch_masks[index];	/* disable prefetch */
 	}
 	__put_cmd640_reg(reg, b);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 }
 
 /*
@@ -561,7 +563,7 @@ static void program_drive_counts (unsign
 	/*
 	 * Now that everything is ready, program the new timings
 	 */
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&cmd640_lock, flags);
 	/*
 	 * Program the address_setup clocks into ARTTIM reg,
 	 * and then the active/recovery counts into the DRWTIM reg
@@ -570,7 +572,7 @@ static void program_drive_counts (unsign
 	setup_count |= __get_cmd640_reg(arttim_regs[index]) & 0x3f;
 	__put_cmd640_reg(arttim_regs[index], setup_count);
 	__put_cmd640_reg(drwtim_regs[index], pack_nibbles(active_count, recovery_count));
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 }
 
 /*
@@ -630,6 +632,7 @@ static void cmd640_set_mode (unsigned in
 
 static void cmd640_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
+	unsigned long flags;
 	unsigned int index = 0, cycle_time;
 	u8 b;
 
@@ -652,7 +655,12 @@ static void cmd640_set_pio_mode(ide_driv
 
 		case 8: /* set prefetch off */
 		case 9: /* set prefetch on */
+			/*
+			 * take ide_lock for drive->[no_]unmask/[no_]io_32bit
+			 */
+			spin_lock_irqsave(&ide_lock, flags);
 			set_prefetch_mode(index, pio & 1);
+			spin_unlock_irqrestore(&ide_lock, flags);
 			printk("%s: %sabled cmd640 prefetch\n", drive->name, (pio & 1) ? "en" : "dis");
 			return;
 	}
@@ -670,20 +678,20 @@ static void cmd640_set_pio_mode(ide_driv
 
 static int pci_conf1(void)
 {
-	u32 tmp;
 	unsigned long flags;
+	u32 tmp;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&cmd640_lock, flags);
 	outb(0x01, 0xCFB);
 	tmp = inl(0xCF8);
 	outl(0x80000000, 0xCF8);
 	if (inl(0xCF8) == 0x80000000) {
 		outl(tmp, 0xCF8);
-		spin_unlock_irqrestore(&ide_lock, flags);
+		spin_unlock_irqrestore(&cmd640_lock, flags);
 		return 1;
 	}
 	outl(tmp, 0xCF8);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 	return 0;
 }
 
@@ -691,15 +699,15 @@ static int pci_conf2(void)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&cmd640_lock, flags);
 	outb(0x00, 0xCFB);
 	outb(0x00, 0xCF8);
 	outb(0x00, 0xCFA);
 	if (inb(0xCF8) == 0x00 && inb(0xCF8) == 0x00) {
-		spin_unlock_irqrestore(&ide_lock, flags);
+		spin_unlock_irqrestore(&cmd640_lock, flags);
 		return 1;
 	}
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&cmd640_lock, flags);
 	return 0;
 }
 
