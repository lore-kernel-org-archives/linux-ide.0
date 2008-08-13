From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: ide: Remove ide_spin_wait_hwgroup() and use special requests instead
Date: Wed, 13 Aug 2008 17:24:23 +0200
Message-ID: <87tzdp0wgo.fsf@denkblock.local>
References: <87iqu73128.fsf@denkblock.local>
	<200808130041.07424.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:51717 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662AbYHMP0J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 11:26:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> Hi,
>
> On Monday 11 August 2008, Elias Oltmanns wrote:
[...]
>> On a different matter, I've encountered several places where requests
>> are being allocated with __GFP_WAIT for no obvious reason. Wouldn't it
>> be more suitable to allocate them with GFP_KERNEL and fail with -ENOMEM
>> in case of an error? Or is there some policy I'm not aware of?
>
> Without more details it is hard to tell, maybe it has something to do
> with GFP_KERNEL also using __GFP_IO?

I'll follow up with a patch to discuss the matter further.

[...]
>> diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
>> index ec6664b..5451e50 100644
>> --- a/drivers/ide/ide-io.c
>> +++ b/drivers/ide/ide-io.c
>> @@ -716,9 +716,63 @@ static ide_startstop_t execute_drive_cmd (ide_drive_t *drive,
>>   	return ide_stopped;
>>  }
>>  
>> +typedef struct {
>> +	u8 opcode;	/* always == REQ_DEVSET_EXEC */
>> +	int arg;
>> +} ide_devset_cdb_t;
>
> Generally we don't want new typedefs in kernel
> and here we shouldn't even need new struct.

As far as typedefs are concerned, fair enough. With regard to the
struct, see below.

