From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2/7] sata_mv: deal with interrupt coalescing interrupts
Date: Sat, 20 May 2006 10:01:28 -0400
Message-ID: <446F2138.9060406@rtr.ca>
References: <11480537082648-git-send-email-htejun@gmail.com> <446DEE92.50102@pobox.com> <200605191614.00023.liml@rtr.ca> <200605191624.56928.liml@rtr.ca> <446E9BE1.3060700@pobox.com> <446F160C.40204@rtr.ca> <446F1883.9090601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 206-248-132-125.dsl.teksavvy.com ([206.248.132.125]:7659 "EHLO
	shrimpy") by vger.kernel.org with ESMTP id S964841AbWETOB3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 May 2006 10:01:29 -0400
In-Reply-To: <446F1883.9090601@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
>
> Unless you have a _lot_ of ports active at the same time, irq coalescing 
> can increase latency.

I agree, which is why I haven't actually turned it on yet.
But a runtime sysfs attr for it should allow us to benchmark
things, and see if it really helps or not under various loads.

> Ideally, for this, AHCI, and any other SATA controller that does 
> coalescing, we have a runtime dynamic trigger that turns on coalescing 
> when interrupt traffic exceeds a runtime limit.

Yeah, if coalescing turns out to be a win under hight load,
then a generic strategy like that would be a great feature.

Cheers
