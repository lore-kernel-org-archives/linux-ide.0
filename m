From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 3/5] devicetree: create a separate binding description
 for sata_highbank
Date: Sat, 03 Aug 2013 00:01:25 +0400
Message-ID: <51FC1015.7010203@cogentembedded.com>
References: <1375460918-4661-1-git-send-email-mark.langsdorf@calxeda.com> <1375460918-4661-3-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375460918-4661-3-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, tj@kernel.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob.herring@calxeda.com
List-Id: linux-ide@vger.kernel.org

On 08/02/2013 08:28 PM, Mark Langsdorf wrote:

> The Calxeda sata_highbank driver has been adding its descriptions to the
> ahci driver. Separate them properly.

> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
[...]

> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index 3ec0c5c..14d7b22 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -4,27 +4,17 @@ SATA nodes are defined to describe on-chip Serial ATA controllers.
[...]
>   Example:
>           sata@ffe08000 {
> -		compatible = "calxeda,hb-ahci";
> +		compatible = "snps,spear-ahci";
>                   reg = <0xffe08000 0x1000>;
>                   interrupts = <115>;

    Indented these 2 props with spaces, would be good to fix...

> -		calxeda,port-phys = <&combophy5 0 &combophy0 0 &combophy0 1
> -					&combophy0 2 &combophy0 3>;
>
>           };
> diff --git a/Documentation/devicetree/bindings/ata/sata_highbank.txt b/Documentation/devicetree/bindings/ata/sata_highbank.txt
> new file mode 100644
> index 0000000..aa1b798
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/sata_highbank.txt

    Shouldn't the file be called calxeda,hb-ahci.txt?

> @@ -0,0 +1,32 @@
> +* Calxeda AHCI SATA Controller
> +
> +SATA nodes are defined to describe on-chip Serial ATA controllers.
> +The Calxeda SATA controller mostly conforms to the AHCI interface
> +with some special extensions to add functionality.
> +Each SATA controller should have its own node.
> +
> +Required properties:
> +- compatible        : compatible list, contains "calxeda,hb-ahci"
> +- interrupts        : <interrupt mapping for SATA IRQ>
> +- reg               : <registers mapping>
> +
> +Optional properties:
> +- dma-coherent      : Present if dma operations are coherent
> +- calxeda,port-phys: phandle-combophy and lane assignment, which maps each
> +			SATA port to a combophy and a lane within that
> +			combophy
> +- calxeda,sgpio-gpio: phandle-gpio bank, bit offset, and default on or off,
> +			which indicates that the driver supports SGPIO
> +			indicator lights using the indicated GPIOs
> +- calxeda,led-order : a u32 array that map port numbers to offsets within the
> +			SGPIO bitstream.
> +
> +Example:
> +        sata@ffe08000 {
> +		compatible = "calxeda,hb-ahci";
> +                reg = <0xffe08000 0x1000>;
> +                interrupts = <115>;
> +		calxeda,port-phys = <&combophy5 0 &combophy0 0 &combophy0 1

    Could you indent props uniformly here, with tabs?

WBR, Sergei
