From: Evgeni Golov <sargentd@die-welt.net>
Subject: Re: Odd behaviour of device in response to idleimmediate with
 unload
Date: Sat, 22 Nov 2008 10:51:00 +0100
Message-ID: <20081122095101.3A09F1FDE0@chi.die-welt.net>
References: <491083CC.5050508@rtr.ca>
	<49108AA0.1080507@rtr.ca>
	<491090BC.5060403@rtr.ca>
	<20081104185444.3BE721FDF7@chi.die-welt.net>
	<4910A509.1030307@rtr.ca>
	<49116811.5000109@kernel.org>
	<873ai6cmio.fsf@denkblock.local>
	<4911A8EA.8030605@kernel.org>
	<87k5bhxerq.fsf@denkblock.local>
	<4913BF3D.3090704@kernel.org>
	<20081107074857.GA6461@dragonheart.kerker.die-welt.net>
	<4917F822.5060204@kernel.org>
	<20081110102607.094281FD7C@chi.die-welt.net>
	<87r65ju83r.fsf@denkblock.local>
	<20081113113345.12E2D1FD80@chi.die-welt.net>
	<491FEA3C.4090906@kernel.org>
	<20081117071552.D25291FD5F@chi.die-welt.net>
	<49211B1F.7040900@kernel.org>
	<20081117074825.322BE1FD5F@chi.die-welt.net>
	<492218D1.5070904@kernel.org>
	<20081118073749.D84FD1FD6E@chi.die-welt.net>
	<49265812.3050902@kernel.org>
	<20081121194020.453461FD6E@chi.die-welt.net>
	<4927C14F.6050707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chi.die-welt.net ([84.246.123.210]:34630 "EHLO chi.die-welt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbYKVJvG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Nov 2008 04:51:06 -0500
In-Reply-To: <4927C14F.6050707@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Elias Oltmanns <eo@nebensachen.de>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Sat, 22 Nov 2008 17:22:39 +0900 Tejun Heo wrote:

> Eh... you have ALPM enabled.

Mh, when did I enable that!?

>  What does "cat
> /sys/block/sda/device/link_power_management_policy" tell you?

Nothing as the file does not exits, but
cat /sys/class/scsi_host/host0/link_power_management_policy
works and said me "min_power".

I rebooted without setting it, so it now says "max_performance" and I
still get the reset on scan :/

Regards
