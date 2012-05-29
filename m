From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ide: icside.c: Fix compile with CONFIG_BLK_DEV_IDEDMA_ICS=n
Date: Tue, 29 May 2012 16:39:45 +0400
Message-ID: <4FC4C391.50700@mvista.com>
References: <20120529103002.GA13283@faui49q.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46415 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab2E2MkR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 May 2012 08:40:17 -0400
Received: by lbbgm6 with SMTP id gm6so2495468lbb.19
        for <linux-ide@vger.kernel.org>; Tue, 29 May 2012 05:40:16 -0700 (PDT)
In-Reply-To: <20120529103002.GA13283@faui49q.informatik.uni-erlangen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, vamos-dev@lists.cs.fau.de

Hello.

On 29-05-2012 14:30, Christian Dietrich wrote:

> The icside driver can be configured without DMA support, but it
> doesn't compile in this case, because DMA operations are referenced.

> drivers/ide/icside.c:523: error: =E2=80=98icside_v6_port_ops=E2=80=99=
 undeclared
> drivers/ide/icside.c:522: error: =E2=80=98icside_dma_init=E2=80=99 un=
declared

> Signed-off-by: Christian Dietrich<christian.dietrich@informatik.uni-e=
rlangen.de>
> ---
>   drivers/ide/icside.c |    6 +++++-
>   1 files changed, 5 insertions(+), 1 deletions(-)

> I attach the configuration, that exposes this compilation error.

    Apparently, you forgot to do it. :-)

> This patch was
> *NOT* tested on real hardware. I don't if the fix really does solve t=
he
> problem, but at least it is a hint that there is a problem.

> diff --git a/drivers/ide/icside.c b/drivers/ide/icside.c
> index 8716066..62c59c1 100644
> --- a/drivers/ide/icside.c
> +++ b/drivers/ide/icside.c
> @@ -271,7 +271,7 @@ static void icside_set_dma_mode(ide_hwif_t *hwif,=
 ide_drive_t *drive)
>
>   	ide_set_drivedata(drive, (void *)cycle_time);
>
> -	printk("%s: %s selected (peak %dMB/s)\n", drive->name,
> +	printk("%s: %s selected (peak %ldMB/s)\n", drive->name,

    Unrelated change, should go into its own patch.

>   		ide_xfer_verbose(xfer_mode),
>   		2000 / (unsigned long)ide_get_drivedata(drive));
>   }
> @@ -456,7 +456,9 @@ err_free:
>   static const struct ide_port_info icside_v6_port_info __initdata =3D=
 {
>   	.init_dma		=3D icside_dma_off_init,
>   	.port_ops		=3D&icside_v6_no_dma_port_ops,
> +#ifdef CONFIG_BLK_DEV_IDEDMA_ICS

    You forgot to remove the useless '#define icside_v6_dma_ops NULL' a=
bove.
Also, you could set .dma_ops inside the 'if' below (and get rid of 'els=
e'=20
then), removing this line.

>   	.dma_ops		=3D&icside_v6_dma_ops,
> +#endif
>   	.host_flags		=3D IDE_HFLAG_SERIALIZE | IDE_HFLAG_MMIO,
>   	.mwdma_mask		=3D ATA_MWDMA2,
>   	.swdma_mask		=3D ATA_SWDMA2,
> @@ -518,10 +520,12 @@ icside_register_v6(struct icside_state *state, =
struct expansion_card *ec)
>
>   	ecard_set_drvdata(ec, state);
>
> +#ifdef CONFIG_BLK_DEV_IDEDMA_ICS
>   	if (ec->dma !=3D NO_DMA && !request_dma(ec->dma, DRV_NAME)) {
>   		d.init_dma =3D icside_dma_init;
>   		d.port_ops =3D &icside_v6_port_ops;
>   	} else
> +#endif
>   		d.dma_ops =3D NULL;
>
>   	ret =3D ide_host_register(host,&d, hws);

MBR, Sergei
