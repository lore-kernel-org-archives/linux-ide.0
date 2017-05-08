From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/4] ata: Add DT bindings for Faraday Technology FTIDE010
Date: Mon, 08 May 2017 12:47:36 +0200
Message-ID: <1678111.DmiVNKW3dQ@amdc3058>
References: <CGME20170506121118epcas2p1b2a2d1a8005a37582a73c0e7be4b1a1b@epcas2p1.samsung.com>
 <20170506121053.11554-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44688 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbdEHKrk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 8 May 2017 06:47:40 -0400
In-reply-to: <20170506121053.11554-1-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, openwrt-devel@openwrt.org, linux-arm-kernel@lists.infradead.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, John Feng-Hsin Chiang <john453@faraday-tech.com>, Greentime Hu <green.hu@gmail.com>


Hi,

On Saturday, May 06, 2017 02:10:50 PM Linus Walleij wrote:
> This adds device tree bindings for the Faraday Technology
> FTIDE010 found in the Storlink/Storm/Cortina Systems Gemini SoC.
> 
> I am not 100% sure that this part if from Faraday Technology but
> a lot points in that direction:
> 
> - A later IDE interface called FTIDE020 exist and share some
>   properties.
> 
> - The SATA bridge has the same Built In Self Test (BIST) that the
>   Faraday FTSATA100 seems to have, and it has version number 0100
>   in the device ID register, so this is very likely a FTSATA100
>   bundled with the FTIDE010.
> 
> Cc: devicetree@vger.kernel.org
> Cc: John Feng-Hsin Chiang <john453@faraday-tech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Greentime: I think this may be interesting to you since the
> FTIDE020 will need the same bindings so we can probably
> just reuse them and maybe make the parser a library if you
> want to upstream the FTIDE020.
> 
> Faraday people: I do not have it from a source that this
> hardware is really FTIDE010 but I would be VERY surprised
> if it is not. U-Boot has an FTIDE020 IDE controller
> synthesized in the Andestech platform, and it has a similar
> yet different register layout, featuring similar timing
> set-ups:
> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/block/ftide020.h
> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/block/ftide020.c
> ---
>  .../devicetree/bindings/ata/faraday,ftide010.txt   | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/faraday,ftide010.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/faraday,ftide010.txt b/Documentation/devicetree/bindings/ata/faraday,ftide010.txt
> new file mode 100644
> index 000000000000..5048408c07c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/faraday,ftide010.txt
> @@ -0,0 +1,63 @@
> +* Faraday Technology FTIDE010 PATA controller
> +
> +This controller is the first Faraday IDE interface block, used in the
> +StorLink SL2312 and SL3516, later known as the Cortina Systems Gemini
> +platform. The controller can do PIO modes 0 through 4, Multi-word DMA
> +(MWDM)modes 0 through 2 and Ultra DMA modes 0 through 6.
> +
> +On the Gemini platform, this PATA block is accompanied by a PATA to
> +SATA bridge in order to support SATA. This is why a phandle to that
> +controller is compulsory on that platform.
> +
> +The timing properties are unique per-SoC, not per-board.
> +
> +Required properties:
> +- compatible: should be one of
> +  "cortina,gemini-pata", "faraday,ftide010"
> +  "faraday,ftide010"
> +- interrupts: interrupt for the block
> +- reg: registers and size for the block
> +
> +  The unit of the below required timings is two clock periods of the ATA
> +  reference clock which is 30 nanoseconds per unit at 66MHz and 20 nanoseconds
> +  per unit at 50 MHz.
> +
> +- faraday,pio-active-time: array of 5 elements for T2 timing for Mode 0,
> +  1, 2, 3 and 4. Range 0..15.
> +- faraday,pio-recovery-time: array of 5 elements for T2l timing for Mode 0,
> +  1, 2, 3 and 4. Range 0..15.
> +- faraday,mdma-50-active-time: array of 4 elements for Td timing for multi
> +  word DMA, Mode 0, 1, and 2 at 50 MHz. Range 0..15.
> +- faraday,mdma-50-recovery-time: array of 4 elements for Tk timing for
> +  multi word DMA, Mode 0, 1 and 2 at 50 MHz. Range 0..15.
> +- faraday,mdma-66-active-time: array of 4 elements for Td timing for multi
> +  word DMA, Mode 0, 1 and 2 at 50 MHz. Range 0..15.

at 66 MHZ?

> +- faraday,mdma-66-recovery-time: array of 4 elements for Tk timing for

at 66 MHZ?

> +  multi word DMA, Mode 0, 1 and 2 at 50 MHz. Range 0..15.
> +- faraday,udma-50-setup-time: array of 4 elements for Tvds timing for ultra
> +  DMA, Mode 0, 1, 2, 3, 4 and 5 at 50 MHz. Range 0..7.
> +- faraday,udma-50-hold-time: array of 4 elements for Tdvh timing for
> +  multi word DMA, Mode 0, 1, 2, 3, 4 and 5 at 50 MHz, Range 0..7.
> +- faraday,udma-66-setup-time: array of 4 elements for Tvds timing for multi
> +  word DMA, Mode 0, 1, 2, 3, 4, 5 and 6 at 50 MHz. Range 0..7.

at 66 MHZ?

> +- faraday,udma-66-hold-time: array of 4 elements for Tdvh timing for
> +  multi word DMA, Mode 0, 1, 2, 3, 4, 5 and 6 at 50 MHz. Range 0..7.

at 66 MHZ?

Also for all current drivers we just put timing values (or a logic
to calculate them from the standard ATA timings) into the driver
itself and not device tree (as they are based on values are dictated
by ATA standard and should not change for a given controller type).

> +Optional properties:
> +- clocks: a SoC clock running the peripheral.
> +- clock-names: should be set to "PCLK" for the peripheral clock.
> +
> +Required properties for "cortina,gemini-pata" compatible:
> +- sata: a phande to the Gemini PATA to SATA bridge, see
> +  cortina,gemini-sata-bridge.txt for details.
> +
> +Example:
> +
> +ata@63000000 {
> +	compatible = "cortina,gemini-pata", "faraday,ftide010";
> +	reg = <0x63000000 0x100>;
> +	interrupts = <4 IRQ_TYPE_EDGE_RISING>;
> +	clocks = <&gcc GEMINI_CLK_GATE_IDE>;
> +	clock-names = "PCLK";
> +	sata = <&sata>;
> +};

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

