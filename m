From: MisterE <MisterE2002@zonnet.nl>
Subject: Re[2]: Sata Sil3512 bug?;  Promise SATA300 TX4
Date: Wed, 17 Oct 2007 14:39:29 +0200
Message-ID: <135469746.20071017143929@zonnet.nl>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info>
Reply-To: MisterE <MisterE2002@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.publishnet.nl ([212.241.49.8]:1854 "EHLO smtp.pn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754205AbXJQMf4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 08:35:56 -0400
In-Reply-To: <47035355.2040405@lxnt.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Sabourenkov <screwdriver@lxnt.info>
Cc: Mikael Pettersson <mikpe@it.uu.se>, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, jeff@garzik.orglinux-ide@vger.kernel.org

Hello,

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


After all the problems i had with the sweex 3512 cards i returned them
to the shop and decided to buy a Sata300 TX4 (because the shop nearby
had one. Unfortunately the shops in the region don't have Highpoints)

Things looked promising when i inserted the card in both Intel D815EEA
motherboards. No problems detecting the hard drives (unlike with the 3512 cards).
With the 3512 i had LOTS of error messages and corrupt data when writing to it.
Using a separate videocard, instead of the onboard one, seemed to reduce the amount of errors.

But after some heavy reading/writing with the promise i got 2 errors. (see log file).
But i did'nt find any corrupt files. I can not reproduce the error.
I'm not sure if these are the "intermittent error interrupts" Mikael
Pettersson mentioned?

ps: as you can i see i got at the boot some errors from the boot disk
(hda). I not sure what is wrong with it. Sometimes it produce these
errors. Used a non-destructive read-write test with badblocks but no
bad sectors found. I don't know if this could influence the sata controller.

Alexander Sabourenkov can you please tell me where i can find the
"Bug is fixed in 2.6.23.1: sata_promise: port is slow to respond,
reset failed" thread you mentioned?

I also see that the driver is now at version 2.10. Is there something
really critical changed? I've tried testing with Debian stable
(2.6.18-4-686; sata_promise: 1.04) and with Debian Unstable
(2.6.22-2-686; sata_promise: 2.07). 2.6.23 is not in the repositories
yet.

So basically the question is this. Can i trust the SATA300 TX4 or
should i buy a Highpoint RocketRAID 1640/1740?. I can order such device
online but i need to be sure that it works correctly :(


-- 
Best regards,
 MisterE                            mailto:MisterE2002@zonnet.nl


