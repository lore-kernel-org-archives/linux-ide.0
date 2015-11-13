From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] drivers: ata: Move vendor specific sata port phy oob
 settings to device-tree
Date: Fri, 13 Nov 2015 08:32:06 -0600
Message-ID: <20151113143206.GA8215@rob-hp-laptop>
References: <1447410743-36086-1-git-send-email-anuragku@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447410743-36086-1-git-send-email-anuragku@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, tj@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, michals@xilinx.com, punnaia@xilinx.com, anirudh@xilinx.com, svemula@xilinx.com, Anurag Kumar Vulisha <anuragku@xilinx.com>
List-Id: linux-ide@vger.kernel.org

On Fri, Nov 13, 2015 at 04:02:23PM +0530, Anurag Kumar Vulisha wrote:
> In SATA, speed negotiation happens with  OOB(Out of Band) signals. These OOB
> signal timing values are configured through vendor specific registers in the
> SATA controller. These OOB timings depends on the generator and detector clock
> frequency, which varies from board to board (ex: ep108, zcu102 and zc1751 has
> different clock frequencies).

Could you calculate the timings based on the frequency instead? 

> Since to make ahci_ceva driver generic, it would be better to move these
> settings to the device-tree node and read them from driver.
> 
> This patch does the same.
> 
> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> ---
>  .../devicetree/bindings/ata/ahci-ceva.txt          |   38 +++++++++
>  drivers/ata/ahci_ceva.c                            |   84 ++++++++++++++------
>  2 files changed, 99 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> index 7ca8b97..66fcd10 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> @@ -5,6 +5,36 @@ Required properties:
>    - compatible: Compatibility string. Must be 'ceva,ahci-1v84'.
>    - clocks: Input clock specifier. Refer to common clock bindings.
>    - interrupts: Interrupt specifier. Refer to interrupt binding.
> +    - ceva,p0-cominit-params: OOB timing value for COMINIT parameter for port 0.
> +    - ceva,p1-cominit-params: OOB timing value for COMINIT parameter for port 1.

This doesn't really scale when you have more than 2 ports. Given that 
you know the length for each port, just make it a single property (i.e. 
an array of ports).

