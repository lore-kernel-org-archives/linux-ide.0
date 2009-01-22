From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Thu, 22 Jan 2009 11:15:40 +0100
Message-ID: <200901221115.41110.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <200901211133.05095.stf_xl@wp.pl> <49783FEA.3010302@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:38611 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754154AbZAVKPy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2009 05:15:54 -0500
In-Reply-To: <49783FEA.3010302@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Thursday 22 January 2009 10:44:10 Sergei Shtylyov napisa=C5=82(a):
> Hello.
>=20
> Stanislaw Gruszka wrote:
>=20
> >>    Besides, we have ide_timing_compute() doing the same thing.
> >>    =20
> > I'm trying use it, but have too bigger results - 1 or 2 cycles is a=
dded.
> >  =20
>=20
>    That's most probably because ide_timing_compute() assumes non-zero=
=20
> minimum recovery time for PIO modes 0 to 2 (libata does the same) --=20
> that actually smells of over-caution. It then tries to stretch the=20
> active time if the sum of active and recovery times is less than cycl=
e=20
> time (all quantized already).
Hmm, why active time is stretched. IMHO it is better to stretch inactiv=
e
time (t2i), such it can be divided into setup (t1) and recovery time (t=
9 with t6z).
Otherwise sum of t1 + t2 + max(t9, t2i -  t1)  will be longer than cycl=
e time t0.

Stanislaw Gruszka
