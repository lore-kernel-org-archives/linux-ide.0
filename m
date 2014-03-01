From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 08/15] ahci-imx: Port to library-ised ahci_platform
Date: Sat, 01 Mar 2014 13:54:04 +0100
Message-ID: <5311D86C.3010803@redhat.com>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com> <1393084424-31099-9-git-send-email-hdegoede@redhat.com> <20140228210820.GZ21483@n2100.arm.linux.org.uk> <5311B8A8.1000501@redhat.com> <20140301112424.GB21483@n2100.arm.linux.org.uk>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB5NQY6MAKGQEBCMFHPQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140301112424.GB21483-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi,

On 03/01/2014 12:24 PM, Russell King - ARM Linux wrote:
> I've moved the devicetree mailing list to the To: header in case anyone
> there wants to comment on this.
> 
> On Sat, Mar 01, 2014 at 11:38:32AM +0100, Hans de Goede wrote:
>> I'm sure Tejun would welcome patches to add a dts property for
>> setting the board-specific phy parameters, but I won't be
>> writing it.
> 
> Don't worry, I already have something :)

Great.

>>> I'm in two minds about this - whether to make the existing binding
>>> with its compatible string always use these settings, and invent a
>>> new compatible string for one which is fully configurable (as it
>>> _should_ have been from the very start) or whether to make this
>>> the default if the various properties aren't specified.
>>
>> IMHO this does not warrant doing a new compatibole-string. Simply
>> default to the current hardcoded phy settings if no settings are
>> specified through devicetree.
> 
> The problem is that we need to keep existing setups working - which
> means when there's no properties specified, we need to default to the
> settings hard-coded into the driver.
> 
> That means introducing properties like:
> 
> 	fsl,no-spread-spectrum
> 
> so that the hard-coded defaults can be turned off, and also deal with
> a whole load of defaults for the other properties.  That's not
> particularly nice.  Doing it this way, what I currently have is this:
> 
> struct reg_value {
>         u32 of_value;
>         u32 reg_value;
> };
> 
> struct reg_property {
>         const char *name;
>         const struct reg_value *values;
>         size_t num_values;
>         u32 def_value;
>         u32 set_value;
> };
> 
> static const struct reg_value gpr13_tx_level[] = {
>         {  937, IMX6Q_GPR13_SATA_TX_LVL_0_937_V },
>         {  947, IMX6Q_GPR13_SATA_TX_LVL_0_947_V },
> ...
>         { 1230, IMX6Q_GPR13_SATA_TX_LVL_1_230_V },
>         { 1240, IMX6Q_GPR13_SATA_TX_LVL_1_240_V }
> };
> 
> static const struct reg_value gpr13_tx_boost[] = {
>         {    0, IMX6Q_GPR13_SATA_TX_BOOST_0_00_DB },
>         {  370, IMX6Q_GPR13_SATA_TX_BOOST_0_37_DB },
> ...
>         {  528, IMX6Q_GPR13_SATA_TX_BOOST_5_28_DB },
>         {  575, IMX6Q_GPR13_SATA_TX_BOOST_5_75_DB }
> };
> 
> static const struct reg_value gpr13_tx_atten[] = {
>         {  8, IMX6Q_GPR13_SATA_TX_ATTEN_8_16 },
>         {  9, IMX6Q_GPR13_SATA_TX_ATTEN_9_16 },
> ...
>         { 14, IMX6Q_GPR13_SATA_TX_ATTEN_14_16 },
>         { 16, IMX6Q_GPR13_SATA_TX_ATTEN_16_16 },
> };
> 
> static const struct reg_value gpr13_rx_eq[] = {
>         {  500, IMX6Q_GPR13_SATA_RX_EQ_VAL_0_5_DB },
>         { 1000, IMX6Q_GPR13_SATA_RX_EQ_VAL_1_0_DB },
> ...
>         { 3500, IMX6Q_GPR13_SATA_RX_EQ_VAL_3_5_DB },
>         { 4000, IMX6Q_GPR13_SATA_RX_EQ_VAL_4_0_DB },
> };
> 
> static const struct reg_property gpr13_props[] = {
>         {
>                 .name = "fsl,transmit-level-mV",
>                 .values = gpr13_tx_level,
>                 .num_values = ARRAY_SIZE(gpr13_tx_level),
>                 .def_value = IMX6Q_GPR13_SATA_TX_LVL_1_025_V,
>         }, {
>                 .name = "fsl,transmit-boost-mdB",
>                 .values = gpr13_tx_boost,
>                 .num_values = ARRAY_SIZE(gpr13_tx_boost),
>                 .def_value = IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB,
>         }, {
>                 .name = "fsl,transmit-atten-16ths",
>                 .values = gpr13_tx_atten,
>                 .num_values = ARRAY_SIZE(gpr13_tx_atten),
>                 .def_value = IMX6Q_GPR13_SATA_TX_ATTEN_9_16,
>         }, {
>                 .name = "fsl,receive-eq-mdB",
>                 .values = gpr13_rx_eq,
>                 .num_values = ARRAY_SIZE(gpr13_rx_eq),
>                 .def_value = IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB,
>         }, {
>                 .name = "fsl,no-spread-spectrum",
>                 .def_value = IMX6Q_GPR13_SATA_MPLL_SS_EN,
>                 .set_value = 0,
>         },
> };
> 
> and then a bunch of code to read through these tables and work out the
> GPR13 register value from it - it doesn't handle everything yet because
> I've not worked out a good way to do the last remaining three - I'm
> thinking that they want to be strings:
> 
>                 regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
>                                    IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK |
> ...
>                                    IMX6Q_GPR13_SATA_TX_EDGE_RATE,
>                                    IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M |
>                                    IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F |
>                                    IMX6Q_GPR13_SATA_SPD_MODE_3P0G |
>                                    reg_value);
> 
> 	RX_LOS_LVL: SATA1I / SATA1M / SATA1X / SATA2I / SATA2M / SATA2X
> 	RX_DPLL_MODE: 1P_1F / 2P_2F / 1P_4F / 2P_4F
> 	SPD_MODE: 3P0G / 1P5G (I do wonder whether this should be changed
> 		when the Linux wants to slow the link speed.)
> 
> With a new compatible string, we can use the hard-coded version for
> fsl,imx6q-ahci, but require all properties (with values) to be specified
> for a different compatible string, thereby eliminating all the defaults,
> and making things like "no-spread-spectrum" be a positive property instead
> of negative, and this simplifies the parsing code.

I see, that does make sense. So consider my +1 for keeping the same
compatible string changed to a 0

> There's also the obvious question about which of these properties should
> be generic ones for AHCI/SATA interfaces...  The only one I see with any
> kind of electrical properties specified is sata_highbank:
> 
> - calxeda,tx-atten  : a u32 array that contains TX attenuation override
>                         codes, one per port. The upper 3 bytes are always
>                         0 and thus ignored.
> 
> and that seems to be a register-coded value rather than an actual
> attenuation figure.
> 
> A simpler solution to this would be to just provide an imx6-specific
> property which encodes the GPR13 value directly, and not bother with
> trying to provide individual properties.

Yes, that is actually the direction I was thinking in. I think it is
great we know what all the bits do in so much detail in the freescale
case, but for many other phys we don't have such extensive documentation.

Still I can see how in the freescale case you do want to use that
documentation to do something better then coding a register value inside
the devicetree.

OTOH I do like the KISS value of jut specifying a register value.

So in the end it is all up to you I'm afraid.

Regards,

Hans
