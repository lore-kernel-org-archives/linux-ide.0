From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ATA: Make CS5536 PATA driver use 32-bit BM DMA template instead
 of 16-bit.
Date: Mon, 16 Nov 2009 22:18:02 -0500
Message-ID: <4B0215EA.9080800@pobox.com>
References: <m3my2u0w6f.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754280AbZKQDSB@vger.kernel.org>
In-Reply-To: <m3my2u0w6f.fsf@intrepid.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 11/10/2009 06:58 PM, Krzysztof Halasa wrote:
> Tested on IXP425 + CS5536.
>
> Signed-off-by: Krzysztof Ha=C5=82asa<khc@pm.waw.pl>
>
> diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
> index 88a7933..0898213 100644
> --- a/drivers/ata/pata_cs5536.c
> +++ b/drivers/ata/pata_cs5536.c
> @@ -232,7 +232,7 @@ static struct scsi_host_template cs5536_sht =3D {
>   };
>
>   static struct ata_port_operations cs5536_port_ops =3D {
> -	.inherits		=3D&ata_bmdma_port_ops,
> +	.inherits		=3D&ata_bmdma32_port_ops,
>   	.cable_detect		=3D cs5536_cable_detect,
>   	.set_piomode		=3D cs5536_set_piomode,
>   	.set_dmamode		=3D cs5536_set_dmamode,

applied
