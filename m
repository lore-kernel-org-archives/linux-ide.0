From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Fix a large collection of DMA mode mismatches
Date: Fri, 1 Aug 2008 23:42:49 +0100
Message-ID: <20080801234249.7d6b36fe@lxorguk.ukuu.org.uk>
References: <20080801091834.5ca39334@lxorguk.ukuu.org.uk>
	<4892FA08.7070403@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54933 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751037AbYHAXAF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2008 19:00:05 -0400
In-Reply-To: <4892FA08.7070403@gmx.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David =?UTF-8?B?TcO8bGxlcg==?= <dave.mueller@gmx.ch>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Fri, 01 Aug 2008 13:56:56 +0200
David M=C3=BCller <dave.mueller@gmx.ch> wrote:

> Alan Cox wrote:
> >  drivers/ata/libata-core.c |    4 ++--
> >  drivers/ata/pata_acpi.c   |    2 +-
> >  drivers/ata/pata_atiixp.c |    2 +-
> >  drivers/ata/pata_cs5530.c |    6 +++---
> >  drivers/ata/pata_sc1200.c |    6 +++---
> >  include/linux/libata.h    |   22 ++++++++++++++++++++++
> >  6 files changed, 32 insertions(+), 10 deletions(-)
>=20
> A patch for the "pata_oldpiix" driver seems to be missing.
>=20
> Signed-off-by: Dave Mueller <dave.mueller@gmx.ch>

Oops I meant to send that one on as well

Acked-by: Alan Cox <alan@redhat.com>

> diff -dpurN a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
> --- a/drivers/ata/pata_oldpiix.c    2008-07-14 18:19:53.000000000 +02=
00
> +++ b/drivers/ata/pata_oldpiix.c    2008-08-01 13:17:34.000000000 +02=
00
> @@ -198,7 +198,7 @@ static unsigned int oldpiix_qc_issue(str
>=20
>   	if (adev !=3D ap->private_data) {
>   		oldpiix_set_piomode(ap, adev);
> -		if (adev->dma_mode)
> +		if (ata_dma_enabled(adev))
>   			oldpiix_set_dmamode(ap, adev);
>   	}
>   	return ata_sff_qc_issue(qc);
>=20


--=20
--
	"Alan, I'm getting a bit worried about you."
				-- Linus Torvalds
