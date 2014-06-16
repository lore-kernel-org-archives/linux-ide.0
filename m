From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v6 6/7] ARM: berlin: add the AHCI node for the BG2Q
Date: Mon, 16 Jun 2014 12:44:28 +0200
Message-ID: <539ECA8C.4010007@gmail.com>
References: <1402914392-6028-1-git-send-email-antoine.tenart@free-electrons.com> <1402914392-6028-7-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:43400 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104AbaFPKoe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jun 2014 06:44:34 -0400
In-Reply-To: <1402914392-6028-7-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>, tj@kernel.org, kishon@ti.com
Cc: alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/16/2014 12:26 PM, Antoine T=C3=A9nart wrote:
> The BG2Q has an AHCI SATA controller. Add the corresponding nodes
> (AHCI, PHY) into its device tree.
>
> Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com=
>
> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berl=
in2q.dtsi
> index 635a16a64cb4..3fb0d3935aec 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -303,6 +303,34 @@
>   			clock-names =3D "refclk";
>   		};
>
> +		ahci: sata@e90000 {
> +			compatible =3D "generic-ahci";
> +			reg =3D <0xe90000 0x1000>;
> +			interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&chip CLKID_SATA>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			sata0: sata-port@0 {
> +				reg =3D <0>;
> +				phys =3D <&sata_phy 0>;
> +				status =3D "disabled";
> +			};
> +
> +			sata1: sata-port@1 {
> +				reg =3D <1>;
> +				phys =3D <&sata_phy 1>;
> +				status =3D "disabled";
> +			};
> +		};
> +
> +		sata_phy: phy@e900a0 {
> +			compatible =3D "marvell,berlin-sata-phy";
> +			reg =3D <0xe900a0 0x200>;

Antoine,

I guess you'll also need
	clocks =3D <&chip CLKID_SATA>;
here and corresponding code in the PHY driver.

If SATA PHY is accessing SATA registers, disabling the clock will
most likely lock-up the SoC.

Sebastian

> +			#phy-cells =3D <1>;
> +			status =3D "disabled";
> +		};
> +
>   		apb@fc0000 {
>   			compatible =3D "simple-bus";
>   			#address-cells =3D <1>;
>

