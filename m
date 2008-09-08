From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_inic162x  LED enable request
Date: Mon, 08 Sep 2008 14:12:36 +0200
Message-ID: <48C516B4.80900@kernel.org>
References: <495283.8352.qm@web904.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45504 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753884AbYIHMOA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 08:14:00 -0400
In-Reply-To: <495283.8352.qm@web904.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Stewart <bob@evoria.net>
Cc: echo6 <echo6_uk@yahoo.com>, linux-ide@vger.kernel.org

Bob Stewart wrote:
> --- Tejun Heo <tj@kernel.org> wrote:
>> Hmm... according to the datasheet, this is SWLED.
>>
>>   SOFTWARE CONTROL LED ENABLE: When set, software has full control o=
f
>>   LED activity. When clear, the LED=C3=A2=E2=82=AC=E2=84=A2s are con=
trolled by hardware.
>>
>> And then there are two more bits, LED0 and LED1 which seem to be the
>> actual control knob for LEDs.  From the description it looks like th=
e
>> bit should stay off so tha the controller hardware can drive LEDs.  =
I
>> presume this doesn't work as described?
>=20
> Uh oh.  It sounds like we may not be looking at the same book.  The o=
ne
> I have is "INIC-1620TA2/1622TA2/1623TA2", Version 1.4, October, 2005.
> In this book, the bit is "03  rw  0  (LEDEN)  LED ENABLE: When set, t=
he=20
> LED will flash when the device is busy."  With your driver as-is, bot=
h LEDs
> turn on during the boot process and then stay on completely. =20

Hmm... I have two - INIC-1622 V1.0 Septermber, 2003 and the one you
have.  Till now, I haven't found any noticeable difference.
Apparently, the meaning of the bit has changed.

> Which book are you using and are all these bits in the Global
> Control register, which we call HOST_CTL?  Did I get an old book?

Yes, that's GCTRL.  Can you please do the '+' -> '|' change and resend
the patch?

Thanks.

--=20
tejun
