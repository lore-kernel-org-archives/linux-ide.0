From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/2] sata_rcar: Adjust DT bindings and add R-Car Gen2 PHY
 support (take 2)
Date: Tue, 15 Oct 2013 08:40:11 -0400
Message-ID: <20131015124011.GA3141@htj.dyndns.org>
References: <1381832407-22541-1-git-send-email-valentine.barshak@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381832407-22541-1-git-send-email-valentine.barshak@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-ide@vger.kernel.org

On Tue, Oct 15, 2013 at 02:20:05PM +0400, Valentine Barshak wrote:
> This modifies and documents R-Car SATA device tree (DT) bindings.
> The "sata-<SoC>" format is now used for the "compatible" property.
> Also, a platform device id table is introduced for non-DT support.
> The device id naming is consistent with the "compatible" DT
> property format.
> 
> R-Car Gen2 SATA PHY support is added. PHY initialization method
> is chosen, based on the device id.
> 
> Changes from the previous version:
> * Kept old DT bindings for compatibility
> * Amended DT bindings documentation
> 
> Valentine Barshak (2):
>   sata_rcar: Adjust and document device tree bindings
>   sata_rcar: Add R-Car Gen2 SATA support

Is this about ready yet?  I'll wait for acks before applying these
patches.

Thanks.

-- 
tejun
