From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/3] Make the IDE DMA timeout modifiable
Date: Sat, 14 Jul 2007 00:08:18 +0400
Message-ID: <4697DBB2.7020507@ru.mvista.com>
References: <20070221011922.GA1777@freefall.freebsd.org>	<200702210342.20775.bzolnier@gmail.com>	<466EEFD6.9030001@ru.mvista.com>	<200706160123.55636.bzolnier@gmail.com>	<4693D9B6.4090408@ru.mvista.com> <20070713161612.2f2ebb0b@the-village.bc.nu> <46979652.6040201@rtr.ca> <4697987E.3040406@ru.mvista.com> <4697D425.7000300@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:46404 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755592AbXGMUGR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 16:06:17 -0400
In-Reply-To: <4697D425.7000300@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Suleiman Souhlal <ssouhlal@freebsd.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mark Lord wrote:

>>>> O> >>    BTW, why the timeout is so damn long? 2*WAIT_CMD is 20 
>>>> secs, and if DMA is not complete or interrupt pending, it may wait 
>>>> 10 more secs...

> ..

>>> I've lost the original question from this thread, but the idea of the 

>>    The original question concerned specifically the DMA command 
>> timeout which is twice more than the usual one, WAIT_CMD (10 seconds).

>>> longish
>>> timeouts was that drive *may* be spun down ("standby"), and thus have 
>>> to spin
>>> up again to complete media commands.  Back then, drives were much 
>>> slower at
>>> spinning up than nowadays, and the ATA spec says to allow up to 30 
>>> seconds.

>>    Well, that doesn't explain the DMA case.

> When a drive is in standby, we don't send it anything special to wake up.

    Wait, aren't we sending IDLE on resume step 2 -- looking at 
ide-io.cide_start_power_step()?

> Cheers

MBR, Sergei
