From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/4] ata: Add DT bindings for the Gemini SATA bridge
Date: Mon, 08 May 2017 12:49:03 +0200
Message-ID: <3791456.ZibJefW5cI@amdc3058>
References: <20170506121053.11554-1-linus.walleij@linaro.org>
        <CGME20170506121119epcas5p437ea69e802ba94bd7df83d0bbac1b0bc@epcas5p4.samsung.com>
        <20170506121053.11554-2-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:11479 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754077AbdEHKtI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 8 May 2017 06:49:08 -0400
In-reply-to: <20170506121053.11554-2-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, openwrt-devel@openwrt.org, linux-arm-kernel@lists.infradead.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, John Feng-Hsin Chiang <john453@faraday-tech.com>, Greentime Hu <green.hu@gmail.com>

On Saturday, May 06, 2017 02:10:51 PM Linus Walleij wrote:
> This adds device tree bindings for the Cortina Systems Gemini
> PATA to SATA bridge.
> 
> Cc: devicetree@vger.kernel.org
> Cc: John Feng-Hsin Chiang <john453@faraday-tech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/ata/cortina,gemini-sata-bridge.txt    | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
> new file mode 100644
> index 000000000000..9fe92818b2fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
> @@ -0,0 +1,55 @@
> +* Cortina Systems Gemini SATA Bridge
> +
> +The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
> +takes two Faraday Technology FTIDE010 PATA controllers and bridges
> +them in different configurations to two SATA ports.
> +
> +Required properties:
> +- compatible: should be
> +  "cortina,gemini-sata-bridge"
> +- reg: registers and size for the block
> +- resets: phandles to the reset lines for both SATA bridges
> +- reset-names: must be "sata0", "sata1"
> +- clocks: phandles to the compulsory peripheral clocks
> +- clock-names: must be "SATA0_PCLK", "SATA1_PCLK"
> +- syscon: a phandle to the global Gemini system controller
> +- cortina,gemini-ata-muxmode: tell the desired multiplexing mode for
> +  the ATA controller and SATA bridges. Values 0..3:
> +  Mode 0: ata0 master <-> sata0
> +          ata1 master <-> sata1
> +          ata0 slave interface brought out on IDE pads
> +  Mode 1: ata0 master <-> sata0
> +          ata1 master <-> sata1
> +          ata1 slave interface brought out on IDE pads
> +  Mode 2: ata1 master <-> sata1
> +          ata1 slave  <-> sata0
> +          ata0 master and slave interfaces brought out
> +               on IDE pads
> +  Mode 3: ata0 master <-> sata0
> +          ata1 slave  <-> sata1

ata0 slave?

> +          ata1 master and slave interfaces brought out
> +               on IDE pads
> +
> +Optional boolean properties:
> +- cortina,gemini-enable-ide-pins: enables the PATA to IDE connection.
> +  The muxmode setting decides whether ATA0 or ATA1 is brought out,
> +  and whether master, slave or both interfaces get brought out.
> +- cortina,gemini-enable-sata-bridge: enables the PATA to SATA bridge
> +  inside the Gemnini SoC. The Muxmode decides what PATA blocks will
> +  be muxed out and how.
> +
> +Example:
> +
> +sata: sata@46000000 {
> +	compatible = "cortina,gemini-sata-bridge";
> +	reg = <0x46000000 0x100>;
> +	resets = <&rcon 26>, <&rcon 27>;
> +	reset-names = "sata0", "sata1";
> +	clocks = <&gcc GEMINI_CLK_GATE_SATA0>,
> +		 <&gcc GEMINI_CLK_GATE_SATA1>;
> +	clock-names = "SATA0_PCLK", "SATA1_PCLK";
> +	syscon = <&syscon>;
> +	cortina,gemini-ata-muxmode = <3>;
> +	cortina,gemini-enable-ide-pins;
> +	cortina,gemini-enable-sata-bridge;
> +};

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

