From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: Re: [PATCH] sata_sx4: refresh and convert to new EH
Date: Mon, 13 Apr 2009 06:23:50 +0400
Message-ID: <a4423d670904121923l391d67cake297c5a71ca49ace@mail.gmail.com>
References: <20090408200511.GA24071@havoc.gtf.org>
	 <a4423d670904111946w2a8f3839n27b77f5473076563@mail.gmail.com>
	 <49E1CE26.9050401@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:61779 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbZDMCXx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Apr 2009 22:23:53 -0400
In-Reply-To: <49E1CE26.9050401@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

2009/4/12 Jeff Garzik <jeff@garzik.org>:
> Alexander Beregalov wrote:
>>
>> 2009/4/9 Jeff Garzik <jeff@garzik.org>:
>>>
>>> I reviewed and refreshed libata-dev.git#new-eh, now renamed to #sx4=
=2E
>>>
>>> Several bugs and missing pieces in the new-EH conversion were addre=
ssed
>>> (often by copying highly similar code from sata_promise, a highly
>>> similar chip)
>>>
>>> The only thing left is some "it still works" testing... =C2=A0any t=
akers?
>>>
>>
>> Hi Jeff
>>
>> I have SX4000 card, it is based on the same PDC20621 chip, but has P=
ATA
>> ports
>> (without PATA-SATA bridges).
>> Can I help?
>>
>> I am newbie here, but I will try to modify the driver to support PAT=
A
>> card as well
>> and test your patch.
>
> It's unknown how well, or what is needed, to support the SX4000. =C2=A0=
You are
> welcome to dive in and figure out what is needed, but you'd be asking
> questions to which we wouldn't have answers.

I found Promise provided docs for FreeBSD team.
http://unix.derkeiler.com/Mailing-Lists/FreeBSD/performance/2003-07/004=
3.html
>I do have the sx4000 in the works (thanks to Promise who has provided =
docs
>and HW to make this happen)..
Can we ask them too? :)

Interesting, I cut off all unrelated lines from freebsd/ata/ata-chipset=
=2Ec
and it seems SX4/SX4000 driver is only about 700 lines long.
