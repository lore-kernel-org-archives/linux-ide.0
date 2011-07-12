From: "tj@kernel.org" <tj@kernel.org>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Tue, 12 Jul 2011 17:01:13 +0200
Message-ID: <20110712150113.GC4347@mtj.dyndns.org>
References: <359604ECF8F440408B9634E6146249B42923805F@mail.scl.local>
 <20110628095723.GC3386@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321BDEE6@mail.scl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:43882 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab1GLPBT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2011 11:01:19 -0400
Received: by fxd18 with SMTP id 18so5073681fxd.11
        for <linux-ide@vger.kernel.org>; Tue, 12 Jul 2011 08:01:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <359604ECF8F440408B9634E6146249B4321BDEE6@mail.scl.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Derry Bryson <derry@high-rely.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Sorry about the long delay.

On Thu, Jun 30, 2011 at 05:53:32PM +0000, Derry Bryson wrote:
> I have included info from kern.log below showing turning the bay on and off before and
> after I patched the kernel.

kern.log tends to be too cluttered with extra timestamps.  Can you
please use 'dmesg -c' after each phase of testing?  printk timestamps
included there should be enough.

> I first applied the patch from your previous email and changed the
> second timing value to 1000 and that makes it work.  It also works
> if you leave the timing values alone and up the retries (i.e
> ATA_EH_PMP_LINK_TRIES) from 3 to 5.  It seems to me the drives are
> taking a long (relatively) time to spin up and either way all we are
> doing is giving it more time to spin up.

That's debouncing timing.  It doesn't have much to do with spinning
up.  Spinning up can take over ten seconds.  PHY is usually ready well
under a sec once power is applied.  The reason why libata stops
waiting during reset is because PHY flickers - it comes up and then
goes out again.  libata EH already debounces to work around these
glitches but it seems this 'flickering' is larger scale than libata
parameters expect.

One suspicion I have is that the PSU in the enclosure isn't stable
enough to maintain PHY state while multiples drives are powering up.
If this is the case, PHYs may keep flickering well over a second which
libata doesn't expect them to.  Beefing up the PSU (or using a second
PSU to power some of the harddrives) and see whether anything changes
would be a good way to test it.

> Is there some way to know it is spinning up and wait for that rather
> than just trying to reset the controller over and over?  Also I
> notice from the kernel log that the 'hotplugged' flag is only set
> the first time it does the hard reset and is then cleared.  If this
> didn't get cleared it may work that way as well.  All of this only
> fixes the problem until an slower drive comes out.

The hotplugged timing is supposed to kick in only once after a hotplug
event as some PHYs tend to take longer time to lock on after hotplug
event.

> From the SMART info on the drives for the WD 3TB that fails the spin
> up value was 188 vs.  a Seagate 160GB that was 87.  I believe these
> values are in milliseconds so we can see that the drive that fails
> takes much longer to spin up.

That's more likely centisecs instead of millisecs.  8.7sec would be
about normal for regular drives.  18.8 isn't too far off for large
ones with more platters.  The more important thing probably is that
the WD 3TB drive is likely to draw much more power than the smaller
one taxing the PSU in the enclosure which could have been designed to
have just enough power for more regular drives.

> Jun 30 10:02:26 HR-NETSWAP kernel: [   99.510350] ata1.00: XXXX hardreset hotplugged = false
> Jun 30 10:02:26 HR-NETSWAP kernel: [   99.510356] ata1.00: XXX0 hardreset debounce 5 100 2000
> Jun 30 10:02:26 HR-NETSWAP kernel: [   99.510361] ata1.00: XXX1 hardreset debounce 5 100 2000

So if you bump the second timing value to 1000, it works without
retrying?  Can you please post kernel log w/ that change?

Thanks.

-- 
tejun
