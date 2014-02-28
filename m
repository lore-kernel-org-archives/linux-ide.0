From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v7 08/15] ahci-imx: Port to library-ised ahci_platform
Date: Fri, 28 Feb 2014 21:08:20 +0000
Message-ID: <20140228210820.GZ21483@n2100.arm.linux.org.uk>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com> <1393084424-31099-9-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60053 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751712AbaB1VIi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Feb 2014 16:08:38 -0500
Content-Disposition: inline
In-Reply-To: <1393084424-31099-9-git-send-email-hdegoede@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, devicetree <devicetree@vger.kernel.org>, linux-ide@vger.kernel.org, Oliver Schinagl <oliver@schinagl.nl>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-sunxi@googlegroups.com, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

On Sat, Feb 22, 2014 at 04:53:37PM +0100, Hans de Goede wrote:
> +		/*
> +		 * set PHY Paremeters, two steps to configure the GPR13,
> +		 * one write for rest of parameters, mask of first write
> +		 * is 0x07ffffff, and the other one write for setting
> +		 * the mpll_clk_en.
> +		 */
> +		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +				   IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK |
> +				   IMX6Q_GPR13_SATA_RX_LOS_LVL_MASK |
> +				   IMX6Q_GPR13_SATA_RX_DPLL_MODE_MASK |
> +				   IMX6Q_GPR13_SATA_SPD_MODE_MASK |
> +				   IMX6Q_GPR13_SATA_MPLL_SS_EN |
> +				   IMX6Q_GPR13_SATA_TX_ATTEN_MASK |
> +				   IMX6Q_GPR13_SATA_TX_BOOST_MASK |
> +				   IMX6Q_GPR13_SATA_TX_LVL_MASK |
> +				   IMX6Q_GPR13_SATA_MPLL_CLK_EN |
> +				   IMX6Q_GPR13_SATA_TX_EDGE_RATE,
> +				   IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB |
> +				   IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M |
> +				   IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F |
> +				   IMX6Q_GPR13_SATA_SPD_MODE_3P0G |
> +				   IMX6Q_GPR13_SATA_MPLL_SS_EN |
> +				   IMX6Q_GPR13_SATA_TX_ATTEN_9_16 |
> +				   IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB |
> +				   IMX6Q_GPR13_SATA_TX_LVL_1_025_V);

While I see this, I'll stick an oar in.

It is totally wrong for this to be hard-coded into the driver - many
of these should be specified via DT, since they're board specific.
These are already different from the reset default in this register.

The side effect of this hard coding is that eSATA just doesn't work
at all on some boards - the board I have requires TX_LVL_1_104V and
TX_BOOST_0_00_DB.

Hence, I'd ask that while you move stuff like this around, you bear
in mind that we do need to add additional properties.

I'm in two minds about this - whether to make the existing binding
with its compatible string always use these settings, and invent a
new compatible string for one which is fully configurable (as it
_should_ have been from the very start) or whether to make this
the default if the various properties aren't specified.

Either way, this driver is electrically unusable as it stands here.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
