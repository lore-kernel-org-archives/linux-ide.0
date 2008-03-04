From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: -rc3 regression (was Re: 2.6.25-rc2 + smartd = hang )
Date: Tue, 4 Mar 2008 23:46:21 +0100
Message-ID: <200803042346.21403.bzolnier@gmail.com>
References: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org> <200803040133.07736.bzolnier@gmail.com> <20080304095701.DDF762DC027@tippex.mynet.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:9099 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbYCDWcu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Mar 2008 17:32:50 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2933579ugc.16
        for <linux-ide@vger.kernel.org>; Tue, 04 Mar 2008 14:32:46 -0800 (PST)
In-Reply-To: <20080304095701.DDF762DC027@tippex.mynet.homeunix.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anders Eriksson <aeriksson@fastmail.fm>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>


Hi,

On Tuesday 04 March 2008, Anders Eriksson wrote:
> 
> bzolnier@gmail.com said:
> >> On Tuesday 04 March 2008, Bartlomiej Zolnierkiewicz wrote:
> >> Untested patch which may help in case that set_pio_mode() raced with
> >> the queueing of the special request and block layer doesn't call
> >> ->request_fn_proc again if we were preempted previously (if PREEMPT=y).
> 
> > I need some sleep...  this patch is not going to help (though disabling
> > PREEMPT may be worth a try).  Sorry for the confusion.
> 
> Ok, I'll drop the patch and, recompile without PREEMPT.
> 
> 
> bzolnier@gmail.com said:
> > If the patch doesn't help could you try removing smartd from system startup
> > and see if it could be run later from the command line? 
> 
> That's how I executed during the bisect. It works as a charm without smartd. 
> The moment I run it, boink, the first accessed hd freezed up. The other ones 
> are usable for a while, though the system tend to lock solid after a while.

Thanks, this (and no success with PREEMPT_NONE) changes the perspective a bit.

Could you set your kernel tree to the guilty commit
34f5d5ae35240a11846875d76eb935875ab0c366:

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 027bf43..717e114 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -620,8 +620,10 @@ static int set_multcount(ide_drive_t *drive, int arg)

        if (drive->special.b.set_multmode)
                return -EBUSY;
+
        ide_init_drive_cmd (&rq);
-       rq.cmd_type = REQ_TYPE_ATA_CMD;
+       rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
+
        drive->mult_req = arg;
        drive->special.b.set_multmode = 1;
        (void) ide_do_drive_cmd (drive, &rq, ide_wait);
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index b8c7e81..9404650 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -781,7 +781,7 @@ int ide_cmd_ioctl (ide_drive_t *drive, unsigned int cmd, uns
                struct request rq;

                ide_init_drive_cmd(&rq);
-               rq.cmd_type = REQ_TYPE_ATA_CMD;
+               rq.cmd_type = REQ_TYPE_ATA_TASKFILE;

                return ide_do_drive_cmd(drive, &rq, ide_wait);
        }
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index 446b128..97894ab 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -880,7 +880,7 @@ int set_pio_mode(ide_drive_t *drive, int arg)
                return -EBUSY;

        ide_init_drive_cmd(&rq);
-       rq.cmd_type = REQ_TYPE_ATA_CMD;
+       rq.cmd_type = REQ_TYPE_ATA_TASKFILE;

        drive->tune_req = (u8) arg;
        drive->special.b.set_tune = 1;

and see if manually reverting only ide-taskfile.c change fixes the problem
(so we know that we are looking at the right place).

Also Alt-SysRq-T output for the hang would probably be very useful to tell
what is going on, maybe it is possible to still get it before system fully
stops?

I must admit that after auditing the patch & code for n-th time I still fail
to see the source of the problem (especialy now that the theory about exposing
races in the tuning code has also failed) as the _only_ changes introduced by
the guilty commit are that we are using different rq->cmd_type and testing for
rq->special instead of rq->buffer but both should be NULL. [ as it can be seen
be looking at ide_cmd_ioctl(), execute_drive_cmd() and ide_end_drive_cmd() ]

If anybody has some ideas on what could be wrong please help, in the meantime
I'm going to take a look at smartd code...

Thanks,
Bart
