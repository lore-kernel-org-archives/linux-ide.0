From: Tejun Heo <tj@kernel.org>
Subject: Re: libata hotplug question
Date: Tue, 01 Dec 2009 13:51:56 +0900
Message-ID: <4B14A0EC.70607@kernel.org>
References: <1259561052.2076.73.camel@pasglop>	 <1259624651.2076.158.camel@pasglop>  <4B1459B5.40504@kernel.org> <1259635420.2076.180.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34346 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397AbZLAEvk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Nov 2009 23:51:40 -0500
In-Reply-To: <1259635420.2076.180.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

Hello, Benjamin.

On 12/01/2009 11:43 AM, Benjamin Herrenschmidt wrote:
> 
>> Oh... yeah, that was the original intention when adding those
>> functions but you wouldn't need them for hot plug/unplug.  Just set
>> probe mask and freeze the port.  EH will do the right thing.
> 
> So I experimented a bit... and not touching probe_mask at all, just
> doing ata_ehi_hotplugged and ata_port_freeze seems to get the basics
> working, however with a few issues.
> 
> For example, if I remove the device, it will spend a few second trying
> to poke at it & reset the bus before deciding its gone. This isn't a
> terribly good idea (and could cause "interesting" issues if it's
> re-plugged right away in fact)

This is actually required for SATA at least.  Because there usually
isn't a separate mechanism to determine device hotplugginga, any link
layer glitch can't be discerned from hotplug events and in SATA link
glitches happens from time to time even on perfectly healthy systems,
so if EH ditches the device immediately after phy event, the system
will lose filesystems underneath it quite often, so the grace period
(IIRCa it's around 15secs) is intentional.

If someone removes power to a drive and then reapplies it while it's
working, then there just isn't so much libata can do about that.  If
ATA devices had a event counter or a flag which indicates that it lost
data in the buffer, then libata would be able to detect such events
and ditch the device immediately and reprobe it as a different device.
That would also solve the data loss issues with flaky power supplies
but without such mechanism, we just can't discern between the two.

If the hotplug events are completely reliable, we can add a flag to
tell libata EH to trust the hotplug notices completely but then again
I'm not too convinced about the benefits of implementing it in very
small number of drivers.  It could be more beneficial to keep the
behavior consistent across all ATA drivers.

> I tried toying with the probe_mask bits but it doesn't seem to make any
> difference here. I must admit that I got more or less lost as to what
> probe_mask actually means, how it's used, when it's initialized and when
> it's cleared. I will try to spend some more time later looking at the
> code and trying to sort it out but it doesn't appear to be a great
> solution.

It's basically an advisory flag telling libata to try to look for new
devices.  From outside EH, the only behavior difference is that with
the flag set EH will try to re-enable ports which got disabled due to
repeated reset failures.

> At the end of the day, it might be better to just add those link
> callbacks... I'll give that a try too, unless you have a better idea.

Link callbacks won't change the hotplug behavior tho.

> In addition, to speed up boot time, I want to remove the synchronous
> waiting for the media bay to be up that we have in there, which is easy
> since it's already run by a kthread.
> 
> The reason I had that was originally to provide some stability in drive
> ordering with old drivers/ide and have the drive ready at boot when the
> driver was probed, but that isn't really necessary anymore. I will
> provide a callback to keep doing that synchronous wait for the old IDE
> driver because I don't want to deal with races there at boot time, but
> for libata, I can just trigger the EH for a hotplug at about any time.
> 
> But for that to work right, I need to be able to prevent probing when
> setting up the host, when I know that the bay is empty, which the link
> stuff would cover nicely too, don't you think ? Or do you have a better
> idea ?

Oh yeah, link stuff will help that.  Or you can also implement custom
softreset which checks link status and exits early if there's no
device.  The only problem with the latter approach is that you'll need
to take care of the race window in the driver itself.  You can close
the window by checking link status again in postreset and rescheduling
hotplug event if hotplug event happened after the link state is
checked in softreset but before the port was thawed.

> I also have to be careful of a possible race if the hotplug callback
> since it can potentially happen as soon as I enter my driver->probe()
> (it comes from the macio "bus" layer). What is the harm of triggering a
> hotplug if nothing was actually unplugged ? Will libata silently just
> keep things as they were ?

Those events are all advisory.  The final decision is always upto what
the reset methods and following probes tell the EH, so it may go
through one more EH round but it won't lose anything.

Thanks.

-- 
tejun
