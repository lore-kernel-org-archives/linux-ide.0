From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH V2 2/2] dt: Document sata_rcar bindings
Date: Fri, 08 Nov 2013 16:31:03 +0100
Message-ID: <1485806.0A3W2702o2@avalon>
References: <1383854642-21660-1-git-send-email-valentine.barshak@cogentembedded.com> <527CCA76.5060706@cogentembedded.com> <527CD08D.80004@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <527CD08D.80004@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Valentine <valentine.barshak@cogentembedded.com>
Cc: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-ide@vger.kernel.org

Hi Valentine,

On Friday 08 November 2013 15:52:45 Valentine wrote:
> On 11/08/2013 03:26 PM, Valentine wrote:
> > On 11/08/2013 05:02 AM, Laurent Pinchart wrote:
> >> On Friday 08 November 2013 00:04:02 Valentine Barshak wrote:
> >>> These bindings can be used to register SATA devices found on R-Car SoC.
> >>> 
> >>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >>> Acked-by: Kumar Gala <galak@codeaurora.org>
> >>> ---
> >>> 
> >>>   Documentation/devicetree/bindings/ata/sata_rcar.txt | 18 +++++++++++++
> >>> 
> >>> 1 file changed, 18 insertions(+)
> >>> 
> >>>   create mode 100644 Documentation/devicetree/bindings/ata/sata_rcar.txt
> >>> 
> >>> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt
> >>> b/Documentation/devicetree/bindings/ata/sata_rcar.txt new file mode
> >>> 100644
> >>> index 0000000..d6b20a6
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> >>> @@ -0,0 +1,18 @@
> >>> +* Renesas R-Car SATA
> >>> +
> >>> +Required properties:
> >>> +- compatible        : should contain one of the following:
> >>> +              - "renesas,sata-r8a7779" for R-Car H1
> >>> +              - "renesas,sata-r8a7790" for R-Car H2
> >>> +              - "renesas,sata-r8a7791" for R-Car M2
> >>> +- reg            : offset and length of the SATA registers;
> >> 
> >> Maybe address instead of offset ?
> > 
> > OK.
> > 
> >>> +- interrupts        : must consist of one interrupt specifier.
> >>> +
> >>> +Example:
> >>> +
> >>> +sata: sata@fc600000 {
> >>> +    compatible = "renesas,sata-r8a7779";
> >>> +    reg = <0xfc600000 0x2000>;
> >>> +    interrupt-parent = <&gic>;
> >>> +    interrupts = <0 100 0x4>;
> >> 
> >> Please use IRQ_TYPE_LEVEL_HIGH instead of 0x4.
> > 
> > OK, I'll do that.
> > 
> > Please, note that all the Renesas dts[i] files do not include
> > <dt-bindings/interrupt-controller/irq.h> Thus, blindly following this
> > bindings documentation when adding new SATA nodes to the existing
> > r8a7790.dtsi, for example, will cause DT compilation error.
> 
> BTW, we'll also have to switch to #include instead of /include/ to make it
> work.

Sure, of course.

I was actually thinking about sending a patch to convert our DT sources to use 
the IRQ_* macros. Morimoto-san, are you working on that already ? If not I'll 
do it.

Simon, would you like one patch per SoC or would a single patch do ? Only 
.dts(i) files will be touched.

-- 
Regards,

Laurent Pinchart

