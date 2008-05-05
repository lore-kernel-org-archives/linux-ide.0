From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH v2 00/13] removing the on-stack struct request
Date: Mon, 5 May 2008 22:02:54 +0900
Message-ID: <20080505220240D.tomof@acm.org>
References: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<200805031510.02167.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo10.iij4u.or.jp ([210.138.174.78]:50804 "EHLO mo10.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753571AbYEENDW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 May 2008 09:03:22 -0400
In-Reply-To: <200805031510.02167.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: fujita.tomonori@lab.ntt.co.jp, linux-ide@vger.kernel.org, jens.axboe@oracle.com, petkovbb@gmail.com

On Sat, 3 May 2008 15:10:02 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> 
> Hi,
> 
> On Thursday 01 May 2008, FUJITA Tomonori wrote:
> > This is an updated version of the patchset to clean up the asymmetry
> > of blk_get/put_request usage:
> > 
> > http://marc.info/?l=linux-ide&m=120882410712466&w=2
> > 
> > This patchset removes the code calling blk_put_request against the
> > requests that are not allocated via blk_get_request. They can use
> > __GFP_WAIT allocation so we can easily convert them to
> > use blk_get/put_request properly.
> > 
> > This patchset enables us to remove the following hack in
> > blk_put_request:
> > 
> > /*
> >  * Gee, IDE calls in w/ NULL q.  Fix IDE and remove the
> >  * following if (q) test.
> >  */
> > if (q) {
> > 	spin_lock_irqsave(q->queue_lock, flags);
> > 	__blk_put_request(q, req);
> > 	spin_unlock_irqrestore(q->queue_lock, flags);
> > }
> > 
> > The major changes are:
> > 
> > - I remove the ide_wait/head_wait path in ide_do_drive_cmd(). It does
> > the same thing that blk_execute_rq() does. So let's simply use
> > blk_execute_rq(). The nice side effect is that I unexport
> > blk_end_sync_rq() since I converted all the users.
> > 
> > - I drop the unnecessary patch to make ide_do_drive_cmd return
> > rq->errors:
> > 
> > http://marc.info/?l=linux-ide&m=120882410612456&w=2
> > 
> > #1-10 are for the ide subsystem and #11-13 for the block layer. This
> > is against the lastest Linus tree.
> 
> Thanks.
> 
> I applied patches #1-10 after making ide_do_drive_cmd() more similar to
> blk_execute_rq() (to ease the conversion - it is really better to handle
> subtle changes first). [ I'll send these pre-patches in separate mails. ]

Thanks for applying the patches.


> However I'm still not quite sure about following change in patch #1:
> 
> @@ -456,24 +452,21 @@ int ide_cdrom_packet(struct cdrom_device_info *cdi,
> ...
> -	cgc->stat = ide_cd_queue_pc(drive, &req);
> +	cgc->stat = ide_cd_queue_pc(drive, cgc->cmd,
> +				    cgc->data_direction == CGC_DATA_WRITE,
> +				    cgc->buffer, cgc->buflen,
> +				    cgc->sense, cgc->timeout, flags);
>  	if (!cgc->stat)
> -		cgc->buflen -= req.data_len;
> +		cgc->buflen = 0;
> ...
> 
> IIRC rq->data_len may be modified while the request is processed?

I think that rq->data_len is modified only when a request is
successful but I might overlook or misunderstand something. How about
the attached patch (against the latest your quilt patchset)? It's a
bit hacky but it should work as before.


> [ The only other (minor) complaint is that patches #9-10 should be at the
>   beginning of the patch series but since no patches contained problems it
>   wouldn't be wise to ask respin just for that (and I'm too lazy to review
>   it all again ;-). ]

Thanks.

If you are ok with the attached patch, I'm happy to incorporate it
into the patchset and send a new version as you like.


==
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: ide: let ide_cd_queue_pc return rq->data_len

ide_cdrom_packet needs rq->data_len after the completion so this patch
makes ide_cd_queue_pc return rq->data_len.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 7c5ab78..ac542ff 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -832,7 +832,7 @@ static void ide_cd_request_sense_fixup(struct request *rq)
 }
 
 int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
-		    int write, void *buffer, unsigned bufflen,
+		    int write, void *buffer, unsigned *bufflen,
 		    struct request_sense *sense, int timeout,
 		    unsigned int cmd_flags)
 {
@@ -855,12 +855,17 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 		rq->cmd_type = REQ_TYPE_ATA_PC;
 		rq->sense = sense;
 		rq->cmd_flags |= cmd_flags;
-		rq->data = buffer;
-		rq->data_len = bufflen;
 		rq->timeout = timeout;
+		if (buffer) {
+			rq->data = buffer;
+			rq->data_len = *bufflen;
+		}
 
 		error = blk_execute_rq(drive->queue, info->disk, rq, 0);
 
+		if (buffer)
+			*bufflen = rq->data_len;
+
 		flags = rq->cmd_flags;
 		blk_put_request(rq);
 
@@ -1303,12 +1308,13 @@ static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
 
 	int stat;
 	unsigned char cmd[BLK_MAX_CDB];
+	unsigned len = sizeof(capbuf);
 
 	memset(cmd, 0, BLK_MAX_CDB);
 	cmd[0] = GPCMD_READ_CDVD_CAPACITY;
 
-	stat = ide_cd_queue_pc(drive, cmd, 0, &capbuf, sizeof(capbuf),
-			       sense, 0, REQ_QUIET);
+	stat = ide_cd_queue_pc(drive, cmd, 0, &capbuf, &len, sense, 0,
+			       REQ_QUIET);
 	if (stat == 0) {
 		*capacity = 1 + be32_to_cpu(capbuf.lba);
 		*sectors_per_frame =
@@ -1335,7 +1341,7 @@ static int cdrom_read_tocentry(ide_drive_t *drive, int trackno, int msf_flag,
 	if (msf_flag)
 		cmd[1] = 2;
 
-	return ide_cd_queue_pc(drive, cmd, 0, buf, buflen, sense, 0, REQ_QUIET);
+	return ide_cd_queue_pc(drive, cmd, 0, buf, &buflen, sense, 0, REQ_QUIET);
 }
 
 /* Try to read the entire TOC for the disk into our internal buffer. */
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index a7971d7..94f5e4e 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -143,7 +143,7 @@ struct cdrom_info {
 void ide_cd_log_error(const char *, struct request *, struct request_sense *);
 
 /* ide-cd.c functions used by ide-cd_ioctl.c */
-int ide_cd_queue_pc(ide_drive_t *, const unsigned char *, int, void *, unsigned,
+int ide_cd_queue_pc(ide_drive_t *, const unsigned char *, int, void *, unsigned *,
 		    struct request_sense *, int, unsigned int);
 int ide_cd_read_toc(ide_drive_t *, struct request_sense *);
 int ide_cdrom_get_capabilities(ide_drive_t *, u8 *);
diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 4571b4f..24d002a 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -270,6 +270,7 @@ int ide_cdrom_get_mcn(struct cdrom_device_info *cdi,
 	int stat, mcnlen;
 	char buf[24];
 	unsigned char cmd[BLK_MAX_CDB];
+	unsigned len = sizeof(buf);
 
 	memset(cmd, 0, BLK_MAX_CDB);
 
@@ -277,9 +278,9 @@ int ide_cdrom_get_mcn(struct cdrom_device_info *cdi,
 	cmd[1] = 2;		/* MSF addressing */
 	cmd[2] = 0x40;	/* request subQ data */
 	cmd[3] = 2;		/* format */
-	cmd[8] = sizeof(buf);
+	cmd[8] = len;
 
-	stat = ide_cd_queue_pc(drive, cmd, 0, buf, sizeof(buf), NULL, 0, 0);
+	stat = ide_cd_queue_pc(drive, cmd, 0, buf, &len, NULL, 0, 0);
 	if (stat)
 		return stat;
 
@@ -445,6 +446,7 @@ int ide_cdrom_packet(struct cdrom_device_info *cdi,
 {
 	ide_drive_t *drive = cdi->handle;
 	unsigned int flags = 0;
+	unsigned len = cgc->buflen;
 
 	if (cgc->timeout <= 0)
 		cgc->timeout = ATAPI_WAIT_PC;
@@ -464,9 +466,9 @@ int ide_cdrom_packet(struct cdrom_device_info *cdi,
 
 	cgc->stat = ide_cd_queue_pc(drive, cgc->cmd,
 				    cgc->data_direction == CGC_DATA_WRITE,
-				    cgc->buffer, cgc->buflen,
+				    cgc->buffer, &len,
 				    cgc->sense, cgc->timeout, flags);
 	if (!cgc->stat)
-		cgc->buflen = 0;
+		cgc->buflen -= len;
 	return cgc->stat;
 }
