From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH V2 2/2] dt: Document sata_rcar bindings
Date: Fri, 8 Nov 2013 18:01:35 +0900
Message-ID: <20131108090126.GA9467@verge.net.au>
References: <1383854642-21660-1-git-send-email-valentine.barshak@cogentembedded.com>
 <1383854642-21660-3-git-send-email-valentine.barshak@cogentembedded.com>
 <7820946.JfD46VSKC7@avalon>
 <874n7nquh4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874n7nquh4.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-ide@vger.kernel.org

On Thu, Nov 07, 2013 at 10:27:08PM -0800, Kuninori Morimoto wrote:
> 
> Hi Laurent, Simon
> 
> One question
> 
> > > +- interrupts		: must consist of one interrupt specifier.
> > > +
> > > +Example:
> > > +
> > > +sata: sata@fc600000 {
> > > +	compatible = "renesas,sata-r8a7779";
> > > +	reg = <0xfc600000 0x2000>;
> > > +	interrupt-parent = <&gic>;
> > > +	interrupts = <0 100 0x4>;
> > 
> > Please use IRQ_TYPE_LEVEL_HIGH instead of 0x4.
> 
> Now, our many SoC codes are using 0x4 in "interrupts".
> Do you think we should use IRQ_TYPE_LEVEL_HIGH ?

Personally I think that would be nice.
