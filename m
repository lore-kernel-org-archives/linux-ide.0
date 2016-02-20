From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH] drivers: ata: Read Rx water mark value from device-tree
Date: Sat, 20 Feb 2016 23:34:41 +0100
Message-ID: <28916176.WDrPajhOPa@wuerfel>
References: <1455974302-7082-1-git-send-email-anuragku@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455974302-7082-1-git-send-email-anuragku@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, tj@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, anirudh@xilinx.com, svemula@xilinx.com, punnaia@xilinx.com, Anurag Kumar Vulisha <anuragku@xilinx.com>
List-Id: linux-ide@vger.kernel.org

On Saturday 20 February 2016 18:48:22 Anurag Kumar Vulisha wrote:
> index 7ca8b97..7e48dfc 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> @@ -8,6 +8,7 @@ Required properties:
>  
>  Optional properties:
>    - ceva,broken-gen2: limit to gen1 speed instead of gen2.
> +  - ceva,rx-watermark: RX fifo water mark level for SATA controller.
>  
>  Examples:
>         ahci@fd0c0000 {
> @@ -17,4 +18,5 @@ Examples:
>                 interrupts = <0 133 4>;
>                 clocks = <&clkc SATA_CLK_ID>;
>                 ceva,broken-gen2;
> +               ceva,rx-watermark = <0x40>;
>         };
> 

How would a hardware integrator know which value is right for a
particular SoC?

Could it be keyed off the hardware ID? Could the bootloader
perhaps set an appropriate value in the AHCI_VEND_PTC
register at boot time and the driver read the initial
value from it?

>From the description, it sounds like this is a policy decision
rather than hardware description, and shouldn't really be
in here.

	Arnd
