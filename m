From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC PATCH] pmac ide doesn't properly cleanup hwif when releasing controller
Date: Wed, 2 Nov 2005 09:05:49 +0100
Message-ID: <58cb370e0511020005q27acb8fdg16acb1f307fafe7b@mail.gmail.com>
References: <20051029044852.1a518908@Tatooine.r3z0>
	 <1130623795.29054.179.camel@gaston>
	 <58cb370e0511010820p77bd47c9wa566f3d356291733@mail.gmail.com>
	 <1130878823.29054.449.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.201]:558 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932636AbVKBIFu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Nov 2005 03:05:50 -0500
Received: by nproxy.gmail.com with SMTP id q29so10680nfc
        for <linux-ide@vger.kernel.org>; Wed, 02 Nov 2005 00:05:49 -0800 (PST)
In-Reply-To: <1130878823.29054.449.camel@gaston>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, linux-ide@vger.kernel.org

On 11/1/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > > Thus my question: Should I
> > >
> > >  - Manually in ide-pmac clean up all callbacks & revert everything in
> > > the HWIF when I want to hand it back
> > >
> > >  - Call init_hwif_data() despite the nasty comment on top
> > >
> > >  - Just don't release the interface...
> >
> > Just don't release it - it is the simplest solution and also
> > as the easiest to maintain in future (hotplug).
>
> Well, not exactly :) If I start to add unplug of that driver, the
> problem will be back, trying to release an interface or rmmod the module

Current behavior is such that pmac driver releases port which
doesn't have devices connected so new behavior will be step forward
(although small).

> will leave all sort of crap in the HWIF ... So I think you need to
> exposrt something from the IDE core to totally cleanup a HWIF (return it
> to pristine state) for use in those cases.
>
> The exact same goes with ide-cd btw. It's not changing as many fields
> as, afaik, it doesn't do DMA, but still. When the CS is removed, all
> HWIF fields should be reverted to their initial state.

"in future" we won't be doing brain-damaged restoring of HWIF
fields in ide_unregister() and the problem will go away.  If you
want to go ahead feel free to but remember to separate 2 states
(HWIF is unregistered by ioctl and HWIF is really going away)
which are currently both handled by ide_unregister().

Thanks,
Bartlomiej
