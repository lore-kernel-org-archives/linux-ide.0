From: Leopold Palomo-Avellaneda <lepalom@wol.es>
Subject: Re: Sata_via problems in a Vintage2-AE1: Resume
Date: Thu, 15 Feb 2007 12:23:18 +0100
Message-ID: <200702151223.19333.lepalom@wol.es>
References: <200702090010.06897.lepalom@wol.es> <200702131711.11781.lepalom@wol.es> <200702131719.47507.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-13
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from violet.upc.es ([147.83.2.51]:34856 "EHLO violet.upc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965885AbXBOLXj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Feb 2007 06:23:39 -0500
In-Reply-To: <200702131719.47507.jdelvare@suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>

A Dimarts 13 Febrer 2007 17:19, Jean Delvare va escriure:
> Le Mardi 13 F=E9vrier 2007 17:11, Leopold Palomo-Avellaneda a =E9crit=
=A0:
> > A Dimarts 13 Febrer 2007 12:20, Jean Delvare va escriure:
> > (...)
> >
> > > > > *If* the VT8251 needs the VIA IRQ quirk, then the attached pa=
tch
> > > > > may help. Leopold, can you give it a try?
> > > >
> > > > Well, making your patch to the vanilla 2.6.20 the result is the=
 same.
> > > > The box doesn't boot. Always the same problem ....
> > >
> > > If it's not a VIA IRQ problem, then there's nothing more I can do=
,
> > > sorry. Someone else will have to look into the problem.
> > >
> > > Out of curiosity, with my patch applied, did you see any "VIA VLi=
nk IRQ
> > > fixup" messages on the console?
> >
> > No :-(
>
> OK, so maybe the VT8251 actually no longer needs the quirk. Thanks fo=
r
> testing and reporting.


Hi people,
=20
arriving to this state. What do you recommend?

I have the box more or less working with irqpoll but with a lot of mess=
ages:
APIC error on CPU0: 08(08)

and the box doesn't boot without the irqpoll option. Do you think that =
the=20
2.6.21 have some kind of changes in this area?

Thank's for all for you patience and your messages.

Best regards,

Leo
