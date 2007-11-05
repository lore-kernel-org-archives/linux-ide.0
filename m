From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 7/15] ide: remove atapi_ireason_t
Date: Mon, 5 Nov 2007 21:24:57 +0100
Message-ID: <200711052124.57782.bzolnier@gmail.com>
References: <200710310028.27935.bzolnier@gmail.com> <200711022121.24688.bzolnier@gmail.com> <472DDDD6.8030806@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:27306 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXKEUUU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Nov 2007 15:20:20 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1709476fkz
        for <linux-ide@vger.kernel.org>; Mon, 05 Nov 2007 12:20:17 -0800 (PST)
In-Reply-To: <472DDDD6.8030806@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Sunday 04 November 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > [PATCH] ide: remove atapi_ireason_t (take 2)
> 
> > Remove atapi_ireason_t.
> 
> > While at it:
> > * replace 'HWIF(drive)' by 'drive->hwif' (or just 'hwif' where possible)
> 
> > v2:
> > * v1 had CD and IO bits reversed in many places.
> 
> > * Use CD and IO defines from <linux/hdreg.h>.
> 
>     You're reading my mind. :-)
> 
> > Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> > Index: b/drivers/ide/ide-floppy.c
> > ===================================================================
> > --- a/drivers/ide/ide-floppy.c
> > +++ b/drivers/ide/ide-floppy.c
> > @@ -788,12 +788,11 @@ static ide_startstop_t idefloppy_pc_intr
> >  {
> >  	idefloppy_floppy_t *floppy = drive->driver_data;
> >  	ide_hwif_t *hwif = drive->hwif;
> > -	atapi_ireason_t ireason;
> >  	idefloppy_pc_t *pc = floppy->pc;
> >  	struct request *rq = pc->rq;
> >  	unsigned int temp;
> >  	u16 bcount;
> > -	u8 stat;
> > +	u8 stat, ireason;
> >  
> >  	debug_log(KERN_INFO "ide-floppy: Reached %s interrupt handler\n",
> >  		__FUNCTION__);
> > @@ -852,18 +851,18 @@ static ide_startstop_t idefloppy_pc_intr
> >  	bcount = (hwif->INB(IDE_BCOUNTH_REG) << 8) |
> >  		  hwif->INB(IDE_BCOUNTL_REG);
> >  	/* on this interrupt */
> > -	ireason.all = HWIF(drive)->INB(IDE_IREASON_REG);
> > +	ireason = hwif->INB(IDE_IREASON_REG);
> >  
> > -	if (ireason.b.cod) {
> > +	if (ireason & CD) {
> >  		printk(KERN_ERR "ide-floppy: CoD != 0 in idefloppy_pc_intr\n");
> >  		return ide_do_reset(drive);
> >  	}
> > -	if (ireason.b.io == test_bit(PC_WRITING, &pc->flags)) {
> > +	if ((ireason & IO) == test_bit(PC_WRITING, &pc->flags)) {
> 
>     This won't work as IO is 0x02 and test_bit() returns 0 or 1.

Thanks!

[ Heh, after "take 2" I had a feeling that something still may be not right
  so I deferred committing of this patch series to the official tree... :) ]

[PATCH] ide: remove atapi_ireason_t (take 3)

Remove atapi_ireason_t.

While at it:
* replace 'HWIF(drive)' by 'drive->hwif' (or just 'hwif' where possible)

v2:
* v1 had CD and IO bits reversed in many places.

* Use CD and IO defines from <linux/hdreg.h>.

v3:
* Fix incorrect "(ireason & IO) == test_bit()". (Noticed by Sergei)

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |   25 ++++++++++++-------------
 drivers/ide/ide-tape.c   |   27 +++++++++++++--------------
 drivers/scsi/ide-scsi.c  |   17 ++++++++---------
 include/linux/ide.h      |   24 ------------------------
 4 files changed, 33 insertions(+), 60 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -788,12 +788,11 @@ static ide_startstop_t idefloppy_pc_intr
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	ide_hwif_t *hwif = drive->hwif;
-	atapi_ireason_t ireason;
 	idefloppy_pc_t *pc = floppy->pc;
 	struct request *rq = pc->rq;
 	unsigned int temp;
 	u16 bcount;
-	u8 stat;
+	u8 stat, ireason;
 
 	debug_log(KERN_INFO "ide-floppy: Reached %s interrupt handler\n",
 		__FUNCTION__);
@@ -852,18 +851,18 @@ static ide_startstop_t idefloppy_pc_intr
 	bcount = (hwif->INB(IDE_BCOUNTH_REG) << 8) |
 		  hwif->INB(IDE_BCOUNTL_REG);
 	/* on this interrupt */
-	ireason.all = HWIF(drive)->INB(IDE_IREASON_REG);
+	ireason = hwif->INB(IDE_IREASON_REG);
 
-	if (ireason.b.cod) {
+	if (ireason & CD) {
 		printk(KERN_ERR "ide-floppy: CoD != 0 in idefloppy_pc_intr\n");
 		return ide_do_reset(drive);
 	}
-	if (ireason.b.io == test_bit(PC_WRITING, &pc->flags)) {
+	if (((ireason & IO) == IO) == test_bit(PC_WRITING, &pc->flags)) {
 		/* Hopefully, we will never get here */
 		printk(KERN_ERR "ide-floppy: We wanted to %s, ",
-			ireason.b.io ? "Write":"Read");
+				(ireason & IO) ? "Write" : "Read");
 		printk(KERN_ERR "but the floppy wants us to %s !\n",
-			ireason.b.io ? "Read":"Write");
+				(ireason & IO) ? "Read" : "Write");
 		return ide_do_reset(drive);
 	}
 	if (!test_bit(PC_WRITING, &pc->flags)) {
@@ -920,15 +919,15 @@ static ide_startstop_t idefloppy_transfe
 {
 	ide_startstop_t startstop;
 	idefloppy_floppy_t *floppy = drive->driver_data;
-	atapi_ireason_t ireason;
+	u8 ireason;
 
 	if (ide_wait_stat(&startstop, drive, DRQ_STAT, BUSY_STAT, WAIT_READY)) {
 		printk(KERN_ERR "ide-floppy: Strange, packet command "
 				"initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
-	ireason.all = HWIF(drive)->INB(IDE_IREASON_REG);
-	if (!ireason.b.cod || ireason.b.io) {
+	ireason = drive->hwif->INB(IDE_IREASON_REG);
+	if ((ireason & CD) == 0 || (ireason & IO)) {
 		printk(KERN_ERR "ide-floppy: (IO,CoD) != (0,1) while "
 				"issuing a packet command\n");
 		return ide_do_reset(drive);
@@ -968,15 +967,15 @@ static ide_startstop_t idefloppy_transfe
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	ide_startstop_t startstop;
-	atapi_ireason_t ireason;
+	u8 ireason;
 
 	if (ide_wait_stat(&startstop, drive, DRQ_STAT, BUSY_STAT, WAIT_READY)) {
 		printk(KERN_ERR "ide-floppy: Strange, packet command "
 				"initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
-	ireason.all = HWIF(drive)->INB(IDE_IREASON_REG);
-	if (!ireason.b.cod || ireason.b.io) {
+	ireason = drive->hwif->INB(IDE_IREASON_REG);
+	if ((ireason & CD) == 0 || (ireason & IO)) {
 		printk(KERN_ERR "ide-floppy: (IO,CoD) != (0,1) "
 				"while issuing a packet command\n");
 		return ide_do_reset(drive);
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1847,14 +1847,13 @@ static ide_startstop_t idetape_pc_intr (
 {
 	ide_hwif_t *hwif = drive->hwif;
 	idetape_tape_t *tape = drive->driver_data;
-	atapi_ireason_t ireason;
 	idetape_pc_t *pc = tape->pc;
 	unsigned int temp;
 #if SIMULATE_ERRORS
 	static int error_sim_count = 0;
 #endif
 	u16 bcount;
-	u8 stat;
+	u8 stat, ireason;
 
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 4)
@@ -1965,18 +1964,18 @@ static ide_startstop_t idetape_pc_intr (
 	bcount = (hwif->INB(IDE_BCOUNTH_REG) << 8) |
 		  hwif->INB(IDE_BCOUNTL_REG);
 
-	ireason.all = hwif->INB(IDE_IREASON_REG);
+	ireason = hwif->INB(IDE_IREASON_REG);
 
-	if (ireason.b.cod) {
+	if (ireason & CD) {
 		printk(KERN_ERR "ide-tape: CoD != 0 in idetape_pc_intr\n");
 		return ide_do_reset(drive);
 	}
-	if (ireason.b.io == test_bit(PC_WRITING, &pc->flags)) {
+	if (((ireason & IO) == IO) == test_bit(PC_WRITING, &pc->flags)) {
 		/* Hopefully, we will never get here */
 		printk(KERN_ERR "ide-tape: We wanted to %s, ",
-			ireason.b.io ? "Write":"Read");
+				(ireason & IO) ? "Write" : "Read");
 		printk(KERN_ERR "ide-tape: but the tape wants us to %s !\n",
-			ireason.b.io ? "Read":"Write");
+				(ireason & IO) ? "Read" : "Write");
 		return ide_do_reset(drive);
 	}
 	if (!test_bit(PC_WRITING, &pc->flags)) {
@@ -2070,28 +2069,28 @@ static ide_startstop_t idetape_transfer_
 	ide_hwif_t *hwif = drive->hwif;
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t *pc = tape->pc;
-	atapi_ireason_t ireason;
 	int retries = 100;
 	ide_startstop_t startstop;
+	u8 ireason;
 
 	if (ide_wait_stat(&startstop,drive,DRQ_STAT,BUSY_STAT,WAIT_READY)) {
 		printk(KERN_ERR "ide-tape: Strange, packet command initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
-	ireason.all = hwif->INB(IDE_IREASON_REG);
-	while (retries-- && (!ireason.b.cod || ireason.b.io)) {
+	ireason = hwif->INB(IDE_IREASON_REG);
+	while (retries-- && ((ireason & CD) == 0 || (ireason & IO))) {
 		printk(KERN_ERR "ide-tape: (IO,CoD != (0,1) while issuing "
 				"a packet command, retrying\n");
 		udelay(100);
-		ireason.all = hwif->INB(IDE_IREASON_REG);
+		ireason = hwif->INB(IDE_IREASON_REG);
 		if (retries == 0) {
 			printk(KERN_ERR "ide-tape: (IO,CoD != (0,1) while "
 					"issuing a packet command, ignoring\n");
-			ireason.b.cod = 1;
-			ireason.b.io = 0;
+			ireason |= CD;
+			ireason &= ~IO;
 		}
 	}
-	if (!ireason.b.cod || ireason.b.io) {
+	if ((ireason & CD) == 0 || (ireason & IO)) {
 		printk(KERN_ERR "ide-tape: (IO,CoD) != (0,1) while issuing "
 				"a packet command\n");
 		return ide_do_reset(drive);
Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -403,10 +403,9 @@ static ide_startstop_t idescsi_pc_intr (
 	ide_hwif_t *hwif = drive->hwif;
 	idescsi_pc_t *pc = scsi->pc;
 	struct request *rq = pc->rq;
-	atapi_ireason_t ireason;
 	unsigned int temp;
 	u16 bcount;
-	u8 stat;
+	u8 stat, ireason;
 
 #if IDESCSI_DEBUG_LOG
 	printk (KERN_INFO "ide-scsi: Reached idescsi_pc_intr interrupt handler\n");
@@ -444,13 +443,13 @@ static ide_startstop_t idescsi_pc_intr (
 	}
 	bcount = (hwif->INB(IDE_BCOUNTH_REG) << 8) |
 		  hwif->INB(IDE_BCOUNTL_REG);
-	ireason.all	= HWIF(drive)->INB(IDE_IREASON_REG);
+	ireason = hwif->INB(IDE_IREASON_REG);
 
-	if (ireason.b.cod) {
+	if (ireason & CD) {
 		printk(KERN_ERR "ide-scsi: CoD != 0 in idescsi_pc_intr\n");
 		return ide_do_reset (drive);
 	}
-	if (ireason.b.io) {
+	if (ireason & IO) {
 		temp = pc->actually_transferred + bcount;
 		if (temp > pc->request_transfer) {
 			if (temp > pc->buffer_size) {
@@ -479,7 +478,7 @@ static ide_startstop_t idescsi_pc_intr (
 #endif /* IDESCSI_DEBUG_LOG */
 		}
 	}
-	if (ireason.b.io) {
+	if (ireason & IO) {
 		clear_bit(PC_WRITING, &pc->flags);
 		if (pc->sg)
 			idescsi_input_buffers(drive, pc, bcount);
@@ -508,16 +507,16 @@ static ide_startstop_t idescsi_transfer_
 	ide_hwif_t *hwif = drive->hwif;
 	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
 	idescsi_pc_t *pc = scsi->pc;
-	atapi_ireason_t ireason;
 	ide_startstop_t startstop;
+	u8 ireason;
 
 	if (ide_wait_stat(&startstop,drive,DRQ_STAT,BUSY_STAT,WAIT_READY)) {
 		printk(KERN_ERR "ide-scsi: Strange, packet command "
 			"initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
-	ireason.all	= HWIF(drive)->INB(IDE_IREASON_REG);
-	if (!ireason.b.cod || ireason.b.io) {
+	ireason = hwif->INB(IDE_IREASON_REG);
+	if ((ireason & CD) == 0 || (ireason & IO)) {
 		printk(KERN_ERR "ide-scsi: (IO,CoD) != (0,1) while "
 				"issuing a packet command\n");
 		return ide_do_reset (drive);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -346,30 +346,6 @@ typedef union {
 } select_t, ata_select_t;
 
 /*
- * ATAPI Interrupt Reason Register.
- *
- * cod		: Information transferred is command (1) or data (0)
- * io		: The device requests us to read (1) or write (0)
- * reserved	: Reserved
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned cod		:1;
-		unsigned io		:1;
-		unsigned reserved	:6;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned reserved	:6;
-		unsigned io		:1;
-		unsigned cod		:1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-	} b;
-} atapi_ireason_t;
-
-/*
  * Status returned from various ide_ functions
  */
 typedef enum {
