From: Tejun Heo <tj@kernel.org>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Thu, 10 Feb 2011 20:32:35 +0100
Message-ID: <20110210193235.GO3770@htj.dyndns.org>
References: <4D51A648.20707@cfl.rr.com>
 <20110209085935.GE6558@htj.dyndns.org>
 <4D52B0B3.40900@cfl.rr.com>
 <20110209153714.558133d7@lxorguk.ukuu.org.uk>
 <4D52ECB6.4010408@cfl.rr.com>
 <20110209214118.GA7196@atj.dyndns.org>
 <4D5332D2.5090701@cfl.rr.com>
 <4D534378.3050304@gmail.com>
 <20110210091325.GK3770@htj.dyndns.org>
 <4D54387F.3030809@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58187 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139Ab1BJTcj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2011 14:32:39 -0500
Received: by bwz15 with SMTP id 15so2452686bwz.19
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2011 11:32:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D54387F.3030809@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, Feb 10, 2011 at 02:11:59PM -0500, Phillip Susi wrote:
> On 2/10/2011 4:13 AM, Tejun Heo wrote:
> > What happens if a drive is moved to another machine?  What about
> > hotplugging a drive?  What if partition detection code incorrectly
> > interprets a chunk of data in a RAID5 member as a partition table
> > (most partition tables don't have good protection against
> > misinterpretation)?
> 
> I don't see how any of these cases are made worse by your change.  If
> you move to another machine and it adds an HPA, then your change will
> unlock it.  If you incorrectly interpret a chunk of data as a partition
> table, then you incorrectly unlock ( this is exactly what I am to fix ),
> but that isn't worse than always unlocking.

RAID.  The partition based detection is flimsy by nature.  Block layer
doesn't have enough information to make the decision reliably.

> > BIOS features are designed with the mindset "If it works on this
> > motherboard and windows, we're done.  Hell with all other use cases",
> > which is quite different from what Linux should be aiming for.
> 
> I agree, but always unlocking seems to HURT that goal rather than help it.

I don't know.  I think I explained as well as I could and it seems the
biggest barrier to reaching agreement seems your attachment to BIOS
features/requirements, which I frankly can't understand or appreciate.

> You can't unlock any more than always ;)
> 
> Ubuntu has dropped its patch to always unlock in favor of your upstream
> change to unlock when it makes sense.  The net result is that it unlocks
> less, but still sometimes unlocks when it should not with certain raid
> setups.  Also this is not just a problem for fakeraid; mdadm raid setups
> can run into the same problem.

Okay, so Ubuntu switched.  Ah well, for most desktop users, that might
be better for now but I still don't think it's a good solution no
matter how much we try to augment it.  We simply don't have enough
information to make those decisions during device probe.

> > Making the condition more intricate won't fix the problem.  It's just
> > gonna make it fail in more weird and convoluted ways.
> 
> If it fails less, then it is an improvement.

In some sense maybe, but ask any self-respecting engineer, [s]he will
tell you the work kind of failures are the ones which happen once in a
blue moon in unpredictable manner.

> > Hotplugging and being able to move hard drives between different
> > machines, and in general behaving consistently across different
> > hardware configurations have way higher priority than trying to avoid
> 
> Your auto unlock change seems to address that issue just fine.

If it did that just fine, this thread wouldn't exist.  I think we just
should agree to disagree.  I'm not buying most of your arguments and
you seem to be doing likewise.

Thanks.

-- 
tejun
