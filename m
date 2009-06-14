From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Sun, 14 Jun 2009 12:06:06 +0200
Message-ID: <20090614100606.GA25379@liondog.tnic>
References: <bug-13399-11633@http.bugzilla.kernel.org/> <200906131629.n5DGT7LL020589@demeter.kernel.org> <200906131859.54080.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f207.google.com ([209.85.220.207]:47165 "EHLO
	mail-fx0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbZFNKGK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Jun 2009 06:06:10 -0400
Received: by fxm3 with SMTP id 3so35878fxm.37
        for <linux-ide@vger.kernel.org>; Sun, 14 Jun 2009 03:06:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200906131859.54080.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: bugzilla-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org

Hi,

On Sat, Jun 13, 2009 at 06:59:53PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > --- Comment #20 from Borislav Petkov <bbpetkov@yahoo.de>  2009-06-13 16:29:05 ---
> > Hi Bart,
> > 
> > thanks for analyzing this.
> > 
> > I'm staring at the ATA_DRQ == 0 part in cdrom_newpc_intr:
> > 
> >                 } else if (!blk_pc_request(rq)) {
> >                         ide_cd_request_sense_fixup(drive, cmd);
> >                         /* complain if we still have data left to transfer */
> >                         uptodate = cmd->nleft ? 0 : 1;
> >                         if (uptodate == 0)
> >                                 rq->cmd_flags |= REQ_FAILED;
> >                 }
> >                 goto out_end;
> >         }
> > 
> > so, in our case ide_cd_error_cmd() kills the rq prematurely and that's
> > why ide_complete_rq() oopses later. And this is caused by uptodate ==
> 
> Nope, it is block layer that kills it prematurely.

ok, I still need to understand the whole code flow properly so please
bare with me.

I got misled by the __blk_end_request() thing: am I right to assume that
you were using it to give a better example where it is more clear that
the block layer really kills rq->bio-less requests?

Because we don't hit __blk_end_request from ide_cd_error_cmd() (or
ide_complete_rq() too, for that matter) - we do rather:

ide_cd_error_cmd() does ide_complete_rq(), which ends up doing
blk_end_request(), then blk_end_io() and the rq->bio thing is checked
in end_that_request_data(). Which is actually the same thing but done
slightly differently.

> There are two issues here:
>
> * OOPS (*the*regression* which should be taken care of first (cause:
> unexpected interaction between ide/block)

I'm thinking something like

if (uptodate == 0 && !(OK_STAT(stat, 0, BAD_STAT)))
	ide_cd_error_cmd(drive, cmd);

> * handling of non-fully completed requests with "good" status (cause:
> stupid hardware)

The non-intrusive solution, IMHO, would be to add another quirk flag for
such a device (SONY DVD-ROM DDU1615) and do not complete the rq in that
case, aka no partial completion for packet commands to that device. I'm
wondering what else is broken with it especially if you're requiring
bigger buffers like the capacities page.

So, how about an ide_cd_complete_rq() helper which hides such special
cases and is called as an indirection at the end of the irq handler?

-- 
Regards/Gruss,
    Boris.
