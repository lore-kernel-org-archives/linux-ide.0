From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 5/5] ARM: dts: imx53: Enable AHCI SATA for M53EVK
Date: Mon, 18 Nov 2013 10:44:21 +0800
Message-ID: <20131118024420.GR11014@S2101-09.ap.freescale.net>
References: <1384651251-5548-1-git-send-email-marex@denx.de>
 <1384651251-5548-5-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:44967
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750877Ab3KRCmi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Nov 2013 21:42:38 -0500
Content-Disposition: inline
In-Reply-To: <1384651251-5548-5-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

On Sun, Nov 17, 2013 at 02:20:51AM +0100, Marek Vasut wrote:
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>
> ---
>  arch/arm/boot/dts/imx53-m53evk.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
> index 658d32a..c45a8d9c 100644
> --- a/arch/arm/boot/dts/imx53-m53evk.dts
> +++ b/arch/arm/boot/dts/imx53-m53evk.dts
> @@ -44,6 +44,10 @@
>  				};
>  			};
>  		};
> +
> +		sata@10000000 {
> +			status = "okay";
> +		};

Why not

&sata {

	status = "okay";
};

just like what other devices in this file are doing?

Shawn

