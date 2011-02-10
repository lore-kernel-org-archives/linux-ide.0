From: Tejun Heo <tj@kernel.org>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Thu, 10 Feb 2011 10:13:25 +0100
Message-ID: <20110210091325.GK3770@htj.dyndns.org>
References: <4D51A648.20707@cfl.rr.com>
 <20110209085935.GE6558@htj.dyndns.org>
 <4D52B0B3.40900@cfl.rr.com>
 <20110209153714.558133d7@lxorguk.ukuu.org.uk>
 <4D52ECB6.4010408@cfl.rr.com>
 <20110209214118.GA7196@atj.dyndns.org>
 <4D5332D2.5090701@cfl.rr.com>
 <4D534378.3050304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55481 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918Ab1BJJNb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2011 04:13:31 -0500
Received: by fxm20 with SMTP id 20so1220049fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2011 01:13:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D534378.3050304@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, guys.

On Wed, Feb 09, 2011 at 07:46:32PM -0600, Robert Hancock wrote:
> On 02/09/2011 06:35 PM, Phillip Susi wrote:
> >On 02/09/2011 04:41 PM, Tejun Heo wrote:
> >>So, no, the situation has always been quite muddy with HPA and if you
> >>ask me it is an inherently stupid feature bound to cause problems.
> >
> >What problems? Other than those caused by unlocking it in the first
> >place, and then upgrading?

The problem with pushing this type of seemingly smart workarounds is
that people gets tunnel visioned by their own narrow view of the
problem.

What happens if a drive is moved to another machine?  What about
hotplugging a drive?  What if partition detection code incorrectly
interprets a chunk of data in a RAID5 member as a partition table
(most partition tables don't have good protection against
misinterpretation)?

> >>The setting is not even bound to the hard drive. You move a hard
> >>drive to a different machine, the size changes, hooray! Oh right,
> >
> >Unless the other machine decides to change it, then it is bound to the
> >drive. It is possible that both machines will change it, but since most
> >don't bother using the HPA, it tends to be preserved when moving from a
> >machine that uses it to one that does not.

Many don't even use volatile setting and most happily override
whatever the current setting may be.  It just doesn't work.  These
BIOS features are designed with the mindset "If it works on this
motherboard and windows, we're done.  Hell with all other use cases",
which is quite different from what Linux should be aiming for.

> >>I think ide had it right all along. We should just have unlocked
> >>things by default when HPA unlock feature was added. A lot of BIOSen
> >
> >Why?
> >
> >>To sum up, no, not unlocking HPA by default was not a conscious
> >>decision and neither was some distros defaulting to unlocking it.
> >>Those decisions are all made by inertia, so please stop bringing them
> >>up. They don't mean much.
> >
> >Then why did you write a patch that seems to be a reasonable compromise
> >between the two and will allow distros to stop diverging from upstream
> >in this way, and are now arguing against that patch?

You've got it backwards.  The patch doesn't do anything for distros
which unlock by default.  On the contrary, the patch unlocks _more_ on
ones which didn't use to.  IIRC, debian didn't want to unlock by
default (the rationale was that they already had both ide and libata
userbases) and it seemed like a good enough tradeoff to avoid breaking
ide compatibility for most people.

Making the condition more intricate won't fix the problem.  It's just
gonna make it fail in more weird and convoluted ways.

> I'm inclined to agree. Unlocking HPA by default is opening up a
> potential can of worms and seems likely to cause regressions. This
> thread:
> 
> http://fossplanet.com/f10/host-protected-area-unconditional-disable-87925/
> 
> points out: "once HPA has been turned off a power cycle is needed to
> turn it back on. This can severely confuse another operating system
> when it finds the disk has changed size. In rare cases it can cause
> RAID cards to drop RAID sets on the floor thinking they are corrupt.
> All bad."
>
> I don't see a case where unlocking HPA benefits us except in the
> case of upgrading from an older distro using IDE where HPA was being
> unlocked, or in the (vanishingly unlikely these days) case where the
> HPA is used to hide the drive's full capacity from the BIOS. The
> former case would be handled by the existing logic and proposed
> patch. The latter case can be handled with a module option. I don't
> see the benefit of playing with fire and shutting off HPA all the
> time.

Hotplugging and being able to move hard drives between different
machines, and in general behaving consistently across different
hardware configurations have way higher priority than trying to avoid
confusing broken BIOSen or other operating systems in obscure
configurations.  Those problems are very rare to begin with (ubuntu
unlocks HPA by default!) and usually can be avoided by changing
configuration (or turning off HPA unlocking if it really comes down to
that).  It's just absurd to decide the default behavior based on those
fringe cases.

Thanks.

-- 
tejun
