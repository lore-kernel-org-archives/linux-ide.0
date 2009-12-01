From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata hotplug question
Date: Tue, 01 Dec 2009 13:43:40 +1100
Message-ID: <1259635420.2076.180.camel@pasglop>
References: <1259561052.2076.73.camel@pasglop>
	 <1259624651.2076.158.camel@pasglop>  <4B1459B5.40504@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54285 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196AbZLACoQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Nov 2009 21:44:16 -0500
In-Reply-To: <4B1459B5.40504@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org


> Oh... yeah, that was the original intention when adding those
> functions but you wouldn't need them for hot plug/unplug.  Just set
> probe mask and freeze the port.  EH will do the right thing.

So I experimented a bit... and not touching probe_mask at all, just
doing ata_ehi_hotplugged and ata_port_freeze seems to get the basics
working, however with a few issues.

For example, if I remove the device, it will spend a few second trying
to poke at it & reset the bus before deciding its gone. This isn't a
terribly good idea (and could cause "interesting" issues if it's
re-plugged right away in fact)

I tried toying with the probe_mask bits but it doesn't seem to make any
difference here. I must admit that I got more or less lost as to what
probe_mask actually means, how it's used, when it's initialized and when
it's cleared. I will try to spend some more time later looking at the
code and trying to sort it out but it doesn't appear to be a great
solution.

At the end of the day, it might be better to just add those link
callbacks... I'll give that a try too, unless you have a better idea.

In addition, to speed up boot time, I want to remove the synchronous
waiting for the media bay to be up that we have in there, which is easy
since it's already run by a kthread.

The reason I had that was originally to provide some stability in drive
ordering with old drivers/ide and have the drive ready at boot when the
driver was probed, but that isn't really necessary anymore. I will
provide a callback to keep doing that synchronous wait for the old IDE
driver because I don't want to deal with races there at boot time, but
for libata, I can just trigger the EH for a hotplug at about any time.

But for that to work right, I need to be able to prevent probing when
setting up the host, when I know that the bay is empty, which the link
stuff would cover nicely too, don't you think ? Or do you have a better
idea ?

I also have to be careful of a possible race if the hotplug callback
since it can potentially happen as soon as I enter my driver->probe()
(it comes from the macio "bus" layer). What is the harm of triggering a
hotplug if nothing was actually unplugged ? Will libata silently just
keep things as they were ?

Cheers,
Ben. 