> +  			The fields for the above parameter must be as shown below:
> +  			ceva,phy-cominit-params = /bits/ 8 <CIBGMN CIBGMX CIBGN CINMP>;
> +  			CINMP : COMINIT Negate Minimum Period.
> +  			CIBGN : COMINIT Burst Gap Nominal.
> +  			CIBGMX: COMINIT Burst Gap Maximum.
> +  			CIBGMN: COMINIT Burst Gap Minimum.
> +    - ceva,p0-comwake-params: OOB timing value for COMWAKE parameter for port 0.
> +    - ceva,p1-comwake-params: OOB timing value for COMWAKE parameter for port 1.
> +  			The fields for the above parameter must be as shown below:
> +  			ceva,phy-comwake-params = /bits/ 8 <CWBGMN CWBGMX CWBGN CWNMP>;
> +  			CWBGMN: COMWAKE Burst Gap Minimum.
> +  			CWBGMX: COMWAKE Burst Gap Maximum.
> +  			CWBGN: COMWAKE Burst Gap Nominal.
> +  			CWNMP: COMWAKE Negate Minimum Period.
> +    - ceva,p0-burst-params: Burst timing value for COM parameter for port 0.
> +    - ceva,p1-burst-params: Burst timing value for COM parameter for port 1.
> +  			The fields for the above parameter must be as shown below:
> +			ceva,phy-burst-params = /bits/ 8 <BMX BNM SFD PTST>;
> +  			BMX: COM Burst Maximum.
> +  			BNM: COM Burst Nominal.
> +  			SFD: Signal Failure Detection value.
> +  			PTST: Partial to Slumber timer value.
> +    - ceva,p0-retry-params: Retry interval timing value for port 0.
> +    - ceva,p1-retry-params: Retry interval timing value for port 1.
> +  			The fields for the above parameter must be as shown below:
> +  			ceva,phy-retry-params = /bits/ 16 <RIT RCT>;
> +  			RIT:  Retry Interval Timer.
> +  			RCT:  Rate Change Timer.
>  
>  Optional properties:
>    - ceva,broken-gen2: limit to gen1 speed instead of gen2.
> @@ -17,4 +47,12 @@ Examples:
>  		interrupts = <0 133 4>;
>  		clocks = <&clkc SATA_CLK_ID>;
>  		ceva,broken-gen2;
> +		ceva,p0-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
> +		ceva,p0-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
> +		ceva,p0-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
> +		ceva,p0-retry-params = /bits/ 16 <0x0216 0x7F06>;
> +		ceva,p1-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
> +		ceva,p1-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
> +		ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
> +		ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
>  	};
> diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
> index 207649d..59de2ca 100644
> --- a/drivers/ata/ahci_ceva.c
> +++ b/drivers/ata/ahci_ceva.c
> @@ -50,21 +50,6 @@
>  #define PPCFG_PSS_EN	(1 << 29)
>  #define PPCFG_ESDF_EN	(1 << 31)
>  
> -#define PP2C_CIBGMN	0x0F
> -#define PP2C_CIBGMX	(0x25 << 8)
> -#define PP2C_CIBGN	(0x18 << 16)
> -#define PP2C_CINMP	(0x29 << 24)
> -
> -#define PP3C_CWBGMN	0x04
> -#define PP3C_CWBGMX	(0x0B << 8)
> -#define PP3C_CWBGN	(0x08 << 16)
> -#define PP3C_CWNMP	(0x0F << 24)
> -
> -#define PP4C_BMX	0x0a
> -#define PP4C_BNM	(0x08 << 8)
> -#define PP4C_SFD	(0x4a << 16)
> -#define PP4C_PTST	(0x06 << 24)
> -
>  #define PP5C_RIT	0x60216
>  #define PP5C_RCT	(0x7f0 << 20)
>  
> @@ -87,6 +72,11 @@
>  
>  struct ceva_ahci_priv {
>  	struct platform_device *ahci_pdev;
> +	/* Port Phy2Cfg Register */
> +	u32 pp2c[NR_PORTS];
> +	u32 pp3c[NR_PORTS];
> +	u32 pp4c[NR_PORTS];
> +	u32 pp5c[NR_PORTS];
>  	int flags;
>  };
>  
> @@ -131,20 +121,16 @@ static void ahci_ceva_setup(struct ahci_host_priv *hpriv)
>  		writel(tmp, mmio + AHCI_VEND_PPCFG);
>  
>  		/* Phy Control OOB timing parameters COMINIT */
> -		tmp = PP2C_CIBGMN | PP2C_CIBGMX | PP2C_CIBGN | PP2C_CINMP;
> -		writel(tmp, mmio + AHCI_VEND_PP2C);
> +		writel(cevapriv->pp2c[i], mmio + AHCI_VEND_PP2C);
>  
>  		/* Phy Control OOB timing parameters COMWAKE */
> -		tmp = PP3C_CWBGMN | PP3C_CWBGMX | PP3C_CWBGN | PP3C_CWNMP;
> -		writel(tmp, mmio + AHCI_VEND_PP3C);
> +		writel(cevapriv->pp3c[i], mmio + AHCI_VEND_PP3C);
>  
>  		/* Phy Control Burst timing setting */
> -		tmp = PP4C_BMX | PP4C_BNM | PP4C_SFD | PP4C_PTST;
> -		writel(tmp, mmio + AHCI_VEND_PP4C);
> +		writel(cevapriv->pp4c[i], mmio + AHCI_VEND_PP4C);
>  
>  		/* Rate Change Timer and Retry Interval Timer setting */
> -		tmp = PP5C_RIT | PP5C_RCT;
> -		writel(tmp, mmio + AHCI_VEND_PP5C);
> +		writel(cevapriv->pp5c[i], mmio + AHCI_VEND_PP5C);
>  
>  		/* Rx Watermark setting  */
>  		tmp = PTC_RX_WM_VAL | PTC_RSVD;
> @@ -187,6 +173,58 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  	if (of_property_read_bool(np, "ceva,broken-gen2"))
>  		cevapriv->flags = CEVA_FLAG_BROKEN_GEN2;
>  
> +	/* Read OOB timing value for COMINIT from device-tree */
> +	if (of_property_read_u8_array(np, "ceva,p0-cominit-params",
> +					(u8 *)&cevapriv->pp2c[0], 4) < 0) {
> +		dev_warn(dev, "ceva,p0-cominit-params property not defined\n");

I'd really like to move all the error prints into the of_property_* 
functions instead, but then we'd probably need *_optional variants to 
avoid spewing to the console.

Rob
