From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/15] ide: remove atapi_error_t
Date: Fri, 2 Nov 2007 21:04:16 +0100
Message-ID: <200711022104.16206.bzolnier@gmail.com>
References: <200710310025.55983.bzolnier@gmail.com> <472A1F30.805@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:61145 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846AbXKBWIP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 18:08:15 -0400
Received: by nf-out-0910.google.com with SMTP id g13so940287nfb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 15:08:14 -0700 (PDT)
In-Reply-To: <472A1F30.805@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Hi,

On Thursday 01 November 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Remove atapi_error_t.
> 
> > While at it:
> > * replace 'HWIF(drive)' by 'drive->hwif'
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/ide-floppy.c |    3 +--
> >  drivers/ide/ide-lib.c    |   21 ++++++++++-----------
> >  drivers/ide/ide-tape.c   |    3 +--
> >  include/linux/ide.h      |   30 ------------------------------
> >  4 files changed, 12 insertions(+), 45 deletions(-)
> 
> > Index: b/drivers/ide/ide-lib.c
> > ===================================================================
> > --- a/drivers/ide/ide-lib.c
> > +++ b/drivers/ide/ide-lib.c
> [...]
> > @@ -576,19 +575,19 @@ static u8 ide_dump_atapi_status(ide_driv
> >  	}
> >  	printk("}\n");
> >  	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
> > -		error.all = HWIF(drive)->INB(IDE_ERROR_REG);
> > -		printk("%s: %s: error=0x%02x { ", drive->name, msg, error.all);
> > -		if (error.b.ili)	printk("IllegalLengthIndication ");
> > -		if (error.b.eom)	printk("EndOfMedia ");
> > -		if (error.b.abrt)	printk("AbortedCommand ");
> > -		if (error.b.mcr)	printk("MediaChangeRequested ");
> > -		if (error.b.sense_key)	printk("LastFailedSense=0x%02x ",
> > -						error.b.sense_key);
> > +		err = drive->hwif->INB(IDE_ERROR_REG);
> > +		printk("%s: %s: error=0x%02x { ", drive->name, msg, err);
> > +		if (err & MARK_ERR)	printk("IllegalLengthIndication ");
> > +		if (err & TRK0_ERR)	printk("EndOfMedia ");
> > +		if (err & ABRT_ERR)	printk("AbortedCommand ");
> > +		if (err & MCR_ERR)	printk("MediaChangeRequested ");
> > +		if (err & 0xf0)		printk("LastFailedSense=0x%02x ",
> > +						(err & 0xf0) >> 4);
> 
>     I'd rather prefer that the ATAPI bit definitions be added to 
> <linux/hdreg.h> -- the ATAPI sector count register fields definitions are 
> already there...

Yeah, that should do it:

[PATCH] ide: remove atapi_error_t (take 2)

Remove atapi_error_t.

While at it:
* replace 'HWIF(drive)' by 'drive->hwif'

