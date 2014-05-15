From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v3 1/6] phy: add a driver for the Berlin SATA PHY
Date: Thu, 15 May 2014 09:02:39 +0200
Message-ID: <5374668F.4060109@gmail.com>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com> <20140514165722.GA18495@kwain> <5373AE9A.3050008@gmail.com> <5764751.ffUj9rhnMd@wuerfel> <5373B908.5090904@gmail.com> <537462A2.5020607@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:40684 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbaEOHCq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 May 2014 03:02:46 -0400
In-Reply-To: <537462A2.5020607@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Arnd Bergmann <arnd@arndb.de>
Cc: =?ISO-8859-1?Q?Antoine_T=E9nart?= <antoine.tenart@free-electrons.com>, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, tj@kernel.org

On 05/15/2014 08:45 AM, Kishon Vijay Abraham I wrote:
> On Thursday 15 May 2014 12:12 AM, Sebastian Hesselbarth wrote:
>> On 05/14/2014 08:12 PM, Arnd Bergmann wrote:
>>> On Wednesday 14 May 2014 19:57:46 Sebastian Hesselbarth wrote:
>>>> On 05/14/2014 06:57 PM, Antoine T=E9nart wrote:
>>>>> On Wed, May 14, 2014 at 06:11:24PM +0200, Arnd Bergmann wrote:
>>>>>> On Wednesday 14 May 2014 17:49:29 Antoine T=E9nart wrote:
>>>>>>> On Wed, May 14, 2014 at 05:31:24PM +0200, Arnd Bergmann wrote:
[...]
>>>> Now, thinking about the PHY binding and the (possible) multi-proto=
col
>>>> support, it can be possible that on BG2Q there is a generic 2-lane
>>>> LVDS PHY that can be configured to support SATA or PCIe. Both are
>>>> electrically and bit-level compatible, so they could be internally
>>>> wired-up with AHCI and PCIe controller.
>>>
>>> Sounds like a reasonable guess. We have other PHY drivers doing the
>>> same thing already.
[...]
>>>> From a DT point-of-view, we need a way to (a) link each SATA or PC=
Ie
>>>> port to the PHY, (b) specify the PHY lane to be used, and (c) spec=
ify
>>>> the protocol to be used on that lane. If I got it right, Arnd alre=
ady
>>>> mentioned to use the phy-specifier to deal with it:
>>>>
>>>> e.g. phy =3D <&genphy 0 MODE_SATA> or phy =3D <&genphy 1 MODE_PCIE=
>
>>>
>>> Right.
>>>
>>>> Let's assume we have one dual-port SATA controller and one PCIe
>>>> controller with either x1 or x2 support. The only sane DT binding,
>>>> I can think of then would be:
>>>>
>>>> berlin2q.dtsi:
>>>>
>>>> genphy: lvds@ea00ff {
>>>> 	compatible =3D "marvell,berlin-lvds-phy";
>>>> 	reg =3D <0xea00ff 0x100>;
>>>> 	#phy-cells =3D <2>;
>>>> };
>>>>
>>>> sata: sata@ab00ff {
>>>> 	compatible =3D "ahci-platform";
>>>> 	reg =3D <0xab00ff 0x100>;
>>>> =09
>>>> 	sata0: sata-port@0 {
>>>> 		reg =3D <0>;
>>>> 		phy =3D <&genphy 0 MODE_SATA>;
>>>> 		status =3D "disabled";
>>>> 	};
>>>>
>>>> 	sata1: sata-port@1 {
>>>> 		reg =3D <1>;
>>>> 		phy =3D <&genphy 1 MODE_SATA>;
>>>> 		status =3D "disabled";
>>>> 	};
>>>> };
>>>>
>>>> pcie: pcie@ab01ff {
>>>> 	compatible =3D "marvell,berlin-pcie";
>>>> 	reg =3D <0xab01ff 0x100>;
>>>>
>>>> 	pcie0: pcie-port@0 {
>>>> 		reg =3D <0>;
>>>> 		/* set phy on a per-board basis */
>>>> 		/* PCIe x1 on Lane 0 : phy =3D <&genphy 0 MODE_PCIE>; */
>>>> 		/* PCIe x2 on Lane 0 and 1 : phy =3D <&genphy 0 MODE_PCIE>, <&ge=
nphy 1
>>>> MODE_PCIE>; */
>>>> 		status =3D "disabled";
>>>> 	};
>>>> };
>>>>
>>>> berlin2q-dmp.dts:
>>>>
>>>> &sata1 {
>>>> 	status =3D "okay";
>>>> };
>>>>
>>>> &pcie0 {
>>>> 	phy =3D <&genphy 1 MODE_PCIE>;
>>>> };
>>>>
>>>> berlin2q-foo.dts:
>>>>
>>>> &pcie0 {
>>>> 	phy =3D <&genphy 0 MODE_PCIE>, <&genphy 1 MODE_PCIE>;
>>>> };
>>>
>>> Exactly. I would also be fine with keeping the sub-nodes of the
>>> phy device as in v3 and using #phy-cells=3D<1> instead of #phy-cell=
s.
>>> The result would be pretty much the same, it just depends on how
>>> closely connected the two logical phys are.
>=20
> huh.. even with sub-nodes you'll need #phy-cells=3D<2> if we use a si=
ngle *PHY
> PROVIDER*. Because with just PHYs node pointer we won't be able to ge=
t the PHY.
> We'll need PHY providers node pointer.
>=20
> However I'd prefer to have sub-nodes for each individual PHYs and reg=
ister a
> single PHY PROVIDER.

Depends on what you call PHY. In the example above the PHY is what
allows you to control both lanes.

So you want sub-nodes for each individual lane given the nomenclature
of the example?

Or like it is used in the example above, a single PHY node with an inde=
x
in the phy-specifier to pick an individual lane.

IMHO, having both phy-specifier index _and_ PHY sub-node per lane
has no benefit at all. You cannot even use the PHY sub-nodes for any
setup properties, as they depend on the consumer claiming the lane.

Sebastian