>
>> +#define DEVSET_CDB_LEN (sizeof(ide_devset_cdb_t))
>> +
>> +int ide_devset_execute(ide_drive_t *drive, const struct ide_devset *setting,
>> +		       int arg)
>> +{
>> +	struct request_queue *q = drive->queue;
>> +	struct request *rq;
>> +	ide_devset_cdb_t *ds;
>> +	int ret = 0;
>> +
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EACCES;
>> +	if (!(setting->flags & DS_SYNC))
>> +		return setting->set(drive, arg);
>> +
>> +	rq = blk_get_request(q, READ, GFP_KERNEL);
>> +	if (!rq)
>> +		return -ENOMEM;
>> +
>> +	rq->cmd_type = REQ_TYPE_SPECIAL;
>> +	BUILD_BUG_ON(DEVSET_CDB_LEN > BLK_MAX_CDB);
>
> BLK_MAX_CDB would never be < 16 so this seems overcautious
>
>> +	rq->cmd_len = DEVSET_CDB_LEN;
>> +	ds = (ide_devset_cdb_t *)rq->cmd;
>> +	ds->opcode = REQ_DEVSET_EXEC;
>> +	ds->arg = arg;
>
> How's about just doing:
>
> 	rq->cmd[0] = REQ_DEVSET_EXEC;
> 	(int *)rq->cmd[1] = arg;

  CC [M]  drivers/ide/ide-io.o
drivers/ide/ide-io.c: In function 'ide_devset_execute':
drivers/ide/ide-io.c:748: warning: cast to pointer from integer of different size
drivers/ide/ide-io.c:748: error: lvalue required as left operand of assignment

Personally, I'd feel more comfortable with casting rq->cmd to a
dedicated struct, especially since I'm not exactly a wizard when it
comes to casting. Naturally, if you prefer something else (and I get it
to work), I'll happily accept that too.

>
> [...]
>
>> @@ -22,9 +22,9 @@ int ide_setting_ioctl(ide_drive_t *drive, struct block_device *bdev,
>>  	int err = -EOPNOTSUPP;
>>  
>>  	for (; s->get_ioctl; s++) {
>> -		if (s->get && s->get_ioctl == cmd)
>> +		if (s->get_ioctl == cmd)
>>  			goto read_val;
>
> What if 'cmd' == -1?
>
> [ That was the reason for s->get / s->set checks. ]

The obvious question, don't know why I didn't realise.

>
>> @@ -42,13 +42,9 @@ set_val:
>>  	if (bdev != bdev->bd_contains)
>>  		err = -EINVAL;
>>  	else {
>> -		if (!capable(CAP_SYS_ADMIN))
>> -			err = -EACCES;
>
> I would prefer that CAP_SYS_ADMIN check here and in ide_write_setting()
> to stay in their places and be done before checking other things (so error
> codes returned to user-space remain unchanged).

Right you are.

>
> There is also a few CodingStyle errors/warnings catched by
>checkpatch.pl
> (some look bogus but others seem legitimate).

Now this really is rather embarrassing. Apparently, I still have to get
used to run checkpatch.pl regularly.

Thanks for reviewing. Find the revised patch below (applies to
next-20080813).

Elias


From: Elias Oltmanns <eo@nebensachen.de>
Subject: ide: Remove ide_spin_wait_hwgroup() and use special requests instead

Use a special request for serialisation purposes and get rid of the
awkward ide_spin_wait_hwgroup(). This also involves converting the
ide_devset structure so it can be shared by the /proc and the ioctl code.

Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
---

 drivers/ide/ide-cd.c     |    8 +--
 drivers/ide/ide-disk.c   |   66 +++++++++++-----------
 drivers/ide/ide-floppy.c |   20 +++----
 drivers/ide/ide-io.c     |   50 +++++++++++++++++
 drivers/ide/ide-ioctls.c |   21 ++++---
 drivers/ide/ide-proc.c   |  102 ++++++++++++++++------------------
 drivers/ide/ide-tape.c   |   48 ++++++++--------
 drivers/ide/ide.c        |   81 +++++----------------------
 drivers/scsi/ide-scsi.c  |   34 ++++++-----
 include/linux/ide.h      |  138 ++++++++++++++++++++++++----------------------
 10 files changed, 284 insertions(+), 284 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index b0e248e..5c23ec9 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1807,11 +1807,11 @@ static ide_proc_entry_t idecd_proc[] = {
 	{ NULL, 0, NULL, NULL }
 };
 
-ide_devset_rw(dsc_overlap, 0, 1, dsc_overlap);
+ide_devset_rw_field(dsc_overlap, dsc_overlap);
 
-static const struct ide_devset *idecd_settings[] = {
-	&ide_devset_dsc_overlap,
-	NULL
+static const struct ide_proc_devset idecd_settings[] = {
+	IDE_PROC_DEVSET(dsc_overlap, 0, 1),
+	{ 0 },
 };
 #endif
 
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index f325237..bb3e343 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -583,11 +583,8 @@ static int set_nowerr(ide_drive_t *drive, int arg)
 	if (arg < 0 || arg > 1)
 		return -EINVAL;
 
-	if (ide_spin_wait_hwgroup(drive))
-		return -EBUSY;
 	drive->nowerr = arg;
 	drive->bad_wstat = arg ? BAD_R_STAT : BAD_W_STAT;
-	spin_unlock_irq(&ide_lock);
 	return 0;
 }
 
@@ -710,33 +707,34 @@ static int set_addressing(ide_drive_t *drive, int arg)
 	return 0;
 }
 
+ide_devset_rw(acoustic, acoustic);
+ide_devset_rw(address, addressing);
+ide_devset_rw(multcount, multcount);
+ide_devset_rw(wcache, wcache);
+
+ide_devset_rw_sync(nowerr, nowerr);
+
 #ifdef CONFIG_IDE_PROC_FS
-ide_devset_rw_nolock(acoustic,	0, 254, acoustic);
-ide_devset_rw_nolock(address,	0,   2, addressing);
-ide_devset_rw_nolock(multcount,	0,  16, multcount);
-ide_devset_rw_nolock(nowerr,	0,   1, nowerr);
-ide_devset_rw_nolock(wcache,	0,   1, wcache);
-
-ide_devset_rw(bios_cyl,		0, 65535, bios_cyl);
-ide_devset_rw(bios_head,	0,   255, bios_head);
-ide_devset_rw(bios_sect,	0,    63, bios_sect);
-ide_devset_rw(failures,		0, 65535, failures);
-ide_devset_rw(lun,		0,     7, lun);
-ide_devset_rw(max_failures,	0, 65535, max_failures);
-
-static const struct ide_devset *idedisk_settings[] = {
-	&ide_devset_acoustic,
-	&ide_devset_address,
-	&ide_devset_bios_cyl,
-	&ide_devset_bios_head,
-	&ide_devset_bios_sect,
-	&ide_devset_failures,
-	&ide_devset_lun,
-	&ide_devset_max_failures,
-	&ide_devset_multcount,
-	&ide_devset_nowerr,
-	&ide_devset_wcache,
-	NULL
+ide_devset_rw_field(bios_cyl, bios_cyl);
+ide_devset_rw_field(bios_head, bios_head);
+ide_devset_rw_field(bios_sect, bios_sect);
+ide_devset_rw_field(failures, failures);
+ide_devset_rw_field(lun, lun);
+ide_devset_rw_field(max_failures, max_failures);
+
+static const struct ide_proc_devset idedisk_settings[] = {
+	IDE_PROC_DEVSET(acoustic,	0,   254),
+	IDE_PROC_DEVSET(address,	0,     2),
+	IDE_PROC_DEVSET(bios_cyl,	0, 65535),
+	IDE_PROC_DEVSET(bios_head,	0,   255),
+	IDE_PROC_DEVSET(bios_sect,	0,    63),
+	IDE_PROC_DEVSET(failures,	0, 65535),
+	IDE_PROC_DEVSET(lun,		0,     7),
+	IDE_PROC_DEVSET(max_failures,	0, 65535),
+	IDE_PROC_DEVSET(multcount,	0,    16),
+	IDE_PROC_DEVSET(nowerr,		0,     1),
+	IDE_PROC_DEVSET(wcache,		0,     1),
+	{ 0 },
 };
 #endif
 
@@ -1009,11 +1007,11 @@ static int idedisk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 static const struct ide_ioctl_devset ide_disk_ioctl_settings[] = {
-{ HDIO_GET_ADDRESS,	HDIO_SET_ADDRESS,   get_addressing, set_addressing },
-{ HDIO_GET_MULTCOUNT,	HDIO_SET_MULTCOUNT, get_multcount,  set_multcount  },
-{ HDIO_GET_NOWERR,	HDIO_SET_NOWERR,    get_nowerr,	    set_nowerr	   },
-{ HDIO_GET_WCACHE,	HDIO_SET_WCACHE,    get_wcache,	    set_wcache	   },
-{ HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,  get_acoustic,   set_acoustic   },
+{ HDIO_GET_ADDRESS,	HDIO_SET_ADDRESS,   &ide_devset_address   },
+{ HDIO_GET_MULTCOUNT,	HDIO_SET_MULTCOUNT, &ide_devset_multcount },
+{ HDIO_GET_NOWERR,	HDIO_SET_NOWERR,    &ide_devset_nowerr	  },
+{ HDIO_GET_WCACHE,	HDIO_SET_WCACHE,    &ide_devset_wcache	  },
+{ HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,  &ide_devset_acoustic  },
 { 0 }
 };
 
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index a63aba2..d36f155 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -629,9 +629,9 @@ static sector_t idefloppy_capacity(ide_drive_t *drive)
 }
 
 #ifdef CONFIG_IDE_PROC_FS
-ide_devset_rw(bios_cyl,  0, 1023, bios_cyl);
-ide_devset_rw(bios_head, 0,  255, bios_head);
-ide_devset_rw(bios_sect, 0,   63, bios_sect);
+ide_devset_rw_field(bios_cyl, bios_cyl);
+ide_devset_rw_field(bios_head, bios_head);
+ide_devset_rw_field(bios_sect, bios_sect);
 
 static int get_ticks(ide_drive_t *drive)
 {
@@ -646,14 +646,14 @@ static int set_ticks(ide_drive_t *drive, int arg)
 	return 0;
 }
 
-IDE_DEVSET(ticks, S_RW, 0, 255, get_ticks, set_ticks);
+IDE_DEVSET(ticks, DS_SYNC, get_ticks, set_ticks);
 
-static const struct ide_devset *idefloppy_settings[] = {
-	&ide_devset_bios_cyl,
-	&ide_devset_bios_head,
-	&ide_devset_bios_sect,
-	&ide_devset_ticks,
-	NULL
+static const struct ide_proc_devset idefloppy_settings[] = {
+	IDE_PROC_DEVSET(bios_cyl,  0, 1023),
+	IDE_PROC_DEVSET(bios_head, 0,  255),
+	IDE_PROC_DEVSET(bios_sect, 0,   63),
+	IDE_PROC_DEVSET(ticks,	   0,  255),
+	{ 0 },
 };
 #endif
 
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index ec6664b..67fdcc8 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -716,9 +716,59 @@ static ide_startstop_t execute_drive_cmd (ide_drive_t *drive,
  	return ide_stopped;
 }
 
+struct ide_devset_cdb {
+	u8 opcode;	/* always == REQ_DEVSET_EXEC */
+	int arg;
+};
+
+#define DEVSET_CDB_LEN sizeof(struct ide_devset_cdb)
+
+int ide_devset_execute(ide_drive_t *drive, const struct ide_devset *setting,
+		       int arg)
+{
+	struct request_queue *q = drive->queue;
+	struct request *rq;
+	struct ide_devset_cdb *ds;
+	int ret = 0;
+
+	if (!(setting->flags & DS_SYNC))
+		return setting->set(drive, arg);
+
+	rq = blk_get_request(q, READ, GFP_KERNEL);
+	if (!rq)
+		return -ENOMEM;
+
+	rq->cmd_type = REQ_TYPE_SPECIAL;
+	rq->cmd_len = DEVSET_CDB_LEN;
+	ds = (struct ide_devset_cdb *)rq->cmd;
+	ds->opcode = REQ_DEVSET_EXEC;
+	ds->arg = arg;
+	rq->special = setting->set;
+
+	if (blk_execute_rq(q, NULL, rq, 0))
+		ret = rq->errors;
+	blk_put_request(rq);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ide_devset_execute);
+
 static ide_startstop_t ide_special_rq(ide_drive_t *drive, struct request *rq)
 {
 	switch (rq->cmd[0]) {
+	case REQ_DEVSET_EXEC:
+	{
+		struct ide_devset_cdb *ds = (struct ide_devset_cdb *)rq->cmd;
+		int err, (*setfunc)(ide_drive_t *, int) = rq->special;
+
+		err = setfunc(drive, ds->arg);
+		if (err)
+			rq->errors = err;
+		else
+			err = 1;
+		ide_end_request(drive, err, 0);
+		return ide_stopped;
+	}
 	case REQ_DRIVE_RESET:
 		return ide_do_reset(drive);
 	default:
diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
index 7a0d62e..cf01564 100644
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -6,11 +6,11 @@
 #include <linux/ide.h>
 
 static const struct ide_ioctl_devset ide_ioctl_settings[] = {
-{ HDIO_GET_32BIT,	 HDIO_SET_32BIT,	get_io_32bit,  set_io_32bit  },
-{ HDIO_GET_KEEPSETTINGS, HDIO_SET_KEEPSETTINGS,	get_ksettings, set_ksettings },
-{ HDIO_GET_UNMASKINTR,	 HDIO_SET_UNMASKINTR,	get_unmaskirq, set_unmaskirq },
-{ HDIO_GET_DMA,		 HDIO_SET_DMA,		get_using_dma, set_using_dma },
-{ -1,			 HDIO_SET_PIO_MODE,	NULL,	       set_pio_mode  },
+{ HDIO_GET_32BIT,	 HDIO_SET_32BIT,	&ide_devset_io_32bit  },
+{ HDIO_GET_KEEPSETTINGS, HDIO_SET_KEEPSETTINGS,	&ide_devset_keepsettings },
+{ HDIO_GET_UNMASKINTR,	 HDIO_SET_UNMASKINTR,	&ide_devset_unmaskirq },
+{ HDIO_GET_DMA,		 HDIO_SET_DMA,		&ide_devset_using_dma },
+{ -1,			 HDIO_SET_PIO_MODE,	&ide_devset_pio_mode  },
 { 0 }
 };
 
@@ -18,13 +18,14 @@ int ide_setting_ioctl(ide_drive_t *drive, struct block_device *bdev,
 		      unsigned int cmd, unsigned long arg,
 		      const struct ide_ioctl_devset *s)
 {
+	const struct ide_devset *ds;
 	unsigned long flags;
 	int err = -EOPNOTSUPP;
 
-	for (; s->get_ioctl; s++) {
-		if (s->get && s->get_ioctl == cmd)
+	for (; (ds = s->setting); s++) {
+		if (ds->get && s->get_ioctl == cmd)
 			goto read_val;
-		else if (s->set && s->set_ioctl == cmd)
+		else if (ds->set && s->set_ioctl == cmd)
 			goto set_val;
 	}
 
@@ -33,7 +34,7 @@ int ide_setting_ioctl(ide_drive_t *drive, struct block_device *bdev,
 read_val:
 	mutex_lock(&ide_setting_mtx);
 	spin_lock_irqsave(&ide_lock, flags);
-	err = s->get(drive);
+	err = ds->get(drive);
 	spin_unlock_irqrestore(&ide_lock, flags);
 	mutex_unlock(&ide_setting_mtx);
 	return err >= 0 ? put_user(err, (long __user *)arg) : err;
@@ -46,7 +47,7 @@ set_val:
 			err = -EACCES;
 		else {
 			mutex_lock(&ide_setting_mtx);
-			err = s->set(drive, arg);
+			err = ide_devset_execute(drive, ds, arg);
 			mutex_unlock(&ide_setting_mtx);
 		}
 	}
diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 6489c64..e7030a4 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -124,15 +124,16 @@ static int proc_ide_read_identify
  *	setting semaphore
  */
 
-static const struct ide_devset *ide_find_setting(const struct ide_devset **st,
-						 char *name)
+static
+const struct ide_proc_devset *ide_find_setting(const struct ide_proc_devset *st,
+					       char *name)
 {
-	while (*st) {
-		if (strcmp((*st)->name, name) == 0)
+	while (st->name) {
+		if (strcmp(st->name, name) == 0)
 			break;
 		st++;
 	}
-	return *st;
+	return st->name ? st : NULL;
 }
 
 /**
@@ -149,15 +150,16 @@ static const struct ide_devset *ide_find_setting(const struct ide_devset **st,
  */
 
 static int ide_read_setting(ide_drive_t *drive,
-			    const struct ide_devset *setting)
+			    const struct ide_proc_devset *setting)
 {
+	const struct ide_devset *ds = setting->setting;
 	int val = -EINVAL;
 
-	if ((setting->flags & S_READ)) {
+	if (ds->get) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&ide_lock, flags);
-		val = setting->get(drive);
+		val = ds->get(drive);
 		spin_unlock_irqrestore(&ide_lock, flags);
 	}
 
@@ -183,24 +185,21 @@ static int ide_read_setting(ide_drive_t *drive,
  */
 
 static int ide_write_setting(ide_drive_t *drive,
-			     const struct ide_devset *setting, int val)
+			     const struct ide_proc_devset *setting, int val)
 {
+	const struct ide_devset *ds = setting->setting;
+
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	if (setting->set && (setting->flags & S_NOLOCK))
-		return setting->set(drive, val);
-	if (!(setting->flags & S_WRITE))
+	if (!ds->set)
 		return -EPERM;
-	if (val < setting->min || val > setting->max)
+	if ((ds->flags & DS_SYNC)
+	    && (val < setting->min || val > setting->max))
 		return -EINVAL;
-	if (ide_spin_wait_hwgroup(drive))
-		return -EBUSY;
-	setting->set(drive, val);
-	spin_unlock_irq(&ide_lock);
-	return 0;
+	return ide_devset_execute(drive, ds, val);
 }
 
-static ide_devset_get(xfer_rate, current_speed);
+ide_devset_get(xfer_rate, current_speed);
 
 static int set_xfer_rate (ide_drive_t *drive, int arg)
 {
@@ -226,29 +225,22 @@ static int set_xfer_rate (ide_drive_t *drive, int arg)
 	return err;
 }
 
-ide_devset_rw_nolock(current_speed, 0, 70, xfer_rate);
-ide_devset_rw_nolock(io_32bit, 0, 1 + (SUPPORT_VLB_SYNC << 1), io_32bit);
-ide_devset_rw_nolock(keepsettings, 0, 1, ksettings);
-ide_devset_rw_nolock(unmaskirq, 0, 1, unmaskirq);
-ide_devset_rw_nolock(using_dma, 0, 1, using_dma);
-
-ide_devset_w_nolock(pio_mode, 0, 255, pio_mode);
-
-ide_devset_rw(init_speed, 0, 70, init_speed);
-ide_devset_rw(nice1, 0, 1, nice1);
-ide_devset_rw(number, 0, 3, dn);
-
-static const struct ide_devset *ide_generic_settings[] = {
-	&ide_devset_current_speed,
-	&ide_devset_init_speed,
-	&ide_devset_io_32bit,
-	&ide_devset_keepsettings,
-	&ide_devset_nice1,
-	&ide_devset_number,
-	&ide_devset_pio_mode,
-	&ide_devset_unmaskirq,
-	&ide_devset_using_dma,
-	NULL
+ide_devset_rw(current_speed, xfer_rate);
+ide_devset_rw_field(init_speed, init_speed);
+ide_devset_rw_field(nice1, nice1);
+ide_devset_rw_field(number, dn);
+
+static const struct ide_proc_devset ide_generic_settings[] = {
+	IDE_PROC_DEVSET(current_speed, 0, 70),
+	IDE_PROC_DEVSET(init_speed, 0, 70),
+	IDE_PROC_DEVSET(io_32bit,  0, 1 + (SUPPORT_VLB_SYNC << 1)),
+	IDE_PROC_DEVSET(keepsettings, 0, 1),
+	IDE_PROC_DEVSET(nice1, 0, 1),
+	IDE_PROC_DEVSET(number, 0, 3),
+	IDE_PROC_DEVSET(pio_mode, 0, 255),
+	IDE_PROC_DEVSET(unmaskirq, 0, 1),
+	IDE_PROC_DEVSET(using_dma, 0, 1),
+	{ 0 },
 };
 
 static void proc_ide_settings_warn(void)
@@ -266,7 +258,8 @@ static void proc_ide_settings_warn(void)
 static int proc_ide_read_settings
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	const struct ide_devset *setting, **g, **d;
+	const struct ide_proc_devset *setting, *g, *d;
+	const struct ide_devset *ds;
 	ide_drive_t	*drive = (ide_drive_t *) data;
 	char		*out = page;
 	int		len, rc, mul_factor, div_factor;
@@ -278,17 +271,17 @@ static int proc_ide_read_settings
 	d = drive->settings;
 	out += sprintf(out, "name\t\t\tvalue\t\tmin\t\tmax\t\tmode\n");
 	out += sprintf(out, "----\t\t\t-----\t\t---\t\t---\t\t----\n");
-	while (*g || (d && *d)) {
+	while (g->name || (d && d->name)) {
 		/* read settings in the alphabetical order */
-		if (*g && d && *d) {
-			if (strcmp((*d)->name, (*g)->name) < 0)
-				setting = *d++;
+		if (g->name && d && d->name) {
+			if (strcmp(d->name, g->name) < 0)
+				setting = d++;
 			else
-				setting = *g++;
-		} else if (d && *d) {
-			setting = *d++;
+				setting = g++;
+		} else if (d && d->name) {
+			setting = d++;
 		} else
-			setting = *g++;
+			setting = g++;
 		mul_factor = setting->mulf ? setting->mulf(drive) : 1;
 		div_factor = setting->divf ? setting->divf(drive) : 1;
 		out += sprintf(out, "%-24s", setting->name);
@@ -298,9 +291,10 @@ static int proc_ide_read_settings
 		else
 			out += sprintf(out, "%-16s", "write-only");
 		out += sprintf(out, "%-16d%-16d", (setting->min * mul_factor + div_factor - 1) / div_factor, setting->max * mul_factor / div_factor);
-		if (setting->flags & S_READ)
+		ds = setting->setting;
+		if (ds->get)
 			out += sprintf(out, "r");
-		if (setting->flags & S_WRITE)
+		if (ds->set)
 			out += sprintf(out, "w");
 		out += sprintf(out, "\n");
 	}
@@ -319,7 +313,7 @@ static int proc_ide_write_settings(struct file *file, const char __user *buffer,
 	int		for_real = 0, mul_factor, div_factor;
 	unsigned long	n;
 
-	const struct ide_devset *setting;
+	const struct ide_proc_devset *setting;
 	char *buf, *s;
 
 	if (!capable(CAP_SYS_ADMIN))
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 690f5e4..55feecc 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2187,40 +2187,40 @@ static int set_##name(ide_drive_t *drive, int arg) \
 	return 0; \
 }
 
-#define ide_tape_devset_rw(_name, _min, _max, _field, _mulf, _divf) \
+#define ide_tape_devset_rw_field(_name, _field) \
 ide_tape_devset_get(_name, _field) \
 ide_tape_devset_set(_name, _field) \
-__IDE_DEVSET(_name, S_RW, _min, _max, get_##_name, set_##_name, _mulf, _divf)
+IDE_DEVSET(_name, DS_SYNC, get_##_name, set_##_name)
 
-#define ide_tape_devset_r(_name, _min, _max, _field, _mulf, _divf) \
+#define ide_tape_devset_r_field(_name, _field) \
 ide_tape_devset_get(_name, _field) \
-__IDE_DEVSET(_name, S_READ, _min, _max, get_##_name, NULL, _mulf, _divf)
+IDE_DEVSET(_name, 0, get_##_name, NULL)
 
 static int mulf_tdsc(ide_drive_t *drive)	{ return 1000; }
 static int divf_tdsc(ide_drive_t *drive)	{ return   HZ; }
 static int divf_buffer(ide_drive_t *drive)	{ return    2; }
 static int divf_buffer_size(ide_drive_t *drive)	{ return 1024; }
 
-ide_devset_rw(dsc_overlap,	0,	1, dsc_overlap);
-
-ide_tape_devset_rw(debug_mask,	0, 0xffff, debug_mask,  NULL, NULL);
-ide_tape_devset_rw(tdsc, IDETAPE_DSC_RW_MIN, IDETAPE_DSC_RW_MAX,
-		   best_dsc_rw_freq, mulf_tdsc, divf_tdsc);
-
-ide_tape_devset_r(avg_speed,	0, 0xffff, avg_speed,   NULL, NULL);
-ide_tape_devset_r(speed,	0, 0xffff, caps[14],    NULL, NULL);
-ide_tape_devset_r(buffer,	0, 0xffff, caps[16],    NULL, divf_buffer);
-ide_tape_devset_r(buffer_size,	0, 0xffff, buffer_size, NULL, divf_buffer_size);
-
-static const struct ide_devset *idetape_settings[] = {
-	&ide_devset_avg_speed,
-	&ide_devset_buffer,
-	&ide_devset_buffer_size,
-	&ide_devset_debug_mask,
-	&ide_devset_dsc_overlap,
-	&ide_devset_speed,
-	&ide_devset_tdsc,
-	NULL
+ide_devset_rw_field(dsc_overlap, dsc_overlap);
+
+ide_tape_devset_rw_field(debug_mask, debug_mask);
+ide_tape_devset_rw_field(tdsc, best_dsc_rw_freq);
+
+ide_tape_devset_r_field(avg_speed, avg_speed);
+ide_tape_devset_r_field(speed, caps[14]);
+ide_tape_devset_r_field(buffer, caps[16]);
+ide_tape_devset_r_field(buffer_size, buffer_size);
+
+static const struct ide_proc_devset idetape_settings[] = {
+	__IDE_PROC_DEVSET(avg_speed,	0, 0xffff, NULL, NULL),
+	__IDE_PROC_DEVSET(buffer,	0, 0xffff, NULL, divf_buffer),
+	__IDE_PROC_DEVSET(buffer_size,	0, 0xffff, NULL, divf_buffer_size),
+	__IDE_PROC_DEVSET(debug_mask,	0, 0xffff, NULL, NULL),
+	__IDE_PROC_DEVSET(dsc_overlap,	0,      1, NULL, NULL),
+	__IDE_PROC_DEVSET(speed,	0, 0xffff, NULL, NULL),
+	__IDE_PROC_DEVSET(tdsc,		IDETAPE_DSC_RW_MIN, IDETAPE_DSC_RW_MAX,
+					mulf_tdsc, divf_tdsc),
+	{ 0 },
 };
 #endif
 
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index 349d7fa..9dcf5ae 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -250,42 +250,9 @@ void ide_init_port_hw(ide_hwif_t *hwif, hw_regs_t *hw)
 
 DEFINE_MUTEX(ide_setting_mtx);
 
-/**
- *	ide_spin_wait_hwgroup	-	wait for group
- *	@drive: drive in the group
- *
- *	Wait for an IDE device group to go non busy and then return
- *	holding the ide_lock which guards the hwgroup->busy status
- *	and right to use it.
- */
-
-int ide_spin_wait_hwgroup (ide_drive_t *drive)
-{
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
-	unsigned long timeout = jiffies + (3 * HZ);
-
-	spin_lock_irq(&ide_lock);
-
-	while (hwgroup->busy) {
-		unsigned long lflags;
-		spin_unlock_irq(&ide_lock);
-		local_irq_set(lflags);
-		if (time_after(jiffies, timeout)) {
-			local_irq_restore(lflags);
-			printk(KERN_ERR "%s: channel busy\n", drive->name);
-			return -EBUSY;
-		}
-		local_irq_restore(lflags);
-		spin_lock_irq(&ide_lock);
-	}
-	return 0;
-}
-
-EXPORT_SYMBOL(ide_spin_wait_hwgroup);
-
 ide_devset_get(io_32bit, io_32bit);
 
-int set_io_32bit(ide_drive_t *drive, int arg)
+static int set_io_32bit(ide_drive_t *drive, int arg)
 {
 	if (drive->no_io_32bit)
 		return -EPERM;
@@ -293,37 +260,28 @@ int set_io_32bit(ide_drive_t *drive, int arg)
 	if (arg < 0 || arg > 1 + (SUPPORT_VLB_SYNC << 1))
 		return -EINVAL;
 
-	if (ide_spin_wait_hwgroup(drive))
-		return -EBUSY;
-
 	drive->io_32bit = arg;
 
-	spin_unlock_irq(&ide_lock);
-
 	return 0;
 }
 
 ide_devset_get(ksettings, keep_settings);
 
-int set_ksettings(ide_drive_t *drive, int arg)
+static int set_ksettings(ide_drive_t *drive, int arg)
 {
 	if (arg < 0 || arg > 1)
 		return -EINVAL;
 
-	if (ide_spin_wait_hwgroup(drive))
-		return -EBUSY;
 	drive->keep_settings = arg;
-	spin_unlock_irq(&ide_lock);
 
 	return 0;
 }
 
 ide_devset_get(using_dma, using_dma);
 
-int set_using_dma(ide_drive_t *drive, int arg)
+static int set_using_dma(ide_drive_t *drive, int arg)
 {
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	ide_hwif_t *hwif = drive->hwif;
 	int err = -EPERM;
 
 	if (arg < 0 || arg > 1)
@@ -332,18 +290,9 @@ int set_using_dma(ide_drive_t *drive, int arg)
 	if (ata_id_has_dma(drive->id) == 0)
 		goto out;
 
-	if (hwif->dma_ops == NULL)
+	if (drive->hwif->dma_ops == NULL)
 		goto out;
 
-	err = -EBUSY;
-	if (ide_spin_wait_hwgroup(drive))
-		goto out;
-	/*
-	 * set ->busy flag, unlock and let it ride
-	 */
-	hwif->hwgroup->busy = 1;
-	spin_unlock_irq(&ide_lock);
-
 	err = 0;
 
 	if (arg) {
@@ -352,12 +301,6 @@ int set_using_dma(ide_drive_t *drive, int arg)
 	} else
 		ide_dma_off(drive);
 
-	/*
-	 * lock, clear ->busy flag and unlock before leaving
-	 */
-	spin_lock_irq(&ide_lock);
-	hwif->hwgroup->busy = 0;
-	spin_unlock_irq(&ide_lock);
 out:
 	return err;
 #else
@@ -368,7 +311,7 @@ out:
 #endif
 }
 
-int set_pio_mode(ide_drive_t *drive, int arg)
+static int set_pio_mode(ide_drive_t *drive, int arg)
 {
 	struct request *rq;
 	ide_hwif_t *hwif = drive->hwif;
@@ -398,7 +341,7 @@ int set_pio_mode(ide_drive_t *drive, int arg)
 
 ide_devset_get(unmaskirq, unmask);
 
-int set_unmaskirq(ide_drive_t *drive, int arg)
+static int set_unmaskirq(ide_drive_t *drive, int arg)
 {
 	if (drive->no_unmask)
 		return -EPERM;
@@ -406,14 +349,20 @@ int set_unmaskirq(ide_drive_t *drive, int arg)
 	if (arg < 0 || arg > 1)
 		return -EINVAL;
 
-	if (ide_spin_wait_hwgroup(drive))
-		return -EBUSY;
 	drive->unmask = arg;
-	spin_unlock_irq(&ide_lock);
 
 	return 0;
 }
 
+#define ide_gen_devset_rw(_name, _func) \
+__IDE_DEVSET(_name, DS_SYNC, get_##_func, set_##_func)
+
+ide_gen_devset_rw(io_32bit, io_32bit);
+ide_gen_devset_rw(keepsettings, ksettings);
+ide_gen_devset_rw(unmaskirq, unmaskirq);
+ide_gen_devset_rw(using_dma, using_dma);
+__IDE_DEVSET(pio_mode, 0, NULL, set_pio_mode);
+
 static int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 {
 	ide_drive_t *drive = dev->driver_data;
diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index 3cd3d2a..e9256d2 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -400,25 +400,25 @@ static int set_##name(ide_drive_t *drive, int arg) \
 	return 0; \
 }
 
-#define ide_scsi_devset_rw(_name, _min, _max, _field) \
+#define ide_scsi_devset_rw_field(_name, _field) \
 ide_scsi_devset_get(_name, _field); \
 ide_scsi_devset_set(_name, _field); \
-IDE_DEVSET(_name, S_RW, _min, _max, get_##_name, set_##_name)
-
-ide_devset_rw(bios_cyl,		0, 1023, bios_cyl);
-ide_devset_rw(bios_head,	0,  255, bios_head);
-ide_devset_rw(bios_sect,	0,   63, bios_sect);
-
-ide_scsi_devset_rw(transform,	0,    3, transform);
-ide_scsi_devset_rw(log,		0,    1, log);
-
-static const struct ide_devset *idescsi_settings[] = {
-	&ide_devset_bios_cyl,
-	&ide_devset_bios_head,
-	&ide_devset_bios_sect,
-	&ide_devset_log,
-	&ide_devset_transform,
-	NULL
+IDE_DEVSET(_name, DS_SYNC, get_##_name, set_##_name);
+
+ide_devset_rw_field(bios_cyl, bios_cyl);
+ide_devset_rw_field(bios_head, bios_head);
+ide_devset_rw_field(bios_sect, bios_sect);
+
+ide_scsi_devset_rw_field(transform, transform);
+ide_scsi_devset_rw_field(log, log);
+
+static const struct ide_proc_devset idescsi_settings[] = {
+	IDE_PROC_DEVSET(bios_cyl,  0, 1023),
+	IDE_PROC_DEVSET(bios_head, 0,  255),
+	IDE_PROC_DEVSET(bios_sect, 0,	63),
+	IDE_PROC_DEVSET(log,	   0,	 1),
+	IDE_PROC_DEVSET(transform, 0,	 3),
+	{ 0 },
 };
 #endif
 
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 00091b5..b85ffd7 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -161,6 +161,7 @@ enum {
  * Values should be in the range of 0x20 to 0x3f.
  */
 #define REQ_DRIVE_RESET		0x20
+#define REQ_DEVSET_EXEC		0x21
 
 /*
  * Check for an interrupt and acknowledge the interrupt status
@@ -403,7 +404,7 @@ struct ide_drive_s {
 	u16			*id;	/* identification info */
 #ifdef CONFIG_IDE_PROC_FS
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
-	const struct ide_devset **settings; /* /proc/ide/ drive settings */
+	const struct ide_proc_devset *settings; /* /proc/ide/ drive settings */
 #endif
 	struct hwif_s		*hwif;	/* actually (ide_hwif_t *) */
 
@@ -705,29 +706,62 @@ typedef struct ide_driver_s ide_driver_t;
 
 extern struct mutex ide_setting_mtx;
 
-int get_io_32bit(ide_drive_t *);
-int set_io_32bit(ide_drive_t *, int);
-int get_ksettings(ide_drive_t *);
-int set_ksettings(ide_drive_t *, int);
-int set_pio_mode(ide_drive_t *, int);
-int get_unmaskirq(ide_drive_t *);
-int set_unmaskirq(ide_drive_t *, int);
-int get_using_dma(ide_drive_t *);
-int set_using_dma(ide_drive_t *, int);
+/*
+ * configurable drive settings
+ */
+
+#define DS_SYNC	(1 << 0)
+
+struct ide_devset {
+	int		(*get)(ide_drive_t *);
+	int		(*set)(ide_drive_t *, int);
+	unsigned int	flags;
+};
+
+#define __DEVSET(_flags, _get, _set) { \
+	.flags	= _flags, \
+	.get	= _get,	\
+	.set	= _set,	\
+}
 
 #define ide_devset_get(name, field) \
-int get_##name(ide_drive_t *drive) \
+static int get_##name(ide_drive_t *drive) \
 { \
 	return drive->field; \
 }
 
 #define ide_devset_set(name, field) \
-int set_##name(ide_drive_t *drive, int arg) \
+static int set_##name(ide_drive_t *drive, int arg) \
 { \
 	drive->field = arg; \
 	return 0; \
 }
 
+#define __IDE_DEVSET(_name, _flags, _get, _set) \
+const struct ide_devset ide_devset_##_name = \
+	__DEVSET(_flags, _get, _set)
+
+#define IDE_DEVSET(_name, _flags, _get, _set) \
+static __IDE_DEVSET(_name, _flags, _get, _set)
+
+#define ide_devset_rw(_name, _func) \
+IDE_DEVSET(_name, 0, get_##_func, set_##_func)
+
+#define ide_devset_w(_name, _func) \
+IDE_DEVSET(_name, 0, NULL, set_##_func)
+
+#define ide_devset_rw_sync(_name, _func) \
+IDE_DEVSET(_name, DS_SYNC, get_##_func, set_##_func)
+
+#define ide_decl_devset(_name) \
+extern const struct ide_devset ide_devset_##_name
+
+ide_decl_devset(io_32bit);
+ide_decl_devset(keepsettings);
+ide_decl_devset(pio_mode);
+ide_decl_devset(unmaskirq);
+ide_decl_devset(using_dma);
+
 /* ATAPI packet command flags */
 enum {
 	/* set when an error is considered normal - no retry (ide-tape) */
@@ -795,60 +829,34 @@ struct ide_atapi_pc {
 
 #ifdef CONFIG_IDE_PROC_FS
 /*
- * configurable drive settings
+ * /proc/ide interface
  */
 
-#define S_READ		(1 << 0)
-#define S_WRITE		(1 << 1)
-#define S_RW		(S_READ | S_WRITE)
-#define S_NOLOCK	(1 << 2)
-
-struct ide_devset {
-	const char	*name;
-	unsigned int	flags;
-	int		min, max;
-	int		(*get)(ide_drive_t *);
-	int		(*set)(ide_drive_t *, int);
-	int		(*mulf)(ide_drive_t *);
-	int		(*divf)(ide_drive_t *);
+#define ide_devset_rw_field(_name, _field) \
+ide_devset_get(_name, _field); \
+ide_devset_set(_name, _field); \
+IDE_DEVSET(_name, DS_SYNC, get_##_name, set_##_name)
+
+struct ide_proc_devset {
+	const char		*name;
+	const struct ide_devset	*setting;
+	int			min, max;
+	int			(*mulf)(ide_drive_t *);
+	int			(*divf)(ide_drive_t *);
 };
 
-#define __DEVSET(_name, _flags, _min, _max, _get, _set, _mulf, _divf) { \
-	.name	= __stringify(_name), \
-	.flags	= _flags, \
-	.min	= _min, \
-	.max	= _max, \
-	.get	= _get, \
-	.set	= _set, \
-	.mulf	= _mulf, \
-	.divf	= _divf, \
+#define __IDE_PROC_DEVSET(_name, _min, _max, _mulf, _divf) { \
+	.name = __stringify(_name), \
+	.setting = &ide_devset_##_name, \
+	.min = _min, \
+	.max = _max, \
+	.mulf = _mulf, \
+	.divf = _divf, \
 }
 
-#define __IDE_DEVSET(_name, _flags, _min, _max, _get, _set, _mulf, _divf) \
-static const struct ide_devset ide_devset_##_name = \
-	__DEVSET(_name, _flags, _min, _max, _get, _set, _mulf, _divf)
-
-#define IDE_DEVSET(_name, _flags, _min, _max, _get, _set) \
-__IDE_DEVSET(_name, _flags, _min, _max, _get, _set, NULL, NULL)
-
-#define ide_devset_rw_nolock(_name, _min, _max, _func) \
-IDE_DEVSET(_name, S_RW | S_NOLOCK, _min, _max, get_##_func, set_##_func)
+#define IDE_PROC_DEVSET(_name, _min, _max) \
+__IDE_PROC_DEVSET(_name, _min, _max, NULL, NULL)
 
-#define ide_devset_w_nolock(_name, _min, _max, _func) \
-IDE_DEVSET(_name, S_WRITE | S_NOLOCK, _min, _max, NULL, set_##_func)
-
-#define ide_devset_rw(_name, _min, _max, _field) \
-static ide_devset_get(_name, _field); \
-static ide_devset_set(_name, _field); \
-IDE_DEVSET(_name, S_RW, _min, _max, get_##_name, set_##_name)
-
-#define ide_devset_r(_name, _min, _max, _field) \
-ide_devset_get(_name, _field) \
-IDE_DEVSET(_name, S_READ, _min, _max, get_##_name, NULL)
-
-/*
- * /proc/ide interface
- */
 typedef struct {
 	const char	*name;
 	mode_t		mode;
@@ -946,8 +954,8 @@ struct ide_driver_s {
 	void		(*resume)(ide_drive_t *);
 	void		(*shutdown)(ide_drive_t *);
 #ifdef CONFIG_IDE_PROC_FS
-	ide_proc_entry_t	*proc;
-	const struct ide_devset	**settings;
+	ide_proc_entry_t		*proc;
+	const struct ide_proc_devset	*settings;
 #endif
 };
 
@@ -959,9 +967,7 @@ void ide_device_put(ide_drive_t *);
 struct ide_ioctl_devset {
 	unsigned int	get_ioctl;
 	unsigned int	set_ioctl;
-
-	int		(*get)(ide_drive_t *);
-	int		(*set)(ide_drive_t *, int);
+	const struct ide_devset *setting;
 };
 
 int ide_setting_ioctl(ide_drive_t *, struct block_device *, unsigned int,
@@ -1000,6 +1006,9 @@ int ide_wait_stat(ide_startstop_t *, ide_drive_t *, u8, u8, unsigned long);
 
 extern ide_startstop_t ide_do_reset (ide_drive_t *);
 
+extern int ide_devset_execute(ide_drive_t *drive,
+			      const struct ide_devset *setting, int arg);
+
 extern void ide_do_drive_cmd(ide_drive_t *, struct request *);
 
 extern void ide_end_drive_cmd(ide_drive_t *, u8, u8);
@@ -1189,7 +1198,6 @@ extern int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout);
 
 extern void ide_stall_queue(ide_drive_t *drive, unsigned long timeout);
 
-extern int ide_spin_wait_hwgroup(ide_drive_t *);
 extern void ide_timer_expiry(unsigned long);
 extern irqreturn_t ide_intr(int irq, void *dev_id);
 extern void do_ide_request(struct request_queue *);
