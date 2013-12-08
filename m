From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v2 0/4] PHY driver for Marvell SATA
Date: Sat, 7 Dec 2013 20:09:58 -0500
Message-ID: <20131208010958.GH11251@titan.lakedaemon.net>
References: <1386262263-18956-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1386262263-18956-1-git-send-email-andrew@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: devicetree@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, kishon@ti.com, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

Andrew,

wrt merging...

On Thu, Dec 05, 2013 at 05:50:59PM +0100, Andrew Lunn wrote:
> This second version addresses most of the points raised during review.
> 
> What has not been changed is the phy-names property. This is awaiting
> feedback on my comment that the naming follows how clocks are named in
> the driver & DT binding. For this reason i've also not added the
> Ack-by: received in the review comments.
> 
> Andrew Lunn (4):
>   Phy: DT binding documentation for Marvell MVEBU SATA phy.
>   Phy: Add a PHY driver for Marvell MVEBU SATA PHY.
>   SATA: MV: Add support for the optional PHYs
>   Phy: Add DT nodes on kirkwood and Dove for the SATA PHY
> 

This is actually really easy.

>  Documentation/devicetree/bindings/ata/marvell.txt  |   6 +
>  .../devicetree/bindings/phy/phy-mvebu.txt          |  22 ++++

Keep this with the phy driver patch.

>  arch/arm/boot/dts/dove.dtsi                        |  11 ++
>  arch/arm/boot/dts/kirkwood-6281.dtsi               |   2 +
>  arch/arm/boot/dts/kirkwood-6282.dtsi               |   2 +
>  arch/arm/boot/dts/kirkwood.dtsi                    |  18 +++

I'll take this.

>  drivers/ata/sata_mv.c                              |  19 +++

This uses the phy if it's available, so this can go through ata.  No
dependency problems there.

>  drivers/phy/Kconfig                                |   6 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-mvebu-sata.c                       | 137 +++++++++++++++++++++

And this can go through Kishon with the binding docs.

thx,

Jason.
