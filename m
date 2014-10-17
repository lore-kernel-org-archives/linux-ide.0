From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] ata: sata_rcar: Disable DIPM mode for r8a7790 ES1
Date: Fri, 17 Oct 2014 07:25:34 +0200
Message-ID: <CANqRtoRYi-_nnFBbz9O8BknrBs+7c3_17VRCiw8fURQ+2w3_Fw@mail.gmail.com>
References: <1413438652-18107-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1413438652-18107-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-ide@vger.kernel.org, Yoshihiro Kaneko <ykaneko0929@gmail.com>, SH-Linux <linux-sh@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi Simon,

On Thu, Oct 16, 2014 at 7:50 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Unlike other SATA R-Car r8a7790 controllers the r8a7790 ES1 SATA R-Car
> controller needs to be run with DIPM disabled.
>
> Loosely based on work by Koji Matsuoka.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> This patch is against for-next branch of Tejun's libata tree.

Thanks for cooking up this improved version of the ES1 workaround.

>  Documentation/devicetree/bindings/ata/sata_rcar.txt |  3 ++-
>  drivers/ata/sata_rcar.c                             | 10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> index 1e61113..7dd32d3 100644
> --- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> @@ -3,7 +3,8 @@
>  Required properties:
>  - compatible           : should contain one of the following:
>                           - "renesas,sata-r8a7779" for R-Car H1
> -                         - "renesas,sata-r8a7790" for R-Car H2
> +                         - "renesas,sata-r8a7790-es1" for R-Car H2 ES1
> +                         - "renesas,sata-r8a7790" for R-Car H2 other than ES1
>                           - "renesas,sata-r8a7791" for R-Car M2
>  - reg                  : address and length of the SATA registers;
>  - interrupts           : must consist of one interrupt specifier.

This portion looks fine to me.

> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 61eb6d7..d5cacb5 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -146,6 +146,7 @@
>  enum sata_rcar_type {
>         RCAR_GEN1_SATA,
>         RCAR_GEN2_SATA,
> +       RCAR_R8A7790_ES1_SATA,
>  };
>
>  struct sata_rcar_priv {
> @@ -763,6 +764,10 @@ static void sata_rcar_setup_port(struct ata_host *host)
>         ap->udma_mask   = ATA_UDMA6;
>         ap->flags       |= ATA_FLAG_SATA;
>
> +       if (priv->type == RCAR_R8A7790_ES1_SATA) {
> +               ap->flags       |= ATA_FLAG_NO_DIPM;
> +       }
> +
>         ioaddr->cmd_addr = base + SDATA_REG;
>         ioaddr->ctl_addr = base + SSDEVCON_REG;
>         ioaddr->scr_addr = base + SCRSSTS_REG;
> @@ -838,6 +843,10 @@ static struct of_device_id sata_rcar_match[] = {
>                 .data = (void *)RCAR_GEN2_SATA
>         },
>         {
> +               .compatible = "renesas,sata-r8a7790-es1",
> +               .data = (void *)RCAR_R8A7790_ES1_SATA
> +       },
> +       {
>                 .compatible = "renesas,sata-r8a7791",
>                 .data = (void *)RCAR_GEN2_SATA
>         },
> @@ -849,6 +858,7 @@ static const struct platform_device_id sata_rcar_id_table[] = {
>         { "sata_rcar", RCAR_GEN1_SATA }, /* Deprecated by "sata-r8a7779" */
>         { "sata-r8a7779", RCAR_GEN1_SATA },
>         { "sata-r8a7790", RCAR_GEN2_SATA },
> +       { "sata-r8a7790-es1", RCAR_R8A7790_ES1_SATA },
>         { "sata-r8a7791", RCAR_GEN2_SATA },
>         { },
>  };
> --
> 2.1.1
>

>From my side I'm not sure if the platform device interface at this
point really needs to cover the ES portion or not. It may not hurt to
be consistent though so no need to change from my side.

Is this patch all needed in the driver to handle the ES1 case?

I'm asking because it looks like the switch() statement in
sata_rcar_init_controller() may accidentally skip some gen2 related
setup code in case of ES1, maybe this is intentional or perhaps some
update is needed.

Cheers,

/ magnus
