From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH 05/11] ide-cd: convert ide_cd_queue_pc to use blk_get_request
Date: Tue, 22 Apr 2008 09:26:36 +0900
Message-ID: <1208824002-3596-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo10.iij4u.or.jp ([210.138.174.78]:49525 "EHLO mo10.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756224AbYDVA2A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 20:28:00 -0400
In-Reply-To: <1208824002-3596-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This converts ide_cd_queue_pc to use blk_get_request to remove struct
request on the stack in the users of ide_cd_queue_pc, necessitating
changing the ide_cd_queue_pc prototype into a form that doesn't takes
a pointer to request struct. ide_cd_queue_pc works like scsi_execute.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c       |   84 +++++++++++++++++++------------------
 drivers/ide/ide-cd.h       |    3 +-
 drivers/ide/ide-cd_ioctl.c |   99 ++++++++++++++++++++-----------------------
 3 files changed, 92 insertions(+), 94 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 3960002..584c522 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -932,31 +932,46 @@ static void ide_cd_request_sense_fixup(struct request *rq)
 		}
 }
 
-int ide_cd_queue_pc(ide_drive_t *drive, struct request *rq)
+int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
+		    int write, void *buffer, unsigned bufflen,
+		    struct request_sense *sense, int timeout,
+		    unsigned int flags)
 {
-	struct request_sense sense;
+	struct cdrom_info *info = drive->driver_data;
+	struct request_sense local_sense;
 	int retries = 10;
-	unsigned int flags = rq->cmd_flags;
 
-	if (rq->sense == NULL)
-		rq->sense = &sense;
+	if (!sense)
+		sense = &local_sense;
 
 	/* Start of retry loop. */
 	do {
+		struct request *rq;
 		int error;
 		unsigned long time = jiffies;
-		rq->cmd_flags = flags;
+
+		rq = blk_get_request(drive->queue, write, __GFP_WAIT);
+
+		memcpy(rq->cmd, cmd, BLK_MAX_CDB);
+		rq->cmd_type = REQ_TYPE_ATA_PC;
+		rq->rq_disk = info->disk;
+		rq->sense = sense;
+		rq->cmd_flags |= flags;
+		rq->data = buffer;
+		rq->data_len = bufflen;
+		rq->timeout = timeout;
 
 		error = ide_do_drive_cmd(drive, rq, ide_wait);
 		time = jiffies - time;
 
 		/* FIXME: we should probably abort/retry or something 
 		 * in case of failure */
-		if (rq->cmd_flags & REQ_FAILED) {
+		if (flags & REQ_FAILED) {
 			/* The request failed.  Retry if it was due to a unit
 			   attention status
 			   (usually means media was changed). */
-			struct request_sense *reqbuf = rq->sense;
+			struct request_sense *reqbuf =
+				(struct request_sense *)sense;
 
 			if (reqbuf->sense_key == UNIT_ATTENTION)
 				cdrom_saw_media_change(drive);
@@ -974,10 +989,10 @@ int ide_cd_queue_pc(ide_drive_t *drive, struct request *rq)
 		}
 
 		/* End of retry loop. */
-	} while ((rq->cmd_flags & REQ_FAILED) && retries >= 0);
+	} while ((flags & REQ_FAILED) && retries >= 0);
 
 	/* Return an error if the command failed. */
-	return (rq->cmd_flags & REQ_FAILED) ? -EIO : 0;
+	return (flags & REQ_FAILED) ? -EIO : 0;
 }
 
 /*
@@ -1383,23 +1398,20 @@ void msf_from_bcd (struct atapi_msf *msf)
 
 int cdrom_check_status(ide_drive_t *drive, struct request_sense *sense)
 {
-	struct request req;
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *cdi = &info->devinfo;
+	unsigned char cmd[BLK_MAX_CDB];
 
-	ide_cd_init_rq(drive, &req);
-
-	req.sense = sense;
-	req.cmd[0] = GPCMD_TEST_UNIT_READY;
-	req.cmd_flags |= REQ_QUIET;
+	memset(cmd, 0, BLK_MAX_CDB);
+	cmd[0] = GPCMD_TEST_UNIT_READY;
 
 	/*
 	 * Sanyo 3 CD changer uses byte 7 of TEST_UNIT_READY to
 	 * switch CDs instead of supporting the LOAD_UNLOAD opcode.
 	 */