v2:
* Add {ILI,EOM,LFS}_ERR defines to <linux/hdreg.h>.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |    3 +--
 drivers/ide/ide-lib.c    |   21 ++++++++++-----------
 drivers/ide/ide-tape.c   |    3 +--
 include/linux/hdreg.h    |    3 +++
 include/linux/ide.h      |   30 ------------------------------
 5 files changed, 15 insertions(+), 45 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -772,9 +772,8 @@ static void idefloppy_retry_pc (ide_driv
 {
 	idefloppy_pc_t *pc;
 	struct request *rq;
-	atapi_error_t error;
 
-	error.all = HWIF(drive)->INB(IDE_ERROR_REG);
+	(void)drive->hwif->INB(IDE_ERROR_REG);
 	pc = idefloppy_next_pc_storage(drive);
 	rq = idefloppy_next_rq_storage(drive);
 	idefloppy_create_request_sense_cmd(pc);
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -558,9 +558,8 @@ static u8 ide_dump_ata_status(ide_drive_
 static u8 ide_dump_atapi_status(ide_drive_t *drive, const char *msg, u8 stat)
 {
 	unsigned long flags;
-	atapi_error_t error;
+	u8 err = 0;
 
-	error.all = 0;
 	local_irq_save(flags);
 	printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
 	if (stat & BUSY_STAT)
@@ -576,19 +575,19 @@ static u8 ide_dump_atapi_status(ide_driv
 	}
 	printk("}\n");
 	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
-		error.all = HWIF(drive)->INB(IDE_ERROR_REG);
-		printk("%s: %s: error=0x%02x { ", drive->name, msg, error.all);
-		if (error.b.ili)	printk("IllegalLengthIndication ");
-		if (error.b.eom)	printk("EndOfMedia ");
-		if (error.b.abrt)	printk("AbortedCommand ");
-		if (error.b.mcr)	printk("MediaChangeRequested ");
-		if (error.b.sense_key)	printk("LastFailedSense=0x%02x ",
-						error.b.sense_key);
+		err = drive->hwif->INB(IDE_ERROR_REG);
+		printk("%s: %s: error=0x%02x { ", drive->name, msg, err);
+		if (err & ILI_ERR)	printk("IllegalLengthIndication ");
+		if (err & EOM_ERR)	printk("EndOfMedia ");
+		if (err & ABRT_ERR)	printk("AbortedCommand ");
+		if (err & MCR_ERR)	printk("MediaChangeRequested ");
+		if (err & LFS_ERR)	printk("LastFailedSense=0x%02x ",
+						(err & LFS_ERR) >> 4);
 		printk("}\n");
 	}
 	ide_dump_opcode(drive);
 	local_irq_restore(flags);
-	return error.all;
+	return err;
 }
 
 /**
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1808,9 +1808,8 @@ static ide_startstop_t idetape_retry_pc 
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t *pc;
 	struct request *rq;
-	atapi_error_t error;
 
-	error.all = HWIF(drive)->INB(IDE_ERROR_REG);
+	(void)drive->hwif->INB(IDE_ERROR_REG);
 	pc = idetape_next_pc_storage(drive);
 	rq = idetape_next_rq_storage(drive);
 	idetape_create_request_sense_cmd(pc);
Index: b/include/linux/hdreg.h
===================================================================
--- a/include/linux/hdreg.h
+++ b/include/linux/hdreg.h
@@ -44,7 +44,9 @@
 
 /* Bits for HD_ERROR */
 #define MARK_ERR		0x01	/* Bad address mark */
+#define ILI_ERR			0x01	/* Illegal Length Indication (ATAPI) */
 #define TRK0_ERR		0x02	/* couldn't find track 0 */
+#define EOM_ERR			0x02	/* End Of Media (ATAPI) */
 #define ABRT_ERR		0x04	/* Command aborted */
 #define MCR_ERR			0x08	/* media change request */
 #define ID_ERR			0x10	/* ID field not found */
@@ -52,6 +54,7 @@
 #define ECC_ERR			0x40	/* Uncorrectable ECC error */
 #define BBD_ERR			0x80	/* pre-EIDE meaning:  block marked bad */
 #define ICRC_ERR		0x80	/* new meaning:  CRC error during transfer */
+#define LFS_ERR			0xf0	/* Last Failed Sense (ATAPI) */
 
 /* Bits of HD_NSECTOR */
 #define CD			0x01
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -417,36 +417,6 @@ typedef union {
 } atapi_ireason_t;
 
 /*
- * The ATAPI error register.
- *
- * ili		: Illegal Length Indication
- * eom		: End Of Media Detected
- * abrt		: Aborted command - As defined by ATA
- * mcr		: Media Change Requested - As defined by ATA
- * sense_key	: Sense key of the last failed packet command
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned ili		:1;
-		unsigned eom		:1;
-		unsigned abrt		:1;
-		unsigned mcr		:1;
-		unsigned sense_key	:4;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned sense_key	:4;
-		unsigned mcr		:1;
-		unsigned abrt		:1;
-		unsigned eom		:1;
-		unsigned ili		:1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-	} b;
-} atapi_error_t;
-
-/*
  * Status returned from various ide_ functions
  */
 typedef enum {
