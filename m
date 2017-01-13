From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 09/10] ARM: dts: da850: add the SATA node
Date: Fri, 13 Jan 2017 13:36:03 -0600
Message-ID: <4eb4ada8-1d2d-2fa1-7961-21da56ea0082@lechnology.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
 <1484311084-31547-10-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:47697 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbdAMTgH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 13 Jan 2017 14:36:07 -0500
In-Reply-To: <1484311084-31547-10-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 01/13/2017 06:38 AM, Bartosz Golaszewski wrote:
> Add the SATA node to the da850 device tree.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 1f6a47d..f5086b1 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -427,6 +427,12 @@
>  			phy-names = "usb-phy";
>  			status = "disabled";
>  		};
> +		sata: ahci@0x218000 {

0x needs to be omitted.

	sata: ahci@218000 {

> +			compatible = "ti,da850-ahci";
> +			reg = <0x218000 0x2000>, <0x22c018 0x4>;
> +			interrupts = <67>;
> +			status = "disabled";
> +		};
>  		mdio: mdio@224000 {
>  			compatible = "ti,davinci_mdio";
>  			#address-cells = <1>;
>

