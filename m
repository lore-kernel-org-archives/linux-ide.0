From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide-cd question
Date: Fri, 18 Mar 2005 17:42:59 +0100
Message-ID: <58cb370e05031808424e549b9a@mail.gmail.com>
References: <7A8F92187EF7A249BF847F1BF4903C04010EEA2A@ausx2kmpc103.aus.amer.dell.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.201]:31339 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261676AbVCRQnC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2005 11:43:02 -0500
Received: by wproxy.gmail.com with SMTP id 67so169349wri
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2005 08:43:00 -0800 (PST)
In-Reply-To: <7A8F92187EF7A249BF847F1BF4903C04010EEA2A@ausx2kmpc103.aus.amer.dell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Stuart_Hayes@dell.com" <Stuart_Hayes@dell.com>
Cc: stuarthayes@austin.rr.com, axboe@suse.de, linux-ide@vger.kernel.org

On Thu, 17 Mar 2005 10:17:58 -0600, Stuart_Hayes@dell.com
<Stuart_Hayes@dell.com> wrote:
> Jens Axboe wrote:
> > On Fri, Mar 04 2005, Stuart_Hayes@Dell.com wrote:
> >>
> >>>
> >>> There's still a problem here, you are not initializing nsectors for
> >>> non-pc requests. And your comments wrap :)
> >>>
> >>>         int nsectors = rq->hard_nr_sectors;
> >>>
> >>>         if (blk_pc_request(rq))
> >>>                 nsectors = (rq->data_len + 511) >> 9;         if
> >>>                 (!nsectors) nsectors = 1;
> >>>
> >>>         ...
> >>>
> >>> Can you resend with that fixed up and with a Signed-off-by header?
> >>
> >> Here it is.  Thanks for all the help.  I'm attaching as a file, too,
> >> just in case it gets garbled again.
> >> Stuart
> >>
> >>
> >> Signed-off-by: Stuart Hayes <stuart_hayes@dell.com>
> >>
> >> --- linux-2.6.11/drivers/ide/ide-io.c.orig   2005-03-04
> >> 16:11:14.000000000 -0500 +++
> >> linux-2.6.11/drivers/ide/ide-io.c    2005-03-04 16:19:19.000000000
> >>              -0500 @@ -516,7 +516,19 @@ static ide_startstop_t
> >> ide_atapi_error(i hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);
> >>
> >>      if (rq->errors >= ERROR_MAX) {
> >> -            drive->driver->end_request(drive, 0, 0);
> >> +            /*
> >> +             * make sure request is fully ended--otherwise the
> >> +             * command will be retried without rq->errors getting
> >> +             * reset to zero, which could cause us to get stuck
> >> +             * in a loop with infinite retries without any more +
> * reset
> >> attempts +            */
> >> +            int nsectors = rq->hard_nr_sectors;
> >> +            if (blk_pc_request(rq))
> >> +                    nsectors = (rq->data_len + 511) >> 9;
> >> +            if (!nsectors)
> >> +                    nsectors = 1;

ide_end_request() handles this case differently
and this code path is used not only by ide-cd.

You've changed the current behavior here.
The question is - what are the consequences of that?

> >> +            drive->driver->end_request(drive, 0, nsectors);
> >>      } else {
> >>              if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
> >>                      ++rq->errors;
> >
> > Looks good, Bart care to pick this up?

This is not so obvious for me...

> > Signed-off-by: Jens Axboe <axboe@suse.de>
> 
> Bart--
> 
> Is there a chance you might pick this up, or is there a problem with it?
> 
> Thanks
> Stuart
>
