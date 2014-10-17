From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ata: sata_rcar: Disable DIPM mode for r8a7790 ES1
Date: Fri, 17 Oct 2014 23:54:33 +0400
Message-ID: <544173F9.20908@cogentembedded.com>
References: <1413438652-18107-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1413438652-18107-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, linux-ide@vger.kernel.org
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 10/16/2014 9:50 AM, Simon Horman wrote:

> Unlike other SATA R-Car r8a7790 controllers the r8a7790 ES1 SATA R-Car
> controller needs to be run with DIPM disabled.

> Loosely based on work by Koji Matsuoka.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> This patch is against for-next branch of Tejun's libata tree.

>   Documentation/devicetree/bindings/ata/sata_rcar.txt |  3 ++-
>   drivers/ata/sata_rcar.c                             | 10 ++++++++++
>   2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> index 1e61113..7dd32d3 100644
> --- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> @@ -3,7 +3,8 @@
>   Required properties:
>   - compatible		: should contain one of the following:
>   			  - "renesas,sata-r8a7779" for R-Car H1
> -			  - "renesas,sata-r8a7790" for R-Car H2
> +			  - "renesas,sata-r8a7790-es1" for R-Car H2 ES1
> +			  - "renesas,sata-r8a7790" for R-Car H2 other than ES1
>   			  - "renesas,sata-r8a7791" for R-Car M2
>   - reg			: address and length of the SATA registers;
>   - interrupts		: must consist of one interrupt specifier.
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 61eb6d7..d5cacb5 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -146,6 +146,7 @@
>   enum sata_rcar_type {
>   	RCAR_GEN1_SATA,
>   	RCAR_GEN2_SATA,
> +	RCAR_R8A7790_ES1_SATA,

    Hm, can't we read the SoC revision somewhere?

>   };
>
>   struct sata_rcar_priv {
> @@ -763,6 +764,10 @@ static void sata_rcar_setup_port(struct ata_host *host)
>   	ap->udma_mask	= ATA_UDMA6;
>   	ap->flags	|= ATA_FLAG_SATA;
>
> +	if (priv->type == RCAR_R8A7790_ES1_SATA) {
> +		ap->flags	|= ATA_FLAG_NO_DIPM;
> +	}

    {} not needed here.

[...]

Back home, Sergei