-	req.cmd[7] = cdi->sanyo_slot % 3;
+	cmd[7] = cdi->sanyo_slot % 3;
 
-	return ide_cd_queue_pc(drive, &req);
+	return ide_cd_queue_pc(drive, cmd, 0, NULL, 0, sense, 0, REQ_QUIET);
 }
 
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
@@ -1412,17 +1424,13 @@ static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
 	} capbuf;
 
 	int stat;
-	struct request req;
-
-	ide_cd_init_rq(drive, &req);
+	unsigned char cmd[BLK_MAX_CDB];
 
-	req.sense = sense;
-	req.cmd[0] = GPCMD_READ_CDVD_CAPACITY;
-	req.data = (char *)&capbuf;
-	req.data_len = sizeof(capbuf);
-	req.cmd_flags |= REQ_QUIET;
+	memset(cmd, 0, BLK_MAX_CDB);
+	cmd[0] = GPCMD_READ_CDVD_CAPACITY;
 
-	stat = ide_cd_queue_pc(drive, &req);
+	stat = ide_cd_queue_pc(drive, cmd, 0, &capbuf, sizeof(capbuf),
+			       sense, 0, REQ_QUIET);
 	if (stat == 0) {
 		*capacity = 1 + be32_to_cpu(capbuf.lba);
 		*sectors_per_frame =
@@ -1436,24 +1444,20 @@ static int cdrom_read_tocentry(ide_drive_t *drive, int trackno, int msf_flag,
 				int format, char *buf, int buflen,
 				struct request_sense *sense)
 {
-	struct request req;
+	unsigned char cmd[BLK_MAX_CDB];
 
-	ide_cd_init_rq(drive, &req);
+	memset(cmd, 0, BLK_MAX_CDB);
 
-	req.sense = sense;
-	req.data =  buf;
-	req.data_len = buflen;
-	req.cmd_flags |= REQ_QUIET;
-	req.cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
-	req.cmd[6] = trackno;
-	req.cmd[7] = (buflen >> 8);
-	req.cmd[8] = (buflen & 0xff);
-	req.cmd[9] = (format << 6);
+	cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
+	cmd[6] = trackno;
+	cmd[7] = (buflen >> 8);
+	cmd[8] = (buflen & 0xff);
+	cmd[9] = (format << 6);
 
 	if (msf_flag)
-		req.cmd[1] = 2;
+		cmd[1] = 2;
 
-	return ide_cd_queue_pc(drive, &req);
+	return ide_cd_queue_pc(drive, cmd, 0, buf, buflen, sense, 0, REQ_QUIET);
 }
 
 /* Try to read the entire TOC for the disk into our internal buffer. */
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index 22e3751..1f2abdd 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -148,7 +148,8 @@ void ide_cd_log_error(const char *, struct request *, struct request_sense *);
 
 /* ide-cd.c functions used by ide-cd_ioctl.c */
 void ide_cd_init_rq(ide_drive_t *, struct request *);
-int ide_cd_queue_pc(ide_drive_t *, struct request *);
+int ide_cd_queue_pc(ide_drive_t *, const unsigned char *, int, void *, unsigned,
+		    struct request_sense *, int, unsigned int);
 int ide_cd_read_toc(ide_drive_t *, struct request_sense *);
 int ide_cdrom_get_capabilities(ide_drive_t *, u8 *);
 void ide_cdrom_update_speed(ide_drive_t *, u8 *);
diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 6d147ce..9c044da 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -104,8 +104,8 @@ int cdrom_eject(ide_drive_t *drive, int ejectflag,
 {
 	struct cdrom_info *cd = drive->driver_data;
 	struct cdrom_device_info *cdi = &cd->devinfo;
-	struct request req;
 	char loej = 0x02;
+	unsigned char cmd[BLK_MAX_CDB];
 
 	if ((cd->cd_flags & IDE_CD_FLAG_NO_EJECT) && !ejectflag)
 		return -EDRIVE_CANT_DO_THIS;
@@ -114,17 +114,16 @@ int cdrom_eject(ide_drive_t *drive, int ejectflag,
 	if ((cd->cd_flags & IDE_CD_FLAG_DOOR_LOCKED) && ejectflag)
 		return 0;
 
-	ide_cd_init_rq(drive, &req);
-
 	/* only tell drive to close tray if open, if it can do that */
 	if (ejectflag && (cdi->mask & CDC_CLOSE_TRAY))
 		loej = 0;
 
-	req.sense = sense;
-	req.cmd[0] = GPCMD_START_STOP_UNIT;
-	req.cmd[4] = loej | (ejectflag != 0);
+	memset(cmd, 0, BLK_MAX_CDB);
+
+	cmd[0] = GPCMD_START_STOP_UNIT;
+	cmd[4] = loej | (ejectflag != 0);
 
-	return ide_cd_queue_pc(drive, &req);
+	return ide_cd_queue_pc(drive, cmd, 0, NULL, 0, sense, 0, 0);
 }
 
 /* Lock the door if LOCKFLAG is nonzero; unlock it otherwise. */
@@ -134,7 +133,6 @@ int ide_cd_lockdoor(ide_drive_t *drive, int lockflag,
 {
 	struct cdrom_info *cd = drive->driver_data;
 	struct request_sense my_sense;
-	struct request req;
 	int stat;
 
 	if (sense == NULL)
@@ -144,11 +142,15 @@ int ide_cd_lockdoor(ide_drive_t *drive, int lockflag,
 	if (cd->cd_flags & IDE_CD_FLAG_NO_DOORLOCK) {
 		stat = 0;
 	} else {
-		ide_cd_init_rq(drive, &req);
-		req.sense = sense;
-		req.cmd[0] = GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
-		req.cmd[4] = lockflag ? 1 : 0;
-		stat = ide_cd_queue_pc(drive, &req);
+		unsigned char cmd[BLK_MAX_CDB];
+
+		memset(cmd, 0, BLK_MAX_CDB);
+
+		cmd[0] = GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
+		cmd[4] = lockflag ? 1 : 0;
+
+		stat = ide_cd_queue_pc(drive, cmd, 0, NULL, 0,
+				       sense, 0, 0);
 	}
 
 	/* If we got an illegal field error, the drive
@@ -206,32 +208,30 @@ int ide_cdrom_select_speed(struct cdrom_device_info *cdi, int speed)
 {
 	ide_drive_t *drive = cdi->handle;
 	struct cdrom_info *cd = drive->driver_data;
-	struct request rq;
 	struct request_sense sense;
 	u8 buf[ATAPI_CAPABILITIES_PAGE_SIZE];
 	int stat;
-
-	ide_cd_init_rq(drive, &rq);
-
-	rq.sense = &sense;
+	unsigned char cmd[BLK_MAX_CDB];
 
 	if (speed == 0)
 		speed = 0xffff; /* set to max */
 	else
 		speed *= 177;   /* Nx to kbytes/s */
 
-	rq.cmd[0] = GPCMD_SET_SPEED;
+	memset(cmd, 0, BLK_MAX_CDB);
+
+	cmd[0] = GPCMD_SET_SPEED;
 	/* Read Drive speed in kbytes/second MSB/LSB */
-	rq.cmd[2] = (speed >> 8) & 0xff;
-	rq.cmd[3] = speed & 0xff;
+	cmd[2] = (speed >> 8) & 0xff;
+	cmd[3] = speed & 0xff;
 	if ((cdi->mask & (CDC_CD_R | CDC_CD_RW | CDC_DVD_R)) !=
 	    (CDC_CD_R | CDC_CD_RW | CDC_DVD_R)) {
 		/* Write Drive speed in kbytes/second MSB/LSB */
-		rq.cmd[4] = (speed >> 8) & 0xff;
-		rq.cmd[5] = speed & 0xff;
+		cmd[4] = (speed >> 8) & 0xff;
+		cmd[5] = speed & 0xff;
 	}
 
-	stat = ide_cd_queue_pc(drive, &rq);
+	stat = ide_cd_queue_pc(drive, cmd, 0, NULL, 0, &sense, 0, 0);
 
 	if (!ide_cdrom_get_capabilities(drive, buf)) {
 		ide_cdrom_update_speed(drive, buf);
@@ -268,21 +268,18 @@ int ide_cdrom_get_mcn(struct cdrom_device_info *cdi,
 {
 	ide_drive_t *drive = cdi->handle;
 	int stat, mcnlen;
-	struct request rq;
 	char buf[24];
+	unsigned char cmd[BLK_MAX_CDB];
 
-	ide_cd_init_rq(drive, &rq);
+	memset(cmd, 0, BLK_MAX_CDB);
 
-	rq.data = buf;
-	rq.data_len = sizeof(buf);
+	cmd[0] = GPCMD_READ_SUBCHANNEL;
+	cmd[1] = 2;		/* MSF addressing */
+	cmd[2] = 0x40;	/* request subQ data */
+	cmd[3] = 2;		/* format */
+	cmd[8] = sizeof(buf);
 
-	rq.cmd[0] = GPCMD_READ_SUBCHANNEL;
-	rq.cmd[1] = 2;		/* MSF addressing */
-	rq.cmd[2] = 0x40;	/* request subQ data */
-	rq.cmd[3] = 2;		/* format */
-	rq.cmd[8] = sizeof(buf);
-
-	stat = ide_cd_queue_pc(drive, &rq);
+	stat = ide_cd_queue_pc(drive, cmd, 0, buf, sizeof(buf), NULL, 0, 0);
 	if (stat)
 		return stat;
 
@@ -351,8 +348,8 @@ static int ide_cd_fake_play_trkind(ide_drive_t *drive, void *arg)
 	struct atapi_toc_entry *first_toc, *last_toc;
 	unsigned long lba_start, lba_end;
 	int stat;
-	struct request rq;
 	struct request_sense sense;
+	unsigned char cmd[BLK_MAX_CDB];
 
 	stat = ide_cd_get_toc_entry(drive, ti->cdti_trk0, &first_toc);
 	if (stat)
@@ -370,14 +367,13 @@ static int ide_cd_fake_play_trkind(ide_drive_t *drive, void *arg)
 	if (lba_end <= lba_start)
 		return -EINVAL;
 
-	ide_cd_init_rq(drive, &rq);
+	memset(cmd, 0, BLK_MAX_CDB);
 
-	rq.sense = &sense;
-	rq.cmd[0] = GPCMD_PLAY_AUDIO_MSF;
-	lba_to_msf(lba_start,   &rq.cmd[3], &rq.cmd[4], &rq.cmd[5]);
-	lba_to_msf(lba_end - 1, &rq.cmd[6], &rq.cmd[7], &rq.cmd[8]);
+	cmd[0] = GPCMD_PLAY_AUDIO_MSF;
+	lba_to_msf(lba_start,   &cmd[3], &cmd[4], &cmd[5]);
+	lba_to_msf(lba_end - 1, &cmd[6], &cmd[7], &cmd[8]);
 
-	return ide_cd_queue_pc(drive, &rq);
+	return ide_cd_queue_pc(drive, cmd, 0, NULL, 0, &sense, 0, 0);
 }
 
 static int ide_cd_read_tochdr(ide_drive_t *drive, void *arg)
@@ -447,8 +443,8 @@ int ide_cdrom_audio_ioctl(struct cdrom_device_info *cdi,
 int ide_cdrom_packet(struct cdrom_device_info *cdi,
 			    struct packet_command *cgc)
 {
-	struct request req;
 	ide_drive_t *drive = cdi->handle;
+	unsigned int flags = 0;
 
 	if (cgc->timeout <= 0)
 		cgc->timeout = ATAPI_WAIT_PC;
@@ -456,24 +452,21 @@ int ide_cdrom_packet(struct cdrom_device_info *cdi,
 	/* here we queue the commands from the uniform CD-ROM
 	   layer. the packet must be complete, as we do not
 	   touch it at all. */
-	ide_cd_init_rq(drive, &req);
 
 	if (cgc->data_direction == CGC_DATA_WRITE)
-		req.cmd_flags |= REQ_RW;
+		flags |= REQ_RW;
 
-	memcpy(req.cmd, cgc->cmd, CDROM_PACKET_SIZE);
 	if (cgc->sense)
 		memset(cgc->sense, 0, sizeof(struct request_sense));
-	req.data = cgc->buffer;
-	req.data_len = cgc->buflen;
-	req.timeout = cgc->timeout;
 
 	if (cgc->quiet)
-		req.cmd_flags |= REQ_QUIET;
+		flags |= REQ_QUIET;
 
-	req.sense = cgc->sense;
-	cgc->stat = ide_cd_queue_pc(drive, &req);
+	cgc->stat = ide_cd_queue_pc(drive, cgc->cmd,
+				    cgc->data_direction == CGC_DATA_WRITE,
+				    cgc->buffer, cgc->buflen,
+				    cgc->sense, cgc->timeout, flags);
 	if (!cgc->stat)
-		cgc->buflen -= req.data_len;
+		cgc->buflen = 0;
 	return cgc->stat;
 }
-- 
1.5.4.2

