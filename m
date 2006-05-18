From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
 c pl atform
Date: Thu, 18 May 2006 11:26:17 -0400
Message-ID: <446C9219.4080300@pobox.com>
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net> <1147935734.17679.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54402 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751366AbWERP0X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 May 2006 11:26:23 -0400
In-Reply-To: <1147935734.17679.93.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Zang Roy-r61911 <tie-fei.zang@freescale.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexandre.Bounine@tundra.com, Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>, Kumar Gala <galak@kernel.crashing.org>

Benjamin Herrenschmidt wrote:
> On Thu, 2006-05-18 at 12:03 +0800, Zang Roy-r61911 wrote:
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: 2006=E5=B9=B45=E6=9C=8817=E6=97=A5 21:28
>> To: Zang Roy-r61911
>> Cc: Paul Mackerras; linuxppc-dev list; Alexandre.Bounine@tundra.com;=
 Yang Xin-Xin-r48390
>> Subject: Re: [PATCH/2.6.17-rc4 10/10] bugs fix for marvell SATA on p=
owerpc pl atform
>=20
> Copying here the comments I already made so Jeff gets them...
>=20
>> @@ -1032,6 +1032,9 @@ static inline void mv_crqb_pack_cmd(u16=20
>>  {
>>       *cmdw =3D data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
>>               (last ? CRQB_CMD_LAST : 0);
>> +#ifdef CONFIG_PPC
>> +     *cmdw =3D cpu_to_le16(*cmdw);
>> +#endif
>>  }
>=20
> Why an ifdef here ? The cpu_to_le16 should probably be unconditional.
> And even if for some weird reason you wanted to ifdef it, why PPC ? a=
nd
> what about other BE architectures ?
> =20
>>  /**
>> @@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
>>  static void mv5_enable_leds(struct mv_host_priv *hpriv, void __iome=
m
> *mmio)
>>  {
>>       u32 tmp;
>> -
>> +#ifndef CONFIG_PPC
>>       writel(0, mmio + MV_GPIO_PORT_CTL);
>> +#endif
>=20
> You'll have to do better here too... I don't wee why when compiled on
> PPC, this driver should "magically" not clear those bits... At the ve=
ry
> least, you should test the machine type if you want to do something
> specific to your platform, but first, you'll have to convince Jeff wh=
y
> this change has to be done in the first place and if there is a bette=
r
> way to handle it.

Correct...  it does seem some bugs were found, but #ifdef powerpc is=20
certainly out of the question.  We want the driver to work without=20
ifdefs on all platforms.

	Jeff



