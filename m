From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ata: sata_rcar: Remove obsolete sata-r8a779*
 platform_device_id entries
Date: Wed, 24 Jun 2015 08:48:16 +0900
Message-ID: <20150623234815.GB9988@verge.net.au>
References: <1435064113-10742-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435064113-10742-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Jun 23, 2015 at 02:55:13PM +0200, Geert Uytterhoeven wrote:
> Since commit a483dcbfa21f919c ("ARM: shmobile: lager: Remove legacy
> board support"), R-Car Gen2 SoCs are only supported in generic DT-only
> ARM multi-platform builds.  The driver doesn't need to match platform
> devices by name anymore, hence remove the corresponding
> platform_device_id entry.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/ata/sata_rcar.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index d49a5193b7de9e94..8804127b108c0f8e 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -861,10 +861,6 @@ MODULE_DEVICE_TABLE(of, sata_rcar_match);
>  static const struct platform_device_id sata_rcar_id_table[] = {
>  	{ "sata_rcar", RCAR_GEN1_SATA }, /* Deprecated by "sata-r8a7779" */
>  	{ "sata-r8a7779", RCAR_GEN1_SATA },
> -	{ "sata-r8a7790", RCAR_GEN2_SATA },
> -	{ "sata-r8a7790-es1", RCAR_R8A7790_ES1_SATA },
> -	{ "sata-r8a7791", RCAR_GEN2_SATA },
> -	{ "sata-r8a7793", RCAR_GEN2_SATA },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(platform, sata_rcar_id_table);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
