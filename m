From: Jean Delvare <jdelvare@suse.de>
Subject: Re: Sata_via problems in a Vintage2-AE1
Date: Tue, 13 Feb 2007 12:20:21 +0100
Message-ID: <200702131220.21690.jdelvare@suse.de>
References: <200702090010.06897.lepalom@wol.es> <200702121011.49818.jdelvare@suse.de> <200702121723.17999.lepalom@wol.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-13
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:33482 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284AbXBMLUT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2007 06:20:19 -0500
In-Reply-To: <200702121723.17999.lepalom@wol.es>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Leopold Palomo-Avellaneda <lepalom@wol.es>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>

Hi Leopold,

Le Lundi 12 F=E9vrier 2007 17:23, Leopold Palomo-Avellaneda a =E9crit=A0=
:
> A Dilluns 12 Febrer 2007 10:11, Jean Delvare va escriure:
> > Did you report the problem to Asus? They should fix it. Maybe this =
new
> > BIOS actually fixes some other problems you have.
>
> no. It's on the todo list. However I'm a bit afraid because I'm not u=
sing
> the "official" system so probably they will say that "we do not suppo=
rt
> ..."

That's indeed probable, but if enough people report the same problems, =
they=20
might still end up looking into it.

> Well in http://via8251.la-evento.com/index.html
>
> <off topic>
> please tell me that I'm not violating any rule about the linux-kernel=
 list
> putting this link :-S
> </off topic>
>
> claims that the VT8251 are supported in 2.6.20. As always you nned to=
 see
> the official place .... :-(

That's quite a bold claim considering that the VT8251 includes many dif=
ferent=20
functions (PATA, SATA, USB, SMBus...) and can be configured differently=
 on=20
different motherboards. Maybe most functions are supposedly supported a=
s of=20
2.6.20, but it doesn't mean everything works for everyone, as you are=20
experiencing yourself.

> > *If* the VT8251 needs the VIA IRQ quirk, then the attached patch ma=
y
> > help. Leopold, can you give it a try?
>
> Well, making your patch to the vanilla 2.6.20 the result is the same.=
 The
> box doesn't boot. Always the same problem ....

If it's not a VIA IRQ problem, then there's nothing more I can do, sorr=
y.=20
Someone else will have to look into the problem.

Out of curiosity, with my patch applied, did you see any "VIA VLink IRQ=
 fixup"=20
messages on the console?

--=20
Jean Delvare
Suse L3
