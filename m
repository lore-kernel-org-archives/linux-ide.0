From: uaca@alumni.uv.es
Subject: Re: 2.6.0-test9: BUG alim15x3.c
Date: Sun, 2 Nov 2003 18:49:25 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031102174925.GA19229@pusa.informat.uv.es>
References: <20031102150911.GB14148@pusa.informat.uv.es> <200311021645.54838.bzolnier@elka.pw.edu.pl> <20031102155423.GA15847@pusa.informat.uv.es> <200311021746.00852.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pusa.informat.uv.es ([147.156.10.98]:52669 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP id S261757AbTKBRt0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Nov 2003 12:49:26 -0500
Content-Disposition: inline
In-Reply-To: <200311021746.00852.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

On Sun, Nov 02, 2003 at 05:46:00PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
>=20
> Try "hda=3Dremap" and "hda=3Dremap63" and please don't ask me why it =
is not
> autodetected (not my fault)...

I think you're in the right direction:

with a 2.4.17 kernel the geometry the kernel displays is

	2481/255/63

with a 2.6.0-test9 is

	39546/16/63

with a 2.6.0-test9 and hda=3Dremap is

	39545/16/6

with a 2.6.0-test9 and hda=3Dremap63 is

	39546/16/63

in any case the 2.6 kernel says "unknown partition table"

I also tried passing the 2481/255/63 geometry to the 2.6 kernel, the ke=
rnel
prints this geometry at boot but it doesn't recognize the partition tab=
le

I have asked further and it seems this system has a beta bios! (sorry I=
 did not know it)

so this may be Linux-unrelated altough WinXP boots fine

Thanks so much Bartlomiej

	Ulisses
>=20
> On Sunday 02 of November 2003 16:54, uaca@alumni.uv.es wrote:
> > Hi Bartlemiej!
> >
> > On Sun, Nov 02, 2003 at 04:45:54PM +0100, Bartlomiej Zolnierkiewicz=
 wrote:
> > > On Sunday 02 of November 2003 16:09, uaca@alumni.uv.es wrote:
> >
> > [...]
> >
> > > Does it recognize drives correctly?
> >
> > I will double check that
> >
> > > Does ALI driver oops?
> >
> > no
> >
> > > Do you have support for your filesystem compiled-in (not as modul=
e).
> >
> > yes
> >
> > > Have you tried passing "root=3D/dev/hda" (or similar) boot parame=
ter?
> >
> > yes, and I pass it right :-)
> >
> > when the systems boot, at the partition table check
> > it prints
> >
> > "unknown partition table"
> >
> > Thanks
> >
> > 	Ulisses
> >
> >                 Debian GNU/Linux: a dream come true
> > -------------------------------------------------------------------=
--------
> >-- "Computers are useless. They can only give answers."            P=
ablo
> > Picasso
> >
> > --->	Visita http://www.valux.org/ para saber acerca de la	<---
> > --->	Asociaci=F3n Valenciana de Usuarios de Linux		<---
>=20

--=20
                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------=
------
"Computers are useless. They can only give answers."            Pablo P=
icasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociaci=F3n Valenciana de Usuarios de Linux		<---
=20
