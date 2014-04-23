From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH 1/6] ata: ahci: add AHCI support for Berlin SoCs
Date: Wed, 23 Apr 2014 10:21:00 +0200
Message-ID: <20140423082100.GB24355@kwain>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-2-git-send-email-antoine.tenart@free-electrons.com>
 <5356A4F4.6090107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5356A4F4.6090107@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: tj@kernel.org, alexandre.belloni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Sebastian,

On Tue, Apr 22, 2014 at 07:20:52PM +0200, Sebastian Hesselbarth wrote:
> On 04/22/2014 05:38 PM, Antoine T=C3=A9nart wrote:

[=E2=80=A6]

> > +static inline void ahci_berlin_reg_set(void __iomem *reg, u32 val)
> > +{
> > +	writel(val, reg);
> > +}
>=20
> Antoine,
>=20
> if you really need to rename writel, the above function name should
> end with _write.

I renamed writel for consistency with ahci_berlin_reg_clear_set() and
ahci_berlin_reg_setbits() but I can definitively drop it.

>=20
> > +static inline void ahci_berlin_reg_clear_set(void __iomem *reg, u3=
2 clear_val,
> > +					     u32 set_val)
> > +{
> > +	u32 regval;
> > +
> > +	regval =3D readl(reg);
> > +	regval &=3D ~(clear_val);
> > +	regval |=3D set_val;
> > +	writel(regval, reg);
> > +}
>=20
> ahci_berlin_reg_setbits(reg, val) =3D=3D ahci_berlin_reg_clear_set(re=
g, 0, val);
>=20
> Maybe get rid of the latter?

Sure.

>=20
> > +static void ahci_berlin_init(void __iomem *mmio)
> > +{
> > +	/* interface select */
> > +	ahci_berlin_reg_set(mmio + HOST_VSA_ADDR, BIT(2));
> > +	ahci_berlin_reg_set(mmio + HOST_VSA_ADDR,
> > +			    BIT(21) | BIT(18) | BIT(5) | BIT(4) | BIT(2));
>=20
> Any chance we get named #defines for the BIT()s above and below?

I'm afraid I can't. I'd love to do so if someone has a clue on this mat=
ter.

> > +	/* force_map is modified only if the property is found */
> > +	of_property_read_u32(np, "marvell,force-port-map", &force_map);
> > +	if (force_map)
> > +		nports =3D force_map;
>=20
> marvell,force-port-map is undocumented and its name does not reflect
> what it is about. Before you just rename it to marvell,nr-ports or
> something, how about having one sub-node per port:
>=20
> sata_phy0: sata-phy@e90100 {
> 	compatible =3D "marvell,berlin-sata-phy";
> 	reg =3D <0xe90100 0x80>;
> 	status =3D "disabled";
> };
>=20
> sata_phy1: sata-phy@e90180 {
> 	compatible =3D "marvell,berlin-sata-phy";
> 	reg =3D <0xe90180 0x80>;
> 	status =3D "disabled";
> };
>=20
> ahci: sata@e90000 {
> 	compatible =3D "marvell,berlin-ahci";
> 	reg =3D <0xe90000 0x100>;
> 	interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> 	#address-cells =3D <1>;
> 	#size-cells =3D <0>;
> 	status =3D "disabled";
>=20
> 	sata-port@0 {
> 		reg =3D <0>;
> 		sata-phy =3D <&sata_phy0>;
> 		status =3D "disabled";
> 	};
>=20
> 	sata-port@1 {
> 		reg =3D <1>;
> 		sata-phy =3D <&sata_phy1>;
> 		status =3D "okay";
> 	};
> };
>=20
> That way you can
> (a) separate a PHY driver that has little code but is able to power-d=
own
>     the PHY even if there is no AHCI driver loaded.
> (b) enable/disable each port individually.
> (c) enable port1 while port0 is disabled.
> (d) disable the PLL if there is no port enabled at all.

That would be better, but as of now I'm not sure I have enough informat=
ion on
the PHY to do (a).

I guess (b), (c) and (d) can still be done.

Thanks for the review!

Antoine

--=20
Antoine T=C3=A9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
