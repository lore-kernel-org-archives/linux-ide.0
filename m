From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Tue, 20 Jan 2009 15:49:30 +0100
Message-ID: <200901201549.31211.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <4975B065.6030705@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:29079 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754967AbZATOtj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jan 2009 09:49:39 -0500
In-Reply-To: <4975B065.6030705@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Tuesday 20 January 2009 12:07:17 Sergei Shtylyov napisa=C5=82(a):
> > do special things before access Task File and Data Register (functi=
ons=20
> > set_8bit_mode() and set_16bit_mode()).
>=20
>    That part really doesn't look well -- Atmel should have put more=20
> though into it and make the register stride 2 bytes, so that 16-bit=20
> access could alwys be used...
Actually it is possible (I realize when seeing pata_at32) when address
lines are connected in diffrent way, h/w trick is described in AVR32 AT=
A
application note. Only register addresses are multiplied by 2 then.
However Atmel reference documents for AT91 don't describe such
connection. I suppose AT91 evaluation boards are designed without the t=
rick.
=20
>   I then don't understand how are you submitting this as a part of=20
> SAM9623EK board code...
I asked for comment not for submition (yet) :)

> > We did not tests on Atmel sam9263ek board, because we have no prope=
r connector
> > for 1,8'' HDD.
>=20
>    Not sure I've understood that. You have 1,8'' drive and the board =
has=20
> stndard IDE connector?
Board has 44-pin male IDE connector (rather non standard one), we have =
no cable
or any device to connect. Kelvatek's board has Compact Flash connector,=
 we use CF
card for testing. We currently ordered proper cable and IDE->CF adapter=
, so
I'll do tests on sam9263ek.

> > On PIO4 mode I achieve 4,5MB/s
>=20
>    Seems a good result actually. How it was measured?
hdparm -t /dev/hda

I will comment other things soon.

Cheers
Stanislaw Gruszka
