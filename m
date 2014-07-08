From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v9 1/7] phy: add a driver for the Berlin SATA PHY
Date: Tue, 8 Jul 2014 18:43:26 +0530
Message-ID: <53BBEE76.7090100@ti.com>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com> <1404728173-20263-2-git-send-email-antoine.tenart@free-electrons.com> <53BBE419.8080107@ti.com> <53BBEB84.50904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53BBEB84.50904@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>, tj@kernel.org
Cc: alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

On Tuesday 08 July 2014 06:30 PM, Sebastian Hesselbarth wrote:
> On 07/08/2014 02:29 PM, Kishon Vijay Abraham I wrote:
>> On Monday 07 July 2014 03:46 PM, Antoine T=C3=A9nart wrote:
>>> The Berlin SoC has a two SATA ports. Add a PHY driver to handle the=
m.
>>>
>>> The mode selection can let us think this PHY can be configured to f=
it
>>> other purposes. But there are reasons to think the SATA mode will b=
e
>>> the only one usable: the PHY registers are only accessible indirect=
ly
>>> through two registers in the SATA range, the PHY seems to be integr=
ated
>>> and no information tells us the contrary. For these reasons, make t=
he
>>> driver a SATA PHY driver.
>>
>> Thanks for doing multiple revisions of this. Looks good to be merged=
 for me now.
>=20
> I'd like to see some Acked-by from Tejun on the AHCI patches first, b=
ut
> if he agrees, should I prepare a stable branch for each of us to pull
> their patches from?

I don't think that's needed. As long as there are no build breaks, each=
 of us
should be able to take it independently.
>=20
> AFAIKS, that would be 1+2 for you, 3-5 for Tejun, and the DT crap 6+7
> for me.

right, I'll take 1 and 2 in my tree.

Cheers
Kishon
