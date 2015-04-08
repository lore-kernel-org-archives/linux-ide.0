From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2 1/9] ata: at91: use syscon to configure the smc
Date: Wed, 8 Apr 2015 14:06:15 +0200
Message-ID: <552519B7.2090206@atmel.com>
References: <1427138955-3617-1-git-send-email-alexandre.belloni@free-electrons.com> <2936706.hVbBP0ExQQ@amdc1032> <20150408111335.GZ20669@piout.net> <3156869.zFaIKVVpHK@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3156869.zFaIKVVpHK@amdc1032>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
List-Id: linux-ide@vger.kernel.org

Le 08/04/2015 14:00, Bartlomiej Zolnierkiewicz a =E9crit :
> On Wednesday, April 08, 2015 01:13:35 PM Alexandre Belloni wrote:
>> Hi,
>>
>> On 08/04/2015 at 13:04:19 +0200, Bartlomiej Zolnierkiewicz wrote :
>>> On Monday, March 23, 2015 08:29:07 PM Alexandre Belloni wrote:
>>>> Use syscon/regmap to configure the smc. This allows to avoid using
>>>> at91sam9_smc.h and to compile the driver in a multiplatform config=
uration.
>>>>
>>>> The driver will still not probe until the proper DT bindings are a=
dded. That
>>>> binding will include an atmel,smc property that is a phandle to th=
e SMC the CF
>>>> controller is connected to.
>>>
>>> If the driver is currently working fine in !ARCH_MULTIPLATFORM
>>> configuration then this patch will make it non-functional until
>>> atmel,smc property is added to DT.  To prevent this and preserve
>>> bisectability the patchset should first add atmel,smc property
>>> and then convert pata_at91 driver to use it.
>>>
>>
>> Starting with 4.1, it will not be possible to use the driver anyway =
as
>> all the platforms using it have switched to multiplatform. This patc=
h
>> makes it compilable again.
>=20
> Hmm.  It seems that it was your commit which did the switch without
> converting all at91 specific code to be multiplatform ready first:
>=20
>     From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>     Date: Fri, 13 Mar 2015 22:57:18 +0100
>     Subject: ARM: at91: switch to multiplatform
>=20
>     Switch AT91 to multiplatform as all SoCs are properly handled.
>=20
>     Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electron=
s.com>
>     Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>=20
> ?
>=20
>> Anyway, it seems that there is little interest in that driver and no=
body
>> I contacted has access to a board which can be used to test this.
>=20
> If there are no users then probably the driver can be removed but thi=
s
> something that platform Maintainers should decide on.

This is why there are loose constrains on this driver and that we
decided to move on.
So I think that modifying it and introducing the DT property afterwards
can be done.

Bye,
--=20
Nicolas Ferre
