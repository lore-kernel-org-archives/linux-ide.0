From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] sata_rcar: Add R-Car Gen2 SATA support
Date: Mon, 14 Oct 2013 17:26:03 +0100
Message-ID: <20131014162603.GB19196@e106331-lin.cambridge.arm.com>
References: <1381765354-28440-1-git-send-email-valentine.barshak@cogentembedded.com>
 <1381765354-28440-3-git-send-email-valentine.barshak@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381765354-28440-3-git-send-email-valentine.barshak@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Oct 14, 2013 at 04:42:34PM +0100, Valentine Barshak wrote:
> R-Car Gen2 SoCs have a different PHY which is not compatible
> with the older R-Car H1 (R8A7779) version.
> This adds OF/platform device id tables and PHY initialization
> callbacks for the following Gen2 SoCs:
>   * R-Car H2: R8A7790;
>   * R-Car M2: R8A7791.
> 
> PHY initialization method is chosen, based on the device id.
> Default PHY settings are applied for Gen2 SoCs, which should
> suit the Gen2 boards available.
> 
> The R8A7779 platform code is modified to use "sata-r8a7779"
> device id.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  .../devicetree/bindings/ata/sata_rcar.txt          |   5 +-
>  arch/arm/mach-shmobile/clock-r8a7779.c             |   2 +-
>  arch/arm/mach-shmobile/setup-r8a7779.c             |   2 +-
>  drivers/ata/sata_rcar.c                            | 112 ++++++++++++++++++---
>  4 files changed, 102 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> index 2465183..b5a41bf 100644
> --- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> @@ -1,7 +1,10 @@
>  * Renesas R-Car SATA
>  
>  Required properties:
> -- compatible		: must be "renesas,sata-r8a7779"
> +- compatible		: must be one of the following:

s/must be/should contain/

> +			  - "renesas,sata-r8a7779" for R-Car H1
> +			  - "renesas,sata-r8a7790" for R-Car H2
> +			  - "renesas,sata-r8a7791" for R-Car M2

How do renesas,sata-r8a7790 and renesas,sata-r8a7791 differ?

>  - reg			: address range of the SATA registers.

It's a size too...

>  - interrupt-parent	: interrupt parent controller phandle

Not required.

[...]

> +static struct of_device_id sata_rcar_match[] = {
> +	{
> +		.compatible = "renesas,sata-r8a7779",
> +		.data = (void *)RCAR_GEN1_SATA,
> +	},
> +	{
> +		.compatible = "renesas,sata-r8a7790",
> +		.data = (void *)RCAR_GEN2_SATA
> +	},
> +	{
> +		.compatible = "renesas,sata-r8a7791",
> +		.data = (void *)RCAR_GEN2_SATA
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sata_rcar_match);

Are the renesas,sata-r8a779x variants identical?

If so, why the two strings?

Could we not require sata-r8a7791 devices to have "sata-r8a7790" in the
compatible list:

	compatible = "sata-r8a7791", "sata-r8a7790";

That way we can match on "sata-r8a7791" if we want to later, but don't
need code for it now.

Thanks,
Mark.
