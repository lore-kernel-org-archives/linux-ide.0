From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/2] sata_rcar: Add R-Car Gen2 SATA support
Date: Tue, 15 Oct 2013 02:32:28 +0200
Message-ID: <1902318.RuT4p9kbZ7@avalon>
References: <1381765354-28440-1-git-send-email-valentine.barshak@cogentembedded.com> <525C608F.5010303@cogentembedded.com> <20131015002319.GG22321@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20131015002319.GG22321@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Valentine <valentine.barshak@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi Simon,

On Tuesday 15 October 2013 09:23:19 Simon Horman wrote:
> On Tue, Oct 15, 2013 at 01:22:23AM +0400, Valentine wrote:
> > On 10/14/2013 10:15 PM, Laurent Pinchart wrote:
> > >On Monday 14 October 2013 21:58:50 Valentine wrote:
> > >>On 10/14/2013 08:26 PM, Mark Rutland wrote:
> > >>>On Mon, Oct 14, 2013 at 04:42:34PM +0100, Valentine Barshak wrote:
> > >>>>R-Car Gen2 SoCs have a different PHY which is not compatible
> > >>>>with the older R-Car H1 (R8A7779) version.
> > >>>>This adds OF/platform device id tables and PHY initialization
> > >>>>
> > >>>>callbacks for the following Gen2 SoCs:
> > >>>>    * R-Car H2: R8A7790;
> > >>>>    * R-Car M2: R8A7791.
> > >>>>
> > >>>>PHY initialization method is chosen, based on the device id.
> > >>>>Default PHY settings are applied for Gen2 SoCs, which should
> > >>>>suit the Gen2 boards available.
> > >>>>
> > >>>>The R8A7779 platform code is modified to use "sata-r8a7779"
> > >>>>device id.
> > >>>>
> > >>>>Signed-off-by: Valentine Barshak
> > >>>><valentine.barshak@cogentembedded.com>
> > >>>>---
> > >>>>
> > >>>>   .../devicetree/bindings/ata/sata_rcar.txt          |   5 +-
> > >>>>   arch/arm/mach-shmobile/clock-r8a7779.c             |   2 +-
> > >>>>   arch/arm/mach-shmobile/setup-r8a7779.c             |   2 +-
> > >>>>   drivers/ata/sata_rcar.c                            | 112
> > >>>>   +++++++++++---
> > >>>>   4 files changed, 102 insertions(+), 19 deletions(-)
> > >>>>
> > >>>>diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt
> > >>>>b/Documentation/devicetree/bindings/ata/sata_rcar.txt index
> > >>>>2465183..b5a41bf 100644
> > >>>>--- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
> > >>>>+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt

[snip]

> > >>>>+static struct of_device_id sata_rcar_match[] = {
> > >>>>+	{
> > >>>>+		.compatible = "renesas,sata-r8a7779",
> > >>>>+		.data = (void *)RCAR_GEN1_SATA,
> > >>>>+	},
> > >>>>+	{
> > >>>>+		.compatible = "renesas,sata-r8a7790",
> > >>>>+		.data = (void *)RCAR_GEN2_SATA
> > >>>>+	},
> > >>>>+	{
> > >>>>+		.compatible = "renesas,sata-r8a7791",
> > >>>>+		.data = (void *)RCAR_GEN2_SATA
> > >>>>+	},
> > >>>>+	{},
> > >>>>+};
> > >>>>+MODULE_DEVICE_TABLE(of, sata_rcar_match);
> > >>>
> > >>>Are the renesas,sata-r8a779x variants identical?
> > >>
> > >>Yes.
> > >>
> > >>>If so, why the two strings?
> > >>
> > >>Just thought the driver should support "renesas,sata-r8a7791"
> > >>compatibility as well since it should support both SoCs.
> > >>Didn't want to force sata-r8a7790 compatibility for the r8a7791 SoC DTS.
> > >
> > >One reason for two compatibility strings is not to be stuck if we later
> > >find out the the 7791 SATA controller differs from the 7790.
> > 
> > Thanks!
> > Yeah, anyways, I'd prefer to keep both strings in the device id table.
> 
> Yes, I do too, mostly for the reason that Laurent gave.
> But also because this is consistent with compatibility strings
> for other Renesas IP.

We need to use the 7791 compatibility string in DT, but if we specify both, 
the driver could have a single entry for both SoCs in its device ID table. As 
stated before, I have no strong preference, both would work.

-- 
Regards,

Laurent Pinchart

