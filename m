From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata hotplug question
Date: Tue, 01 Dec 2009 16:17:27 +1100
Message-ID: <1259644647.2076.204.camel@pasglop>
References: <1259561052.2076.73.camel@pasglop>
	 <1259624651.2076.158.camel@pasglop>  <4B1459B5.40504@kernel.org>
	 <1259635420.2076.180.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:34546 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbZLAFSC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 00:18:02 -0500
In-Reply-To: <1259635420.2076.180.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Tue, 2009-12-01 at 13:43 +1100, Benjamin Herrenschmidt wrote:
> > Oh... yeah, that was the original intention when adding those
> > functions but you wouldn't need them for hot plug/unplug.  Just set
> > probe mask and freeze the port.  EH will do the right thing.

 .../...

> But for that to work right, I need to be able to prevent probing when
> setting up the host, when I know that the bay is empty, which the link
> stuff would cover nicely too, don't you think ? Or do you have a better
> idea ?
> 
> I also have to be careful of a possible race if the hotplug callback
> since it can potentially happen as soon as I enter my driver->probe()
> (it comes from the macio "bus" layer). What is the harm of triggering a
> hotplug if nothing was actually unplugged ? Will libata silently just
> keep things as they were ?

So I tried with implementing the link_online and link_offline callbacks
and it doesn't fly very high.

When I unplug the bay, it displays:

ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata3: EH complete

and doesn't really "unplug" it (ie, trying to access the device then
causes all sorts of errors to pile up in the log). Plugging it back then
causes it to soft reset and restore the DMA timings and it works again.

But it's overall sub optimal. Comparatively, it worked better without
the link callbacks though I would call it sub-optimal :-)

What would be the best way to tell libata to just remove the device and
not bother poking the HW again on an unplug and do as it does today on a
plug without the link callbacks ?

Cheers,
Ben.

