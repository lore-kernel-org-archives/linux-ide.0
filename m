From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: Odd behaviour of device in response to idleimmediate with unload
Date: Thu, 13 Nov 2008 13:29:39 +0100
Message-ID: <87fxlvreq4.fsf@denkblock.local>
References: <491083CC.5050508@rtr.ca> <49108AA0.1080507@rtr.ca>
	<491090BC.5060403@rtr.ca> <20081104185444.3BE721FDF7@chi.die-welt.net>
	<4910A509.1030307@rtr.ca> <49116811.5000109@kernel.org>
	<873ai6cmio.fsf@denkblock.local> <4911A8EA.8030605@kernel.org>
	<87k5bhxerq.fsf@denkblock.local> <4913BF3D.3090704@kernel.org>
	<20081107074857.GA6461@dragonheart.kerker.die-welt.net>
	<4917F822.5060204@kernel.org>
	<20081110102607.094281FD7C@chi.die-welt.net>
	<87r65ju83r.fsf@denkblock.local>
	<20081113113345.12E2D1FD80@chi.die-welt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:54252 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbYKMM3z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Nov 2008 07:29:55 -0500
In-Reply-To: <20081113113345.12E2D1FD80@chi.die-welt.net> (Evgeni Golov's
	message of "Thu, 13 Nov 2008 12:33:38 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Evgeni Golov <sargentd@die-welt.net>
Cc: Tejun Heo <tj@kernel.org>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Evgeni Golov <sargentd@die-welt.net> wrote:
> On Mon, 10 Nov 2008 12:35:20 +0100 Elias Oltmanns wrote:
>
>> Evgeni Golov <sargentd@die-welt.net> wrote:
>> > On Mon, 10 Nov 2008 18:00:18 +0900 Tejun Heo wrote:
>> >
>> >> Is the phy event before or after head unloading?
>> >
>> > How do I check this?
>> 
>> # dmesg
>> # echo 3000 > /sys/block/sda/device/unload_heads &
>> # dmesg
>> 
>> The first call to dmesg is only to make sure that it is in the cache so
>> the second won't be blocked by the park request.
>
> Okay, I get the following as soon I issue unload:
> ata1: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0xf
> ata1: SError: { PHYRdyChg CommWake }
> ata1: hard resetting link
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: SError: 0x0
>
> The rest comes a bit later.

Right, that settles it: the reset sequence is initiated even before the
unload command is issued for the first time. This means that head
parking is not part of the picture except for the fact that it provides
the means to initiate EH from userspace and makes the problem easily
reproducible. On the other hand, it remains to be a mystery to me what
actually sets those bits in SError in the first place without event
notification taking care of it. I'll have to think about this for a
while. Perhaps Tejun has another idea?

Regards,

Elias
