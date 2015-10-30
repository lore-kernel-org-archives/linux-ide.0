From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: Re: [v3 08/10] MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7425
Date: Fri, 30 Oct 2015 22:52:46 +0900
Message-ID: <A997D184-1774-4720-A3A9-B34C1E2F6365@gmail.com>
References: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com> <1446212339-1210-9-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36672 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030474AbbJ3Nww convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2015 09:52:52 -0400
In-Reply-To: <1446212339-1210-9-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org

> On Oct 30, 2015, at 10:38 PM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> 
> Add AHCI and PHY device nodes to MIPS-based BCM7425 set-top box
> platform.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
> arch/mips/boot/dts/brcm/bcm7425.dtsi | 42 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 42 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
> index 5b660b617ead..e24d41ab4e30 100644
> --- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
> +++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
> @@ -221,5 +221,47 @@
> 			interrupts = <73>;
> 			status = "disabled";
> 		};
> +
> +		sata: sata@181000 {
> +			compatible = "brcm,bcm7425-ahci", "brcm,sata3-ahci";
> +			reg-names = "ahci", "top-ctrl";
> +			reg = <0x181000 0xa9c>, <0x180020 0x1c>;
> +			interrupt-parent = <&periph_intc>;
> +			interrupts = <40>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			brcm,broken-ncq;
> +			brcm,broken-phi;

I am sorry. This should be remove brcm,broken-ncq and brcm,broken-phy.

> +			status = "disabled";
> +
> +			sata0: sata-port@0 {
> +				reg = <0>;
> +				phys = <&sata_phy0>;
> +			};
> +
> +			sata1: sata-port@1 {
> +				reg = <1>;
> +				phys = <&sata_phy1>;
> +			};
> +		};
> +
> +		sata_phy: sata-phy@1800000 {
> +			compatible = "brcm,bcm7425-sata-phy", "brcm,phy-sata3";
> +			reg = <0x180100 0x0eff>;
> +			reg-names = "phy";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			sata_phy0: sata-phy@0 {
> +				reg = <0>;
> +				#phy-cells = <0>;
> +			};
> +
> +			sata_phy1: sata-phy@1 {
> +				reg = <1>;
> +				#phy-cells = <0>;
> +			};
> +		};
> 	};
> };
> -- 
> 2.6.2
> 

