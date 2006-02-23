From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil.c, 3512 and SIL_QUIRK_MOD15WRITE
Date: Thu, 23 Feb 2006 12:52:33 +0900
Message-ID: <43FD3181.5010702@gmail.com>
References: <loom.20060222T182150-518@post.gmane.org> <43FD18F5.20002@gmail.com> <43FD2D9E.9020709@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:49363 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750732AbWBWDwn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Feb 2006 22:52:43 -0500
Received: by zproxy.gmail.com with SMTP id 9so1710207nzo
        for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2006 19:52:42 -0800 (PST)
In-Reply-To: <43FD2D9E.9020709@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: =?UTF-8?B?Sm9uIEvDpXJlIEhlbGxhbg==?= <hellan@acm.org>, linux-ide@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Jeff Garzik =EC=93=B4 =EA=B8=80:
> Tejun Heo wrote:
>> According to the errata information from Silicon Image, SiI3512 does=
=20
>> not have m15w bug, neither does ST3200822AS. So, this must be=20
>> something else and you're not an isolated case. One of my friends=20
>> reported the same problem but I currently can't test it as he sold h=
is=20
>> motherboard *really* fast. :-( So, it would be very nice if you can=20
>> test fixes we'll be able to come up with.
>>
>> Carlos (Hi!), 3512 + some 7200.7 hangs. Can you think of any related=
=20
>> errata?
>=20
>=20
> I think I'm going to start patching sata_sil.c with a todo list, just=
 to=20
> keep track of things.
>=20
> In particular, in ADDITION to errata recently sent by SiI, sata_sil=20
> could do better with reset, it needs to handle watchdog timer interru=
pt,=20
> and it desperately wants the irq-pio branch merged.
>=20

We also need to delist some drives from m15w list according to SIMG's=20
blacklist. Is there any reason why sata_sil wants irq-pio desparately=20
compared to other drivers? Actually it seems that all sata_sil=20
controllers seem to be capable of performing PIO using DMA which makes=20
PIO support unncessary.

--=20
tejun
