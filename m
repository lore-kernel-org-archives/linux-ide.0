From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Thu, 22 Jan 2009 13:57:26 +0100
Message-ID: <200901221357.27247.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <497863B6.4040306@ru.mvista.com> <49786572.1030408@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:40445 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbZAVM6F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2009 07:58:05 -0500
In-Reply-To: <49786572.1030408@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Thursday 22 January 2009 13:24:18 Sergei Shtylyov napisa=C5=82(a):
> Hello, I wrote:
>=20
> >>>>> +            t9 =3D t2i - t1;
> >>>>>        =20
> >>>>    It  more sense to calculate such things *after* quantizing th=
e=20
> >>>> timings with calc_mck_cycles()...
> >>>>    =20
> >>> Why?
> >>>  =20
> >>
> >>   More precise result -- matching the clock being used.
> >
> >   However, I don't understand now why you need to stretch t9...
>=20
>   Ah, I do again. t0 *should be equal* to t1 + t2 + t9 for the better=
=20
> speeds.
And hold time should meet min t2i requirement, so t9 =3D max(t9_orig, t=
2i - t1).

Stanislaw Gruszka

