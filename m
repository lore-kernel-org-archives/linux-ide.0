From: Tejun Heo <tj@kernel.org>
Subject: Re: Promise 300-TX 4-channel SATA disk going dead under load 2.6.24-7
Date: Fri, 29 Aug 2008 14:02:59 +0200
Message-ID: <48B7E573.60601@kernel.org>
References: <48A35FE6.1080903@tlinx.org> <200808281436.30089.trenn@suse.de> <48B7CD5E.1050701@kernel.org> <200808291339.59785.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51294 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226AbYH2MEl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Aug 2008 08:04:41 -0400
In-Reply-To: <200808291339.59785.trenn@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Linda Walsh <lkml@tlinx.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux acpi <linux-acpi@vger.kernel.org>

Thomas Renninger wrote:
> On Friday 29 August 2008 12:20:14 Tejun Heo wrote:
>> Thomas Renninger wrote:
>>> Also the system is really old. Why don't you stick to pci=noacpi or
>>> even acpi=off?
>>> What advantage do you want to get with ACPI (SATA works?)?
>> I think this is the second time I see ACPI IRQ routing doesn't work on
>> old ACPI.
> Hey, that's great. I expected you have seen much more (you inflicted me
> on more than two? :) ).

Yeah, I tend to redirect all IRQ routing related problems to you.  :-P

...
> where pci=noacpi helped. IMO not worth an automated detection.
> Especially for those old machines..., people know which param to use, you will
> produce more grief than any good.
> 
> There were several acpipnp problems recently, but this is another topic and 
> that needs fixing anyway, Bjorn is doing a real good job here.

Hmm... Maybe what's necessary it to detect IRQ misrouting and turn on
irqpoll on the specific IRQ (or IRQ handler), which would help 'nobody
cared' cases too.  Misrouted or killed IRQs cause a lot of griefs and
sporadic ones are kinda wide spread.  For example, I got hit by one
during resume for an IRQ shared by USB, 1394 and sound controller after
probably hundreds of successful suspend/resume cycles (not in one go) on
the same machine and that somehow caused the sound driver to get stuck
leaving no way out than rebooting.

Thanks.

-- 
tejun
