From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: fix out-of-bounds access in pata_oldpiix.c
Date: Fri, 18 Jul 2008 16:15:25 +0200
Message-ID: <200807181615.26272.bzolnier@gmail.com>
References: <488040E4.1090500@gmx.ch> <20080718095541.6bf01fff@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:27182 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYGROSH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jul 2008 10:18:07 -0400
Received: by yw-out-2324.google.com with SMTP id 9so106623ywe.1
        for <linux-ide@vger.kernel.org>; Fri, 18 Jul 2008 07:18:06 -0700 (PDT)
In-Reply-To: <20080718095541.6bf01fff@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David =?utf-8?q?M=C3=BCller?= <dave.mueller@gmx.ch>, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Friday 18 July 2008, Alan Cox wrote:
> On Fri, 18 Jul 2008 09:06:12 +0200
> David M=C3=BCller <dave.mueller@gmx.ch> wrote:
>=20
> > The "pata_oldpiix" driver in linux-2.6.26 is calling its "set_dmamo=
de"=20
> > routine also locally, but under different preconditions as the=20
> > corresponding call in libata-core.c. This may cause an "out-of-arra=
y=20
> > bounds" access in "oldpiix_set_dmamode".
>=20
> This looks wrong adev->dma_mode should never be invalid at this point=
=2E
> Are you not confusing dma_mask and dma_mode. Can you provide the
> backtraces of the failing case and the actual chip variant you are us=
ing ?
>=20
> Either way the fix is not in oldpiix if this is appearing as 0xFF but=
 in
> the core code so NAK

->dma_mode =3D=3D 0xff means that DMA is unsupported by a given device
and according to the core code it is a valid ->dma_mode setting.

This may want to be changed in the future but as the things are right
now David's patch is correct and fixes a real bug.  Please UNNAK.

Thanks,
Bart
