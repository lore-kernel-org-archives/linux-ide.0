From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: Bug 11581
Date: Sun, 26 Oct 2008 16:46:57 +0100
Message-ID: <20081026154657.GA2578@gollum.tnic>
References: <Pine.LNX.4.64.0810141314590.2555@cantor.unex.es> <9ea470500810140453m6e1f7eb6raf179ee78414e19e@mail.gmail.com> <Pine.LNX.4.64.0810141709450.4529@cantor.unex.es>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:4290 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbYJZPrD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Oct 2008 11:47:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1610894fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 26 Oct 2008 08:47:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0810141709450.4529@cantor.unex.es>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Santiago Vila <sanvila@unex.es>
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

On Tue, Oct 14, 2008 at 05:11:10PM +0200, Santiago Vila wrote:
> On Tue, 14 Oct 2008, Boris Petkov wrote:
> 
> > Ok, we see now where the problem hides. Nice! However, IIRC, you can boot 2.6.18
> > with the same Debian unstable setup (correct?) which means that the drive
> > receives the same commands.
> 
> It's Debian testing, which is very very close to Debian unstable.
> 
> Yes, I will gladly try a patched 2.6.18 keeping everything else the same.

Hi Santiago,

sorry for the long delay but I've been really busy lately. I finally
had the time to do a debug patch for you to try under 2.6.18 so that
we could see why do newer ones fail wrt some commands. The patch below
should apply ontop of 2.6.18, please try it out and mail me your dmesg
back.

Thanks.

---
 drivers/ide/ide-cd.c |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 654d4cd..33f551d 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -331,6 +331,11 @@ static DEFINE_MUTEX(idecd_ref_mutex);
 #define ide_cd_g(disk) \
 	container_of((disk)->private_data, struct cdrom_info, driver)
 
+#define ide_dbg_log(fmt, args...)						\
+{										\
+	printk(KERN_INFO "ide-cd: " fmt, ## args);				\
+}
+
 static struct cdrom_info *ide_cd_get(struct gendisk *disk)
 {
 	struct cdrom_info *cd = NULL;
@@ -607,6 +612,8 @@ static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
 	struct cdrom_info *info		= drive->driver_data;
 	struct request *rq		= &info->request_sense_request;
 
+	ide_dbg_log("Call %s\n", __func__);
+
 	if (sense == NULL)
 		sense = &info->sense_data;
 
@@ -622,6 +629,10 @@ static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
 	/* NOTE! Save the failed command in "rq->buffer" */
 	rq->buffer = (void *) failed_command;
 
+	if (failed_command)
+		ide_dbg_log("%s: failed_cmd: 0x%x\n", __func__,
+			    failed_command->cmd[0]);
+
 	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
 }
 
@@ -706,6 +717,10 @@ static int cdrom_decode_status(ide_drive_t *drive, int good_stat, int *stat_ret)
 		return 1;
 	}
 
+	ide_dbg_log("Call %s, stat: 0x%x, good_stat: 0x%x, rq->cmd[0]: 0x%x,"
+		    "rq->flags: 0x%lx, err: 0x%x\n", __func__, stat, good_stat,
+		    rq->cmd[0], rq->flags, err);
+
 	if (rq->flags & REQ_SENSE) {
 		/* We got an error trying to get sense info
 		   from the drive (probably while trying
@@ -904,6 +919,8 @@ static ide_startstop_t cdrom_start_packet_command(ide_drive_t *drive,
 	struct cdrom_info *info = drive->driver_data;
 	ide_hwif_t *hwif = drive->hwif;
 
+	ide_dbg_log("Call %s: xferlen: %d\n", __func__, xferlen);
+
 	/* Wait for the controller to be idle. */
 	if (ide_wait_stat(&startstop, drive, 0, BUSY_STAT, WAIT_READY))
 		return startstop;
@@ -958,6 +975,8 @@ static ide_startstop_t cdrom_transfer_packet_command (ide_drive_t *drive,
 	struct cdrom_info *info = drive->driver_data;
 	ide_startstop_t startstop;
 
+	ide_dbg_log("Call %s, rq->cmd[0]: 0x%x\n", __func__, rq->cmd[0]);
+
 	if (CDROM_CONFIG_FLAGS(drive)->drq_interrupt) {
 		/* Here we should have been called after receiving an interrupt
 		   from the device.  DRQ should how be set. */
@@ -1963,6 +1982,9 @@ static ide_startstop_t cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 {
 	struct cdrom_info *info = drive->driver_data;
 
+	ide_dbg_log("Call %s, rq->cmd[0]: 0x%x, rq->flags: 0x%lx, rq->bio: %p\n",
+		    __func__, rq->cmd[0], rq->flags, (rq->bio ? rq->bio : 0));
+
 	rq->flags |= REQ_QUIET;
 
 	info->dma = 0;
@@ -1982,8 +2004,13 @@ static ide_startstop_t cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 		 * NOTE! The "len" and "addr" checks should possibly have
 		 * separate masks.
 		 */
-		if ((rq->data_len & 15) || (addr & mask))
+		if ((rq->data_len & 15) || (addr & mask)) {
+			ide_dbg_log("Turning off dma for cmd 0x%x,"
+				    "rq->data_len: 0x%x, addr: 0x%lx"
+				    "mask: 0x%x\n",
+				    rq->cmd[0], rq->data_len, addr, mask);
 			info->dma = 0;
+		}
 	}
 
 	/* Start sending the command to the drive. */
@@ -1999,6 +2026,9 @@ ide_do_rw_cdrom (ide_drive_t *drive, struct request *rq, sector_t block)
 	ide_startstop_t action;
 	struct cdrom_info *info = drive->driver_data;
 
+	ide_dbg_log("Call %s, rq->cmd[0]: 0x%x, rq->flags: 0x%lx, block: %llu\n",
+		    __func__, rq->cmd[0], rq->flags, (unsigned long long)block);
+
 	if (blk_fs_request(rq)) {
 		if (CDROM_CONFIG_FLAGS(drive)->seeking) {
 			unsigned long elapsed = jiffies - info->start_seek;
@@ -2026,6 +2056,16 @@ ide_do_rw_cdrom (ide_drive_t *drive, struct request *rq, sector_t block)
 	} else if (rq->flags & (REQ_PC | REQ_SENSE)) {
 		return cdrom_do_packet_command(drive);
 	} else if (rq->flags & REQ_BLOCK_PC) {
+
+		printk(KERN_ERR "BLOCK PC:\n");
+		blk_dump_rq_flags(rq, "Original rq: ");
+		printk(KERN_ERR "rq->cmd_len: %d\n", rq->cmd_len);
+
+		if (rq->cmd[0] == GPCMD_GET_CONFIGURATION) {
+			printk(KERN_ERR "GET_CONFIGURATION cmd!\n");
+			dump_stack();
+		}
+
 		return cdrom_do_block_pc(drive, rq);
 	} else if (rq->flags & REQ_SPECIAL) {
 		/*
-- 
1.5.6.5


-- 
Regards/Gruss,
    Boris.
