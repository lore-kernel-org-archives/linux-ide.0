From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x  LED enable request
Date: Thu, 4 Sep 2008 08:52:01 -0700 (PDT)
Message-ID: <495283.8352.qm@web904.biz.mail.mud.yahoo.com>
References: <48BF98B4.5070307@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web904.biz.mail.mud.yahoo.com ([216.252.100.44]:23752 "HELO
	web904.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750822AbYIDPwD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Sep 2008 11:52:03 -0400
In-Reply-To: <48BF98B4.5070307@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: echo6 <echo6_uk@yahoo.com>, linux-ide@vger.kernel.org

--- Tejun Heo <tj@kernel.org> wrote:
>=20
> Hmm... according to the datasheet, this is SWLED.
>=20
>   SOFTWARE CONTROL LED ENABLE: When set, software has full control of
>   LED activity. When clear, the LED=E2=80=99s are controlled by hardw=
are.
>=20
> And then there are two more bits, LED0 and LED1 which seem to be the
> actual control knob for LEDs.  From the description it looks like the
> bit should stay off so tha the controller hardware can drive LEDs.  I
> presume this doesn't work as described?

Uh oh.  It sounds like we may not be looking at the same book.  The one
I have is "INIC-1620TA2/1622TA2/1623TA2", Version 1.4, October, 2005.
In this book, the bit is "03  rw  0  (LEDEN)  LED ENABLE: When set, the=
=20
LED will flash when the device is busy."  With your driver as-is, both =
LEDs
turn on during the boot process and then stay on completely. =20

Which book are you using and are all these bits in the Global Control r=
egister,
which we call HOST_CTL?  Did I get an old book?

> >  	/* fire up the ADMA engine */
> > -	writew(HCTL_FTHD0, port_base + HOST_CTL);
> > +	writew(HCTL_FTHD0 + HCTL_LEDEN, port_base + HOST_CTL);
>=20
> Nitpick: for flags, it's customary to use | instead of +.

Oh, duh.  <red face>

