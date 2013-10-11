From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ata: sata_rcar: Add RCAR Gen2 SATA PHY support
Date: Fri, 11 Oct 2013 10:41:57 +0100
Message-ID: <20131011094156.GF3910@e106331-lin.cambridge.arm.com>
References: <1381432083-3684-1-git-send-email-valentine.barshak@cogentembedded.com>
 <20131011010032.GA13809@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131011010032.GA13809@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Fri, Oct 11, 2013 at 02:00:35AM +0100, Simon Horman wrote:
> [ CCed devicetree@vger.kernel.org as this involves DT compatibility strings ]

Cheers!

> 
> On Thu, Oct 10, 2013 at 11:08:03PM +0400, Valentine Barshak wrote:
> > RCAR Gen2 SoC has a different phy which is not compatible with
> > the older H1/M1 versions. This adds OF/platform device table
> > and PHY initialization callbacks for H2/M2 (Gen2) SoC.

Is the PHY combined with the rest of the controller, or are they
logically separate components in the SoC? I note that the Calxeda
Highbank SATA controller driver treats the phy and the controller as
separate entities, and describes the way the two are attached (though
the driver handles both). Would a similar approach work here?

[...]

> > +static struct of_device_id sata_rcar_match[] = {
> > +	{
> > +		.compatible = "renesas,rcar-sata",
> > +		.data = (void *)RCAR_SATA
> > +	},
> > +	{
> > +		.compatible = "renesas,sata-r8a7790",
> > +		.data = (void *)RCAR_GEN2_SATA
> > +	},
> > +	{
> > +		.compatible = "renesas,sata-r8a7791",
> > +		.data = (void *)RCAR_GEN2_SATA
> > +	},
> > +	{},

These bindings will need documentation. A grep of any of these in
mainline's Documentation/devicetree shows up nothing (not even the
existing "renesas,rcar-sata" string used by the driver.

Thanks,
Mark.
