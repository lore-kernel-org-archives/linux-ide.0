From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 0/3] OF-platform PATA driver
Date: Sat, 24 Nov 2007 12:23:56 +1100
Message-ID: <1195867436.7195.37.camel@pasglop>
References: <20071123175229.GA27143@localhost.localdomain>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:53967 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710AbXKXBYT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 20:24:19 -0500
In-Reply-To: <20071123175229.GA27143@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org


On Fri, 2007-11-23 at 20:52 +0300, Anton Vorontsov wrote:

> As an alternative approach we can use plain pata_platform
> driver, but I'm not sure how Linux OF bindings' ideologists will
> or will not like it.
> 
> So, these patches are strongly Request For Comments. Feel free
> to train your nitpicking skills ;-), and/or vote for the option
> you most pleased about (or suggest another?).
> 
> 
> Thanks.
> 
> ---
> Down here is "alternative approach".
> 
> Probably board-neutral version may be placed somewhere in
> the drivers/of/...? But who will call it: board file, or
> device_initcall for all boards?

 .../...

I'm fine with either approaches in fact. I think it's fair enough when
there is existing platform devices to avoid duplicating the whole thing
for an of_platform_device (unless you find a nice way to split to a
library like you just did) and instead, have a "constructor" that
constructs the platform device based on the OF node.

Now, as you pointed out, the question is where to call it... the
initcall has the problem of potentially being called for the wrong board
and the thing having duplicate OF device and platform device created for
it...

One of the thing I've been brewing in my mind is the idea of reworking
the current code that create OF platform devices when walking busses
down, and have it instead call registered constructor functions. The
default ones would then create OF platform devices but one could
override that with constructors creating something else (such as a
platform device).

Now, it's not trivial, as there is a bit of a mixup on whether a "bus"
should create all children and thus define their type (PCI would do such
a thing) or whether the type is defined by the device object itself
which typically would be the case for "generic" busses such as SoCs or
PLBs when creating platform devices. I haven't quite found out a nice
way to enable both possibilities... if you have ideas, please share.

In the meantime, maybe it's best to merge the of_platform_device
approach since Jeff agrees with it.

Cheers,
Ben.


