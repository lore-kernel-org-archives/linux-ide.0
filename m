From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: IDE cdrom problem with PLEXTOR DVDR PX-608AL
Date: Thu, 14 Feb 2008 07:26:52 +0100
Message-ID: <20080214062652.GE13446@gollum.tnic>
References: <200802121026.17420.hpj@urpla.net> <20080212172057.GA12480@gollum.tnic> <200802140037.51450.hpj@urpla.net>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:64521 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbYBNG1B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 01:27:01 -0500
Received: by nf-out-0910.google.com with SMTP id g13so165995nfb.21
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 22:26:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200802140037.51450.hpj@urpla.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, bzolnier@gmail.com

On Thu, Feb 14, 2008 at 12:37:50AM +0100, Hans-Peter Jansen wrote:

[Added Bart to CC]

> Am Dienstag, 12. Februar 2008 schrieb Borislav Petkov:
> > On Tue, Feb 12, 2008 at 10:26:17AM +0100, Hans-Peter Jansen wrote:
> > > Hi,
> > >
> > > I suffer from unreliable cdrom operations (failing DAE and burn
> > > sessions) with the openSUSE 2.6.18.8-0.7-bigsmp kernel.
> >
> > 			^^^^
> > Hi,
> >
> > can please you test this with a more recent kernel. Yours is almost
> > ancient - from Sep. 2006.
>=20
> Sure, sorry. Here we go:
>=20
> Feb 14 00:18:18 kernel: hde: cdrom_pc_intr: The drive appears confuse=
d (ireason =3D 0x01).
>  Trying to recover by ending request.
> Feb 14 00:27:27 kernel: hdc: cdrom_pc_intr: The drive appears confuse=
d (ireason =3D 0x01).=20
>  Trying to recover by ending request.
>=20
> ~> uname -a
> Linux xrated 2.6.24.1-35-pae #1 SMP 2008/02/12 01:00:18 UTC i686 athl=
on i386 GNU/Linux

Actually the interrupt handler in ide-cd got rewritten and you're still=
 using the
old one (cdrom_pc_intr vs cdrom_newpc_intr). Those changes went into ma=
inline before
the 2.6.25-rc1 so we'll be able to test the new one only when you try o=
ut 2.6.25-rc1
or wait until 2.6.25 is released in case you don't want to try hazardou=
s materials
such as an -rc kernel[*] :).

Bart?

*. As a matter of fact it runs quite smoothly on my machines.

--=20
Regards/Gru=DF,
    Boris.
