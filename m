From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: ATA: Make CS5536 PATA driver use 32-bit BM DMA template
	instead of 16-bit.
Date: Wed, 11 Nov 2009 00:08:10 +0000
Message-ID: <20091111000810.GG15159@caffeine.csclub.uwaterloo.ca>
References: <m3my2u0w6f.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758772AbZKKAIL@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <m3my2u0w6f.fsf@intrepid.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Nov 11, 2009 at 12:58:16AM +0100, Krzysztof Halasa wrote:
> Tested on IXP425 + CS5536.

Well I guess we will find out if it works on the Geode LX + CS5536 and
loongson + CS5536 sometime.  I don't know why it wouldn't work.

> Signed-off-by: Krzysztof Ha=C5=82asa <khc@pm.waw.pl>
>=20
> diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
> index 88a7933..0898213 100644
> --- a/drivers/ata/pata_cs5536.c
> +++ b/drivers/ata/pata_cs5536.c
> @@ -232,7 +232,7 @@ static struct scsi_host_template cs5536_sht =3D {
>  };
> =20
>  static struct ata_port_operations cs5536_port_ops =3D {
> -	.inherits		=3D &ata_bmdma_port_ops,
> +	.inherits		=3D &ata_bmdma32_port_ops,
>  	.cable_detect		=3D cs5536_cable_detect,
>  	.set_piomode		=3D cs5536_set_piomode,
>  	.set_dmamode		=3D cs5536_set_dmamode,

--=20
Len Sorensen
