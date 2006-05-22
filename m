From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/7] sata_mv: deal with interrupt coalescing interrupts
Date: Mon, 22 May 2006 02:35:07 -0400
Message-ID: <44715B9B.6010208@pobox.com>
References: <11480537082648-git-send-email-htejun@gmail.com> <446DEE92.50102@pobox.com> <200605191614.00023.liml@rtr.ca> <200605191624.56928.liml@rtr.ca> <446E9BE1.3060700@pobox.com> <446F160C.40204@rtr.ca> <446F1883.9090601@pobox.com> <446F2138.9060406@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:14215 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932503AbWEVGfK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2006 02:35:10 -0400
In-Reply-To: <446F2138.9060406@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
>>
>> Unless you have a _lot_ of ports active at the same time, irq 
>> coalescing can increase latency.
> 
> I agree, which is why I haven't actually turned it on yet.
> But a runtime sysfs attr for it should allow us to benchmark
> things, and see if it really helps or not under various loads.
> 
>> Ideally, for this, AHCI, and any other SATA controller that does 
>> coalescing, we have a runtime dynamic trigger that turns on coalescing 
>> when interrupt traffic exceeds a runtime limit.
> 
> Yeah, if coalescing turns out to be a win under hight load,
> then a generic strategy like that would be a great feature.

It should definitely be a win.  Every irq raised by the system, even 
with MSI, has a fixed overhead, with spinlocks being taken along the way 
or disable/enable_irq() deep in the system irq handler code.  Its a 
measurable CPU usage win reducing that overhead, if nothing else.

I've already "been there, done that" in the networking area, which 
benefits from hardware (coalescing) and software (polling) interrupt 
mitigation.  Hardware miti mitigates interrupts on a per-hardware basis, 
but doesn't have any inherent overall-system-load feedback mechanisms. 
Software miti takes into account overall system load, but can be 
somewhat dumb at times (can add overhead at low loads).  However, "high 
load" in networking easily means 10x or 100x the number of interrupts 
per second.  Networking also processes data in smaller chunks (== more 
interrupt events).  SATA is catching up though, at 3.0Gbps+ and 8-port 
cards.

	Jeff



