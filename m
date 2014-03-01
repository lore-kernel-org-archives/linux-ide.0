From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v7 08/15] ahci-imx: Port to library-ised ahci_platform
Date: Sat, 1 Mar 2014 11:24:24 +0000
Message-ID: <20140301112424.GB21483@n2100.arm.linux.org.uk>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com> <1393084424-31099-9-git-send-email-hdegoede@redhat.com> <20140228210820.GZ21483@n2100.arm.linux.org.uk> <5311B8A8.1000501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:33904 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752512AbaCALYh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2014 06:24:37 -0500
Content-Disposition: inline
In-Reply-To: <5311B8A8.1000501@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, devicetree <devicetree@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-ide@vger.kernel.org, Oliver Schinagl <oliver@schinagl.nl>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-sunxi@googlegroups.com, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

I've moved the devicetree mailing list to the To: header in case anyone
there wants to comment on this.

On Sat, Mar 01, 2014 at 11:38:32AM +0100, Hans de Goede wrote:
> I'm sure Tejun would welcome patches to add a dts property for
> setting the board-specific phy parameters, but I won't be
> writing it.

Don't worry, I already have something :)

>> I'm in two minds about this - whether to make the existing binding
>> with its compatible string always use these settings, and invent a
>> new compatible string for one which is fully configurable (as it
>> _should_ have been from the very start) or whether to make this
>> the default if the various properties aren't specified.
>
> IMHO this does not warrant doing a new compatibole-string. Simply
> default to the current hardcoded phy settings if no settings are
> specified through devicetree.

The problem is that we need to keep existing setups working - which
means when there's no properties specified, we need to default to the
settings hard-coded into the driver.

That means introducing properties like:

	fsl,no-spread-spectrum

so that the hard-coded defaults can be turned off, and also deal with
a whole load of defaults for the other properties.  That's not
particularly nice.  Doing it this way, what I currently have is this:

struct reg_value {
        u32 of_value;
        u32 reg_value;
};

struct reg_property {
        const char *name;
        const struct reg_value *values;
        size_t num_values;
        u32 def_value;
        u32 set_value;
};

static const struct reg_value gpr13_tx_level[] = {
        {  937, IMX6Q_GPR13_SATA_TX_LVL_0_937_V },
        {  947, IMX6Q_GPR13_SATA_TX_LVL_0_947_V },
...
        { 1230, IMX6Q_GPR13_SATA_TX_LVL_1_230_V },
        { 1240, IMX6Q_GPR13_SATA_TX_LVL_1_240_V }
};

static const struct reg_value gpr13_tx_boost[] = {
        {    0, IMX6Q_GPR13_SATA_TX_BOOST_0_00_DB },
        {  370, IMX6Q_GPR13_SATA_TX_BOOST_0_37_DB },
...
        {  528, IMX6Q_GPR13_SATA_TX_BOOST_5_28_DB },
        {  575, IMX6Q_GPR13_SATA_TX_BOOST_5_75_DB }
};

static const struct reg_value gpr13_tx_atten[] = {
        {  8, IMX6Q_GPR13_SATA_TX_ATTEN_8_16 },
        {  9, IMX6Q_GPR13_SATA_TX_ATTEN_9_16 },
...
        { 14, IMX6Q_GPR13_SATA_TX_ATTEN_14_16 },
        { 16, IMX6Q_GPR13_SATA_TX_ATTEN_16_16 },
};

static const struct reg_value gpr13_rx_eq[] = {
        {  500, IMX6Q_GPR13_SATA_RX_EQ_VAL_0_5_DB },
        { 1000, IMX6Q_GPR13_SATA_RX_EQ_VAL_1_0_DB },
...
        { 3500, IMX6Q_GPR13_SATA_RX_EQ_VAL_3_5_DB },
        { 4000, IMX6Q_GPR13_SATA_RX_EQ_VAL_4_0_DB },
};

static const struct reg_property gpr13_props[] = {
        {
                .name = "fsl,transmit-level-mV",
                .values = gpr13_tx_level,
                .num_values = ARRAY_SIZE(gpr13_tx_level),
                .def_value = IMX6Q_GPR13_SATA_TX_LVL_1_025_V,
        }, {
                .name = "fsl,transmit-boost-mdB",
                .values = gpr13_tx_boost,
                .num_values = ARRAY_SIZE(gpr13_tx_boost),
                .def_value = IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB,
        }, {
                .name = "fsl,transmit-atten-16ths",
                .values = gpr13_tx_atten,
                .num_values = ARRAY_SIZE(gpr13_tx_atten),
                .def_value = IMX6Q_GPR13_SATA_TX_ATTEN_9_16,
        }, {
                .name = "fsl,receive-eq-mdB",
                .values = gpr13_rx_eq,
                .num_values = ARRAY_SIZE(gpr13_rx_eq),
                .def_value = IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB,
        }, {
                .name = "fsl,no-spread-spectrum",
                .def_value = IMX6Q_GPR13_SATA_MPLL_SS_EN,
                .set_value = 0,
        },
};

and then a bunch of code to read through these tables and work out the
GPR13 register value from it - it doesn't handle everything yet because
I've not worked out a good way to do the last remaining three - I'm
thinking that they want to be strings:

                regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
                                   IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK |
...
                                   IMX6Q_GPR13_SATA_TX_EDGE_RATE,
                                   IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M |
                                   IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F |
                                   IMX6Q_GPR13_SATA_SPD_MODE_3P0G |
                                   reg_value);

	RX_LOS_LVL: SATA1I / SATA1M / SATA1X / SATA2I / SATA2M / SATA2X
	RX_DPLL_MODE: 1P_1F / 2P_2F / 1P_4F / 2P_4F
	SPD_MODE: 3P0G / 1P5G (I do wonder whether this should be changed
		when the Linux wants to slow the link speed.)

With a new compatible string, we can use the hard-coded version for
fsl,imx6q-ahci, but require all properties (with values) to be specified
for a different compatible string, thereby eliminating all the defaults,
and making things like "no-spread-spectrum" be a positive property instead
of negative, and this simplifies the parsing code.

There's also the obvious question about which of these properties should
be generic ones for AHCI/SATA interfaces...  The only one I see with any
kind of electrical properties specified is sata_highbank:

- calxeda,tx-atten  : a u32 array that contains TX attenuation override
                        codes, one per port. The upper 3 bytes are always
                        0 and thus ignored.

and that seems to be a register-coded value rather than an actual
attenuation figure.

A simpler solution to this would be to just provide an imx6-specific
property which encodes the GPR13 value directly, and not bother with
trying to provide individual properties.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
