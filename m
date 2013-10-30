From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] sata_rcar: Add R-Car Gen2 SATA PHY support
Date: Wed, 30 Oct 2013 09:28:47 +0900
Message-ID: <20131030002847.GL21262@verge.net.au>
References: <1381925161-16729-1-git-send-email-valentine.barshak@cogentembedded.com>
 <1381925161-16729-3-git-send-email-valentine.barshak@cogentembedded.com>
 <20131029045943.GE20432@verge.net.au>
 <B6798662-4DEC-499A-A96E-EB995A482C1B@codeaurora.org>
 <20131029084444.GC15731@verge.net.au>
 <82E941A8-D062-4E90-B661-511881F51F9B@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:38704 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab3J3A2w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Oct 2013 20:28:52 -0400
Content-Disposition: inline
In-Reply-To: <82E941A8-D062-4E90-B661-511881F51F9B@codeaurora.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <tj@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Tue, Oct 29, 2013 at 12:19:08PM -0500, Kumar Gala wrote:
> 
> On Oct 29, 2013, at 3:44 AM, Simon Horman wrote:
> 
> > On Tue, Oct 29, 2013 at 03:24:16AM -0500, Kumar Gala wrote:
> >> 
> >> On Oct 28, 2013, at 11:59 PM, Simon Horman wrote:
> >> 
> >>> On Wed, Oct 16, 2013 at 04:06:01PM +0400, Valentine Barshak wrote:
> >>>> R-Car Gen2 SoCs have a different PHY which is not compatible
> >>>> with the older R-Car H1 (R8A7779) version.
> >>>> This adds OF/platform device id tables and PHY initialization
> >>>> callbacks for the following Gen2 SoCs:
> >>>> * R-Car H2: R8A7790;
> >>>> * R-Car M2: R8A7791.
> >>>> 
> >>>> PHY initialization method is chosen based on the device id.
> >>>> Default PHY settings are applied for Gen2 SoCs, which should
> >>>> suit the Gen2 boards available.
> >>>> 
> >>>> The R8A7779 platform code is modified to use "sata-r8a7779"
> >>>> device name.
> >>>> 
> >>>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >>>> ---
> >>>> .../devicetree/bindings/ata/sata_rcar.txt          |   5 +-
> >>>> arch/arm/mach-shmobile/clock-r8a7779.c             |   2 +-
> >>>> arch/arm/mach-shmobile/setup-r8a7779.c             |   2 +-
> >>>> drivers/ata/sata_rcar.c                            | 118 ++++++++++++++++++---
> >>> 
> >>> Hi Mark, Hi Device-Tree Folks,
> >>> 
> >>> I'm wondering if you have had a chance to look over the bindings
> >>> aspect of this and the other patch in the series. I believe that
> >>> this series addresses all previous review in that regards.
> >> 
> >> What tree is this binding in?
> > 
> > sata_car.txt is added by the previous patch in this series
> > "[PATCH 1/2] sata_rcar: Adjust and document device tree bindings"
> 
> Why not just have all the binding in one patch.  There isn't a reason this should be split.

I think that the motivation was that the first patch documents the
existing implementation while the second documents a change to it.
With that in mind would you still like a single patch for the binding?
