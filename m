From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 2/2] dt: Document sata_rcar bindings
Date: Thu, 31 Oct 2013 09:27:50 -0500
Message-ID: <597E950F-A53D-4BBD-9E78-8901D50E3FD7@codeaurora.org>
References: <1383217394-18582-1-git-send-email-valentine.barshak@cogentembedded.com> <1383217394-18582-3-git-send-email-valentine.barshak@cogentembedded.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1383217394-18582-3-git-send-email-valentine.barshak@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-ide@vger.kernel.org


On Oct 31, 2013, at 6:03 AM, Valentine Barshak wrote:

> These bindings can be used to register SATA devices found on R-Car SoC.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
> Documentation/devicetree/bindings/ata/sata_rcar.txt | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/ata/sata_rcar.txt

Acked-by: Kumar Gala <galak@codeaurora.org>

- k

> 
> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> new file mode 100644
> index 0000000..d6b20a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> @@ -0,0 +1,18 @@
> +* Renesas R-Car SATA
> +
> +Required properties:
> +- compatible		: should contain one of the following:
> +			  - "renesas,sata-r8a7779" for R-Car H1
> +			  - "renesas,sata-r8a7790" for R-Car H2
> +			  - "renesas,sata-r8a7791" for R-Car M2
> +- reg			: offset and length of the SATA registers;
> +- interrupts		: must consist of one interrupt specifier.
> +
> +Example:
> +
> +sata: sata@fc600000 {
> +	compatible = "renesas,sata-r8a7779";
> +	reg = <0xfc600000 0x2000>;
> +	interrupt-parent = <&gic>;
> +	interrupts = <0 100 0x4>;
> +};
> -- 
> 1.8.3.1
> 

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

