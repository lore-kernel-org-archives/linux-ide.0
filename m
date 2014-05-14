From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/6] phy: add a driver for the Berlin SATA PHY
Date: Wed, 14 May 2014 19:57:46 +0200
Message-ID: <5373AE9A.3050008@gmail.com>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com> <31922167.uMVzxsQNIT@wuerfel> <20140514154929.GA8016@kwain> <4414637.rKolGB14Rm@wuerfel> <20140514165722.GA18495@kwain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140514165722.GA18495@kwain>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Antoine_T=E9nart?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 05/14/2014 06:57 PM, Antoine T=E9nart wrote:
> On Wed, May 14, 2014 at 06:11:24PM +0200, Arnd Bergmann wrote:
>> On Wednesday 14 May 2014 17:49:29 Antoine T=E9nart wrote:
>>> On Wed, May 14, 2014 at 05:31:24PM +0200, Arnd Bergmann wrote:
>>>> Why do you need a custom mask? Is that something you could pass
>>>> as the argument in the phy descriptor using #phy-cells=3D<1>?
>>>
>>> I meant a custom mask in the AHCI driver, when calling the
>>> ahci_platform_init_host() function. Otherwise we'll have problems o=
n the
>>> BG2Q DMP (it only has one PHY available, and not initializing it is=
 not
>>> enough).
>>
>> Ah, I see what you mean now. Of course, this could also be an option=
al
>> property in the generic AHCI binding, which would require that you
>> specify the available ports in DT for nonstandard masks.
>>
>> Just to confirm: The HOST_PORTS_IMPL register on BG2Q DMP has an
>> value that we can't use here to determine the available ports, right=
?
>=20
> Right. The register is here but saying there are 2 available ports,
> which is true for the BG2Q SoC but not true for the BG2Q DMP board. S=
o
> the AHCI framework reads the register and performs a misconfiguration=
 of
> the SATA.

*Disclaimer:* All PHY IP related comments below are *pure* guessing. I
have no clue how that PHY really looks like or how it is wired up.

I think it is time to sum this up a little bit and help Antoine carry
on this patches.

=46rom what I understand from the conversation, we have a single PHY
register set dealing with both SATA ports available on the SoC.
Also, from the name of the PHY bits we assume the PHY may be able
to work in different modes than just SATA. And we currently have
an AHCI-compatible SATA IP that supports up to two ports, with one
actually connected to a SATA plug on the DMP board.

Now, thinking about the PHY binding and the (possible) multi-protocol
support, it can be possible that on BG2Q there is a generic 2-lane
LVDS PHY that can be configured to support SATA or PCIe. Both are
electrically and bit-level compatible, so they could be internally
wired-up with AHCI and PCIe controller.

=46rom a DT point-of-view, we need a way to (a) link each SATA or PCIe
port to the PHY, (b) specify the PHY lane to be used, and (c) specify
the protocol to be used on that lane. If I got it right, Arnd already
mentioned to use the phy-specifier to deal with it:

e.g. phy =3D <&genphy 0 MODE_SATA> or phy =3D <&genphy 1 MODE_PCIE>

Let's assume we have one dual-port SATA controller and one PCIe
controller with either x1 or x2 support. The only sane DT binding,
I can think of then would be:

berlin2q.dtsi:

genphy: lvds@ea00ff {
	compatible =3D "marvell,berlin-lvds-phy";
	reg =3D <0xea00ff 0x100>;
	#phy-cells =3D <2>;
};

sata: sata@ab00ff {
	compatible =3D "ahci-platform";
	reg =3D <0xab00ff 0x100>;
=09
	sata0: sata-port@0 {
		reg =3D <0>;
		phy =3D <&genphy 0 MODE_SATA>;
		status =3D "disabled";
	};

	sata1: sata-port@1 {
		reg =3D <1>;
		phy =3D <&genphy 1 MODE_SATA>;
		status =3D "disabled";
	};
};

pcie: pcie@ab01ff {
	compatible =3D "marvell,berlin-pcie";
	reg =3D <0xab01ff 0x100>;

	pcie0: pcie-port@0 {
		reg =3D <0>;
		/* set phy on a per-board basis */
		/* PCIe x1 on Lane 0 : phy =3D <&genphy 0 MODE_PCIE>; */
		/* PCIe x2 on Lane 0 and 1 : phy =3D <&genphy 0 MODE_PCIE>, <&genphy =
1
MODE_PCIE>; */
		status =3D "disabled";
	};
};

berlin2q-dmp.dts:

&sata1 {
	status =3D "okay";
};

&pcie0 {
	phy =3D <&genphy 1 MODE_PCIE>;
};

berlin2q-foo.dts:

&pcie0 {
	phy =3D <&genphy 0 MODE_PCIE>, <&genphy 1 MODE_PCIE>;
};

=46or the driver, Antoine then would have to squeeze all PHY register
mangling in phy-berlin2.c and see how to make ahci-platform aware of
individual port nodes (I haven't looked up if it already exists, sorry)
and announce only enabled port child nodes, right?

Sebastian

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
