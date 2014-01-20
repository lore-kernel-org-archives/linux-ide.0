From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] libata, dt: Add clocks to sata_rcar bindings
Date: Mon, 20 Jan 2014 16:29:33 +0100
Message-ID: <5453735.fEby5SBpD0@avalon>
References: <1389910062-17777-1-git-send-email-valentine.barshak@cogentembedded.com> <2218997.BjldcaRU33@avalon> <20140120093119.GA28747@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140120093119.GA28747@e106331-lin.cambridge.arm.com>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-ide@vger.kernel.org

Hi Mark,

On Monday 20 January 2014 09:31:19 Mark Rutland wrote:
> On Sun, Jan 19, 2014 at 08:16:42PM +0000, Laurent Pinchart wrote:
> > On Friday 17 January 2014 02:07:42 Valentine Barshak wrote:
> > > Now that the clocks are available in the R-Car Gen2 DT,
> > > add clocks property description to the sata_rcar bindings.
> > > The clocks have been tested on r8a7791 so we use that
> > > as an example of the R-Car SATA node.
> > > 
> > > The patch is against for-next branch of the libata git repo.
> > > 
> > > Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> > > ---
> > > 
> > >  Documentation/devicetree/bindings/ata/sata_rcar.txt | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt
> > > b/Documentation/devicetree/bindings/ata/sata_rcar.txt index
> > > 1e61113..6da60c0 100644
> > > --- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
> > > +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> > > 
> > > @@ -7,12 +7,14 @@ Required properties:
> > >  			  - "renesas,sata-r8a7791" for R-Car M2
> > >  - reg			: address and length of the SATA registers;
> > >  - interrupts		: must consist of one interrupt specifier.
> > > +- clocks		: must contain a phandle and clock-specifier pair.
> > 
> > I would say "must contain a reference to the functional clock.", as the
> > clock could be referenced by a phandle only depending on the SATA IP core
> > integration in the SoC.
> 
> In that case the clock-specifier is simply zero cells (though admittedly
> a pair including a zero-cells element is a bit odd).
> 
> The wording in the patch is consistent with the form I've been
> recommending elsewhere:
> 
> - clocks: A list of phandles + clock-specifier pairs, one for each
>   entry in clock-names.
> - clock-names: Should contain:
>   * "fclk" - the functional clock
>   * "other_clk" - some other clock.
> 
> > Wouldn't it be time to have standard wordings for clocks (and interrupt)
> > bindings ?
> 
> I would certainly like to see consistent wording across bindings
> (especially for interrupts given the addition of the interrupts-extended
> binding).

What about creating a new file in Documentation/devicetree/bindings/ with 
reference wordings for common properties ?

-- 
Regards,

Laurent Pinchart

