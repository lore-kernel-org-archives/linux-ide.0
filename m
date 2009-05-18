From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add a dma-mapping.h file
Date: Mon, 18 May 2009 10:28:00 +0200
Message-ID: <200905181028.01914.arnd@arndb.de>
References: <20090513043409.GA13577@cynthia.pants.nu> <200905172245.23774.arnd@arndb.de> <10f740e80905172303n4ef3cfc2j9922e19c281d471b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:61438 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbZERI32 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 May 2009 04:29:28 -0400
In-Reply-To: <10f740e80905172303n4ef3cfc2j9922e19c281d471b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Robert Hancock <hancockrwd@gmail.com>, Tejun Heo <htejun@gmail.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, alan@lxorguk.ukuu.org.uk, flar@allandria.com, schmitz@biophys.uni-duesseldorf.de, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, takata@linux-m32r.org, linux-m68k@vger.kernel.org, ysato@users.sourceforge.jp

On Monday 18 May 2009, Geert Uytterhoeven wrote:

> > +#ifndef dma_alloc_coherent
> > +static inline void *
> > +dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dm=
a_handle,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfp=
_t flag)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 void *virt =3D kmalloc(size, flag);
>=20
> kmalloc() may fail.
>=20
> > + =C2=A0 =C2=A0 =C2=A0 *dma_handle =3D virt_to_phys(virt);
>=20
> Not all variants of virt_to_phys() may handle the NULL case very well=
=2E
> I took a statistically invalid sample: some just cast to unsigned
> long, other subtract PAGE_OFFSET.

Right. It should not really hurt, because all users need to check virt
before using dma_handle, but I can fix it just to be sure.

I'll wait for comments from Fujita Tomonori and others before I repost.

	Arnd <><
