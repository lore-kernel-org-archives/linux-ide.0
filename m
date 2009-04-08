From: Jeff Garzik <jeff@garzik.org>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
Date: Wed, 08 Apr 2009 02:12:46 -0400
Message-ID: <49DC405E.5050005@garzik.org>
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>	 <ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com> <1239156559.10104.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51627 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753940AbZDHGNx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Apr 2009 02:13:53 -0400
In-Reply-To: <1239156559.10104.7.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: michael@ellerman.id.au
Cc: Timur Tabi <timur@freescale.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Linux PPC Development <linuxppc-dev@ozlabs.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

Michael Ellerman wrote:
> On Tue, 2009-04-07 at 19:36 -0500, Timur Tabi wrote:
>> On Tue, Apr 7, 2009 at 6:57 PM, Tejun Heo <tj@kernel.org> wrote:
>>
>>> Hmmm... that means intx isn't set by default.  I'm not sure what is
>>> the right thing to do here.  I think it's something which should be
>>> handled by the PCI layer.  Oh well, maybe we should just revert the
>>> change and keep setting intx?
>> cc'ing linuxppc-dev
>>
>> I really don't know what should be done.  It seems to make sense to
>> have the PCI layer enable interrupts.
>>
>> This seems to be a powerpc-specific bug, but I don't know enough of
>> the PCI subsystem.
> 
> Have you confirmed that INTX is disabled before that call?

The symptoms definitely indicate such, as well as his reversing that commit.

My guess is that this is a ULI M1575-specific bug, and the PCI layer 
needs a quirk that knows this device does -not- disable INTX, when MSI 
is enabled.

But honestly, I never saw any harm in disabling INTX manually.  Indeed, 
I wrote the code that disabled INTX out of now-substantiated paranoia 
that some PCI devices would be too dumb to follow that particular MSI 
rule...  and the cost of twiddling INTX seemed quite low in comparison 
the potential problems created by the absence of INTX twiddling.

	Jeff



