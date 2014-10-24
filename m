From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] ata: sata_rcar: Disable DIPM mode for r8a7790 ES1
Date: Fri, 24 Oct 2014 14:47:19 +0400
Message-ID: <544A2E37.6090206@cogentembedded.com>
References: <1414116319-16813-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1414116319-16813-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, linux-ide@vger.kernel.org
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 10/24/2014 6:05 AM, Simon Horman wrote:

> Unlike other SATA R-Car r8a7790 controllers the r8a7790 ES1 SATA R-Car
> controller needs to be run with DIPM disabled.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> v2
> * Handle ES1 in sata_rcar_init_controller()
> ---
>   Documentation/devicetree/bindings/ata/sata_rcar.txt |  3 ++-
>   drivers/ata/sata_rcar.c                             | 11 +++++++++++
>   2 files changed, 13 insertions(+), 1 deletion(-)

[...]
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 61eb6d7..b398513 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
[...]
> @@ -763,6 +764,10 @@ static void sata_rcar_setup_port(struct ata_host *host)
>   	ap->udma_mask	= ATA_UDMA6;
>   	ap->flags	|= ATA_FLAG_SATA;
>
> +	if (priv->type == RCAR_R8A7790_ES1_SATA) {
> +		ap->flags	|= ATA_FLAG_NO_DIPM;
> +	}
> +

    Please, please drop {}. I think checkpatch.pl should complain about them...

[...]

MBR, Sergei

