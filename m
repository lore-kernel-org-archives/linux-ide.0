From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 7/12] ide-disk: merge LBA28 and LBA48 Host Protected Area support code
Date: Thu, 25 Oct 2007 01:14:53 +0200
Message-ID: <200710250114.53414.bzolnier@gmail.com>
References: <200710082313.39894.bzolnier@gmail.com> <471758A7.90402@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:15191 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693AbXJXXci (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 19:32:38 -0400
Received: by nf-out-0910.google.com with SMTP id g13so325235nfb
        for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2007 16:32:37 -0700 (PDT)
In-Reply-To: <471758A7.90402@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 18 October 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Merge idedisk_{read_native,set}_max_address_ext() into
> >   idedisk_{read_native,set}_max_address().
> 
> > There should be no functionality changes caused by this patch.
> 
>     This is unfortunately not achieved...
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
>     No cookie this time. :-)

"Oh, cookie cookie cookie starts with C!" :)

> > Index: b/drivers/ide/ide-disk.c
> > ===================================================================
> > --- a/drivers/ide/ide-disk.c
> > +++ b/drivers/ide/ide-disk.c
> [...]
> > @@ -350,31 +353,12 @@ static unsigned long idedisk_read_native
> >  
> >  	/* if OK, compute maximum address value */
> >  	if ((tf->command & 0x01) == 0) {
> > -		addr = ((tf->device & 0xf) << 24) |
> > -		       (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
> > -		addr++;	/* since the return value is (maxlba - 1), we add 1 */
> 
>     Actually, the return value is just maxlba (which is *not* the same as 
> capacity).

Indeed, moreover idedisk_{read_native,set}_max_address() comments look
also incorrect, ditto for the function names.

Probably if we handle 'addr++'/'addr_req--'/'addr_set++' in
idedisk_check_hpa() all issues will fix themselves.

Care to look into it? 

[...]

> > +		if (lba48)
> > +			high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) |
> > +				tf->hob_lbal;
> > +		else
> > +			high = tf->device & 0xf;
> >  		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
> 
>     Wait, you've just properly calculated 'high'!  And now LBA28 variant is 
> borken. :-|

I can swear that it was OK but I remember that I few times needed fix the
rejects in this patch because other patches in the series were changed or
reordered...

just another brown paper bag bug...

> > -		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
> > +		if (lba48)
> > +			high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) |
> > +				tf->hob_lbal;
> > +		else
> > +			high = tf->device & 0xf;
> >  		low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
> >  		addr_set = ((__u64)high << 24) | low;
> >  		addr_set++;
> 
>     BTW, haven't you noticed that LBA readback code is duplicate? It just asks 
> to be put into a separate function, like:
> 
> static u64 ide_read_lba(struct ide_taskfile *tf)
> {
> 	if (!(tf->command & 0x01)) {
> 		u32 high, low;
> 
> 		if (lba48)
> 			high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) |
> 				tf->hob_lbal;
> 		else
> 			high = tf->device & 0xf;
> 		low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
> 		return (((__u64)high << 24) | low) + 1;
> 	} else
> 		return 0;
> }

"back in the days" I even had a patch doing something similar but since
it is still lost somewhere in the TODO folder + requires update for the
recent changes (which makes it useless a starting point) it would be
great if you could cook a patch adding the above helper.


Thanks for review (especially for catching problem with 'high' variable),
revised patch:

[PATCH] ide-disk: merge LBA28 and LBA48 Host Protected Area support code (take 2)

* Merge idedisk_{read_native,set}_max_address_ext() into
  idedisk_{read_native,set}_max_address().

v2:
* Remove LBA48 code leftover from idedisk_read_native_max_address()
  ('high' variable initialization).  (Noticed by Sergei).

