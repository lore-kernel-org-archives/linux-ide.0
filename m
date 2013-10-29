From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] sata_rcar: Add R-Car Gen2 SATA PHY support
Date: Tue, 29 Oct 2013 17:44:48 +0900
Message-ID: <20131029084444.GC15731@verge.net.au>
References: <1381925161-16729-1-git-send-email-valentine.barshak@cogentembedded.com>
 <1381925161-16729-3-git-send-email-valentine.barshak@cogentembedded.com>
 <20131029045943.GE20432@verge.net.au>
 <B6798662-4DEC-499A-A96E-EB995A482C1B@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:45736 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab3J2Iov (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Oct 2013 04:44:51 -0400
Content-Disposition: inline
In-Reply-To: <B6798662-4DEC-499A-A96E-EB995A482C1B@codeaurora.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <tj@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Tue, Oct 29, 2013 at 03:24:16AM -0500, Kumar Gala wrote:
> 
> On Oct 28, 2013, at 11:59 PM, Simon Horman wrote:
> 
> > On Wed, Oct 16, 2013 at 04:06:01PM +0400, Valentine Barshak wrote:
> >> R-Car Gen2 SoCs have a different PHY which is not compatible
> >> with the older R-Car H1 (R8A7779) version.
> >> This adds OF/platform device id tables and PHY initialization
> >> callbacks for the following Gen2 SoCs:
> >>  * R-Car H2: R8A7790;
> >>  * R-Car M2: R8A7791.
> >> 
> >> PHY initialization method is chosen based on the device id.
> >> Default PHY settings are applied for Gen2 SoCs, which should
> >> suit the Gen2 boards available.
> >> 
> >> The R8A7779 platform code is modified to use "sata-r8a7779"
> >> device name.
> >> 
> >> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >> ---
> >> .../devicetree/bindings/ata/sata_rcar.txt          |   5 +-
> >> arch/arm/mach-shmobile/clock-r8a7779.c             |   2 +-
> >> arch/arm/mach-shmobile/setup-r8a7779.c             |   2 +-
> >> drivers/ata/sata_rcar.c                            | 118 ++++++++++++++++++---
> > 
> > Hi Mark, Hi Device-Tree Folks,
> > 
> > I'm wondering if you have had a chance to look over the bindings
> > aspect of this and the other patch in the series. I believe that
> > this series addresses all previous review in that regards.
> 
> What tree is this binding in?

sata_car.txt is added by the previous patch in this series
"[PATCH 1/2] sata_rcar: Adjust and document device tree bindings"

> > Hi Valentine,
> > 
> > I would like to request that the arch/arm/mach-shmobile/ portion
> > of this patch be split out into a separate patch. The reason is
> > that in general it is nicer to apply driver changes separately
> > to platform changes: for starters they have different maintainers.
> > And in this case there seems to be no reason not to split the change.
> > 
> > Also, I would like to this chance to pass on part of a discussion
> > at the ARM Linux Kernel summit which is that when posting a series of
> > patches please only CC devicetree@vger.kernel.org on the patches in
> > the series that relate to device tree. This would not include
> > to the new patch with only the arch/arm/mach-shmobile/ portions
> > of this patch. Feel free to post that patch as a separate series
> > noting its dependencies below '---' accordingly.
> > 
> >> 4 files changed, 107 insertions(+), 20 deletions(-)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> >> index 0719115..d6b20a6 100644
> >> --- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
> >> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> >> @@ -1,7 +1,10 @@
> >> * Renesas R-Car SATA
> >> 
> >> Required properties:
> >> -- compatible		: should contain "renesas,sata-r8a7779";
> >> +- compatible		: should contain one of the following:
> >> +			  - "renesas,sata-r8a7779" for R-Car H1
> >> +			  - "renesas,sata-r8a7790" for R-Car H2
> >> +			  - "renesas,sata-r8a7791" for R-Car M2
> >> - reg			: offset and length of the SATA registers;
> >> - interrupts		: must consist of one interrupt specifier.
> 
> We normally have an example (not sure if there is one, and just not seeing it because of diff or not).

An example is present.

I have included the text of sata_rcar.txt below to aid review:

---- begin sata_rcar.txt ----
* Renesas R-Car SATA

Required properties:
- compatible           : should contain "renesas,sata-r8a7779";
- reg                  : offset and length of the SATA registers;
- interrupts           : must consist of one interrupt specifier.

Example:

sata: sata@fc600000 {
	compatible = "renesas,sata-r8a7779";
	reg = <0xfc600000 0x2000>;
	interrupt-parent = <&gic>;
	interrupts = <0 100 0x4>;
};
