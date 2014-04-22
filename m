From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 3/6] ARM: berlin: add the AHCI node for the BG2Q
Date: Tue, 22 Apr 2014 18:28:02 +0200
Message-ID: <20140422182802.447c2912@skate>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
	<1398181105-19714-4-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398181105-19714-4-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Antoine =?UTF-8?B?VMOpbmFydA==?= <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, tj@kernel.org, zmxu@marvell.com, jszhang@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Dear Antoine T=C3=A9nart,

On Tue, 22 Apr 2014 17:38:22 +0200, Antoine T=C3=A9nart wrote:
> The BG2Q has an AHCI SATA controller. Add the corresponding node
> in its device tree.

I believe the commit log should explain why an apparently unrelated
generic-regs@ node gets added in this commit.

Thanks!

Thomas

> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berl=
in2q.dtsi
> index 07452a7483fa..8e58aae73365 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -183,6 +183,18 @@
>  			};
>  		};
> =20
> +		ahci: sata@e90000 {
> +			compatible =3D "marvell,berlin-ahci";
> +			reg =3D <0xe90000 0x10000>;
> +			interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disable";
> +		};
> +
> +		generic-regs@ea0110 {
> +			compatible =3D "marvell,berlin-generic-regs", "syscon";
> +			reg =3D <0xea0110 0x10>;
> +		};
> +
>  		apb@fc0000 {
>  			compatible =3D "simple-bus";
>  			#address-cells =3D <1>;



--=20
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
