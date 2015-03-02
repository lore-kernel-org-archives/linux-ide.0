From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] ahci: st: Update the ahci_st DT documentation
Date: Mon, 2 Mar 2015 16:59:47 +0000
Message-ID: <20150302165947.GA6976@x1>
References: <1425300519-13747-1-git-send-email-peter.griffin@linaro.org>
 <1425300519-13747-2-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425300519-13747-2-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, tj@kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, 02 Mar 2015, Peter Griffin wrote:

> As part of testing ahci_st driver working on stih407 I noticed
> several things wrong in the DT documentation: -
>=20
> 1) Compatible string doesn't match the driver code
> 2) pwr-rst reset isn't documented (but exists in the driver)
> 3) some whitespace issues (spaces not tabs)
>=20
> Also add in a stih407 family example into the doc.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  Documentation/devicetree/bindings/ata/ahci-st.txt | 45 +++++++++++++=
+++-------
>  1 file changed, 32 insertions(+), 13 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/Documentation/devicetree/bindings/ata/ahci-st.txt b/Docu=
mentation/devicetree/bindings/ata/ahci-st.txt
> index 1331202..e1d01df 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-st.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-st.txt
> @@ -3,29 +3,48 @@ STMicroelectronics STi SATA controller
>  This binding describes a SATA device.
> =20
>  Required properties:
> - - compatible	   : Must be "st,sti-ahci"
> + - compatible	   : Must be "st,ahci"
>   - reg		   : Physical base addresses and length of register sets
>   - interrupts	   : Interrupt associated with the SATA device
>   - interrupt-names :   Associated name must be; "hostc"
> - - resets	   : The power-down and soft-reset lines of SATA IP
> - - reset-names	   :   Associated names must be; "pwr-dwn" and "sw-rs=
t"
>   - clocks	   : The phandle for the clock
>   - clock-names	   :   Associated name must be; "ahci_clk"
>   - phys		   : The phandle for the PHY port
>   - phy-names	   :   Associated name must be; "ahci_phy"
> =20
> +Optional properties:
> + - resets	   : The power-down, soft-reset and power-reset lines of S=
ATA IP
> + - reset-names	   :   Associated names must be; "pwr-dwn", "sw-rst" =
and "pwr-rst"
> +
>  Example:
> =20
> +	/* Example for stih416 */
>  	sata0: sata@fe380000 {
> -		compatible      =3D "st,sti-ahci";
> -		reg             =3D <0xfe380000 0x1000>;
> -		interrupts      =3D <GIC_SPI 157 IRQ_TYPE_NONE>;
> -		interrupt-names =3D "hostc";
> -		phys	        =3D <&phy_port0 PHY_TYPE_SATA>;
> -		phy-names       =3D "ahci_phy";
> -		resets	        =3D <&powerdown STIH416_SATA0_POWERDOWN>,
> +		compatible	=3D "st,ahci";
> +		reg		=3D <0xfe380000 0x1000>;
> +		interrupts	=3D <GIC_SPI 157 IRQ_TYPE_NONE>;
> +		interrupt-names	=3D "hostc";
> +		phys		=3D <&phy_port0 PHY_TYPE_SATA>;
> +		phy-names	=3D "ahci_phy";
> +		resets		=3D <&powerdown STIH416_SATA0_POWERDOWN>,
>  				  <&softreset STIH416_SATA0_SOFTRESET>;
> -		reset-names     =3D "pwr-dwn", "sw-rst";
> -		clocks	        =3D <&clk_s_a0_ls CLK_ICN_REG>;
> -		clock-names     =3D "ahci_clk";
> +		reset-names	=3D "pwr-dwn", "sw-rst";
> +		clocks		=3D <&clk_s_a0_ls CLK_ICN_REG>;
> +		clock-names	=3D "ahci_clk";
> +	};
> +
> +	/* Example for stih407 family silicon */
> +	sata0: sata@9b20000 {
> +		compatible	=3D "st,ahci";
> +		reg		=3D <0x9b20000 0x1000>;
> +		interrupts	=3D <GIC_SPI 159 IRQ_TYPE_NONE>;
> +		interrupt-names	=3D "hostc";
> +		phys		=3D <&phy_port0 PHY_TYPE_SATA>;
> +		phy-names	=3D "ahci_phy";
> +		resets		=3D <&powerdown STIH407_SATA0_POWERDOWN>,
> +				  <&softreset STIH407_SATA0_SOFTRESET>,
> +				  <&softreset STIH407_SATA0_PWR_SOFTRESET>;
> +		reset-names	=3D "pwr-dwn", "sw-rst", "pwr-rst";
> +		clocks		=3D <&clk_s_c0_flexgen CLK_ICN_REG>;
> +		clock-names	=3D "ahci_clk";
>  	};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
