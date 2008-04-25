From: "Grant Grundler" <grundler@google.com>
Subject: Re: [PATCH 1/8] sata_mv more cosmetics
Date: Fri, 25 Apr 2008 10:39:04 -0700
Message-ID: <da824cf30804251039v414bf9baxe14872ac78c95526@mail.gmail.com>
References: <480A3D2E.4040503@rtr.ca> <480A3D5E.8090206@rtr.ca>
	 <481168E7.50402@pobox.com> <4811E0B7.2060508@rtr.ca>
	 <da824cf30804250940o4f0e0396k1696348f8d86cb77@mail.gmail.com>
	 <48120D82.7060009@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:36404 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760929AbYDYRjO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Apr 2008 13:39:14 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id m3PHd6k3024657
	for <linux-ide@vger.kernel.org>; Fri, 25 Apr 2008 18:39:07 +0100
Received: from rn-out-0910.google.com (rnea43.prod.google.com [10.38.153.43])
	by zps78.corp.google.com with ESMTP id m3PHcwRt017777
	for <linux-ide@vger.kernel.org>; Fri, 25 Apr 2008 10:39:06 -0700
Received: by rn-out-0910.google.com with SMTP id a43so1710644rne.10
        for <linux-ide@vger.kernel.org>; Fri, 25 Apr 2008 10:39:05 -0700 (PDT)
In-Reply-To: <48120D82.7060009@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, Apr 25, 2008 at 9:57 AM, Jeff Garzik <jgarzik@pobox.com> wrote:
> Grant Grundler wrote:
>
> > I think you can associate any names you want with whatever the
> > non-public documentation is calling the registers by adding a comment
> > in the header files where the bit masks and register offsets are defined.
> > Or vice versa. Which ever way works for you.
> >
> > I prefer to use the non-public register names in the code only because it
> > will be easier for Marvell engineers to participate in _maintaining_
> > this driver. I think getting involved with open source developement
> > is a good career developement experience. And the device drivers for
> > "obsolete" HW allows them to take more risks/make mistakes
> > without getting into serious trouble with the company.
> >
>
>
>  The trouble, though, comes with following that logic in every driver,
> making the collective body less accessible to anyone not _intimately_ tied
> into the hardware _and_ possessing NDA'd docs.

As a general statement I agree but think linux drivers have issues with
accessibility anyway.

Not possessing documentation inherently makes the device driver less accessible
and no naming convention is going to fix that.  I agree different variable names
make it slightly harder for someone like yourself (well, me too to a
lesser degree)
since we are looking at lots of different drivers. My problem with
this statement is
the definition of "majority" here sounds like a few kernel maintainers. The
"industry" (HW Vendors and their customers) folks I've dealt with historically
are only interested in a few drivers (less than a hand full) since
that's all they need to solve particular problems.

Secondly, anyone trying to understand a particular device driver will have to
understand quite a bit about the HW (hopefully from comments if it's not obvious
from the code) in order to make sense of what "IRQ_STAT" register actually
provides and what the side effects are from reading it (e.g. flushing DMA that
the driver authoer knew was inflight). The only other way is to have this
understanding is to read the NDA documentation which employees
of HW vendors typically have done.

Lastly, I'm trying to _encourage_ some Marvell employees to spend a few minutes
on this driver since it's easier for them than it is for me (despite
also having access
to various vendor's NDA documentation). I'm lazy and any time I don't have
to read the documentation because someone already knows the answer
is good. While having documentation is way better than nothing, documentation
is never as good as one hopes because of "errata", omissions, ambiguity, etc.

>  Further, it is obvious with _most_ drivers in Linux that engineers at the
> hardware vendor do _not_ participate in maintaining drivers for their older
> hardware, so I also wish to be careful and avoid punishing the majority to
> help a minority.

OK - I guess I was expressing more optimism than reflecting reality. :(

>  I put a significant value in having more-readable code like
>
>         status = mr32(IRQ_STAT);        /* read IRQ status from PPB */
>
>  rather than
>
>         status = READ_REG(ICR5PPB);     /* read IRQ status from PPB */
>
>  because the casual reader is more likely to understand the first example,
> even though it deviates from the string of line noise some engineer writing
> Verilog at 4:00am decided was a good register name.

*nod*  - though to be fair, "MAIN_CAUSE" is readable and "ICR5PPB" is not.
(and mark already posted a patch renaming this to main_irq_cause).

BTW, if this is really important, you might consider adding a sentence
to Documentation/CodingStyle "Chapter 4: Naming" to encourage using
"the same register names as what similar drivers are using" and give the
above example (It's a good one.)

cheers,
grant
