From: Tejun Heo <tj@kernel.org>
Subject: Re: Odd behaviour of device in response to idleimmediate with unload
Date: Sun, 16 Nov 2008 18:39:08 +0900
Message-ID: <491FEA3C.4090906@kernel.org>
References: <491083CC.5050508@rtr.ca>	<49108AA0.1080507@rtr.ca>	<491090BC.5060403@rtr.ca>	<20081104185444.3BE721FDF7@chi.die-welt.net>	<4910A509.1030307@rtr.ca>	<49116811.5000109@kernel.org>	<873ai6cmio.fsf@denkblock.local>	<4911A8EA.8030605@kernel.org>	<87k5bhxerq.fsf@denkblock.local>	<4913BF3D.3090704@kernel.org>	<20081107074857.GA6461@dragonheart.kerker.die-welt.net>	<4917F822.5060204@kernel.org>	<20081110102607.094281FD7C@chi.die-welt.net>	<87r65ju83r.fsf@denkblock.local> <20081113113345.12E2D1FD80@chi.die-welt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36100 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626AbYKPJjM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 04:39:12 -0500
In-Reply-To: <20081113113345.12E2D1FD80@chi.die-welt.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Evgeni Golov <sargentd@die-welt.net>
Cc: Elias Oltmanns <eo@nebensachen.de>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello,

Evgeni Golov wrote:
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

So, this comes before actually issuing the park.  It sounds like it has
nothing to do with park command itself.  If you do "echo - - - >
/sys/class/scsi_host/host0/scan" right after boot, what does the kernel say?

Thanks.

-- 
tejun
