From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 3/6] ARM: berlin: add the AHCI node for the BG2Q
Date: Tue, 22 Apr 2014 19:22:42 +0200
Message-ID: <5356A562.2090403@gmail.com>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com> <1398181105-19714-4-git-send-email-antoine.tenart@free-electrons.com> <20140422182802.447c2912@skate>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140422182802.447c2912@skate>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>
Cc: tj@kernel.org, zmxu@marvell.com, jszhang@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 04/22/2014 06:28 PM, Thomas Petazzoni wrote:
> Dear Antoine T=C3=A9nart,
>=20
> On Tue, 22 Apr 2014 17:38:22 +0200, Antoine T=C3=A9nart wrote:
>> The BG2Q has an AHCI SATA controller. Add the corresponding node
>> in its device tree.
>=20
> I believe the commit log should explain why an apparently unrelated
> generic-regs@ node gets added in this commit.

generic-regs@ is from another patch, please drop it entirely.

Sebastian

>> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/ber=
lin2q.dtsi
>> index 07452a7483fa..8e58aae73365 100644
>> --- a/arch/arm/boot/dts/berlin2q.dtsi
>> +++ b/arch/arm/boot/dts/berlin2q.dtsi
>> @@ -183,6 +183,18 @@
>>  			};
>>  		};
>> =20
>> +		ahci: sata@e90000 {
>> +			compatible =3D "marvell,berlin-ahci";
>> +			reg =3D <0xe90000 0x10000>;
>> +			interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +			status =3D "disable";
>> +		};
>> +
>> +		generic-regs@ea0110 {
>> +			compatible =3D "marvell,berlin-generic-regs", "syscon";
>> +			reg =3D <0xea0110 0x10>;
>> +		};
>> +
>>  		apb@fc0000 {
>>  			compatible =3D "simple-bus";
>>  			#address-cells =3D <1>;
>=20
>=20
>=20
