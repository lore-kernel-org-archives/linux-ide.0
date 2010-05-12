From: Olof Johansson <olof@lixom.net>
Subject: Re: link resets with SSD on AHCI
Date: Wed, 12 May 2010 13:49:06 -0500
Message-ID: <20100512184906.GA1893@lixom.net>
References: <20100429215935.GA9796@lixom.net> <4BE1452A.6040607@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lixom.net ([66.141.50.11]:51882 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754692Ab0ELSc1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 May 2010 14:32:27 -0400
Content-Disposition: inline
In-Reply-To: <4BE1452A.6040607@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Wed, May 05, 2010 at 12:15:06PM +0200, Tejun Heo wrote:
> Hello,
> 
> On 04/29/2010 11:59 PM, Olof Johansson wrote:
> > I did notice that ALPM is enabled at boot, and doesn't seem to be
> > re-enabled after the error reset. Based on this, I experimented with
> > disabling it (just returning -EINVAL in ahci_enable_alpm). That did make
> > the problem not happen after a significant test run (overnight vs 4.5
> > minutes above).
> 
> It could be that libata's ALPM enable sequence isn't liked by the
> controller.  libata first resets the link disabling all powersave
> transitions, then turn on ALPM then allows powersave transitions.
> It's possible that the controller or device somehow gets upset by this
> (ie. the device is told to go to powersave mode only to find out that
> the host side isn't allowing it).
> 
> Does the attached patch make any difference?  Can you please post the
> kernel boot log with the patch applied?

The patch didn't make a difference for me, but I got sidetracked looking
at some other things and didn't get a chance to collect data just yet;
it's coming.

I also got second thoughts about what actually makes it happen; and
I am now of the suspicion that it does indeed take an invocation of
the laptop-mode tools setting power settings for battery operation
(i.e. taking the link off of max_performance) for the problem to
show. Earlier I had been of the impression that it happened even with
it being left untouched, that does not seem to be the case.

As for ALPM overall: I have also noticed that the link doesn't actually
seem to be put in low-power mode with these SSD devices, since I see
now power consumption difference between having it on or off.


-Olof

