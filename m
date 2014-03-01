From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 08/15] ahci-imx: Port to library-ised ahci_platform
Date: Sat, 01 Mar 2014 11:38:32 +0100
Message-ID: <5311B8A8.1000501@redhat.com>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com> <1393084424-31099-9-git-send-email-hdegoede@redhat.com> <20140228210820.GZ21483@n2100.arm.linux.org.uk>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBNXRY2MAKGQEKVAE6LY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140228210820.GZ21483-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi Russell,

On 02/28/2014 10:08 PM, Russell King - ARM Linux wrote:
> On Sat, Feb 22, 2014 at 04:53:37PM +0100, Hans de Goede wrote:
>> +		/*
>> +		 * set PHY Paremeters, two steps to configure the GPR13,
>> +		 * one write for rest of parameters, mask of first write
>> +		 * is 0x07ffffff, and the other one write for setting
>> +		 * the mpll_clk_en.
>> +		 */
>> +		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
>> +				   IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK |
>> +				   IMX6Q_GPR13_SATA_RX_LOS_LVL_MASK |
>> +				   IMX6Q_GPR13_SATA_RX_DPLL_MODE_MASK |
>> +				   IMX6Q_GPR13_SATA_SPD_MODE_MASK |
>> +				   IMX6Q_GPR13_SATA_MPLL_SS_EN |
>> +				   IMX6Q_GPR13_SATA_TX_ATTEN_MASK |
>> +				   IMX6Q_GPR13_SATA_TX_BOOST_MASK |
>> +				   IMX6Q_GPR13_SATA_TX_LVL_MASK |
>> +				   IMX6Q_GPR13_SATA_MPLL_CLK_EN |
>> +				   IMX6Q_GPR13_SATA_TX_EDGE_RATE,
>> +				   IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB |
>> +				   IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M |
>> +				   IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F |
>> +				   IMX6Q_GPR13_SATA_SPD_MODE_3P0G |
>> +				   IMX6Q_GPR13_SATA_MPLL_SS_EN |
>> +				   IMX6Q_GPR13_SATA_TX_ATTEN_9_16 |
>> +				   IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB |
>> +				   IMX6Q_GPR13_SATA_TX_LVL_1_025_V);
>
> While I see this, I'll stick an oar in.
>
> It is totally wrong for this to be hard-coded into the driver - many
> of these should be specified via DT, since they're board specific.
> These are already different from the reset default in this register.
>
> The side effect of this hard coding is that eSATA just doesn't work
> at all on some boards - the board I have requires TX_LVL_1_104V and
> TX_BOOST_0_00_DB.

I completely agree that if this is board specific it should be
settable (override-able since we've existing dt files without a setting
for it).

> Hence, I'd ask that while you move stuff like this around, you bear
> in mind that we do need to add additional properties.

I understand, but my interest in the imx code only goes as far as
not making it regress. I already went above and beyond duty by
buying an imx board with sata and cleaning up the horific platform
device driver instantiating a platform device hack there was.

My interest in platform-ahci was to clean it up so that it could be
used as a proper basis to build other ARM ahci drivers on top of,
such as a driver for the allwinner A10 and A20 ahci controller.

While at this I ended up having to clean up the imx driver too, so
as to not break at. As a bonus I fixed it to not loose the harddisk
after a suspend / resume cycle, and that is really as far as my
interest in the imx driver goes.

I'm sure Tejun would welcome patches to add a dts property for
setting the board-specific phy parameters, but I won't be
writing it.

> I'm in two minds about this - whether to make the existing binding
> with its compatible string always use these settings, and invent a
> new compatible string for one which is fully configurable (as it
> _should_ have been from the very start) or whether to make this
> the default if the various properties aren't specified.

IMHO this does not warrant doing a new compatibole-string. Simply
default to the current hardcoded phy settings if no settings are
specified through devicetree.

> Either way, this driver is electrically unusable as it stands here.

That is only true on some boards.

Regards,

Hans
