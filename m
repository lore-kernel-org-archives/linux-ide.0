From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH V4] sata_rcar: Add R-Car Gen2 SATA PHY support
Date: Fri, 1 Nov 2013 09:13:40 +0900
Message-ID: <20131101001340.GB6818@verge.net.au>
References: <1383153261-17383-1-git-send-email-valentine.barshak@cogentembedded.com>
 <20131031060141.GT1603@verge.net.au>
 <5272326B.3050500@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5272326B.3050500@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Valentine <valentine.barshak@cogentembedded.com>
Cc: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-ide@vger.kernel.org

On Thu, Oct 31, 2013 at 02:35:23PM +0400, Valentine wrote:
> On 10/31/2013 10:01 AM, Simon Horman wrote:
> >On Wed, Oct 30, 2013 at 09:14:21PM +0400, Valentine Barshak wrote:
> >>R-Car Gen2 SoCs have a different PHY which is not compatible
> >>with the older R-Car H1 (R8A7779) version.
> >>This adds OF/platform device id tables and PHY initialization
> >>callbacks for the following Gen2 SoCs:
> >>   * R-Car H2: R8A7790;
> >>   * R-Car M2: R8A7791.
> >>
> >>PHY initialization method is chosen based on the device id.
> >>Default PHY settings are applied for Gen2 SoCs, which should
> >>suit the Gen2 boards available.
> >>
> >>While at it, this also adds "sata-r8a7779" compatibility string
> >>for R-Car H1 SATA, while keeping the old one for compatibility.
> >>
> >>Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >
> >I know we are going around and around in circles regarding the bindings.
> >But I think you need to submit that patch which documents the bindings
> >that exist after this patch in order for the bindings, as they are
> >used here, to be reviewed by the device tree people.
> 
> OK, I'll resend.
> 
> >
> >Also, I think I found a typo which I have noted below.
> 
> There's no typo. I'm using "sata_rcar" device name for compatibility with the current r8a7779 code
> that uses the driver and registers "sata_rcar" device.

Thanks, sorry for the noise.
