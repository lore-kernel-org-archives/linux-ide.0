From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/7] sata_mv: deal with interrupt coalescing interrupts
Date: Sat, 20 May 2006 09:24:19 -0400
Message-ID: <446F1883.9090601@pobox.com>
References: <11480537082648-git-send-email-htejun@gmail.com> <446DEE92.50102@pobox.com> <200605191614.00023.liml@rtr.ca> <200605191624.56928.liml@rtr.ca> <446E9BE1.3060700@pobox.com> <446F160C.40204@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32965 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964844AbWETNYW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 May 2006 09:24:22 -0400
In-Reply-To: <446F160C.40204@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
>> Applied, though I would like a follow-up which simply guarantees that 
>> irq coalescing is off.
> 
> Perhaps.  I'm getting pressure to do the exact opposite from users
> of this chipset --> they'd like IRQ coalescing to be guaranteed to
> be turned *on*.  Maybe a sysfs attr for it, with default == off ?

Yes, I should have been more clear.  Support is fine, as long as the 
default is off.

Unless you have a _lot_ of ports active at the same time, irq coalescing 
can increase latency.

Ideally, for this, AHCI, and any other SATA controller that does 
coalescing, we have a runtime dynamic trigger that turns on coalescing 
when interrupt traffic exceeds a runtime limit.

	Jeff