There should be no functionality changes caused by this patch.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |  103 +++++++++++++++----------------------------------
 1 file changed, 32 insertions(+), 71 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -333,16 +333,19 @@ static ide_startstop_t ide_do_rw_disk (i
  * Queries for true maximum capacity of the drive.
  * Returns maximum LBA address (> 0) of the drive, 0 if failed.
  */
-static unsigned long idedisk_read_native_max_address(ide_drive_t *drive)
+static u64 idedisk_read_native_max_address(ide_drive_t *drive, int lba48)
 {
 	ide_task_t args;
 	struct ide_taskfile *tf = &args.tf;
-	unsigned long addr = 0;
+	u64 addr = 0;
 
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
+	if (lba48)
+		tf->command = WIN_READ_NATIVE_MAX_EXT;
+	else
+		tf->command = WIN_READ_NATIVE_MAX;
 	tf->device  = ATA_LBA;
-	tf->command = WIN_READ_NATIVE_MAX;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	/* submit command request */
@@ -350,33 +353,13 @@ static unsigned long idedisk_read_native
 
 	/* if OK, compute maximum address value */
 	if ((tf->status & 0x01) == 0) {
-		addr = ((tf->device & 0xf) << 24) |
-		       (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
-		addr++;	/* since the return value is (maxlba - 1), we add 1 */
-	}
-	return addr;
-}
-
-static unsigned long long idedisk_read_native_max_address_ext(ide_drive_t *drive)
-{
-	ide_task_t args;
-	struct ide_taskfile *tf = &args.tf;
-	unsigned long long addr = 0;
-
-	/* Create IDE/ATA command request structure */
-	memset(&args, 0, sizeof(ide_task_t));
-	tf->device  = ATA_LBA;
-	tf->command = WIN_READ_NATIVE_MAX_EXT;
-	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
-	args.handler				= &task_no_data_intr;
-        /* submit command request */
-        ide_raw_taskfile(drive, &args, NULL);
-
-	/* if OK, compute maximum address value */
-	if ((tf->status & 0x01) == 0) {
 		u32 high, low;
 
-		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
+		if (lba48)
+			high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) |
+				tf->hob_lbal;
+		else
+			high = tf->device & 0xf;
 		low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
 		addr = ((__u64)high << 24) | low;
 		addr++;	/* since the return value is (maxlba - 1), we add 1 */
@@ -388,38 +371,11 @@ static unsigned long long idedisk_read_n
  * Sets maximum virtual LBA address of the drive.
  * Returns new maximum virtual LBA address (> 0) or 0 on failure.
  */
-static unsigned long idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)
+static u64 idedisk_set_max_address(ide_drive_t *drive, u64 addr_req, int lba48)
 {
 	ide_task_t args;
 	struct ide_taskfile *tf = &args.tf;
-	unsigned long addr_set = 0;
-	
-	addr_req--;
-	/* Create IDE/ATA command request structure */
-	memset(&args, 0, sizeof(ide_task_t));
-	tf->lbal    =  (addr_req >>  0) & 0xff;
-	tf->lbam    =  (addr_req >>  8) & 0xff;
-	tf->lbah    =  (addr_req >> 16) & 0xff;
-	tf->device  = ((addr_req >> 24) & 0x0f) | ATA_LBA;
-	tf->command = WIN_SET_MAX;
-	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
-	args.handler				= &task_no_data_intr;
-	/* submit command request */
-	ide_raw_taskfile(drive, &args, NULL);
-	/* if OK, read new maximum address value */
-	if ((tf->status & 0x01) == 0) {
-		addr_set = ((tf->device & 0xf) << 24) |
-			   (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
-		addr_set++;
-	}
-	return addr_set;
-}
-
-static unsigned long long idedisk_set_max_address_ext(ide_drive_t *drive, unsigned long long addr_req)
-{
-	ide_task_t args;
-	struct ide_taskfile *tf = &args.tf;
-	unsigned long long addr_set = 0;
+	u64 addr_set = 0;
 
 	addr_req--;
 	/* Create IDE/ATA command request structure */
@@ -427,11 +383,16 @@ static unsigned long long idedisk_set_ma
 	tf->lbal     = (addr_req >>  0) & 0xff;
 	tf->lbam     = (addr_req >>= 8) & 0xff;
 	tf->lbah     = (addr_req >>= 8) & 0xff;
-	tf->device   = ATA_LBA;
-	tf->command  = WIN_SET_MAX_EXT;
-	tf->hob_lbal = (addr_req >>= 8) & 0xff;
-	tf->hob_lbam = (addr_req >>= 8) & 0xff;
-	tf->hob_lbah = (addr_req >>= 8) & 0xff;
+	if (lba48) {
+		tf->hob_lbal = (addr_req >>= 8) & 0xff;
+		tf->hob_lbam = (addr_req >>= 8) & 0xff;
+		tf->hob_lbah = (addr_req >>= 8) & 0xff;
+		tf->command  = WIN_SET_MAX_EXT;
+	} else {
+		tf->device   = (addr_req >>= 8) & 0x0f;
+		tf->command  = WIN_SET_MAX;
+	}
+	tf->device |= ATA_LBA;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	/* submit command request */
@@ -440,7 +401,11 @@ static unsigned long long idedisk_set_ma
 	if ((tf->status & 0x01) == 0) {
 		u32 high, low;
 
-		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
+		if (lba48)
+			high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) |
+				tf->hob_lbal;
+		else
+			high = tf->device & 0xf;
 		low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
 		addr_set = ((__u64)high << 24) | low;
 		addr_set++;
@@ -490,10 +455,8 @@ static void idedisk_check_hpa(ide_drive_
 	int lba48 = idedisk_supports_lba48(drive->id);
 
 	capacity = drive->capacity64;
-	if (lba48)
-		set_max = idedisk_read_native_max_address_ext(drive);
-	else
-		set_max = idedisk_read_native_max_address(drive);
+
+	set_max = idedisk_read_native_max_address(drive, lba48);
 
 	if (ide_in_drive_list(drive->id, hpa_list)) {
 		/*
@@ -514,10 +477,8 @@ static void idedisk_check_hpa(ide_drive_
 			 capacity, sectors_to_MB(capacity),
 			 set_max, sectors_to_MB(set_max));
 
-	if (lba48)
-		set_max = idedisk_set_max_address_ext(drive, set_max);
-	else
-		set_max = idedisk_set_max_address(drive, set_max);
+	set_max = idedisk_set_max_address(drive, set_max, lba48);
+
 	if (set_max) {
 		drive->capacity64 = set_max;
 		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
