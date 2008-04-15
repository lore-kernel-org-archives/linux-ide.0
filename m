From: Mark Lord <liml@rtr.ca>
Subject: Re: [patch 2/2] libata: power off unused ports
Date: Tue, 15 Apr 2008 15:02:40 -0400
Message-ID: <4804FBD0.8060900@rtr.ca>
References: <20080325221646.567639335@intel.com>	<20080325152813.0b34761f@appleyard>	<48003A5D.9000306@garzik.org> <20080414161122.03b2211d@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2352 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753972AbYDOTCm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Apr 2008 15:02:42 -0400
In-Reply-To: <20080414161122.03b2211d@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kristen.c.accardi@intel.com
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, arjan@linux.intel.com

Kristen Carlson Accardi wrote:
> On Sat, 12 Apr 2008 00:28:13 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
..
>> Thinking about the bigger pictures, powering off the phy is something we 
>> want to do in a lot more cases than this, but there is a stumbling 
>> block:  we wander into the realm of policy.
>>
>> For most users most of the time, empty SATA ports are needlessly 
>> powered.  The problem is that, at any given moment, a device may be 
>> hot-plugged, so we must be ready for that.  We need some way for the 
>> user to let the driver know that they will not be hotplugging anything 
>> anytime soon, permitting power savings to be enabled.
>>
>> A compromise solution that avoids adding a userspace "knob" has also 
>> been proposed (by Tejun, I think?):  power up the phy every N seconds, 
>> check for device, power down phy if nothing.  That should provide some 
>> power savings, though not as much as with a "knob" switched to "hotplug: 
>> off"
..

How long does a poll actually take, in real time?
Probably a hundred milliseconds or two, to see if the PHY syncs up?

So with a knob set to, say 2 seconds (sysfs), then this would
save 90% of the power of a permanent "off".  That's pretty good,
and setting that same knob to "infinity" (-1 ?) would achieve 100%.
Definitely a good way to go, IMHO.

> I think that for the common case - we should use HPCP to determine if
> the suggested use of the port is for hot plug.  I can see your point
> about wanting to give the user the option to just disregard the intended
> use of the port and do what they want, but I say we don't make that
> the default behavior.  And, I don't like the idea of adding another
> wakeup in the driver to do polling - seems like 99% of users are
> going to be just fine with a knob - and that they should only
> have to use the knob to override the default (or how bout a 
> module param?).  I don't think we should compromise power for a 
> feature that most people are unlikely to use (if HPCP is not set).
..

I worry that this is far too x86 / vendor specific.
Most of the SATA ports I have here, for example, probably lack this HPCP bit
even on x86, and on other arch's it likely doesn't exist at all, right?

For arch/system/device that does have HPCP implemented, then sure,
it could be used to automatically tweak the sysfs knob.
But from userspace perhaps, rather than kernel ?

Thanks

