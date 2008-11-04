From: Mark Lord <liml@rtr.ca>
Subject: Re: Odd behaviour of device in response to idleimmediate with unload
Date: Tue, 04 Nov 2008 14:39:53 -0500
Message-ID: <4910A509.1030307@rtr.ca>
References: <871vxrzssj.fsf@denkblock.local>	<491026AB.1090704@kernel.org>	<20081104123211.A86321FD5A@chi.die-welt.net>	<49108120.6000205@rtr.ca>	<491083CC.5050508@rtr.ca>	<49108AA0.1080507@rtr.ca>	<491090BC.5060403@rtr.ca> <20081104185444.3BE721FDF7@chi.die-welt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:52282 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbYKDTjN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 14:39:13 -0500
In-Reply-To: <20081104185444.3BE721FDF7@chi.die-welt.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Evgeni Golov <sargentd@die-welt.net>
Cc: Tejun Heo <tj@kernel.org>, Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Evgeni Golov wrote:
> On Tue, 04 Nov 2008 13:13:16 -0500 Mark Lord wrote:
> 
>> Okay, hdparm-9.3 is now out in the wild (sourceforge),
>> and has  --idle-immediate and --idle-unload  flags now,
>> so it can be used to help debug/test this problem.
> 
> Okay, got it, built it.
> Neither --idle-immediate nor --idle-immediate brings up the reset,
> echo 1000 > /sys/block/sda/device/unload_heads does.
..

Mmmm.. okay, this is new stuff in 2.6.28,
and it appears to just issue a --idle-unload equivalent after a delay.

But it does it from within libata-eh, so I suppose there must
be some confusion in there somewhere.

So it's up to Tejun now, I suppose.

Cheers
