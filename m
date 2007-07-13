From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 1/3] Make the IDE DMA timeout modifiable
Date: Fri, 13 Jul 2007 15:36:05 -0400
Message-ID: <4697D425.7000300@rtr.ca>
References: <20070221011922.GA1777@freefall.freebsd.org>	<200702210342.20775.bzolnier@gmail.com>	<466EEFD6.9030001@ru.mvista.com>	<200706160123.55636.bzolnier@gmail.com>	<4693D9B6.4090408@ru.mvista.com> <20070713161612.2f2ebb0b@the-village.bc.nu> <46979652.6040201@rtr.ca> <4697987E.3040406@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2675 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759357AbXGMTgI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 15:36:08 -0400
In-Reply-To: <4697987E.3040406@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Suleiman Souhlal <ssouhlal@freebsd.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Sergei Shtylyov wrote:
> Mark Lord wrote:
> 
>>> O> >>    BTW, why the timeout is so damn long? 2*WAIT_CMD is 20 secs, 
>>> and if DMA is not complete or interrupt pending, it may wait 10 more secs...
..
>> I've lost the original question from this thread, but the idea of the 
> 
>    The original question concerned specifically the DMA command timeout 
> which is twice more than the usual one, WAIT_CMD (10 seconds).
> 
>> longish
>> timeouts was that drive *may* be spun down ("standby"), and thus have 
>> to spin
>> up again to complete media commands.  Back then, drives were much 
>> slower at
>> spinning up than nowadays, and the ATA spec says to allow up to 30 
>> seconds.
> 
>    Well, that doesn't explain the DMA case.

When a drive is in standby, we don't send it anything special to wake up.
So even DMA commands have to have a long enough timeout to allow
for spinning up.

Cheers
