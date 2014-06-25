From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 0/8] iMX6 SATA configuration
Date: Wed, 25 Jun 2014 23:29:14 +0800
Message-ID: <20140625152912.GI2224@dragon>
References: <20140624101901.GL32514@n2100.arm.linux.org.uk>
 <20140624220958.GI14909@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140624220958.GI14909@htj.dyndns.org>
Sender: linux-doc-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-ide@vger.kernel.org

On Tue, Jun 24, 2014 at 06:09:58PM -0400, Tejun Heo wrote:
> On Tue, Jun 24, 2014 at 11:19:01AM +0100, Russell King - ARM Linux wrote:
> > Another round of these patches.  I've integrated Shawn's patch to split
> > the documentation into this series so I can add the DT documentation
> > on top of it.
> > 
> >  .../devicetree/bindings/ata/ahci-platform.txt      |   6 -
> >  Documentation/devicetree/bindings/ata/imx-sata.txt |  36 ++++
> >  arch/arm/boot/dts/imx6q-cubox-i.dts                |   4 +
> >  drivers/ata/ahci_imx.c                             | 184 ++++++++++++++++++++-
> >  4 files changed, 216 insertions(+), 14 deletions(-)
> 
> Patches look good to me.  Shawn, can you please review the ahci_imx
> portion?

Reviewed-by: Shawn Guo <shawn.guo@freescale.com>

I also tested the series on imx6q-sabresd board and nothing breaks
regarding SATA support on the board.

> How should the patches be routed?  Should I pick only the
> ata parts or apply the whole thing?

I will apply the last two dts patches via IMX tree, and please apply
the first 6 patches through your tree.

Shawn
