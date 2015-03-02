From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3] ARM: DT: STi: STiH407: Add sata DT nodes.
Date: Mon, 2 Mar 2015 17:00:28 +0000
Message-ID: <20150302170028.GB6976@x1>
References: <1425300519-13747-1-git-send-email-peter.griffin@linaro.org>
 <1425300519-13747-3-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425300519-13747-3-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, tj@kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, 02 Mar 2015, Peter Griffin wrote:

> Now that the miphy28lp is upstream, we can add the sata dt nodes
> for stih407 family silicon. This has been tested on b2120 board
> J4 (sata0 channel). These nodes are disabled by default as a
> special mini pci-e to sata daughter board is required which
> isn't shipped with the board.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 44 +++++++++++++++++++++++++=
++++++++++
>  1 file changed, 44 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dt=
s/stih407-family.dtsi
> index a57c06e..d526921 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -338,6 +338,50 @@
>  			};
>  		};
> =20
> +		sata0: sata@9b20000 {
> +			compatible =3D "st,ahci";
> +			reg =3D <0x9b20000 0x1000>;
> +
> +			interrupts =3D <GIC_SPI 159 IRQ_TYPE_NONE>;
> +			interrupt-names =3D "hostc";
> +
> +			phys =3D <&phy_port0 PHY_TYPE_SATA>;
> +			phy-names =3D "ahci_phy";
> +
> +			resets =3D <&powerdown STIH407_SATA0_POWERDOWN>,
> +				 <&softreset STIH407_SATA0_SOFTRESET>,
> +				 <&softreset STIH407_SATA0_PWR_SOFTRESET>;
> +			reset-names =3D "pwr-dwn", "sw-rst", "pwr-rst";
> +
> +			clock-names =3D "ahci_clk";
> +			clocks =3D <&clk_s_c0_flexgen CLK_ICN_REG>;
> +
> +			status =3D "disabled";
> +		};
> +
> +		sata1: sata@9b28000 {
> +			compatible =3D "st,ahci";
> +			reg =3D <0x9b28000 0x1000>;
> +
> +			interrupts =3D <GIC_SPI 170 IRQ_TYPE_NONE>;
> +			interrupt-names =3D "hostc";
> +
> +			phys =3D <&phy_port1 PHY_TYPE_SATA>;
> +			phy-names =3D "ahci_phy";
> +
> +			resets =3D <&powerdown STIH407_SATA1_POWERDOWN>,
> +				 <&softreset STIH407_SATA1_SOFTRESET>,
> +				 <&softreset STIH407_SATA1_PWR_SOFTRESET>;
> +			reset-names =3D "pwr-dwn",
> +				      "sw-rst",
> +				      "pwr-rst";
> +
> +			clock-names =3D "ahci_clk";
> +			clocks =3D <&clk_s_c0_flexgen CLK_ICN_REG>;
> +
> +			status =3D "disabled";
> +		};
> +
>  		st_dwc3: dwc3@8f94000 {
>  			compatible	=3D "st,stih407-dwc3";
>  			reg		=3D <0x08f94000 0x1000>, <0x110 0x4>;

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
