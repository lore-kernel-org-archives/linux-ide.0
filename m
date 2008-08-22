From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Fix a large collection of DMA mode mismatches
Date: Fri, 22 Aug 2008 02:28:09 -0400
Message-ID: <48AE5C79.8090101@pobox.com>
References: <20080801091834.5ca39334@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39384 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502AbYHVG2Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 02:28:16 -0400
In-Reply-To: <20080801091834.5ca39334@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: =?UTF-8?B?RGF2aWQgTcO8bGxlcg==?= <dave.mueller@gmx.ch>, linux-ide@vger.kernel.org

Alan Cox wrote:
> From: Alan Cox <alan@redhat.com>
>=20
> Dave M=C3=BCller sent a diff for the pata_oldpiix that highlighted a =
problem
> where a lot of the ATA drivers assume dma_mode =3D=3D 0 means "no DMA=
" while
> the core code uses 0xFF.
>=20
> This turns out to have other consequences such as code doing >=3D XFE=
R_UDMA_0
> also catching 0xFF as UDMAlots. Fortunately it doesn't generally affe=
ct
> set_dma_mode, although some drivers call back into their own set mode=
 code
> from other points.
>=20
> Having been through the drivers I've added helpers for using_udma/usi=
ng_mwdma
> dma_enabled so that people don't open code ranges that may change (eg=
 if UDMA8
> appears somewhere)
>=20
> Thanks to David for the initial bits
>=20
> Signed-off-by: Alan Cox <alan@redhat.com>
> ---
>=20
>  drivers/ata/libata-core.c |    4 ++--
>  drivers/ata/pata_acpi.c   |    2 +-
>  drivers/ata/pata_atiixp.c |    2 +-
>  drivers/ata/pata_cs5530.c |    6 +++---
>  drivers/ata/pata_sc1200.c |    6 +++---
>  include/linux/libata.h    |   22 ++++++++++++++++++++++
>  6 files changed, 32 insertions(+), 10 deletions(-)

applied (w/ David's pata_oldpiix update)


