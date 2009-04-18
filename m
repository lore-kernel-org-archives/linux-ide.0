From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 02/15] ide-tape: remove back-to-back REQUEST_SENSE detection
Date: Sat, 18 Apr 2009 18:51:49 +0200
Message-ID: <200904181851.50010.bzolnier@gmail.com>
References: <1239960802-31978-1-git-send-email-tj@kernel.org> <1239960802-31978-3-git-send-email-tj@kernel.org> <9ea470500904170323k2adbe63q5488c63fe368d328@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:61111 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbZDRQyh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Apr 2009 12:54:37 -0400
Received: by fk-out-0910.google.com with SMTP id 18so597853fkq.5
        for <linux-ide@vger.kernel.org>; Sat, 18 Apr 2009 09:54:36 -0700 (PDT)
In-Reply-To: <9ea470500904170323k2adbe63q5488c63fe368d328@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Tejun Heo <tj@kernel.org>, axboe@kernel.dk, linux-ide@vger.kernel.org

On Friday 17 April 2009 12:23:13 Borislav Petkov wrote:
> Hi,
> 
> On Fri, Apr 17, 2009 at 11:33 AM, Tejun Heo <tj@kernel.org> wrote:
> > Impact: fix an oops which always triggers
> >
> > ide_tape_issue_pc() assumed drive->pc isn't NULL on invocation when
> > checking for back-to-back request sense issues but drive->pc can be
> > NULL and even when it's not NULL, it's not safe to dereference it once
> > the previous command is complete because pc could have been freed or
> > was on stack.  Kill back-to-back REQUEST_SENSE detection.
> >
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> >  drivers/ide/ide-tape.c |    6 ------
> >  1 files changed, 0 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> > index cb942a9..3a53e08 100644
> > --- a/drivers/ide/ide-tape.c
> > +++ b/drivers/ide/ide-tape.c
> > @@ -614,12 +614,6 @@ static ide_startstop_t ide_tape_issue_pc(ide_drive_t *drive,
> >  {
> >        idetape_tape_t *tape = drive->driver_data;
> >
> > -       if (drive->pc->c[0] == REQUEST_SENSE &&
> > -           pc->c[0] == REQUEST_SENSE) {
> > -               printk(KERN_ERR "ide-tape: possible ide-tape.c bug - "
> > -                       "Two request sense in serial were issued\n");
> > -       }
> > -
> >        if (drive->failed_pc == NULL && pc->c[0] != REQUEST_SENSE)
> >                drive->failed_pc = pc;
> >
> 
> I hit that too when debugging an ide-tape problem a user has
> (http://bugzilla.kernel.org/show_bug.cgi?id=12874). However, this is not the
> proper solution since, currently, ide-tape stuffs all packet commands in
> rq->buffer or rq->special now after your changes. It has to get them out of
> there in the ->do_request callback and set drive->pc to point to the current
> packet command in flight through the IRQ handler. And since ide_tape_issue_pc()
> is called by the ->do_request callback we should have the drive->pc always
> valid.
> 
> How about something like that instead:

Can't we just apply them both? :)

Could it be that we just need to take care if this case:

        if (rq->cmd[13] & REQ_IDETAPE_PC2) {
                idetape_media_access_finished(drive);
                return ide_stopped;
        }

[all other code-paths set pc before calling ide_tape_issue_pc()]

> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index 4e6181c..171dbcd 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -792,6 +792,9 @@ static ide_startstop_t
> idetape_do_request(ide_drive_t *drive,
>  	struct request *postponed_rq = tape->postponed_rq;
>  	u8 stat;
> 
> +	if (rq->cmd_type == REQ_TYPE_SPECIAL)
> +		drive->pc = (struct ide_atapi_pc *) rq->buffer;
> +
>  	debug_log(DBG_SENSE, "sector: %llu, nr_sectors: %lu,"
>  			" current_nr_sectors: %u\n",
>  			(unsigned long long)rq->sector, rq->nr_sectors,
