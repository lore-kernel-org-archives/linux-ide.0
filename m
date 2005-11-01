From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] pmac ide doesn't properly cleanup hwif when
	releasing controller
Date: Wed, 02 Nov 2005 08:00:23 +1100
Message-ID: <1130878823.29054.449.camel@gaston>
References: <20051029044852.1a518908@Tatooine.r3z0>
	 <1130623795.29054.179.camel@gaston>
	 <58cb370e0511010820p77bd47c9wa566f3d356291733@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52388 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751219AbVKAVDC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Nov 2005 16:03:02 -0500
In-Reply-To: <58cb370e0511010820p77bd47c9wa566f3d356291733@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, linux-ide@vger.kernel.org


> > Thus my question: Should I
> >
> >  - Manually in ide-pmac clean up all callbacks & revert everything in
> > the HWIF when I want to hand it back
> >
> >  - Call init_hwif_data() despite the nasty comment on top
> >
> >  - Just don't release the interface...
> 
> Just don't release it - it is the simplest solution and also
> as the easiest to maintain in future (hotplug).

Well, not exactly :) If I start to add unplug of that driver, the
problem will be back, trying to release an interface or rmmod the module
will leave all sort of crap in the HWIF ... So I think you need to
exposrt something from the IDE core to totally cleanup a HWIF (return it
to pristine state) for use in those cases.

The exact same goes with ide-cd btw. It's not changing as many fields
as, afaik, it doesn't do DMA, but still. When the CS is removed, all
HWIF fields should be reverted to their initial state

Ben.

