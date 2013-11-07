From: Valentine <valentine.barshak@cogentembedded.com>
Subject: Re: [PATCH V2 1/2] sata_rcar: Add R-Car Gen2 SATA PHY support
Date: Fri, 08 Nov 2013 00:13:20 +0400
Message-ID: <527BF460.1030503@cogentembedded.com>
References: <1383854642-21660-1-git-send-email-valentine.barshak@cogentembedded.com> <1383854642-21660-2-git-send-email-valentine.barshak@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1383854642-21660-2-git-send-email-valentine.barshak@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kumar Gala <galak@codeaurora.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-ide@vger.kernel.org

On 11/08/2013 12:04 AM, Valentine Barshak wrote:
> R-Car Gen2 SoCs have a different PHY which is not compatible
> with the older R-Car H1 (R8A7779) version.
> This adds OF/platform device id tables and PHY initialization
> callbacks for the following Gen2 SoCs:
>    * R-Car H2: R8A7790;
>    * R-Car M2: R8A7791.
>
> PHY initialization method is chosen based on the device id.
> Default PHY settings are applied for Gen2 SoCs, which should
> suit the Gen2 boards available.
>
> While at it, this also adds "sata-r8a7779" compatibility string
> for R8A7779 SATA, while keeping the old one for compatibility.
>
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>

Tejun,
are you OK with applying this?

All the comments have been addressed in the previous version.
I've just decided to give it a minor white-space clean-up here
to make both array terminators look identical: "{ },".

I wonder if it's not to late for the 3.13.

Thanks,
Val.

