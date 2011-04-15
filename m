From: Mark Lord <kernel@teksavvy.com>
Subject: Re: sata_mv port lockup on hotplug (kernel 2.6.38.2)
Date: Thu, 14 Apr 2011 23:32:27 -0400
Message-ID: <4DA7BC4B.9090104@teksavvy.com>
References: <C1438B59050E1B4C9482FF3266AD6BA32C7493557A@gretna.indigovision.com> <C1438B59050E1B4C9482FF3266AD6BA32C7493559F@gretna.indigovision.com> <4D9CD275.9000002@teksavvy.com> <C1438B59050E1B4C9482FF3266AD6BA32C749358D0@gretna.indigovision.com> <alpine.DEB.2.00.1104150510181.14027@uplift.swm.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:42627 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754161Ab1DODca (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Apr 2011 23:32:30 -0400
In-Reply-To: <alpine.DEB.2.00.1104150510181.14027@uplift.swm.pp.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Abrahamsson <swmike@swm.pp.se>
Cc: Bruce Stenning <b.stenning@indigovision.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 11-04-14 11:15 PM, Mikael Abrahamsson wrote:
> On Fri, 8 Apr 2011, Bruce Stenning wrote:
> 
>> The 2.6.38.2 kernel still exhibits the same lockups that we see with the
>> 2.6.26 kernel.
> 
> Hi.
> 
> I have some input on this. I have one of these controllers and had problems with
> one channel where if I had a drive in that hotswap bay, the controller wouldn't
> even POST at boot. It just stuck in the detection phase in the controller BIOS.
> 
> When I tested hotplugging into that bay when the system was running, I received
> a kernel warning (it's not powered on at the moment so I can't provide the
> output, if it's important I can get it).

I would like to see the output, next time you can get it.

The thing with the 6041 chip, is that I actually have all of the Marvell
documentation and errata info for the chip.  So in theory, we know everything
about it, and there are no secret failure modes yet to be discovered.
The sata_mv driver does not depend on the board's BIOS for anything either.

That's the theory, anyway.  :)

Cheers
