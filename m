From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Sun, 14 Jun 2009 15:02:38 +0200
Message-ID: <20090614130238.GA1892@liondog.tnic>
References: <bug-13399-11633@http.bugzilla.kernel.org/> <200906131859.54080.bzolnier@gmail.com> <20090614100606.GA25379@liondog.tnic> <200906141432.11139.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f207.google.com ([209.85.220.207]:37476 "EHLO
	mail-fx0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbZFNNCl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Jun 2009 09:02:41 -0400
Received: by fxm3 with SMTP id 3so83682fxm.37
        for <linux-ide@vger.kernel.org>; Sun, 14 Jun 2009 06:02:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200906141432.11139.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, bruinjm@xs4all.nl
Cc: bugzilla-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org

Hi,

On Sun, Jun 14, 2009 at 02:32:10PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 14 June 2009 12:06:06 Borislav Petkov wrote:
> > Hi,
> > 
> > On Sat, Jun 13, 2009 at 06:59:53PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > --- Comment #20 from Borislav Petkov <bbpetkov@yahoo.de>  2009-06-13 16:29:05 ---
> > > > Hi Bart,
> > > > 
> > > > thanks for analyzing this.
> > > > 
> > > > I'm staring at the ATA_DRQ == 0 part in cdrom_newpc_intr:
> > > > 
> > > >                 } else if (!blk_pc_request(rq)) {
> > > >                         ide_cd_request_sense_fixup(drive, cmd);
> > > >                         /* complain if we still have data left to transfer */
> > > >                         uptodate = cmd->nleft ? 0 : 1;
> > > >                         if (uptodate == 0)
> > > >                                 rq->cmd_flags |= REQ_FAILED;
> > > >                 }
> > > >                 goto out_end;
> > > >         }
> > > > 
> > > > so, in our case ide_cd_error_cmd() kills the rq prematurely and that's
> > > > why ide_complete_rq() oopses later. And this is caused by uptodate ==
> > > 
> > > Nope, it is block layer that kills it prematurely.
> > 
> > ok, I still need to understand the whole code flow properly so please
> > bare with me.
> > 
> > I got misled by the __blk_end_request() thing: am I right to assume that
> > you were using it to give a better example where it is more clear that
> > the block layer really kills rq->bio-less requests?
> > 
> > Because we don't hit __blk_end_request from ide_cd_error_cmd() (or
> > ide_complete_rq() too, for that matter) - we do rather:
> > 
> > ide_cd_error_cmd() does ide_complete_rq(), which ends up doing
> > blk_end_request(), then blk_end_io() and the rq->bio thing is checked
> > in end_that_request_data(). Which is actually the same thing but done
> > slightly differently.
> 
> Yes, you're seeing block layer updates from 2 days ago.

Nope, I'm staring at .30-rc7 sources. I guess those updates are a bit
older.

> > > There are two issues here:
> > >
> > > * OOPS (*the*regression* which should be taken care of first (cause:
> > > unexpected interaction between ide/block)
> > 
> > I'm thinking something like
> > 
> > if (uptodate == 0 && !(OK_STAT(stat, 0, BAD_STAT)))
> > 	ide_cd_error_cmd(drive, cmd);
> 
> Those are two separate issues, please stop mixing them.
> 
> AFAICS ide-cd has been always failing !uptodate requests so the latter
> issue is nothing new.  Which means that it is really not the right time
> to be scratching our heads about it while the former problem has been
> seriously affecting people for weeks now and also managed to slip into
> the final 2.6.30 release..

Ok, let's do that:

@Hans: can you apply the following ontop of the debugging patch and test and
send us the whole dmesg, thanks.

--
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 6f728da..219c303 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -764,7 +764,7 @@ out_end:
 				rq->errors = -EIO;
 		}
 
-		if (uptodate == 0)
+		if (uptodate == 0 && rq->bio)
 			ide_cd_error_cmd(drive, cmd);
 
 		/* make sure it's fully ended */

--

> > > * handling of non-fully completed requests with "good" status (cause:
> > > stupid hardware)
> > 
> > The non-intrusive solution, IMHO, would be to add another quirk flag for
> > such a device (SONY DVD-ROM DDU1615) and do not complete the rq in that
> > case, aka no partial completion for packet commands to that device. I'm
> > wondering what else is broken with it especially if you're requiring
> > bigger buffers like the capacities page.
> > 
> > So, how about an ide_cd_complete_rq() helper which hides such special
> > cases and is called as an indirection at the end of the irq handler?
> 
> I can't tell much without seeing the concept with more details.
>
> IOW please send patches, that is the best way to discuss things.

Ok.

-- 
Regards/Gruss,
    Boris.
