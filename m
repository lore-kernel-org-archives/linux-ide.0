From: Heiko Schocher <hs@denx.de>
Subject: Re: ata, pcmcia: problem with irq and ata_dev_read_id()
Date: Mon, 26 Jul 2010 14:59:16 +0200
Message-ID: <4C4D86A4.2040500@denx.de>
References: <4C034FAE.9090605@denx.de> <4C044C8F.8050406@gmail.com>
 <4C2833B2.3040209@denx.de> <4C2DFF43.6050502@gmail.com>
 <4C319741.3060602@denx.de> <4C319D31.60705@gmail.com>
 <4C31A519.7030806@denx.de> <4C31A6DF.9080109@gmail.com>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a.relay.invitel.net ([62.77.203.3]:46648 "EHLO
	a.relay.invitel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab0GZM7X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jul 2010 08:59:23 -0400
In-reply-to: <4C31A6DF.9080109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello Tejun,

Tejun Heo wrote:
> On 07/05/2010 11:25 AM, Heiko Schocher wrote:
>>> Yeah, that's the new polling code kicking in.  If the IRQ problem
>>> doesn't persiste (which should be the case here), polling will step
>>> down after a while and everything will return to normal.  If you keep
>>> the system running more than ten minutes and use the CF device, does
>>> the kernel complain anymore?
>> No, I can use the CF while kernel is in polling mode, also if the
>> kernel switched back to irq mode:
>>
>> Log, direct after kernel is up:
>>
> ..
>>  25:          9   MPC8XX SIU       Level        pata_pcmcia
>>  26:      10000   MPC8XX SIU       Level        pata_pcmcia
> ...
>> No irq is used.
>>
>> -bash-3.2# dmesg
>> [...]
>> Freeing unused kernel memory: 132k init
>> IRQ 26: spurious polling finished, reenabling IRQ
>> -bash-3.2#
>>
>> Now it is back in irq mode:
>>
>> -bash-3.2# cat /proc/uptime
>> 419.65 370.56
>> -bash-3.2#
>>
> ...
>>  25:          9   MPC8XX SIU       Level        pata_pcmcia
>>  26:      10033   MPC8XX SIU       Level        pata_pcmcia
> 
> Cool, so it works as expected.  With the new lost/spurious IRQ
> handling in place, removing TFLAG_POLLING from read_id for all
> controllers shouldn't cause much problem.  However, the CF device is a
> pretty rare corner case and spurious IRQ handling can deal with it
> without too much problem, so leaving things as it is is probably
> better.

Hmm.. I am not sure if "leaving things as it is" is the better way,
because this behaviour comes every time, I insert a card! And with
my patch I can prevent this behaviour ...

> Thanks for testing.

Thanks for your comments!

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
