From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: Fix HDIO_DRIVE_RESET handling
Date: Wed, 25 Jun 2008 22:24:36 +0200
Message-ID: <200806252224.36364.bzolnier@gmail.com>
References: <87k5gmz596.fsf@denkblock.local> <58cb370e0806240719o4a70537p4a6fb64e9086e2d8@mail.gmail.com> <87k5gdn4fq.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:21013 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbYFYUd7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jun 2008 16:33:59 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1166804ywe.1
        for <linux-ide@vger.kernel.org>; Wed, 25 Jun 2008 13:33:50 -0700 (PDT)
In-Reply-To: <87k5gdn4fq.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>

On Wednesday 25 June 2008, Elias Oltmanns wrote:
> "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com> wrote:
> > On Tue, Jun 24, 2008 at 3:35 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >>> > I don't see why you think it's "hard". We have timeout handlers for many
> >
> >>> > commands and those reset/abort just fine.
> >>>
> >>> They are different beasts from user-space initiated abort operation
> >>
> >> No they are not. They are the *same* thing in every respect.
> >>
> >> You have the drive in an unknown state, you want it back. If your drive
> >> lost a command due to noise or a firmware flaw you have no idea about the
> >> state it is actually in (supposed to be is irrelevant)
> >
> > I generally agree with you w.r.t. to drive side of the operations but
> > the drive is only part of the equation (the host and the request states
> > are the others) so 'supposed to be is' is quite relevant.
> >
> > Also abort request can happen i.e. while the command is being prepared
> > & issued (it is done without ide_lock being taken and the timeout is not
> > even armed yet) so there are additional issues to take care of.
> 
> Yes there are. Still, I think it should be feasible which is why I
> personally would prefer to drop the second patch in the series for the
> time being. But then I can keep it around for reference locally and the
> original infrastructure can be found in the history after all.
> 
> Even though the patch series currently doesn't fully restore the
> intended functionality, I'd like to merge it now. Command aborting

Thanks, I applied everything and queued it for 2.6.27.

[ including patch #2, we should re-add aborting when fixed/necessary ]

> didn't work reliably (if at all) before and now, at least, a simple
> ioctl won't harm a healthy system anymore. Since I think that we can add
> command aborting back later, I'd like to keep the HDIO_DRIVE_RESET ioctl
> even if it should currently be superfluous given SG_IO.

SG_IO ATA pass-through is unsupported currently in drivers/ide/
(though nowadays it should be quite easy to add it if somebody is
interested) so it is indeed the best to leave the ioctl for now.

Bart
