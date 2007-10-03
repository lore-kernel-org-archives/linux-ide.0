From: MisterE <MisterE2002@zonnet.nl>
Subject: Re[2]: Sata Sil3512 bug?
Date: Wed, 3 Oct 2007 16:45:12 +0200
Message-ID: <8514267.20071003164512@zonnet.nl>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info>
Reply-To: MisterE <MisterE2002@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.publishnet.nl ([212.241.49.8]:4296 "EHLO smtp.pn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbXJCOlw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 10:41:52 -0400
Received: from localhost ([84.246.52.165])
	by smtp.pn.nl (smtp.pn.nl [212.241.49.8])
	(MDaemon.PRO.v8.1.3.R)
	with ESMTP id 11-md50000101936.msg
	for <linux-ide@vger.kernel.org>; Wed, 03 Oct 2007 16:41:32 +0200
In-Reply-To: <47035355.2040405@lxnt.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Sabourenkov <screwdriver@lxnt.info>
Cc: Mikael Pettersson <mikpe@it.uu.se>, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello Alexander,

Wednesday, October 3, 2007, 10:31:17 AM, you wrote:

> Mikael Pettersson wrote:

>>>
>>> I'm thinking of replacing both 3512 controllers with a Promise SATA300
>>> TX4. Do you know if there are problems with this device?
>> 
>> (please don't top-post)
>> 
>> There are no known data-corruption issues with Promise SATA cards.
>> However, some of them, especially the 2nd generation SATA300 TX4,
>> are known to trigger intermittent error interrupts (that are dealt
>> with but may cause a speed reduction) in some systems. We're still
>> scratching our heads on that issue.
>> 

> But see this thread:

> http://marc.info/?l=linux-ide&m=119122463403033&w=2
> http://www.spinics.net/lists/linux-ide/msg14868.html

> Personally I would not recommend Promise SATA300 TX4 at the moment.


That is not hopefull. Highpoint does not have sata controllers (Except
softraid controllers). Other (real raid controllers) brands are too
expensive or/and does not have a PCI interface.
Maybe i should keep those 3512 cards? How are the user experiences
with these controllers (except nvidia boards)? Because i don't really
trust the intel boards so using the Asus would be an option.


-- 
Best regards,
 MisterE                            mailto:MisterE2002@zonnet.nl


