From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC PATCH] ide-floppy: use rq->cmd for preparing and sending packet cmds to the drive
Date: Wed, 13 Feb 2008 14:30:16 +0100
Message-ID: <200802131430.16450.bzolnier@gmail.com>
References: <20080212143715.GB4530@gollum.tnic> <200802122239.22566.bzolnier@gmail.com> <20080213124625.GB13446@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:54390 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbYBMNRG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 08:17:06 -0500
Received: by nf-out-0910.google.com with SMTP id g13so5283nfb.21
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 05:17:05 -0800 (PST)
In-Reply-To: <20080213124625.GB13446@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Wednesday 13 February 2008, Borislav Petkov wrote:
> On Tue, Feb 12, 2008 at 10:39:22PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi Bart,
> 
> > I think that this _really_ should be done _after_ unifying ATAPI handling [*].
> > Otherwise you will be making some of the same changes to the _three_ copies
> > of (more or less) identical code and more importantly we will have to delay
> > unification after _all_ drivers are converted to rq->cmd[] (+ lets not forget
> > that I'll have more changes to review ;).
> > 
> > (*) please take a closer look at *_issue_pc(), *_transfer_pc() and *_pc_intr()
> >     in ide-{floppy,tape,scsi} (the useful hint is that after making these
> >     functions free of references to device driver specific objects/functions
> >     we can use drive->media == ide_{floppy,tape,scsi} checks for handling
> >     not yet fully unified / media type specific code).
> 
> I started working on probably the easiest unification we could do: unify all the
> pc->flags defines and move them in a header where all drivers can use them. This

Yep.

> raises an architectural design question: The way i see it, the generic ATAPI handling
> is going to be sort of "serving" functionality to the drivers using ATAPI. Do we want
> all this functionality to go to ide.{h,c} or we want specific atapi.{h,c} files that
> contain only this unified functionality, or whatever else. In general, how is this
> generic layer going to be distributed among headers/.c files and what do we want there?
> 
> /me tends to think that special headers/files, small and easy to manage and
> modular, have more advantages in this case but this is just me. After we've
> decided on that, the rest of the issues will resolve by themselves/get easier to
> tackle.

I think that:

	drivers/ide/ide-atapi.c
	include/linux/ide.h

should be fine for now...

Moving code around is trivial so we can always fixup before pushing upstream.

Thanks,
Bart
