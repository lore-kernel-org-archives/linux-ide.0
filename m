From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 02/15] ATA : vortex86 : fix vortex86dx/sx hardware CRC
 bug.
Date: Fri, 28 Oct 2011 19:27:10 +0100
Message-ID: <20111028192710.361093ea@pyx>
References: <1319602564-19162-1-git-send-email-paul.s.schilling@gmail.com>
	<20111027084310.2b7da753@pyx>
	<CAC=G6sz9tpLnxWN7_Ts+rcNf-YQZw-4VQUNo6vKNeHOnOPOHVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [85.13.70.251] ([85.13.70.251]:34308 "EHLO
	localhost.localdomain" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754037Ab1J1S1U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Oct 2011 14:27:20 -0400
In-Reply-To: <CAC=G6sz9tpLnxWN7_Ts+rcNf-YQZw-4VQUNo6vKNeHOnOPOHVA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Schilling <paul.s.schilling@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

On Thu, 27 Oct 2011 13:55:21 -0500
Paul Schilling <paul.s.schilling@gmail.com> wrote:

> The Vortex86dx uses RDC IDE peripheral integrated into the SOC.  The
> CRC design is
> broken in the Vortex86dx and sx.  The original reference can be found
> in the Linux kernel itself.
>=20
> The Vortex86sx uses the RDC D1010.
> The Vortex86dx uses the RDC D1011.
> Both of which have broken CRC hardware which breaks DMA.

CRC hardware is only used for *UDMA* yet your change also disabled MWDM=
A.


> >> =C2=A0 =C2=A0 =C2=A0 static const struct ata_port_info info_rdc_11=
 =3D {
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D ATA_FL=
AG_SLAVE_POSS,
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pio_mask =3D ATA=
_PIO4,
> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .mwdma_mask =3D ATA_MW=
DMA2,
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .mwdma_mask =3D 0,
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .udma_mask =3D 0,

Why ?
