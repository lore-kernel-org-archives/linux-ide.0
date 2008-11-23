From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: Odd behaviour of device in response to idleimmediate with unload
Date: Sun, 23 Nov 2008 19:09:50 +0100
Message-ID: <878wrapb4h.fsf@denkblock.local>
References: <491083CC.5050508@rtr.ca>
	<20081104185444.3BE721FDF7@chi.die-welt.net> <4910A509.1030307@rtr.ca>
	<49116811.5000109@kernel.org> <873ai6cmio.fsf@denkblock.local>
	<4911A8EA.8030605@kernel.org> <87k5bhxerq.fsf@denkblock.local>
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
	<49265812.3050902@kernel.org> <4927C14F.6050707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:53143 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777AbYKWSKR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 Nov 2008 13:10:17 -0500
In-Reply-To: <4927C14F.6050707@kernel.org> (Tejun Heo's message of "Sat, 22
	Nov 2008 17:22:39 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Evgeni Golov <sargentd@die-welt.net>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo <tj@kernel.org> wrote:
> Evgeni Golov wrote:
>> On Fri, 21 Nov 2008 15:41:22 +0900 Tejun Heo wrote:
>
>> 
>>> Something strange is going on there.  Can you please apply the attached
>>> patch and post resulting kernel log?
>> 
>> Wow, that one is spammy :)
>> See relevant part of /var/log/messages attached.
>
> Eh... you have ALPM enabled.

Quite. The thing that's puzzling me, though, is this: There are a lot of
phy events occurring during normal operation that get cleared by the
interrupt handler. However, during link autopsy, phyrdy and comwake are
set in SError even though event notification has not been disabled yet
at this point. This suggests to me that not all changes to those bits in
SError are brought to our attention through event notification, at least
as long as ALPM is enabled. Besides, I'm wondering whether that many phy
events are to be expected (i.e. observed on other controllers too) when
ALPM is enabled.

Regards,

Elias
