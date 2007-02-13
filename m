From: Jean Delvare <jdelvare@suse.de>
Subject: Re: Sata_via problems in a Vintage2-AE1
Date: Tue, 13 Feb 2007 17:19:47 +0100
Message-ID: <200702131719.47507.jdelvare@suse.de>
References: <200702090010.06897.lepalom@wol.es> <200702131220.21690.jdelvare@suse.de> <200702131711.11781.lepalom@wol.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-13
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:54040 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbXBMQTf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2007 11:19:35 -0500
In-Reply-To: <200702131711.11781.lepalom@wol.es>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Leopold Palomo-Avellaneda <lepalom@wol.es>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>

Le Mardi 13 F=E9vrier 2007 17:11, Leopold Palomo-Avellaneda a =E9crit=A0=
:
> A Dimarts 13 Febrer 2007 12:20, Jean Delvare va escriure:
> (...)
> > > > *If* the VT8251 needs the VIA IRQ quirk, then the attached patc=
h may
> > > > help. Leopold, can you give it a try?
> > >
> > > Well, making your patch to the vanilla 2.6.20 the result is the s=
ame.
> > > The box doesn't boot. Always the same problem ....
> >
> > If it's not a VIA IRQ problem, then there's nothing more I can do, =
sorry.
> > Someone else will have to look into the problem.
> >
> > Out of curiosity, with my patch applied, did you see any "VIA VLink=
 IRQ
> > fixup" messages on the console?
>
> No :-(

OK, so maybe the VT8251 actually no longer needs the quirk. Thanks for =
testing=20
and reporting.

--=20
Jean Delvare
Suse L3
