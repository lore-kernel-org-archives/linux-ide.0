From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 6/12] ide: add struct ide_taskfile
Date: Thu, 25 Oct 2007 00:16:29 +0200
Message-ID: <200710250016.29315.bzolnier@gmail.com>
References: <200710082311.10925.bzolnier@gmail.com> <47164894.9080007@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:14891 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676AbXJXXcg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 19:32:36 -0400
Received: by nf-out-0910.google.com with SMTP id g13so325232nfb
        for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2007 16:32:35 -0700 (PDT)
In-Reply-To: <47164894.9080007@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On Wednesday 17 October 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
>=20
> > * Don't set write-only ide_task_t.hobRegister[6] and ide_task_t.hob=
Register[7]
> >   in idedisk_set_max_address_ext().
>=20
> > * Add struct ide_taskfile and use it in ide_task_t instead of tfReg=
ister[]
> >   and hobRegister[].
>=20
> > * Remove no longer needed IDE_CONTROL_OFFSET_HOB define.
>=20
> > * Add #ifndef/#endif __KERNEL__ around definitions of {task,hob}_st=
ruct_t.
>=20
> > While at it:
>=20
> > * Use ATA_LBA define for LBA bit (0x40) as suggested by Tejun Heo.
>=20
> > There should be no functionality changes caused by this patch.
>=20
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>=20
> Nearly-acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>=20
> > Index: b/drivers/ide/ide-disk.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- a/drivers/ide/ide-disk.c
> > +++ b/drivers/ide/ide-disk.c
>=20
> [...]
>=20
> > +	if ((tf->command & 0x01) =3D=3D 0) {
> > +		u32 high, low;
>=20
>     Isn't newline needed after declarations?

Well, it is not stricly needed, this code should compile and work witho=
ut it.

;)

fixed (FWIW the original code also lacked newline)

