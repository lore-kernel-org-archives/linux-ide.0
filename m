From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Mon, 27 Feb 2006 21:52:31 -0500
Message-ID: <4403BAEF.1000908@pobox.com>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <Pine.LNX.4.64.0602271744470.22647@g5.osdl.org> <4403B04F.5090405@pobox.com> <Pine.LNX.4.64.0602271813120.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:63203 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751128AbWB1Cwl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Feb 2006 21:52:41 -0500
In-Reply-To: <Pine.LNX.4.64.0602271813120.22647@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tejun Heo <htejun@gmail.com>, Mark Lord <lkml@rtr.ca>, David Greaves <david@dgreaves.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de

Linus Torvalds wrote:
> 
> On Mon, 27 Feb 2006, Jeff Garzik wrote:
> 
>>I've had this waiting in the wings, in fact...  [see attached]
> 
> 
> I really hate having a _global_ variable called "fua". That's just bad 
> taste. I would suggest calling it "atapi_forced_unit_attention_enabled", 
> but maybe that is going a bit overboard. It's definitely better than just 
> "fua", though.

<shrug>  It will go away when things are fixed, and only users who are 
testing will even bother with it.

Looking over the module subsystem, it looks like one could use 
module_param_named() to achieve proper namespace separation (C versus 
module opt) -- then you could call it libata_fua -- but for a temporary 
module option it seems like more trouble than its worth.

	Jeff



