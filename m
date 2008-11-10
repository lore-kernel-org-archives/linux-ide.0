From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: Odd behaviour of device in response to idleimmediate with unload
Date: Mon, 10 Nov 2008 12:35:20 +0100
Message-ID: <87r65ju83r.fsf@denkblock.local>
References: <491083CC.5050508@rtr.ca> <49108AA0.1080507@rtr.ca>
	<491090BC.5060403@rtr.ca> <20081104185444.3BE721FDF7@chi.die-welt.net>
	<4910A509.1030307@rtr.ca> <49116811.5000109@kernel.org>
	<873ai6cmio.fsf@denkblock.local> <4911A8EA.8030605@kernel.org>
	<87k5bhxerq.fsf@denkblock.local> <4913BF3D.3090704@kernel.org>
	<20081107074857.GA6461@dragonheart.kerker.die-welt.net>
	<4917F822.5060204@kernel.org>
	<20081110102607.094281FD7C@chi.die-welt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:48743 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754492AbYKJLfc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Nov 2008 06:35:32 -0500
In-Reply-To: <20081110102607.094281FD7C@chi.die-welt.net> (Evgeni Golov's
	message of "Mon, 10 Nov 2008 11:26:05 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Evgeni Golov <sargentd@die-welt.net>
Cc: Tejun Heo <tj@kernel.org>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Evgeni Golov <sargentd@die-welt.net> wrote:
> On Mon, 10 Nov 2008 18:00:18 +0900 Tejun Heo wrote:
>
>> Is the phy event before or after head unloading?
>
> How do I check this?

# dmesg
# echo 3000 > /sys/block/sda/device/unload_heads &
# dmesg

The first call to dmesg is only to make sure that it is in the cache so
the second won't be blocked by the park request.

Regards,

Elias
