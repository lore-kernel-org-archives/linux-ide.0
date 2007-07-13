From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/3] Make the IDE DMA timeout modifiable
Date: Sat, 14 Jul 2007 00:03:58 +0400
Message-ID: <4697DAAE.5090704@ru.mvista.com>
References: <20070221011922.GA1777@freefall.freebsd.org>	<200702210342.20775.bzolnier@gmail.com>	<466EEFD6.9030001@ru.mvista.com>	<200706160123.55636.bzolnier@gmail.com>	<4693D9B6.4090408@ru.mvista.com> <20070713161612.2f2ebb0b@the-village.bc.nu> <46979652.6040201@rtr.ca> <4697987E.3040406@ru.mvista.com> <4697D425.7000300@rtr.ca> <4697D518.7010108@ru.mvista.com> <4697D686.6090104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:46365 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758358AbXGMUB5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 16:01:57 -0400
In-Reply-To: <4697D686.6090104@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Suleiman Souhlal <ssouhlal@freebsd.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mark Lord wrote:

>>>>    The original question concerned specifically the DMA command 
>>>> timeout which is twice more than the usual one, WAIT_CMD (10 seconds)...

>>> When a drive is in standby, we don't send it anything special to wake 
>>> up.
>>> So even DMA commands have to have a long enough timeout to allow
>>> for spinning up.

>>    Yes, but why *twice* as long as the others?

> I would guess simply because DMA has to transfer up to 256 sectors of data,
> possibly with sector reallocations, in addition to waiting for the drive
> to spin up.  Other commands don't.

    What?! PIO commands don't have to do this as well? :-)

> At the time that was coded (?), I suspect that PIO READ/WRITE commands
> were fed data as it became available to/from the drive.  This may or may

    I don't see *any* difference with the DMA commands here -- the drive has 
always been free to assert and deassert DMARQ at its well.

> not still be the case, but it does imply that they don't need to hang
> around as long on the timeouts as do DMA commands (which have to wait
> for *everything* to be transferred).

    Ah, that makes sense -- during PIO interrupts happen a lot more often.
20 secs still seem to be too much.

> Cheers

MBR, Sergei

PS: Your mail server still keeps bouncing me off. :-(
