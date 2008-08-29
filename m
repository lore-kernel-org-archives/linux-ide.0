From: Tejun Heo <tj@kernel.org>
Subject: Re: Promise 300-TX 4-channel SATA disk going dead under load 2.6.24-7
Date: Fri, 29 Aug 2008 15:18:08 +0200
Message-ID: <48B7F710.8080007@kernel.org>
References: <48A35FE6.1080903@tlinx.org> <200808291339.59785.trenn@suse.de> <48B7E573.60601@kernel.org> <200808291511.02062.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43147 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149AbYH2NTv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Aug 2008 09:19:51 -0400
In-Reply-To: <200808291511.02062.trenn@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Linda Walsh <lkml@tlinx.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux acpi <linux-acpi@vger.kernel.org>

Thomas Renninger wrote:
>>> There were several acpipnp problems recently, but this is another topic
>>> and that needs fixing anyway, Bjorn is doing a real good job here.
>> Hmm... Maybe what's necessary it to detect IRQ misrouting and turn on
>> irqpoll on the specific IRQ (or IRQ handler), which would help 'nobody
>> cared' cases too.
> But you risk that things never get fixed correctly.
> At least yell loudly at the user that things must get fixed.
> IMO the a message (you already see appearing?) at the right place:
> try irqpoll, try xyz param is enough.

Yeah, the kernel should scream like hell but keep working after screaming.

> The current behavior is not that bad and not that much machines
> (at least new machines) are affected, but as said I am not
> deeply involved in PCI/IRQ things.

The thing is IRQ storms occassionally happen on otherwise working
machines taking down the IRQ and all the devices running off the IRQ, so
it's not as cut and dry as boot or no boot.

Thanks.

-- 
tejun
