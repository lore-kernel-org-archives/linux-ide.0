From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 02/15] ide-tape: remove back-to-back REQUEST_SENSE
	detection
Date: Sat, 18 Apr 2009 21:48:40 +0200
Message-ID: <20090418194839.GA2848@liondog.tnic>
References: <1239960802-31978-1-git-send-email-tj@kernel.org> <1239960802-31978-3-git-send-email-tj@kernel.org> <9ea470500904170323k2adbe63q5488c63fe368d328@mail.gmail.com> <49E85B6F.7080603@kernel.org> <49E85CA7.2060801@gmail.com> <9ea470500904170403n621f84det8cfec405131d893c@mail.gmail.com> <49E8F0A7.5040208@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f211.google.com ([209.85.218.211]:46587 "EHLO
	mail-bw0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021AbZDRTyv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Apr 2009 15:54:51 -0400
Received: by bwz7 with SMTP id 7so607205bwz.37
        for <linux-ide@vger.kernel.org>; Sat, 18 Apr 2009 12:54:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49E8F0A7.5040208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hi,

On Sat, Apr 18, 2009 at 06:12:07AM +0900, Tejun Heo wrote:
> Hello,
> 
> Borislav Petkov wrote:
> > Honestly, I don't know. The code predates even the initial git
> > commit of the kernel so I guess nobody knows?
> 
> Heh.. maybe Mark does.
> 
> > And yeah, such a check looks a bit too much so I won't have any
> > problem with removing it. Nevertheless, we need the small fix above
> > in the ->do_request callback for all other packet commands since
> > ide-tape uses currently ide_queue_pc_tail() for sending those. I
> > know, I know, it is ugly and we're working on it :).
> 
> Can you explain a bit more about the bug?  I'm not really following.

sorry for I wasn't that clear. We need the drive->pc ptr valid in order to
retry a packet command couple lines below in the ->do_request callback:

        /* Retry a failed packet command */
        if (drive->failed_pc && drive->pc->c[0] == REQUEST_SENSE) {
                pc = drive->failed_pc;
                goto out;
        }

Generally, throughout the request path of a command through the driver,
drive->pc points to it, that's why we need that assignment. As I said
before, this'll be fixed rather sooner than later so consider it a
temporary hack :). Something like the following, for example, should
suffice for now IMHO.

--
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index cb942a9..40e6de7 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -753,6 +753,9 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
 	struct ide_cmd cmd;
 	u8 stat;
 
+	if (rq->cmd_type == REQ_TYPE_SPECIAL)
+		drive->pc = pc = (struct ide_atapi_pc *) rq->buffer;
+
 	debug_log(DBG_SENSE, "sector: %llu, nr_sectors: %lu,"
 			" current_nr_sectors: %u\n",
 			(unsigned long long)rq->sector, rq->nr_sectors,
@@ -769,7 +772,7 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
 	}
 
 	/* Retry a failed packet command */
-	if (drive->failed_pc && drive->pc->c[0] == REQUEST_SENSE) {
+	if (drive->failed_pc && pc->c[0] == REQUEST_SENSE) {
 		pc = drive->failed_pc;
 		goto out;
 	}

-- 
Regards/Gruss,
    Boris.
