From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Fri, 28 Mar 2008 15:16:25 +0000
Message-ID: <20080328151625.0791c2dd@core>
References: <12066128663306-git-send-email-htejun@gmail.com>
	<47EBAE2B.8070102@rtr.ca>
	<47EBB09F.9070607@rtr.ca>
	<47EC5079.5020105@gmail.com>
	<47EC58F6.3070601@rtr.ca>
	<47ECF47A.2040508@emc.com>
	<47ED061F.2070701@gmail.com>
	<47ED0681.4090003@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53004 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754060AbYC1Pdp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 11:33:45 -0400
In-Reply-To: <47ED0681.4090003@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ric@emc.com
Cc: Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, jeff@garzik.org, linux-ide@vger.kernel.org

> I do agree with the above, we should try to get the FLUSH done according 
> to spec, I meant to argue that we should bound the time spent. If my 
> laptop spends more than 30? 60? 120? seconds trying to flush a write 
> cache, I will probably be looking for a way to force it to power down ;-)

But if your PhD thesis is being written back you'd be different 8). I am
not sure we can exceed 30 seconds, currently although we set 60 second
I/O timeouts we are timing out at 30 seconds in some traces I get sent so
something is messing up our timeout handling back to the default. I've
tried tracing it and so far failed to figure it out.

> It is also worth noting that most users of ext3 run without barriers 
> enabled (and the drive write cache enabled) which means that we test 
> this corruption path on any non-UPS power failure.

It is most unfortunate that distributions continue to ship that default.

Alan