> > +		high =3D (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lb=
al;
> > +		low  =3D (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
> >  		addr =3D ((__u64)high << 24) | low;
> >  		addr++;	/* since the return value is (maxlba - 1), we add 1 */
> >  	}
>=20
> [...]
>=20
> > @@ -422,33 +417,29 @@ static unsigned long idedisk_set_max_add
> [...]
> >  	/* if OK, compute maximum address value */
> > -	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) =3D=3D 0) {
> > -		u32 high =3D (args.hobRegister[IDE_HCYL_OFFSET] << 16) |
> > -			   (args.hobRegister[IDE_LCYL_OFFSET] <<  8) |
> > -			    args.hobRegister[IDE_SECTOR_OFFSET];
> > -		u32 low  =3D ((args.tfRegister[IDE_HCYL_OFFSET])<<16) |
> > -			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
> > -			    (args.tfRegister[IDE_SECTOR_OFFSET]);
> > +	if ((tf->command & 0x01) =3D=3D 0) {
> > +		u32 high, low;
>=20
>     Again missing newline...

fixed

> > +		high =3D (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lb=
al;
> > +		low  =3D (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
> >  		addr_set =3D ((__u64)high << 24) | low;
> >  		addr_set++;
> >  	}

[...]

> > @@ -596,13 +588,14 @@ static int smart_enable(ide_drive_t *dri
> >  static int get_smart_data(ide_drive_t *drive, u8 *buf, u8 sub_cmd)
> >  {
> >  	ide_task_t args;
> > +	struct ide_taskfile *tf =3D &args.tf;
> > =20
> >  	memset(&args, 0, sizeof(ide_task_t));
> > -	args.tfRegister[IDE_FEATURE_OFFSET]	=3D sub_cmd;
> > -	args.tfRegister[IDE_NSECTOR_OFFSET]	=3D 0x01;
> > -	args.tfRegister[IDE_LCYL_OFFSET]	=3D SMART_LCYL_PASS;
> > -	args.tfRegister[IDE_HCYL_OFFSET]	=3D SMART_HCYL_PASS;
> > -	args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_SMART;
> > +	tf->feature =3D sub_cmd;
> > +	tf->nsect   =3D 0x01;
> > +	tf->lbam    =3D SMART_LCYL_PASS;
> > +	tf->lbah    =3D SMART_HCYL_PASS;
> > +	tf->command =3D WIN_SMART;
>=20
>     I guess the code above and below were menat to have the same =3D =
indentation...
>=20
> >  	args.command_type			=3D IDE_DRIVE_TASK_IN;
> >  	args.data_phase				=3D TASKFILE_IN;
> >  	args.handler				=3D &task_in_intr;

This is to distinguish struct ide_taskfile initialization from ide_task=
_t
initialization.  It would be also just a pointless noise since patch #1=
1/12
("ide: add ide_no_data_taskfile() helper") cleanups such places (with t=
he
only exception being this one because it uses IDE_DRIVE_TASK_IN but som=
e of
the future patches should address it as well).

[...]

> > Index: b/drivers/ide/ide-io.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- a/drivers/ide/ide-io.c
> > +++ b/drivers/ide/ide-io.c
> > @@ -189,15 +189,15 @@ static ide_startstop_t ide_start_power_s
> >  			return ide_stopped;
> >  		}
> >  		if (ide_id_has_flush_cache_ext(drive->id))
> > -			args->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_FLUSH_CACHE_EXT;
> > +			args->tf.command =3D WIN_FLUSH_CACHE_EXT;
> >  		else
> > -			args->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_FLUSH_CACHE;
> > +			args->tf.command =3D WIN_FLUSH_CACHE;
> >  		args->command_type =3D IDE_DRIVE_TASK_NO_DATA;
> >  		args->handler	   =3D &task_no_data_intr;
> >  		return do_rw_taskfile(drive, args);
> > =20
> >  	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
> > -		args->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_STANDBYNOW1;
> > +		args->tf.command =3D WIN_STANDBYNOW1;
>=20
>     ... and here...

ditto but this one is cleaned up by patch #12/12
("ide: use do_rw_taskfile() in flagged_taskfile()")

> >  		args->command_type =3D IDE_DRIVE_TASK_NO_DATA;
> >  		args->handler	   =3D &task_no_data_intr;
> >  		return do_rw_taskfile(drive, args);
> [...]
> > @@ -387,28 +387,30 @@ void ide_end_drive_cmd (ide_drive_t *dri
> >  			rq->errors =3D !OK_STAT(stat,READY_STAT,BAD_STAT);
> >  		=09
> >  		if (args) {
> > +			struct ide_taskfile *tf =3D &args->tf;
> > +
> >  			if (args->tf_in_flags.b.data) {
> > -				u16 data				=3D hwif->INW(IDE_DATA_REG);
> > -				args->tfRegister[IDE_DATA_OFFSET]	=3D (data) & 0xFF;
> > -				args->hobRegister[IDE_DATA_OFFSET]	=3D (data >> 8) & 0xFF;
> > +				u16 data =3D hwif->INW(IDE_DATA_REG);
>=20
>     Again, no newline after declaration block.

fixed

> [...]
>=20
> > @@ -707,28 +709,28 @@ static ide_startstop_t drive_cmd_intr (i
> > =20
> >  static void ide_init_specify_cmd(ide_drive_t *drive, ide_task_t *t=
ask)
> >  {
> > -	task->tfRegister[IDE_NSECTOR_OFFSET] =3D drive->sect;
> > -	task->tfRegister[IDE_SECTOR_OFFSET]  =3D drive->sect;
> > -	task->tfRegister[IDE_LCYL_OFFSET]    =3D drive->cyl;
> > -	task->tfRegister[IDE_HCYL_OFFSET]    =3D drive->cyl>>8;
> > -	task->tfRegister[IDE_SELECT_OFFSET]  =3D ((drive->head-1)|drive->=
select.all)&0xBF;
> > -	task->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_SPECIFY;
> > +	task->tf.nsect   =3D drive->sect;
> > +	task->tf.lbal    =3D drive->sect;
> > +	task->tf.lbam    =3D drive->cyl;
> > +	task->tf.lbah    =3D drive->cyl >> 8;
> > +	task->tf.device  =3D ((drive->head - 1) | drive->select.all) & 0x=
BF;
>=20
>     Well, if you started using ATA_LBA, s/0xBF/~ATA_LBA.

thanks, fixed

> > +	task->tf.command =3D WIN_SPECIFY;
>=20
> [...]
>=20
> > Index: b/drivers/ide/ide-taskfile.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- a/drivers/ide/ide-taskfile.c
> > +++ b/drivers/ide/ide-taskfile.c
> [...]
> >  	/* (ks) send hob registers first */
> >  	if (task->tf_out_flags.b.nsector_hob)
> > -		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
> > +		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
> >  	if (task->tf_out_flags.b.sector_hob)
> > -		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
> > +		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
> >  	if (task->tf_out_flags.b.lcyl_hob)
> > -		hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
> > +		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
> >  	if (task->tf_out_flags.b.hcyl_hob)
> > -		hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
> > +		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
> > =20
> >  	/* (ks) Send now the standard registers */
> >  	if (task->tf_out_flags.b.error_feature)
> > -		hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
> > +		hwif->OUTB(tf->feature, IDE_FEATURE_REG);
> >  	/* refers to number of sectors to transfer */
> >  	if (task->tf_out_flags.b.nsector)
> > -		hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
> > +		hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
> >  	/* refers to sector offset or start sector */
> >  	if (task->tf_out_flags.b.sector)
> > -		hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
> > +		hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
> >  	if (task->tf_out_flags.b.lcyl)
> > -		hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
> > +		hwif->OUTB(tf->lbam, IDE_LCYL_REG);
> >  	if (task->tf_out_flags.b.hcyl)
> > -		hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
> > +		hwif->OUTB(tf->lbah, IDE_HCYL_REG);
> > =20
> >          /*
> >  	 * (ks) In the flagged taskfile approch, we will use all specifie=
d
>=20
>     Well, maybe it time to fix typo in approAch? :-)

fixed in patch #12/12 which just removes this comment along with the ma=
jority
of flagged_taskfile()'s content :)

> > Index: b/include/linux/ide.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- a/include/linux/ide.h
> > +++ b/include/linux/ide.h
> > @@ -103,8 +103,6 @@ typedef unsigned char	byte;	/* used ever
> >  #define IDE_FEATURE_OFFSET	IDE_ERROR_OFFSET
> >  #define IDE_COMMAND_OFFSET	IDE_STATUS_OFFSET
> > =20
> > -#define IDE_CONTROL_OFFSET_HOB	(7)
> > -
> >  #define IDE_DATA_REG		(HWIF(drive)->io_ports[IDE_DATA_OFFSET])
> >  #define IDE_ERROR_REG		(HWIF(drive)->io_ports[IDE_ERROR_OFFSET])
> >  #define IDE_NSECTOR_REG		(HWIF(drive)->io_ports[IDE_NSECTOR_OFFSET=
])
> > @@ -1072,15 +1070,33 @@ extern void ide_end_drive_cmd(ide_drive_
> >   */
> >  extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
> > =20
> > +struct ide_taskfile {
> > +	u8	hob_data;	/*  0: high data byte (for TASKFILE IOCTL) */
> > +
> > +	u8	hob_feature;	/*  1-5: additional data to support LBA48 */
> > +	u8	hob_nsect;
> > +	u8	hob_lbal;
> > +	u8	hob_lbam;
> > +	u8	hob_lbah;
> > +
> > +	u8	data;		/*  6: low data byte (for TASKFILE IOCTL) */
>=20
>     I wonder who needs to read/write the data reg. (even with HOB)? :=
-O

HDIO_DRIVE_TASKFILE ioctl, unfortunately this is all that is known :(


New revision of the patch (it also uses the suggestion about using unna=
med
unions for error/feature and status/command, thanks!):

[PATCH] ide: add struct ide_taskfile (take 2)

* Don't set write-only ide_task_t.hobRegister[6] and ide_task_t.hobRegi=
ster[7]
  in idedisk_set_max_address_ext().

* Add struct ide_taskfile and use it in ide_task_t instead of tfRegiste=
r[]
  and hobRegister[].

* Remove no longer needed IDE_CONTROL_OFFSET_HOB define.

* Add #ifndef/#endif __KERNEL__ around definitions of {task,hob}_struct=
_t.

While at it:

* Use ATA_LBA define for LBA bit (0x40) as suggested by Tejun Heo.

v2:
* Add missing newlines. (Noticed by Sergei)

* Use ~ATA_LBA instead of 0xBF. (Noticed by Sergei)

* Use unnamed unions for error/feature and status/command.
  (Suggested by Sergei).

There should be no functionality changes caused by this patch.

Cc: Tejun Heo <htejun@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c     |  156 ++++++++++++++++++++++++------------=
---------
 drivers/ide/ide-io.c       |   80 +++++++++++++----------
 drivers/ide/ide-iops.c     |   12 +--
 drivers/ide/ide-lib.c      |    3
 drivers/ide/ide-acpi.c     |    8 ---
 drivers/ide/ide-disk.c     |  120 +++++++++++++++++++++---------------=
---------
 drivers/ide/ide-io.c       |   61 ++++++++++++----------
 drivers/ide/ide-iops.c     |   12 ++--
 drivers/ide/ide-lib.c      |    3 -
 drivers/ide/ide-taskfile.c |   99 +++++++++++++++++-------------------=
-
 include/linux/hdreg.h      |    4 +
 include/linux/ide.h        |   43 ++++++++++++----
 8 files changed, 179 insertions(+), 171 deletions(-)

Index: b/drivers/ide/ide-acpi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -354,13 +354,7 @@ static int taskfile_load_raw(ide_drive_t
 	args.handler      =3D &task_no_data_intr;
=20
 	/* convert gtf to IDE Taskfile */
-	args.tfRegister[1] =3D gtf->tfa[0];	/* 0x1f1 */
-	args.tfRegister[2] =3D gtf->tfa[1];	/* 0x1f2 */
-	args.tfRegister[3] =3D gtf->tfa[2];	/* 0x1f3 */
-	args.tfRegister[4] =3D gtf->tfa[3];	/* 0x1f4 */
-	args.tfRegister[5] =3D gtf->tfa[4];	/* 0x1f5 */
-	args.tfRegister[6] =3D gtf->tfa[5];	/* 0x1f6 */
-	args.tfRegister[7] =3D gtf->tfa[6];	/* 0x1f7 */
+	memcpy(&args.tf_array[7], &gtf->tfa, 7);
=20
 	if (ide_noacpitfs) {
 		DEBPRINT("_GTF execution disabled\n");
Index: b/drivers/ide/ide-disk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -336,23 +336,22 @@ static ide_startstop_t ide_do_rw_disk (i
 static unsigned long idedisk_read_native_max_address(ide_drive_t *driv=
e)
 {
 	ide_task_t args;
+	struct ide_taskfile *tf =3D &args.tf;
 	unsigned long addr =3D 0;
=20
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_SELECT_OFFSET]	=3D 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_READ_NATIVE_MAX;
+	tf->device  =3D ATA_LBA;
+	tf->command =3D WIN_READ_NATIVE_MAX;
 	args.command_type			=3D IDE_DRIVE_TASK_NO_DATA;
 	args.handler				=3D &task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
=20
 	/* if OK, compute maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) =3D=3D 0) {
-		addr =3D ((args.tfRegister[IDE_SELECT_OFFSET] & 0x0f) << 24)
-		     | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
-		     | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
-		     | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
+	if ((tf->status & 0x01) =3D=3D 0) {
+		addr =3D ((tf->device & 0xf) << 24) |
+		       (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
 		addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	}
 	return addr;
@@ -361,26 +360,24 @@ static unsigned long idedisk_read_native
 static unsigned long long idedisk_read_native_max_address_ext(ide_driv=
e_t *drive)
 {
 	ide_task_t args;
+	struct ide_taskfile *tf =3D &args.tf;
 	unsigned long long addr =3D 0;
=20
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
-
-	args.tfRegister[IDE_SELECT_OFFSET]	=3D 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_READ_NATIVE_MAX_EXT;
+	tf->device  =3D ATA_LBA;
+	tf->command =3D WIN_READ_NATIVE_MAX_EXT;
 	args.command_type			=3D IDE_DRIVE_TASK_NO_DATA;
 	args.handler				=3D &task_no_data_intr;
         /* submit command request */
         ide_raw_taskfile(drive, &args, NULL);
=20
 	/* if OK, compute maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) =3D=3D 0) {
-		u32 high =3D (args.hobRegister[IDE_HCYL_OFFSET] << 16) |
-			   (args.hobRegister[IDE_LCYL_OFFSET] <<  8) |
-			    args.hobRegister[IDE_SECTOR_OFFSET];
-		u32 low  =3D ((args.tfRegister[IDE_HCYL_OFFSET])<<16) |
-			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
-			    (args.tfRegister[IDE_SECTOR_OFFSET]);
+	if ((tf->status & 0x01) =3D=3D 0) {
+		u32 high, low;
+
+		high =3D (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
+		low  =3D (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
 		addr =3D ((__u64)high << 24) | low;
 		addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	}
@@ -394,26 +391,25 @@ static unsigned long long idedisk_read_n
 static unsigned long idedisk_set_max_address(ide_drive_t *drive, unsig=
ned long addr_req)
 {
 	ide_task_t args;
+	struct ide_taskfile *tf =3D &args.tf;
 	unsigned long addr_set =3D 0;
 =09
 	addr_req--;
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_SECTOR_OFFSET]	=3D ((addr_req >>  0) & 0xff);
-	args.tfRegister[IDE_LCYL_OFFSET]	=3D ((addr_req >>  8) & 0xff);
-	args.tfRegister[IDE_HCYL_OFFSET]	=3D ((addr_req >> 16) & 0xff);
-	args.tfRegister[IDE_SELECT_OFFSET]	=3D ((addr_req >> 24) & 0x0f) | 0x=
40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_SET_MAX;
+	tf->lbal    =3D  (addr_req >>  0) & 0xff;
+	tf->lbam    =3D  (addr_req >>  8) & 0xff;
+	tf->lbah    =3D  (addr_req >> 16) & 0xff;
+	tf->device  =3D ((addr_req >> 24) & 0x0f) | ATA_LBA;
+	tf->command =3D WIN_SET_MAX;
 	args.command_type			=3D IDE_DRIVE_TASK_NO_DATA;
 	args.handler				=3D &task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, read new maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) =3D=3D 0) {
-		addr_set =3D ((args.tfRegister[IDE_SELECT_OFFSET] & 0x0f) << 24)
-			 | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
-			 | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
-			 | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
+	if ((tf->status & 0x01) =3D=3D 0) {
+		addr_set =3D ((tf->device & 0xf) << 24) |
+			   (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
 		addr_set++;
 	}
 	return addr_set;
@@ -422,33 +418,30 @@ static unsigned long idedisk_set_max_add
 static unsigned long long idedisk_set_max_address_ext(ide_drive_t *dri=
ve, unsigned long long addr_req)
 {
 	ide_task_t args;
+	struct ide_taskfile *tf =3D &args.tf;
 	unsigned long long addr_set =3D 0;
=20
 	addr_req--;
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_SECTOR_OFFSET]	=3D ((addr_req >>  0) & 0xff);
-	args.tfRegister[IDE_LCYL_OFFSET]	=3D ((addr_req >>=3D 8) & 0xff);
-	args.tfRegister[IDE_HCYL_OFFSET]	=3D ((addr_req >>=3D 8) & 0xff);
-	args.tfRegister[IDE_SELECT_OFFSET]      =3D 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_SET_MAX_EXT;
-	args.hobRegister[IDE_SECTOR_OFFSET]	=3D (addr_req >>=3D 8) & 0xff;
-	args.hobRegister[IDE_LCYL_OFFSET]	=3D (addr_req >>=3D 8) & 0xff;
-	args.hobRegister[IDE_HCYL_OFFSET]	=3D (addr_req >>=3D 8) & 0xff;
-	args.hobRegister[IDE_SELECT_OFFSET]	=3D 0x40;
-	args.hobRegister[IDE_CONTROL_OFFSET_HOB]=3D (drive->ctl|0x80);
+	tf->lbal     =3D (addr_req >>  0) & 0xff;
+	tf->lbam     =3D (addr_req >>=3D 8) & 0xff;
+	tf->lbah     =3D (addr_req >>=3D 8) & 0xff;
+	tf->device   =3D ATA_LBA;
+	tf->command  =3D WIN_SET_MAX_EXT;
+	tf->hob_lbal =3D (addr_req >>=3D 8) & 0xff;
+	tf->hob_lbam =3D (addr_req >>=3D 8) & 0xff;
+	tf->hob_lbah =3D (addr_req >>=3D 8) & 0xff;
 	args.command_type			=3D IDE_DRIVE_TASK_NO_DATA;
 	args.handler				=3D &task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, compute maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) =3D=3D 0) {
-		u32 high =3D (args.hobRegister[IDE_HCYL_OFFSET] << 16) |
-			   (args.hobRegister[IDE_LCYL_OFFSET] <<  8) |
-			    args.hobRegister[IDE_SECTOR_OFFSET];
-		u32 low  =3D ((args.tfRegister[IDE_HCYL_OFFSET])<<16) |
-			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
-			    (args.tfRegister[IDE_SECTOR_OFFSET]);
+	if ((tf->status & 0x01) =3D=3D 0) {
+		u32 high, low;
+
+		high =3D (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
+		low  =3D (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
 		addr_set =3D ((__u64)high << 24) | low;
 		addr_set++;
 	}
@@ -582,12 +575,13 @@ static sector_t idedisk_capacity (ide_dr
 static int smart_enable(ide_drive_t *drive)
 {
 	ide_task_t args;
+	struct ide_taskfile *tf =3D &args.tf;
=20
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_FEATURE_OFFSET]	=3D SMART_ENABLE;
-	args.tfRegister[IDE_LCYL_OFFSET]	=3D SMART_LCYL_PASS;
-	args.tfRegister[IDE_HCYL_OFFSET]	=3D SMART_HCYL_PASS;
-	args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_SMART;
+	tf->feature =3D SMART_ENABLE;
+	tf->lbam    =3D SMART_LCYL_PASS;
+	tf->lbah    =3D SMART_HCYL_PASS;
+	tf->command =3D WIN_SMART;
 	args.command_type			=3D IDE_DRIVE_TASK_NO_DATA;
 	args.handler				=3D &task_no_data_intr;
 	return ide_raw_taskfile(drive, &args, NULL);
@@ -596,13 +590,14 @@ static int smart_enable(ide_drive_t *dri
 static int get_smart_data(ide_drive_t *drive, u8 *buf, u8 sub_cmd)
 {
 	ide_task_t args;
+	struct ide_taskfile *tf =3D &args.tf;
=20
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_FEATURE_OFFSET]	=3D sub_cmd;
-	args.tfRegister[IDE_NSECTOR_OFFSET]	=3D 0x01;
-	args.tfRegister[IDE_LCYL_OFFSET]	=3D SMART_LCYL_PASS;
-	args.tfRegister[IDE_HCYL_OFFSET]	=3D SMART_HCYL_PASS;
-	args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_SMART;
+	tf->feature =3D sub_cmd;
+	tf->nsect   =3D 0x01;
+	tf->lbam    =3D SMART_LCYL_PASS;
+	tf->lbah    =3D SMART_HCYL_PASS;
+	tf->command =3D WIN_SMART;
 	args.command_type			=3D IDE_DRIVE_TASK_IN;
 	args.data_phase				=3D TASKFILE_IN;
 	args.handler				=3D &task_in_intr;
@@ -779,9 +774,9 @@ static int write_cache(ide_drive_t *driv
=20
 	if (ide_id_has_flush_cache(drive->id)) {
 		memset(&args, 0, sizeof(ide_task_t));
-		args.tfRegister[IDE_FEATURE_OFFSET]	=3D (arg) ?
+		args.tf.feature =3D arg ?
 			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
-		args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_SETFEATURES;
+		args.tf.command =3D WIN_SETFEATURES;
 		args.command_type		=3D IDE_DRIVE_TASK_NO_DATA;
 		args.handler			=3D &task_no_data_intr;
 		err =3D ide_raw_taskfile(drive, &args, NULL);
@@ -800,9 +795,9 @@ static int do_idedisk_flushcache (ide_dr
=20
 	memset(&args, 0, sizeof(ide_task_t));
 	if (ide_id_has_flush_cache_ext(drive->id))
-		args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_FLUSH_CACHE_EXT;
+		args.tf.command =3D WIN_FLUSH_CACHE_EXT;
 	else
-		args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_FLUSH_CACHE;
+		args.tf.command =3D WIN_FLUSH_CACHE;
 	args.command_type			=3D IDE_DRIVE_TASK_NO_DATA;
 	args.handler				=3D &task_no_data_intr;
 	return ide_raw_taskfile(drive, &args, NULL);
@@ -816,10 +811,9 @@ static int set_acoustic (ide_drive_t *dr
 		return -EINVAL;
=20
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_FEATURE_OFFSET]	=3D (arg) ? SETFEATURES_EN_AAM :
-							  SETFEATURES_DIS_AAM;
-	args.tfRegister[IDE_NSECTOR_OFFSET]	=3D arg;
-	args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_SETFEATURES;
+	args.tf.feature =3D arg ? SETFEATURES_EN_AAM : SETFEATURES_DIS_AAM;
+	args.tf.nsect   =3D arg;
+	args.tf.command =3D WIN_SETFEATURES;
 	args.command_type =3D IDE_DRIVE_TASK_NO_DATA;
 	args.handler	  =3D &task_no_data_intr;
 	ide_raw_taskfile(drive, &args, NULL);
@@ -1086,7 +1080,7 @@ static int idedisk_open(struct inode *in
 	if (drive->removable && idkp->openers =3D=3D 1) {
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
-		args.tfRegister[IDE_COMMAND_OFFSET] =3D WIN_DOORLOCK;
+		args.tf.command =3D WIN_DOORLOCK;
 		args.command_type =3D IDE_DRIVE_TASK_NO_DATA;
 		args.handler	  =3D &task_no_data_intr;
 		check_disk_change(inode->i_bdev);
@@ -1113,7 +1107,7 @@ static int idedisk_release(struct inode=20
 	if (drive->removable && idkp->openers =3D=3D 1) {
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
-		args.tfRegister[IDE_COMMAND_OFFSET] =3D WIN_DOORUNLOCK;
+		args.tf.command =3D WIN_DOORUNLOCK;
 		args.command_type =3D IDE_DRIVE_TASK_NO_DATA;
 		args.handler	  =3D &task_no_data_intr;
 		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
Index: b/drivers/ide/ide-io.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -189,15 +189,15 @@ static ide_startstop_t ide_start_power_s
 			return ide_stopped;
 		}
 		if (ide_id_has_flush_cache_ext(drive->id))
-			args->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_FLUSH_CACHE_EXT;
+			args->tf.command =3D WIN_FLUSH_CACHE_EXT;
 		else
-			args->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_FLUSH_CACHE;
+			args->tf.command =3D WIN_FLUSH_CACHE;
 		args->command_type =3D IDE_DRIVE_TASK_NO_DATA;
 		args->handler	   =3D &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
=20
 	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
-		args->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_STANDBYNOW1;
+		args->tf.command =3D WIN_STANDBYNOW1;
 		args->command_type =3D IDE_DRIVE_TASK_NO_DATA;
 		args->handler	   =3D &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
@@ -214,7 +214,7 @@ static ide_startstop_t ide_start_power_s
 		return ide_stopped;
=20
 	case idedisk_pm_idle:		/* Resume step 2 (idle) */
-		args->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_IDLEIMMEDIATE;
+		args->tf.command =3D WIN_IDLEIMMEDIATE;
 		args->command_type =3D IDE_DRIVE_TASK_NO_DATA;
 		args->handler =3D task_no_data_intr;
 		return do_rw_taskfile(drive, args);
@@ -352,28 +352,31 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			rq->errors =3D !OK_STAT(stat,READY_STAT,BAD_STAT);
 		=09
 		if (args) {
+			struct ide_taskfile *tf =3D &args->tf;
+
 			if (args->tf_in_flags.b.data) {
-				u16 data				=3D hwif->INW(IDE_DATA_REG);
-				args->tfRegister[IDE_DATA_OFFSET]	=3D (data) & 0xFF;
-				args->hobRegister[IDE_DATA_OFFSET]	=3D (data >> 8) & 0xFF;
+				u16 data =3D hwif->INW(IDE_DATA_REG);
+
+				tf->data =3D data & 0xff;
+				tf->hob_data =3D (data >> 8) & 0xff;
 			}
-			args->tfRegister[IDE_ERROR_OFFSET]   =3D err;
+			tf->error =3D err;
 			/* be sure we're looking at the low order bits */
 			hwif->OUTB(drive->ctl & ~0x80, IDE_CONTROL_REG);
-			args->tfRegister[IDE_NSECTOR_OFFSET] =3D hwif->INB(IDE_NSECTOR_REG)=
;
-			args->tfRegister[IDE_SECTOR_OFFSET]  =3D hwif->INB(IDE_SECTOR_REG);
-			args->tfRegister[IDE_LCYL_OFFSET]    =3D hwif->INB(IDE_LCYL_REG);
-			args->tfRegister[IDE_HCYL_OFFSET]    =3D hwif->INB(IDE_HCYL_REG);
-			args->tfRegister[IDE_SELECT_OFFSET]  =3D hwif->INB(IDE_SELECT_REG);
-			args->tfRegister[IDE_STATUS_OFFSET]  =3D stat;
+			tf->nsect  =3D hwif->INB(IDE_NSECTOR_REG);
+			tf->lbal   =3D hwif->INB(IDE_SECTOR_REG);
+			tf->lbam   =3D hwif->INB(IDE_LCYL_REG);
+			tf->lbah   =3D hwif->INB(IDE_HCYL_REG);
+			tf->device =3D hwif->INB(IDE_SELECT_REG);
+			tf->status =3D stat;
=20
 			if (drive->addressing =3D=3D 1) {
 				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
-				args->hobRegister[IDE_FEATURE_OFFSET]	=3D hwif->INB(IDE_FEATURE_RE=
G);
-				args->hobRegister[IDE_NSECTOR_OFFSET]	=3D hwif->INB(IDE_NSECTOR_RE=
G);
-				args->hobRegister[IDE_SECTOR_OFFSET]	=3D hwif->INB(IDE_SECTOR_REG)=
;
-				args->hobRegister[IDE_LCYL_OFFSET]	=3D hwif->INB(IDE_LCYL_REG);
-				args->hobRegister[IDE_HCYL_OFFSET]	=3D hwif->INB(IDE_HCYL_REG);
+				tf->hob_feature =3D hwif->INB(IDE_FEATURE_REG);
+				tf->hob_nsect   =3D hwif->INB(IDE_NSECTOR_REG);
+				tf->hob_lbal    =3D hwif->INB(IDE_SECTOR_REG);
+				tf->hob_lbam    =3D hwif->INB(IDE_LCYL_REG);
+				tf->hob_lbah    =3D hwif->INB(IDE_HCYL_REG);
 			}
 		}
 	} else if (blk_pm_request(rq)) {
@@ -672,28 +675,28 @@ static ide_startstop_t drive_cmd_intr (i
=20
 static void ide_init_specify_cmd(ide_drive_t *drive, ide_task_t *task)
 {
-	task->tfRegister[IDE_NSECTOR_OFFSET] =3D drive->sect;
-	task->tfRegister[IDE_SECTOR_OFFSET]  =3D drive->sect;
-	task->tfRegister[IDE_LCYL_OFFSET]    =3D drive->cyl;
-	task->tfRegister[IDE_HCYL_OFFSET]    =3D drive->cyl>>8;
-	task->tfRegister[IDE_SELECT_OFFSET]  =3D ((drive->head-1)|drive->sele=
ct.all)&0xBF;
-	task->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_SPECIFY;
+	task->tf.nsect   =3D drive->sect;
+	task->tf.lbal    =3D drive->sect;
+	task->tf.lbam    =3D drive->cyl;
+	task->tf.lbah    =3D drive->cyl >> 8;
+	task->tf.device  =3D ((drive->head - 1) | drive->select.all) & ~ATA_L=
BA;
+	task->tf.command =3D WIN_SPECIFY;
=20
 	task->handler =3D &set_geometry_intr;
 }
=20
 static void ide_init_restore_cmd(ide_drive_t *drive, ide_task_t *task)
 {
-	task->tfRegister[IDE_NSECTOR_OFFSET] =3D drive->sect;
-	task->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_RESTORE;
+	task->tf.nsect   =3D drive->sect;
+	task->tf.command =3D WIN_RESTORE;
=20
 	task->handler =3D &recal_intr;
 }
=20
 static void ide_init_setmult_cmd(ide_drive_t *drive, ide_task_t *task)
 {
-	task->tfRegister[IDE_NSECTOR_OFFSET] =3D drive->mult_req;
-	task->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_SETMULT;
+	task->tf.nsect   =3D drive->mult_req;
+	task->tf.command =3D WIN_SETMULT;
=20
 	task->handler =3D &set_multmode_intr;
 }
Index: b/drivers/ide/ide-iops.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -638,9 +638,9 @@ no_80w:
=20
 int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
 {
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] =3D=3D WIN_SETFEATURES) &&
-	    (args->tfRegister[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
-	    (args->tfRegister[IDE_FEATURE_OFFSET] =3D=3D SETFEATURES_XFER)) {
+	if (args->tf.command =3D=3D WIN_SETFEATURES &&
+	    args->tf.lbal > XFER_UDMA_2 &&
+	    args->tf.feature =3D=3D SETFEATURES_XFER) {
 		if (eighty_ninty_three(drive) =3D=3D 0) {
 			printk(KERN_WARNING "%s: UDMA speeds >UDMA33 cannot "
 					    "be set\n", drive->name);
@@ -658,9 +658,9 @@ int ide_ata66_check (ide_drive_t *drive,
  */
 int set_transfer (ide_drive_t *drive, ide_task_t *args)
 {
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] =3D=3D WIN_SETFEATURES) &&
-	    (args->tfRegister[IDE_SECTOR_OFFSET] >=3D XFER_SW_DMA_0) &&
-	    (args->tfRegister[IDE_FEATURE_OFFSET] =3D=3D SETFEATURES_XFER) &&
+	if (args->tf.command =3D=3D WIN_SETFEATURES &&
+	    args->tf.lbal >=3D XFER_SW_DMA_0 &&
+	    args->tf.feature =3D=3D SETFEATURES_XFER &&
 	    (drive->id->dma_ultra ||
 	     drive->id->dma_mword ||
 	     drive->id->dma_1word))
Index: b/drivers/ide/ide-lib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -465,8 +465,7 @@ static void ide_dump_opcode(ide_drive_t=20
 	} else if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *args =3D rq->special;
 		if (args) {
-			task_struct_t *tf =3D (task_struct_t *) args->tfRegister;
-			opcode =3D tf->command;
+			opcode =3D args->tf.command;
 			found =3D 1;
 		}
 	}
Index: b/drivers/ide/ide-taskfile.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -66,12 +66,13 @@ static void taskfile_output_data(ide_dri
 int taskfile_lib_get_identify (ide_drive_t *drive, u8 *buf)
 {
 	ide_task_t args;
+
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_NSECTOR_OFFSET]	=3D 0x01;
+	args.tf.nsect =3D 0x01;
 	if (drive->media =3D=3D ide_disk)
-		args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_IDENTIFY;
+		args.tf.command =3D WIN_IDENTIFY;
 	else
-		args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_PIDENTIFY;
+		args.tf.command =3D WIN_PIDENTIFY;
 	args.command_type =3D IDE_DRIVE_TASK_IN;
 	args.data_phase   =3D TASKFILE_IN;
 	args.handler	  =3D &task_in_intr;
@@ -81,8 +82,7 @@ int taskfile_lib_get_identify (ide_drive
 ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	task_struct_t *taskfile	=3D (task_struct_t *) task->tfRegister;
-	hob_struct_t *hobfile	=3D (hob_struct_t *) task->hobRegister;
+	struct ide_taskfile *tf =3D &task->tf;
 	u8 HIHI			=3D (drive->addressing =3D=3D 1) ? 0xE0 : 0xEF;
=20
 	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
@@ -93,35 +93,35 @@ ide_startstop_t do_rw_taskfile (ide_driv
 	SELECT_MASK(drive, 0);
=20
 	if (drive->addressing =3D=3D 1) {
-		hwif->OUTB(hobfile->feature, IDE_FEATURE_REG);
-		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
-		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
-		hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
-		hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
+		hwif->OUTB(tf->hob_feature, IDE_FEATURE_REG);
+		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
+		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
+		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
+		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
 	}
=20
-	hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
-	hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
-	hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
-	hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
-	hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
+	hwif->OUTB(tf->feature, IDE_FEATURE_REG);
+	hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
+	hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
+	hwif->OUTB(tf->lbam, IDE_LCYL_REG);
+	hwif->OUTB(tf->lbah, IDE_HCYL_REG);
=20
-	hwif->OUTB((taskfile->device_head & HIHI) | drive->select.all, IDE_SE=
LECT_REG);
+	hwif->OUTB((tf->device & HIHI) | drive->select.all, IDE_SELECT_REG);
=20
 	if (task->handler !=3D NULL) {
 		if (task->prehandler !=3D NULL) {
-			hwif->OUTBSYNC(drive, taskfile->command, IDE_COMMAND_REG);
+			hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
 			ndelay(400);	/* FIXME */
 			return task->prehandler(drive, task->rq);
 		}
-		ide_execute_command(drive, taskfile->command, task->handler, WAIT_WO=
RSTCASE, NULL);
+		ide_execute_command(drive, tf->command, task->handler, WAIT_WORSTCAS=
E, NULL);
 		return ide_started;
 	}
=20
 	if (!drive->using_dma)
 		return ide_stopped;
=20
-	switch (taskfile->command) {
+	switch (tf->command) {
 		case WIN_WRITEDMA_ONCE:
 		case WIN_WRITEDMA:
 		case WIN_WRITEDMA_EXT:
@@ -130,7 +130,7 @@ ide_startstop_t do_rw_taskfile (ide_driv
 		case WIN_READDMA_EXT:
 		case WIN_IDENTIFY_DMA:
 			if (!hwif->dma_setup(drive)) {
-				hwif->dma_exec_cmd(drive, taskfile->command);
+				hwif->dma_exec_cmd(drive, tf->command);
 				hwif->dma_start(drive);
 				return ide_started;
 			}
@@ -482,7 +482,7 @@ static int ide_diag_taskfile(ide_drive_t
 	 */
 	if (args->command_type !=3D IDE_DRIVE_TASK_NO_DATA) {
 		if (data_size =3D=3D 0)
-			rq.nr_sectors =3D (args->hobRegister[IDE_NSECTOR_OFFSET] << 8) | ar=
gs->tfRegister[IDE_NSECTOR_OFFSET];
+			rq.nr_sectors =3D (args->tf.hob_nsect << 8) | args->tf.nsect;
 		else
 			rq.nr_sectors =3D data_size / SECTOR_SIZE;
=20
@@ -517,8 +517,6 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	ide_task_t		args;
 	u8 *outbuf		=3D NULL;
 	u8 *inbuf		=3D NULL;
-	u8 *argsptr		=3D args.tfRegister;
-	u8 *hobsptr		=3D args.hobRegister;
 	int err			=3D 0;
 	int tasksize		=3D sizeof(struct ide_task_request_s);
 	unsigned int taskin	=3D 0;
@@ -570,9 +568,9 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	}
=20
 	memset(&args, 0, sizeof(ide_task_t));
-	memcpy(argsptr, req_task->io_ports, HDIO_DRIVE_TASK_HDR_SIZE);
-	memcpy(hobsptr, req_task->hob_ports, HDIO_DRIVE_HOB_HDR_SIZE);
=20
+	memcpy(&args.tf_array[0], req_task->hob_ports, HDIO_DRIVE_HOB_HDR_SIZ=
E - 2);
+	memcpy(&args.tf_array[6], req_task->io_ports, HDIO_DRIVE_TASK_HDR_SIZ=
E);
 	args.tf_in_flags  =3D req_task->in_flags;
 	args.tf_out_flags =3D req_task->out_flags;
 	args.data_phase   =3D req_task->data_phase;
@@ -626,8 +624,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 			goto abort;
 	}
=20
-	memcpy(req_task->io_ports, &(args.tfRegister), HDIO_DRIVE_TASK_HDR_SI=
ZE);
-	memcpy(req_task->hob_ports, &(args.hobRegister), HDIO_DRIVE_HOB_HDR_S=
IZE);
+	memcpy(req_task->hob_ports, &args.tf_array[0], HDIO_DRIVE_HOB_HDR_SIZ=
E - 2);
+	memcpy(req_task->io_ports, &args.tf_array[6], HDIO_DRIVE_TASK_HDR_SIZ=
E);
 	req_task->in_flags  =3D args.tf_in_flags;
 	req_task->out_flags =3D args.tf_out_flags;
=20
@@ -685,6 +683,7 @@ int ide_cmd_ioctl (ide_drive_t *drive, u
 	u8 xfer_rate =3D 0;
 	int argsize =3D 4;
 	ide_task_t tfargs;
+	struct ide_taskfile *tf =3D &tfargs.tf;
=20
 	if (NULL =3D=3D (void *) arg) {
 		struct request rq;
@@ -696,13 +695,10 @@ int ide_cmd_ioctl (ide_drive_t *drive, u
 		return -EFAULT;
=20
 	memset(&tfargs, 0, sizeof(ide_task_t));
-	tfargs.tfRegister[IDE_FEATURE_OFFSET] =3D args[2];
-	tfargs.tfRegister[IDE_NSECTOR_OFFSET] =3D args[3];
-	tfargs.tfRegister[IDE_SECTOR_OFFSET]  =3D args[1];
-	tfargs.tfRegister[IDE_LCYL_OFFSET]    =3D 0x00;
-	tfargs.tfRegister[IDE_HCYL_OFFSET]    =3D 0x00;
-	tfargs.tfRegister[IDE_SELECT_OFFSET]  =3D 0x00;
-	tfargs.tfRegister[IDE_COMMAND_OFFSET] =3D args[0];
+	tf->feature =3D args[2];
+	tf->nsect   =3D args[3];
+	tf->lbal    =3D args[1];
+	tf->command =3D args[0];
=20
 	if (args[3]) {
 		argsize =3D 4 + (SECTOR_WORDS * 4 * args[3]);
@@ -764,8 +760,7 @@ int ide_task_ioctl (ide_drive_t *drive,=20
 ide_startstop_t flagged_taskfile (ide_drive_t *drive, ide_task_t *task=
)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	task_struct_t *taskfile	=3D (task_struct_t *) task->tfRegister;
-	hob_struct_t *hobfile	=3D (hob_struct_t *) task->hobRegister;
+	struct ide_taskfile *tf =3D &task->tf;
=20
 	if (task->data_phase =3D=3D TASKFILE_MULTI_IN ||
 	    task->data_phase =3D=3D TASKFILE_MULTI_OUT) {
@@ -795,34 +790,32 @@ ide_startstop_t flagged_taskfile (ide_dr
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 	SELECT_MASK(drive, 0);
=20
-	if (task->tf_out_flags.b.data) {
-		u16 data =3D  taskfile->data + (hobfile->data << 8);
-		hwif->OUTW(data, IDE_DATA_REG);
-	}
+	if (task->tf_out_flags.b.data)
+		hwif->OUTW((tf->hob_data << 8) | tf->data, IDE_DATA_REG);
=20
 	/* (ks) send hob registers first */
 	if (task->tf_out_flags.b.nsector_hob)
-		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
+		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
 	if (task->tf_out_flags.b.sector_hob)
-		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
+		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
 	if (task->tf_out_flags.b.lcyl_hob)
-		hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
+		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
 	if (task->tf_out_flags.b.hcyl_hob)
-		hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
+		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
=20
 	/* (ks) Send now the standard registers */
 	if (task->tf_out_flags.b.error_feature)
-		hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
+		hwif->OUTB(tf->feature, IDE_FEATURE_REG);
 	/* refers to number of sectors to transfer */
 	if (task->tf_out_flags.b.nsector)
-		hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
+		hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
 	/* refers to sector offset or start sector */
 	if (task->tf_out_flags.b.sector)
-		hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
+		hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
 	if (task->tf_out_flags.b.lcyl)
-		hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
+		hwif->OUTB(tf->lbam, IDE_LCYL_REG);
 	if (task->tf_out_flags.b.hcyl)
-		hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
+		hwif->OUTB(tf->lbah, IDE_HCYL_REG);
=20
         /*
 	 * (ks) In the flagged taskfile approch, we will use all specified
@@ -830,7 +823,7 @@ ide_startstop_t flagged_taskfile (ide_dr
 	 * select bit (master/slave) in the drive_head register. We must make
 	 * sure that the desired drive is selected.
 	 */
-	hwif->OUTB(taskfile->device_head | drive->select.all, IDE_SELECT_REG)=
;
+	hwif->OUTB(tf->device | drive->select.all, IDE_SELECT_REG);
 	switch(task->data_phase) {
=20
    	        case TASKFILE_OUT_DMAQ:
@@ -841,7 +834,7 @@ ide_startstop_t flagged_taskfile (ide_dr
 				break;
=20
 			if (!hwif->dma_setup(drive)) {
-				hwif->dma_exec_cmd(drive, taskfile->command);
+				hwif->dma_exec_cmd(drive, tf->command);
 				hwif->dma_start(drive);
 				return ide_started;
 			}
@@ -853,11 +846,11 @@ ide_startstop_t flagged_taskfile (ide_dr
=20
 			/* Issue the command */
 			if (task->prehandler) {
-				hwif->OUTBSYNC(drive, taskfile->command, IDE_COMMAND_REG);
+				hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
 				ndelay(400);	/* FIXME */
 				return task->prehandler(drive, task->rq);
 			}
-			ide_execute_command(drive, taskfile->command, task->handler, WAIT_W=
ORSTCASE, NULL);
+			ide_execute_command(drive, tf->command, task->handler, WAIT_WORSTCA=
SE, NULL);
 			return ide_started;
 	}
=20
Index: b/include/linux/hdreg.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/hdreg.h
+++ b/include/linux/hdreg.h
@@ -117,7 +117,7 @@ typedef union ide_reg_valid_s {
=20
 typedef struct ide_task_request_s {
 	__u8		io_ports[8];
-	__u8		hob_ports[8];
+	__u8		hob_ports[8]; /* bytes 6 and 7 are unused */
 	ide_reg_valid_t	out_flags;
 	ide_reg_valid_t	in_flags;
 	int		data_phase;
@@ -139,6 +139,7 @@ struct hd_drive_cmd_hdr {
 	__u8 sector_count;
 };
=20
+#ifndef __KERNEL__
 typedef struct hd_drive_task_hdr {
 	__u8 data;
 	__u8 feature;
@@ -160,6 +161,7 @@ typedef struct hd_drive_hob_hdr {
 	__u8 device_head;
 	__u8 control;
 } hob_struct_t;
+#endif
=20
 #define TASKFILE_INVALID		0x7fff
 #define TASKFILE_48			0x8000
Index: b/include/linux/ide.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -103,8 +103,6 @@ typedef unsigned char	byte;	/* used ever
 #define IDE_FEATURE_OFFSET	IDE_ERROR_OFFSET
 #define IDE_COMMAND_OFFSET	IDE_STATUS_OFFSET
=20
-#define IDE_CONTROL_OFFSET_HOB	(7)
-
 #define IDE_DATA_REG		(HWIF(drive)->io_ports[IDE_DATA_OFFSET])
 #define IDE_ERROR_REG		(HWIF(drive)->io_ports[IDE_ERROR_OFFSET])
 #define IDE_NSECTOR_REG		(HWIF(drive)->io_ports[IDE_NSECTOR_OFFSET])
@@ -1069,15 +1067,40 @@ extern void ide_end_drive_cmd(ide_drive_
  */
 extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
=20
+struct ide_taskfile {
+	u8	hob_data;	/*  0: high data byte (for TASKFILE IOCTL) */
+
+	u8	hob_feature;	/*  1-5: additional data to support LBA48 */
+	u8	hob_nsect;
+	u8	hob_lbal;
+	u8	hob_lbam;
+	u8	hob_lbah;
+
+	u8	data;		/*  6: low data byte (for TASKFILE IOCTL) */
+
+	union {			/* =A07: */
+		u8 error;	/*   read:  error */
+		u8 feature;	/*  write: feature */
+	};
+
+	u8	nsect;		/*  8: number of sectors */
+	u8	lbal;		/*  9: LBA low */
+	u8	lbam;		/* 10: LBA mid */
+	u8	lbah;		/* 11: LBA high */
+
+	u8	device;		/* 12: device select */
+
+	union {			/* 13: */
+		u8 status;	/* =A0read: status =A0*/
+		u8 command;	/* write: command */
+	};
+};
+
 typedef struct ide_task_s {
-/*
- *	struct hd_drive_task_hdr	tf;
- *	task_struct_t		tf;
- *	struct hd_drive_hob_hdr		hobf;
- *	hob_struct_t		hobf;
- */
-	u8			tfRegister[8];
-	u8			hobRegister[8];
+	union {
+		struct ide_taskfile	tf;
+		u8			tf_array[14];
+	};
 	ide_reg_valid_t		tf_out_flags;
 	ide_reg_valid_t		tf_in_flags;
 	int			data_phase;
