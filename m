From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata hotplug question
Date: Tue, 01 Dec 2009 16:24:42 +1100
Message-ID: <1259645082.2076.210.camel@pasglop>
References: <1259561052.2076.73.camel@pasglop>
	 <1259624651.2076.158.camel@pasglop>  <4B1459B5.40504@kernel.org>
	 <1259635420.2076.180.camel@pasglop>  <4B14A0EC.70607@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55930 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbZLAFZQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 00:25:16 -0500
In-Reply-To: <4B14A0EC.70607@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Tue, 2009-12-01 at 13:51 +0900, Tejun Heo wrote:
> 
> If the hotplug events are completely reliable, we can add a flag to
> tell libata EH to trust the hotplug notices completely but then again
> I'm not too convinced about the benefits of implementing it in very
> small number of drivers.  It could be more beneficial to keep the
> behavior consistent across all ATA drivers.

Well... in my case I know for sure the device is out. So the stuff
libata does to try to poke at the device is not only a waste of time,
but a few scary messages in the dmesg log ;-)

> It's basically an advisory flag telling libata to try to look for new
> devices.  From outside EH, the only behavior difference is that with
> the flag set EH will try to re-enable ports which got disabled due to
> repeated reset failures.

Ok, but ata_ehi_hotplugged() will set it anyway so I don't really have
to do anything.

> > At the end of the day, it might be better to just add those link
> > callbacks... I'll give that a try too, unless you have a better
> idea.
> 
> Link callbacks won't change the hotplug behavior tho.

Right, see my other message, they make the situation even more complex
in fact so I'm backing off that.

> Oh yeah, link stuff will help that.  Or you can also implement custom
> softreset which checks link status and exits early if there's no
> device.

That might be an option, I'll look at it.

> The only problem with the latter approach is that you'll need
> to take care of the race window in the driver itself.  You can close
> the window by checking link status again in postreset and rescheduling
> hotplug event if hotplug event happened after the link state is
> checked in softreset but before the port was thawed.

I've done simpler. I've added a pair of calls to lock/unlock the media
bay which directly grab the bay driver internal mutex, which guarantees
we won't get any callback while we hold it. I could have done something
like you described instead but this is easy and allow to also easily
solve some of the possible races with drivers/ide while at it.

> Those events are all advisory.  The final decision is always upto what
> the reset methods and following probes tell the EH, so it may go
> through one more EH round but it won't lose anything.

That's what I'm starting to understand :-) Very good. I'll look at the
custom softreset approach.

Cheers,
Ben.

