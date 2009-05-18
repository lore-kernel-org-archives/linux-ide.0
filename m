From: Richard Atterer <richard@2009.atterer.net>
Subject: Re: s2disk hangs with kernel >=2.6.29, SATA, Gigabyte EG45M-DS2H
	(bisected)
Date: Mon, 18 May 2009 16:16:46 +0200
Message-ID: <20090518141646.GA6460@arbonne.lan>
References: <20090516225153.GA7883@arbonne.lan> <200905180117.28413.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:56892 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752862AbZEROQs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 May 2009 10:16:48 -0400
Content-Disposition: inline
In-Reply-To: <200905180117.28413.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org

On Mon, May 18, 2009 at 01:17:27AM +0200, Bartlomiej Zolnierkiewicz wro=
te:
> On Sunday 17 May 2009 00:51:53 Richard Atterer wrote:
> > The patch that causes the hang is 295f00042aaf6b553b5f37348f89bab46=
3d4a469:
> > ide: don't execute the next queued command from the hard-IRQ contex=
t (v2)
>=20
> Hmm, this should have been fixed by:
>=20
> commit 2ea5521022ac8f4f528dcbae02668e02a3501a5a
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date:   Wed Jan 14 19:19:04 2009 +0100
>=20
>     ide: fix suspend regression

I just tried that revision (with a small patch to get pcf50633-core to=20
compile) and hibernating does not work. :-/

> What was the last 'good' kernel that you've started bisection with?

I started with the 2.6.28 release.

In case it makes a difference: The swap partition that I'm hibernating =
to=20
is encrypted via luks and uses lvm. This is the standard way suggested =
by=20
the Debian installer when you choose encryption.

Cheers,

  Richard

PS: This is my /etc/uswsusp.conf file:
resume device =3D /dev/mapper/pc-swap
splash =3D n
compress =3D y
early writeout =3D y
image size =3D 1897884221
RSA key file =3D /etc/uswsusp.key         <-- that file does not exist
shutdown method =3D platform
--=20
  __   _
  |_) /|  Richard Atterer     |  GnuPG key: 888354F7
  | \/=AF|  http://atterer.net  |  08A9 7B7D 3D13 3EF2 3D25  D157 79E6 =
=466DC 8883 54F7
  =AF '` =AF
