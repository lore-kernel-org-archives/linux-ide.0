From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel 2.6.30rc7 limits IDE to UDMA33
Date: Sat, 6 Jun 2009 23:08:52 +0100
Message-ID: <20090606230852.200d1432@lxorguk.ukuu.org.uk>
References: <c5bd819b0906021525l13ee9282j1fb270e141985f66@mail.gmail.com>
	<4A25F688.9000407@gmail.com>
	<c5bd819b0906030435w466368cbsd48be91a97597437@mail.gmail.com>
	<20090603131407.57c490ed@lxorguk.ukuu.org.uk>
	<c5bd819b0906030552w6f23185etb394f83c8b630e6@mail.gmail.com>
	<20090603140140.491a8ea8@lxorguk.ukuu.org.uk>
	<c5bd819b0906030639o5f9c34ffg500e132d3a0b5117@mail.gmail.com>
	<c5bd819b0906040750w75e0389cod2a03b89ce838d1b@mail.gmail.com>
	<20090605100505.41b3b818@lxorguk.ukuu.org.uk>
	<c5bd819b0906050335i4e813887sc8f4d901da86a1aa@mail.gmail.com>
	<20090605114245.175499e1@lxorguk.ukuu.org.uk>
	<4A29C163.3080706@gmail.com>
	<20090606155636.18bc4f2e@lxorguk.ukuu.org.uk>
	<4A2AB298.7020603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54633 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752712AbZFFWIc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Jun 2009 18:08:32 -0400
In-Reply-To: <4A2AB298.7020603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Grozdan <neutrino8@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

> > Drive side detection doesn't work for many VIA boards, the neccessary
> > components are not included.
> 
> Ugh, seems they messed this stuff up as bad as NVIDIA did..

Nvidia seem to have gotten it close to right. The Nvidia chipsets use
ACPI for reporting and only ACPI. The ACPI parts are pretty reliable, its
just if your ACPI is busted....

> Well, that's pretty much the same thing that GTM does (it generally just 
> reads the configured mode out of the controller registers). So it really 
> wouldn't be much worse than what we're doing now.
> 
> Thing is somehow the GTM detection isn't working now and it apparently 
> was in 2.6.27.1. I'm not seeing any patches to pata_via or libata-acpi 
> that seem like they would affect this offhand. Grozdan, would you be 
> able to try git bisect to try to figure out what changed the behavior?

Could be power management. Something is putting devices into D3 that
didn't use to happen. That was what broke the ALi ATA driver and I could
believe a D3 transition of the IDE controller broke the BIOS
configuration.
