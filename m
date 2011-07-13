From: "tj@kernel.org" <tj@kernel.org>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Wed, 13 Jul 2011 15:34:25 +0200
Message-ID: <20110713133425.GP2872@htj.dyndns.org>
References: <359604ECF8F440408B9634E6146249B42923805F@mail.scl.local>
 <20110628095723.GC3386@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321BDEE6@mail.scl.local>
 <20110712150113.GC4347@mtj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39238 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab1GMNeb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2011 09:34:31 -0400
Received: by bwd5 with SMTP id 5so4838119bwd.19
        for <linux-ide@vger.kernel.org>; Wed, 13 Jul 2011 06:34:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Derry Bryson <derry@high-rely.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On Tue, Jul 12, 2011 at 07:21:17PM +0000, Derry Bryson wrote:
> > One suspicion I have is that the PSU in the enclosure isn't stable
> > enough to maintain PHY state while multiples drives are powering up.
> > If this is the case, PHYs may keep flickering well over a second which
> > libata doesn't expect them to.  Beefing up the PSU (or using a second
> > PSU to power some of the harddrives) and see whether anything changes
> > would be a good way to test it.
> 
> I doubt it is a PSU issue for a couple of reasons:  1) all drives (5) are
> detected properly if I power the unit (external hard drive box, not computer) 
> off and on, and 2) it fails the same way with only 1 drive in the unit.
> 
> I will, however, try to test with a larger power supply tomorrow.

I see.  Yeah, it doesn't seem to be PHY flickering.  It looks like
IDENTIFY is failing before disk finishes spinning up, which isn't the
correct behavior.  SRST is supposed to wait for disk spin up
completion.  I don't know why sil24 softreset is failing without
waiting for spinup.  I'll see whether I can reproduce the problem
here.

Thank you.

-- 
tejun
