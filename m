From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata_via problems in a Vintage2-AE1: Resume
Date: Wed, 21 Feb 2007 20:42:16 +0900
Message-ID: <45DC3018.7010704@gmail.com>
References: <200702090010.06897.lepalom@wol.es> <200702131711.11781.lepalom@wol.es> <200702131719.47507.jdelvare@suse.de> <200702151223.19333.lepalom@wol.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:42591 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932435AbXBULmU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 06:42:20 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2317660wxd
        for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2007 03:42:20 -0800 (PST)
In-Reply-To: <200702151223.19333.lepalom@wol.es>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Leopold Palomo-Avellaneda <lepalom@wol.es>
Cc: Jean Delvare <jdelvare@suse.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>

Leopold Palomo-Avellaneda wrote:
> A Dimarts 13 Febrer 2007 17:19, Jean Delvare va escriure:
>> Le Mardi 13 F=E9vrier 2007 17:11, Leopold Palomo-Avellaneda a =E9cri=
t :
>>> A Dimarts 13 Febrer 2007 12:20, Jean Delvare va escriure:
>>> (...)
>>>
>>>>>> *If* the VT8251 needs the VIA IRQ quirk, then the attached patch
>>>>>> may help. Leopold, can you give it a try?
>>>>> Well, making your patch to the vanilla 2.6.20 the result is the s=
ame.
>>>>> The box doesn't boot. Always the same problem ....
>>>> If it's not a VIA IRQ problem, then there's nothing more I can do,
>>>> sorry. Someone else will have to look into the problem.
>>>>
>>>> Out of curiosity, with my patch applied, did you see any "VIA VLin=
k IRQ
>>>> fixup" messages on the console?
>>> No :-(
>> OK, so maybe the VT8251 actually no longer needs the quirk. Thanks f=
or
>> testing and reporting.
>=20
>=20
> Hi people,
> =20
> arriving to this state. What do you recommend?
>=20
> I have the box more or less working with irqpoll but with a lot of me=
ssages:
> APIC error on CPU0: 08(08)
>=20
> and the box doesn't boot without the irqpoll option. Do you think tha=
t the=20
> 2.6.21 have some kind of changes in this area?
>=20
> Thank's for all for you patience and your messages.

I'm sorry but I'm clueless other than that it seems to be an irq routin=
g
problem.

Any ideas, people?

--=20
tejun
