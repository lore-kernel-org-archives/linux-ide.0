From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/6] Documentation: bindings: add the berlin-achi compatible
 to the ahci platform
Date: Tue, 22 Apr 2014 19:21:53 +0200
Message-ID: <5356A531.7030606@gmail.com>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com> <1398181105-19714-3-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:43515 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932861AbaDVRV6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Apr 2014 13:21:58 -0400
In-Reply-To: <1398181105-19714-3-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>, tj@kernel.org
Cc: alexandre.belloni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/22/2014 05:38 PM, Antoine T=C3=A9nart wrote:
> The berlin-achi driver allows Berlin SoCs to support their AHCI SATA =
controller.
> Add the compatible to the device tree bindings documentation.
>=20
> Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com=
>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt =
b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index 48b285ffa3a6..9987b63aaa10 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -7,7 +7,8 @@ Required properties:
>  - compatible        : compatible list, one of "snps,spear-ahci",
>                        "snps,exynos5440-ahci", "ibm,476gtr-ahci",
>                        "allwinner,sun4i-a10-ahci", "fsl,imx53-ahci"
> -                      "fsl,imx6q-ahci" or "snps,dwc-ahci"
> +                      "fsl,imx6q-ahci", "snps,dwc-ahci" or
> +		      "marvell,berlin-ahci"

Besides the typo Thomas already mentioned, it looks like the compatible=
s
are indented by spaces while you have tabs.

Sebastian

>  - interrupts        : <interrupt mapping for SATA IRQ>
>  - reg               : <registers mapping>
> =20
>=20

