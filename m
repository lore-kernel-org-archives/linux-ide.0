From: Tejun Heo <tj@kernel.org>
Subject: Re: Odd behaviour of device in response to idleimmediate with unload
Date: Mon, 24 Nov 2008 13:20:35 +0900
Message-ID: <492A2B93.7060204@kernel.org>
References: <491083CC.5050508@rtr.ca>	<20081104185444.3BE721FDF7@chi.die-welt.net> <4910A509.1030307@rtr.ca>	<49116811.5000109@kernel.org> <873ai6cmio.fsf@denkblock.local>	<4911A8EA.8030605@kernel.org> <87k5bhxerq.fsf@denkblock.local>	<4913BF3D.3090704@kernel.org>	<20081107074857.GA6461@dragonheart.kerker.die-welt.net>	<4917F822.5060204@kernel.org>	<20081110102607.094281FD7C@chi.die-welt.net>	<87r65ju83r.fsf@denkblock.local>	<20081113113345.12E2D1FD80@chi.die-welt.net>	<491FEA3C.4090906@kernel.org>	<20081117071552.D25291FD5F@chi.die-welt.net>	<49211B1F.7040900@kernel.org>	<20081117074825.322BE1FD5F@chi.die-welt.net>	<492218D1.5070904@kernel.org>	<20081118073749.D84FD1FD6E@chi.die-welt.net>	<49265812.3050902@kernel.org> <4927C14F.6050707@kernel.org> <878wrapb4h.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51915 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837AbYKXEU6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 Nov 2008 23:20:58 -0500
In-Reply-To: <878wrapb4h.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Evgeni Golov <sargentd@die-welt.net>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Elias Oltmanns wrote:
> Tejun Heo <tj@kernel.org> wrote:
>> Evgeni Golov wrote:
>>> On Fri, 21 Nov 2008 15:41:22 +0900 Tejun Heo wrote:
>>>> Something strange is going on there.  Can you please apply the attached
>>>> patch and post resulting kernel log?
>>> Wow, that one is spammy :)
>>> See relevant part of /var/log/messages attached.
>> Eh... you have ALPM enabled.
> 
> Quite. The thing that's puzzling me, though, is this: There are a lot of
> phy events occurring during normal operation that get cleared by the
> interrupt handler. However, during link autopsy, phyrdy and comwake are
> set in SError even though event notification has not been disabled yet
> at this point. This suggests to me that not all changes to those bits in
> SError are brought to our attention through event notification, at least
> as long as ALPM is enabled. Besides, I'm wondering whether that many phy
> events are to be expected (i.e. observed on other controllers too) when
> ALPM is enabled.

Yeah, entering and leaving link power save mode generate PHY event
each time and ahci explicitly ignores them if ALPM is enabled.  We
probably need to teach EH that PHY events can be ignored if ALPM is
enabled.

Thanks.

-- 
tejun
