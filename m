From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] honor IDE drive write cache settings (respin#1)
Date: Tue, 19 Oct 2004 21:13:54 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e041019121367d56b6f@mail.gmail.com>
References: <58cb370e04101910153f179edc@mail.gmail.com>
	 <200410191821.i9JILGLl011765@falcon10.austin.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.196]:53394 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270098AbUJSTNz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Oct 2004 15:13:55 -0400
Received: by mproxy.gmail.com with SMTP id 77so355740rnk
        for <linux-ide@vger.kernel.org>; Tue, 19 Oct 2004 12:13:55 -0700 (PDT)
In-Reply-To: <200410191821.i9JILGLl011765@falcon10.austin.ibm.com>
List-Id: linux-ide@vger.kernel.org
To: Doug Maxey <dwm@austin.ibm.com>
Cc: Linux IDE Mailing List <linux-ide@vger.kernel.org>

On Tue, 19 Oct 2004 13:21:16 -0500, Doug Maxey <dwm@austin.ibm.com> wrote:
> Respin at the bottom...
> 
> On Tue, 19 Oct 2004 19:15:27 +0200, Bartlomiej Zolnierkiewicz wrote:
> >Hi Doug,
> >
> >On Tue, 19 Oct 2004 11:15:14 -0500, Doug Maxey <dwm@austin.ibm.com> wrote:
> >>
> >> Bart,
> >>
> >> here is a patch that handles drives that come with write cache disabled,
> >> both as modular and builtin drivers.
> >
> >This patch seems to be trying to do too much in one go and we've learned
> >(by experience :) that write cache related changes should be done in small
> >steps.  Please split your patch to:
> >
> >* HDIO_DRIVE_CMD fix
> >* honor disk write cache fix
> >* "barrier" fix (this one needs some more thinking)
> >
> >Do you care to also make "disable write cache by default" patch?
> 
> This patch neither enables or disables write cache, it simply honors what
> the drive is set for, and ensure the correct barrier handling.  The code
> as it exists is broken when attempting to change the write cache from
> hdparm, and is broken when attaching the drive.  There is no reason that I
> can see to enable any of it without all of it.  Other than to break it up.
> 
> Bottom line is that none of this is standalone.

The thing is that I can apply first 2 fixes immediately while I need
some time to check the 3rd one so not breaking patch holds it down...

> >+      if (!(drive->id->command_set_1 & (1 << 5)))
> >+              return -EIO;    /* Would prefer ENXIO for command not supported... */
> >
> >Is this enough?  IMO it is the best to leave it alone for now...
> 
> The previous test was for FLUSH incarnations, which I believe was

I was thinking about something else...

Previously if you did hdparm -W this condition wasn't checked et all
and while at it, why -ENXIO can't be used here?

> an error.  Barrier tests are done later.  The kernel barrier=off is
> a kludge at best, and if the drive DOES have write cache enabled,
> is a window for data loss.  Not much of an issue on a workstation,
> but really a concern for server class machines.

There was an discussion->agreement that IDE driver should
disable write cache by default (think about cases when WC
is available but FLUSH is not).

BTW I'm not the right person to complain about barrier code... :)
