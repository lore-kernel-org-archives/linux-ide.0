From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] cmd64x: set IDE_HFLAG_SERIALIZE explictly for CMD646
Date: Thu, 30 Oct 2008 00:10:05 +0100
Message-ID: <200810300010.06303.bzolnier@gmail.com>
References: <200810272058.54522.bzolnier@gmail.com> <200810292242.39729.bzolnier@gmail.com> <4908EACC.5060601@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.181]:8670 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812AbYJ2XM4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 19:12:56 -0400
Received: by ik-out-1112.google.com with SMTP id c29so252964ika.5
        for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 16:12:53 -0700 (PDT)
In-Reply-To: <4908EACC.5060601@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 29 October 2008, Sergei Shtylyov wrote:
> Hello.
>=20
> Bartlomiej Zolnierkiewicz wrote:
>=20
> >>>>> * Set IDE_HFLAG_SERIALIZE explictly for CMD646.
> >>>>>          =20
> >>>>  Was that some kernel.org bug that this is fixing?
> >>>>        =20
> >>> Nope (AFAIK).
> >>>      =20
> >>     User report then?
> >>    =20
> >
> > Nope as far as my inbox tells me.
> >  =20
>=20
>    Then whar's the reason? :-)

=46rom the patch description:

	* Set IDE_HFLAG_SERIALIZE explictly for CMD646.

	* Remove no longer needed ide_cmd646 chipset type (which has
	=A0 a nice side-effect of fixing handling of unexpected IRQs).

The latter is possible because of the former
(see ide-probe.c::init_irq() for details).

Also more reasons coming in the near future...

> > However http://bugzilla.kernel.org/ may know more.
> >  =20
>=20
>    Tried already -- to no avail.
