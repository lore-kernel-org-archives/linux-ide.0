From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v9 1/7] phy: add a driver for the Berlin SATA PHY
Date: Tue, 08 Jul 2014 15:00:52 +0200
Message-ID: <53BBEB84.50904@gmail.com>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com> <1404728173-20263-2-git-send-email-antoine.tenart@free-electrons.com> <53BBE419.8080107@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53BBE419.8080107@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>, tj@kernel.org
Cc: alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 07/08/2014 02:29 PM, Kishon Vijay Abraham I wrote:
> On Monday 07 July 2014 03:46 PM, Antoine T=C3=A9nart wrote:
>> The Berlin SoC has a two SATA ports. Add a PHY driver to handle them=
=2E
>>
>> The mode selection can let us think this PHY can be configured to fi=
t
>> other purposes. But there are reasons to think the SATA mode will be
>> the only one usable: the PHY registers are only accessible indirectl=
y
>> through two registers in the SATA range, the PHY seems to be integra=
ted
>> and no information tells us the contrary. For these reasons, make th=
e
>> driver a SATA PHY driver.
>
> Thanks for doing multiple revisions of this. Looks good to be merged =
for me now.

I'd like to see some Acked-by from Tejun on the AHCI patches first, but
if he agrees, should I prepare a stable branch for each of us to pull
their patches from?

AFAIKS, that would be 1+2 for you, 3-5 for Tejun, and the DT crap 6+7
for me.

Sebastian
