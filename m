From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide: Remove ide_spin_wait_hwgroup() and use special requests instead
Date: Wed, 13 Aug 2008 22:32:32 +0200
Message-ID: <200808132232.33425.bzolnier@gmail.com>
References: <87iqu73128.fsf@denkblock.local> <200808130041.07424.bzolnier@gmail.com> <87tzdp0wgo.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:20236 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbYHMVGO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Aug 2008 17:06:14 -0400
Received: by ug-out-1314.google.com with SMTP id h2so172535ugf.16
        for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 14:06:12 -0700 (PDT)
In-Reply-To: <87tzdp0wgo.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org

On Wednesday 13 August 2008, Elias Oltmanns wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > Hi,
> >
> > On Monday 11 August 2008, Elias Oltmanns wrote:
> [...]
> >> On a different matter, I've encountered several places where requests
> >> are being allocated with __GFP_WAIT for no obvious reason. Wouldn't it
> >> be more suitable to allocate them with GFP_KERNEL and fail with -ENOMEM
> >> in case of an error? Or is there some policy I'm not aware of?
> >
> > Without more details it is hard to tell, maybe it has something to do
> > with GFP_KERNEL also using __GFP_IO?
> 
> I'll follow up with a patch to discuss the matter further.
> 
> [...]
> >> diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
> >> index ec6664b..5451e50 100644
> >> --- a/drivers/ide/ide-io.c
> >> +++ b/drivers/ide/ide-io.c
> >> @@ -716,9 +716,63 @@ static ide_startstop_t execute_drive_cmd (ide_drive_t *drive,
> >>   	return ide_stopped;
> >>  }
> >>  
> >> +typedef struct {
> >> +	u8 opcode;	/* always == REQ_DEVSET_EXEC */
> >> +	int arg;
> >> +} ide_devset_cdb_t;
> >
> > Generally we don't want new typedefs in kernel
> > and here we shouldn't even need new struct.
> 
> As far as typedefs are concerned, fair enough. With regard to the
> struct, see below.
> 
> >
> >> +#define DEVSET_CDB_LEN (sizeof(ide_devset_cdb_t))
> >> +
> >> +int ide_devset_execute(ide_drive_t *drive, const struct ide_devset *setting,
> >> +		       int arg)
> >> +{
> >> +	struct request_queue *q = drive->queue;
> >> +	struct request *rq;
> >> +	ide_devset_cdb_t *ds;
> >> +	int ret = 0;
> >> +
> >> +	if (!capable(CAP_SYS_ADMIN))
> >> +		return -EACCES;
> >> +	if (!(setting->flags & DS_SYNC))
> >> +		return setting->set(drive, arg);
> >> +
> >> +	rq = blk_get_request(q, READ, GFP_KERNEL);
> >> +	if (!rq)
> >> +		return -ENOMEM;
> >> +
> >> +	rq->cmd_type = REQ_TYPE_SPECIAL;
> >> +	BUILD_BUG_ON(DEVSET_CDB_LEN > BLK_MAX_CDB);
> >
> > BLK_MAX_CDB would never be < 16 so this seems overcautious
> >
> >> +	rq->cmd_len = DEVSET_CDB_LEN;
> >> +	ds = (ide_devset_cdb_t *)rq->cmd;
> >> +	ds->opcode = REQ_DEVSET_EXEC;
> >> +	ds->arg = arg;
> >
> > How's about just doing:
> >
> > 	rq->cmd[0] = REQ_DEVSET_EXEC;
> > 	(int *)rq->cmd[1] = arg;
> 
>   CC [M]  drivers/ide/ide-io.o
> drivers/ide/ide-io.c: In function 'ide_devset_execute':
> drivers/ide/ide-io.c:748: warning: cast to pointer from integer of different size
> drivers/ide/ide-io.c:748: error: lvalue required as left operand of assignment

Heh, I must have been falling asleep already when writing this,
it should have been:

	*(int *)&rq->cmd[1] = arg;

> Personally, I'd feel more comfortable with casting rq->cmd to a
> dedicated struct, especially since I'm not exactly a wizard when it
> comes to casting. Naturally, if you prefer something else (and I get it
> to work), I'll happily accept that too.

What I find ugly about this dedicated struct is that it overlaps with
rq->cmd[0] and in all other places we just use rq->cmd[0] directly
(+ it is very easy for people unfamiliar with the code to overlook it).

Then if 'opcode' gets removed all that is left is 'arg' so the struct
no loger makes much sense.

I fixed it locally (interdiff attached), I hope you're fine with it.

> Thanks for reviewing. Find the revised patch below (applies to
> next-20080813).
> 
> Elias
> 
> 
> From: Elias Oltmanns <eo@nebensachen.de>
> Subject: ide: Remove ide_spin_wait_hwgroup() and use special requests instead
> 
> Use a special request for serialisation purposes and get rid of the
> awkward ide_spin_wait_hwgroup(). This also involves converting the
> ide_devset structure so it can be shared by the /proc and the ioctl code.
> 
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>

Thanks, applied.


diff -u b/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- b/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -716,19 +716,11 @@
  	return ide_stopped;
 }
 
-struct ide_devset_cdb {
-	u8 opcode;	/* always == REQ_DEVSET_EXEC */
-	int arg;
-};
-
-#define DEVSET_CDB_LEN sizeof(struct ide_devset_cdb)
-
 int ide_devset_execute(ide_drive_t *drive, const struct ide_devset *setting,
 		       int arg)
 {
 	struct request_queue *q = drive->queue;
 	struct request *rq;
-	struct ide_devset_cdb *ds;
 	int ret = 0;
 
 	if (!(setting->flags & DS_SYNC))
@@ -739,10 +731,9 @@
 		return -ENOMEM;
 
 	rq->cmd_type = REQ_TYPE_SPECIAL;
-	rq->cmd_len = DEVSET_CDB_LEN;
-	ds = (struct ide_devset_cdb *)rq->cmd;
-	ds->opcode = REQ_DEVSET_EXEC;
-	ds->arg = arg;
+	rq->cmd_len = 5;
+	rq->cmd[0] = REQ_DEVSET_EXEC;
+	*(int *)&rq->cmd[1] = arg;
 	rq->special = setting->set;
 
 	if (blk_execute_rq(q, NULL, rq, 0))
@@ -758,10 +749,9 @@
 	switch (rq->cmd[0]) {
 	case REQ_DEVSET_EXEC:
 	{
-		struct ide_devset_cdb *ds = (struct ide_devset_cdb *)rq->cmd;
 		int err, (*setfunc)(ide_drive_t *, int) = rq->special;
 
-		err = setfunc(drive, ds->arg);
+		err = setfunc(drive, *(int *)&rq->cmd[1]);
 		if (err)
 			rq->errors = err;
 		else
