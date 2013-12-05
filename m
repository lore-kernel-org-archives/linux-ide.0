From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/5] Phy: DT binding documentation for Marvell MVEBU SATA
 phy.
Date: Thu, 5 Dec 2013 10:43:19 +0100
Message-ID: <20131205094319.GD10498@lunn.ch>
References: <1386177364-10164-1-git-send-email-andrew@lunn.ch>
 <1386177364-10164-2-git-send-email-andrew@lunn.ch>
 <52A01742.2080405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:57164 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753550Ab3LEJn3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Dec 2013 04:43:29 -0500
Content-Disposition: inline
In-Reply-To: <52A01742.2080405@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

On Thu, Dec 05, 2013 at 11:33:46AM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Wednesday 04 December 2013 10:46 PM, Andrew Lunn wrote:
> > Describe the binding for the Marvell MVEBU SATA phy. This driver
> > can be used at least with Kirkwood, Dove and maybe others.
> > Additionally, update the SATA binding with the properties to link
> > to the phy nodes.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  Documentation/devicetree/bindings/ata/marvell.txt  |  6 ++++++
> >  .../devicetree/bindings/phy/phy-mvebu-sata.txt     | 22 ++++++++++++++++++++++
> >  2 files changed, 28 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-sata.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/marvell.txt b/Documentation/devicetree/bindings/ata/marvell.txt
> > index b5cdd20cde9c..e072fa105b49 100644
> > --- a/Documentation/devicetree/bindings/ata/marvell.txt
> > +++ b/Documentation/devicetree/bindings/ata/marvell.txt
> > @@ -6,11 +6,17 @@ Required Properties:
> >  - interrupts    : Interrupt controller is using
> >  - nr-ports      : Number of SATA ports in use.
> >  
> > +Optional Properties:
> > +- phys		: List of phandles to sata phys
> > +- phy-names	: Should be "0", "1", etc, one number per phandle
> 
> over aligned..

Could you explain please? Here is what it looks like without the patch
formatting, which could be messing up the display of tabs, due to the
+ at the beginning:

Required Properties:
- compatibility : "marvell,orion-sata"
- reg		: Address range of controller
- interrupts	: Interrupt controller is using
- nr-ports	: Number of SATA ports in use.

Optional Properties:
- phys		: List of phandles to sata phys
- phy-names	: Should be "0", "1", etc, one number per phandle



> > +
> >  Example:
> >  
> >  	sata@80000 {
> >  		compatible = "marvell,orion-sata";
> >  		reg = <0x80000 0x5000>;
> >  		interrupts = <21>;
> > +		phys = <&sata_phy0>, <&sata_phy1>;
> > +		phy-names = "0", "1";
> 
> more descriptive phy-names? sata-phy0?
> >  		nr-ports = <2>;

I could do, but i was following how the clocks work. Unfortunately,
the binding documentation is out of date and does not contain
clocks. A real example is:

		sata@80000 {
			compatible = "marvell,orion-sata";
			reg = <0x80000 0x5000>;
			interrupts = <21>;
			clocks = <&gate_clk 14>, <&gate_clk 15>;
			clock-names = "0", "1";
			phys = <&sata_phy0>, <&sata_phy1>;
			phy-names = "0", "1";
			status = "disabled";
		};

So clocks and the phy are described nearly identically. I can however
handle phys differently if you wish.

I will also submit a separate patch to the binding documentation to
add the clocks.


> >  	}
> > diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu-sata.txt b/Documentation/devicetree/bindings/phy/phy-mvebu-sata.txt
> > new file mode 100644
> > index 000000000000..1cf9cef50b4b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/phy-mvebu-sata.txt
> 
> Just name this mvebu-phy.txt so that we can add bindings of other mvebu PHYs
> here when it's added.

O.K. I also have a pcie phy driver, but it does not work
yet. devm_phy_get() is too restrictive for a complex device like a
PCIe controller.

> > +		sata-phy@1 {
> 
> The value after '@' must match the first address specified in the reg property
> of the node according to the ePAPR spec.

O.K, will fix.

> > +			compatible = "marvell,mvebu-sata-phy";
> > +			reg = <0x84000 0x0334>;
> > +			clocks = <&gate_clk 15>;
> > +			clock-names = "sata";
> > +			#phy-cells = <1>;
> 
> Is it on purpose that your are having phy-cells value to 1?

Yes. Each instance only controls one phy.

     Thanks
	Andrew
