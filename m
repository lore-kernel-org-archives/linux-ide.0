From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH V2 2/2] dt: Document sata_rcar bindings
Date: Tue, 12 Nov 2013 12:42:58 +0900
Message-ID: <20131112034257.GJ9863@verge.net.au>
References: <1383854642-21660-1-git-send-email-valentine.barshak@cogentembedded.com>
 <527CCA76.5060706@cogentembedded.com>
 <527CD08D.80004@cogentembedded.com>
 <1485806.0A3W2702o2@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:39889 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab3KLDnD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Nov 2013 22:43:03 -0500
Content-Disposition: inline
In-Reply-To: <1485806.0A3W2702o2@avalon>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Valentine <valentine.barshak@cogentembedded.com>, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>

On Fri, Nov 08, 2013 at 04:31:03PM +0100, Laurent Pinchart wrote:
> Hi Valentine,
> 
> On Friday 08 November 2013 15:52:45 Valentine wrote:
> > On 11/08/2013 03:26 PM, Valentine wrote:
> > > On 11/08/2013 05:02 AM, Laurent Pinchart wrote:
> > >> On Friday 08 November 2013 00:04:02 Valentine Barshak wrote:
> > >>> These bindings can be used to register SATA devices found on R-Car SoC.
> > >>> 
> > >>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> > >>> Acked-by: Kumar Gala <galak@codeaurora.org>
> > >>> ---
> > >>> 
> > >>>   Documentation/devicetree/bindings/ata/sata_rcar.txt | 18 +++++++++++++
> > >>> 
> > >>> 1 file changed, 18 insertions(+)
> > >>> 
> > >>>   create mode 100644 Documentation/devicetree/bindings/ata/sata_rcar.txt
> > >>> 
> > >>> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt
> > >>> b/Documentation/devicetree/bindings/ata/sata_rcar.txt new file mode
> > >>> 100644
> > >>> index 0000000..d6b20a6
> > >>> --- /dev/null
> > >>> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> > >>> @@ -0,0 +1,18 @@
> > >>> +* Renesas R-Car SATA
> > >>> +
> > >>> +Required properties:
> > >>> +- compatible        : should contain one of the following:
> > >>> +              - "renesas,sata-r8a7779" for R-Car H1
> > >>> +              - "renesas,sata-r8a7790" for R-Car H2
> > >>> +              - "renesas,sata-r8a7791" for R-Car M2
> > >>> +- reg            : offset and length of the SATA registers;
> > >> 
> > >> Maybe address instead of offset ?
> > > 
> > > OK.
> > > 
> > >>> +- interrupts        : must consist of one interrupt specifier.
> > >>> +
> > >>> +Example:
> > >>> +
> > >>> +sata: sata@fc600000 {
> > >>> +    compatible = "renesas,sata-r8a7779";
> > >>> +    reg = <0xfc600000 0x2000>;
> > >>> +    interrupt-parent = <&gic>;
> > >>> +    interrupts = <0 100 0x4>;
> > >> 
> > >> Please use IRQ_TYPE_LEVEL_HIGH instead of 0x4.
> > > 
> > > OK, I'll do that.
> > > 
> > > Please, note that all the Renesas dts[i] files do not include
> > > <dt-bindings/interrupt-controller/irq.h> Thus, blindly following this
> > > bindings documentation when adding new SATA nodes to the existing
> > > r8a7790.dtsi, for example, will cause DT compilation error.
> > 
> > BTW, we'll also have to switch to #include instead of /include/ to make it
> > work.
> 
> Sure, of course.
> 
> I was actually thinking about sending a patch to convert our DT sources to use 
> the IRQ_* macros. Morimoto-san, are you working on that already ? If not I'll 
> do it.
> 
> Simon, would you like one patch per SoC or would a single patch do ? Only 
> .dts(i) files will be touched.

I would prefer one patch per SoC.
The reason is that in general that approach makes backporting easier.
