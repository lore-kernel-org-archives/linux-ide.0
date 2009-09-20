From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata:ide: Fix udma timings of pdc202xx_old controllers
Date: Sun, 20 Sep 2009 21:48:36 +0200
Message-ID: <200909202148.36109.bzolnier@gmail.com>
References: <8b5805ff0909171602v3dc10db9i5920be3a2abf2e04@mail.gmail.com> <8b5805ff0909171654i515c832bm570db9bd5936b11a@mail.gmail.com> <4AB37492.90407@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752077AbZITVGj@vger.kernel.org>
In-Reply-To: <4AB37492.90407@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "Jung-Ik (John) Lee" <jilee@google.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Friday 18 September 2009 13:52:50 Sergei Shtylyov wrote:
> Hello.
>=20
> Jung-Ik (John) Lee wrote:
>=20
> >>>From: John(Jung-Ik) Lee <jilee@google.com>
>=20
> >>>Fix udma timings of pdc202xx_old controllers.
> >>>MB=3D1, MC=3D1 (0x20, 0x01) for all UDMA modes of pdc2026{57}.
>=20
>     The patch should be broken in two as it's for 2 different subsyst=
ems.
>=20
> >>On what documentation is this based ?
>=20
> > I have two documents, 20265, and 20267, and both need to set to the
> > same single value for all UDMA modes.
>=20
> > Doc 1:
> >   PDC20265 Bus Mastering Ultra DMA PCI =96ATA/ATAPI Controller
> > Specification Rev 2.0
> >   #7.17.2, Ultra DMA Data Transfer Speed list
> >     For all Ultra DMA mode, MB, MC =3D 01h, 01h
>=20
> > Doc 2:
> >   PDC20267 Bus Mastering Ultra DMA PCI =96ATA/ATAPI Controller
> > Specification Rev 2.0
> >   #7.17.2, Ultra DMA Data Transfer Speed list
> >     For all Ultra DMA mode, MB, MC =3D 01h, 01h

I think that this patch is going in the right direction but it needs to=
 also
take care of 66MHz internal clock setting:

* Please note that the same docs say that "For all Ultra DMA modes, 66M=
Hz
  internal clock will be used instead of 33MHz internal clock." and tha=
t this
  is not true in case of Linux drivers.

* PDC20246 has no 66MHz internal clock AFAIK so those changes should no=
t be
  applied for this controller.

> > Are there other pdc202xx old controllers that are different?
>=20
>     There are PDC20262 and PDC20246. We should ask Bart -- he probabl=
y has=20
> the documatation for them...

He doesn't, unfortunately..
