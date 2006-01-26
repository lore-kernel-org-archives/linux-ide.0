From: Jens Axboe <axboe@suse.de>
Subject: Re: [akpm@osdl.org: Re: 2.6.16 eating filesystems]
Date: Thu, 26 Jan 2006 19:52:41 +0100
Message-ID: <20060126185240.GJ4311@suse.de>
References: <20060125185320.GL14225@havoc.gtf.org> <43D8373B.1070802@gmail.com> <20060126080544.GH4212@suse.de> <43D8FDA5.3000701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:43549 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964774AbWAZSzn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 13:55:43 -0500
Content-Disposition: inline
In-Reply-To: <43D8FDA5.3000701@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nicolas.Mailhot@LaPoste.net, linux-ide@vger.kernel.org

On Fri, Jan 27 2006, Tejun wrote:
> Jens Axboe wrote:
> >On Thu, Jan 26 2006, Tejun Heo wrote:
> >
> >>Jeff Garzik wrote:
> >>
> >>>----- Forwarded message from Andrew Morton <akpm@osdl.org> -----
> >>>
> >>>From: Andrew Morton <akpm@osdl.org>
> >>>To: Jeff Garzik <jgarzik@pobox.com>
> >>>Subject: Re: 2.6.16 eating filesystems
> >>>Date: Wed, 25 Jan 2006 10:51:15 -0800
> >>>X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
> >>>
> >>>Jeff Garzik <jgarzik@pobox.com> wrote:
> >>>
> >>>
> >>>>Returning from a biz trip today, and will be looking (and/or passing the
> >>>>buck to Tejun/Jens) at the stuff you mentioned.
> >>>>
> >>>>Was there just the one case of filesystem eating?
> >>>>Pointers / message-ids / URLs?
> >>>
> >>>
> >>>http://bugzilla.kernel.org/show_bug.cgi?id=5914
> >>>
> >>
> >>The device reports FUA support.
> >>
> >>SCSI device sda: drive cache: write back w/ FUA
> >>SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
> >>
> >>This is my first time to see an ATA drive which supports FUA, great. 
> >>Anyways, my guess is...
> >
> >
> >Really? I've seen several of them, in fact the Maxtor in my workstation
> >here supports it.
> 
> [CC'ing Nicolas & linux-ide]
> 
> Hmm.. I just bought three SATA-II drives 7200.9, samsung and WD, and I 
> have two NCQ maxtor drives Eric sent me (the ones with read log page 10h 
> bug).  None of these reports FUA capability.  Can you let me know the 
> model names of FUA-capable drives you have?

My Seagate doesn't either, but all the Maxtors I've seen (two different
firmwares tested here) do and the Hitachi I have also does. They are:

Model Number:       Maxtor 6B250S0
Firmware Revision:  BANC1B70

Model Number:       Maxtor 7B300S0
Firmware Revision:  BANC1BM0

Model Number:       HDT722516DLA380
Firmware Revision:  V430

I have a bunch of other drives I can test as well (pata, sata, sas,
scsi), but out of the ones I have 'online' at this moment 4 out of 6
support it :-)

> >>1. I screwed up libata FUA part.
> >>2. Maxtor screwed up.  It reports FUA but chokes when one is given.
> >>
> >>Both will result in failure of all barrier requests and that won't be 
> >>very good for filesystem integrity.
> >
> >
> >Auch, test case?
> >
> 
> It's just a guess.  Weird thing with Nicolas's case is that the 
> supposedly FUA failures resulted in filesystem corruption.  Plain ext3 
> just backs out if it meets an error during barrier operation and no 
> corruption occurs due to the failure.  It seems like dm/md isn't 
> reacting very well to barrier failures.  I'm not sure at all.

I could not reproduce anything bad with raid1 on a FUA capable drive as
well. The fs fallback have been pretty well tested in the past, so I'm
fairly confident that they work.

> What do you think about implementing auto-fallback?  If FUA-write gets 
> aborted, the queue is switched to non-FUA mode and the barrier is 
> retried.  This feature was in the first few drafts of the new barrier 
> implementation but I dropped it because it was difficult to get right 
> for ordered tags and is pretty clearly an over-design.  Hmmm... still 
> doesn't sound right.

I'd rather blacklist if we have to, a drive lying about working FUA
support is down right buggy.

> Anyways, it's clear that we need to do something to prevent data 
> corruption on barrier failures.  Nicolas's case is just too scary.  It 
> should warn and turn off barrier, not corrupt whole fs.  Maybe we should 
> turn off libata FUA support until this issue is resolved?

Lets wait a day and find out what this bug is precisely, I still think
it's pretty weird if the FUA write doesn't work at all (perhaps it's
just tossing out writes? sounds too buggy to be true).

-- 
Jens Axboe

