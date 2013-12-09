From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ARM: dts: imx53: Enable AHCI SATA for imx53-qsb
Date: Mon, 9 Dec 2013 10:11:39 +0800
Message-ID: <20131209021137.GA825@S2101-09.ap.freescale.net>
References: <1386081578-3651-1-git-send-email-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-db8lp0189.outbound.messaging.microsoft.com ([213.199.154.189]:29856
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755336Ab3LICLa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Dec 2013 21:11:30 -0500
Content-Disposition: inline
In-Reply-To: <1386081578-3651-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

On Tue, Dec 03, 2013 at 08:39:38AM -0600, Robert Nelson wrote:
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>

Applied, thanks.

Shawn

> ---
>  arch/arm/boot/dts/imx53-qsb.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
> index 91a5935..ea927be 100644
> --- a/arch/arm/boot/dts/imx53-qsb.dts
> +++ b/arch/arm/boot/dts/imx53-qsb.dts
> @@ -307,6 +307,10 @@
>  	status = "okay";
>  };
>  
> +&sata {
> +	status = "okay";
> +};
> +
>  &vpu {
>  	status = "okay";
>  };
> -- 
> 1.8.4.3
> 

