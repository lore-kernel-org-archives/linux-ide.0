From: Tejun Heo <tj@kernel.org>
Subject: Re: Odd behaviour of device in response to idleimmediate with unload
Date: Mon, 17 Nov 2008 16:19:59 +0900
Message-ID: <49211B1F.7040900@kernel.org>
References: <491083CC.5050508@rtr.ca>	<49108AA0.1080507@rtr.ca>	<491090BC.5060403@rtr.ca>	<20081104185444.3BE721FDF7@chi.die-welt.net>	<4910A509.1030307@rtr.ca>	<49116811.5000109@kernel.org>	<873ai6cmio.fsf@denkblock.local>	<4911A8EA.8030605@kernel.org>	<87k5bhxerq.fsf@denkblock.local>	<4913BF3D.3090704@kernel.org>	<20081107074857.GA6461@dragonheart.kerker.die-welt.net>	<4917F822.5060204@kernel.org>	<20081110102607.094281FD7C@chi.die-welt.net>	<87r65ju83r.fsf@denkblock.local>	<20081113113345.12E2D1FD80@chi.die-welt.net>	<491FEA3C.4090906@kernel.org> <20081117071552.D25291FD5F@chi.die-welt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37743 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945AbYKQHUX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Nov 2008 02:20:23 -0500
In-Reply-To: <20081117071552.D25291FD5F@chi.die-welt.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Evgeni Golov <sargentd@die-welt.net>
Cc: Elias Oltmanns <eo@nebensachen.de>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Evgeni Golov wrote:
> On Sun, 16 Nov 2008 18:39:08 +0900 Tejun Heo wrote:
> 
>> So, this comes before actually issuing the park.  It sounds like it has
>> nothing to do with park command itself.  If you do "echo - - - >
>> /sys/class/scsi_host/host0/scan" right after boot, what does the kernel say?
> 
> # echo - - - > /sys/class/scsi_host/host0/scan
> echo: write error: invalid argument

Eh... strange.  It works perfectly fine here.  Can you play with quoting
and -n?

-- 
tejun
