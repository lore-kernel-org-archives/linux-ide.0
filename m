From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 1/7] phy: add a driver for the Berlin SATA PHY
Date: Tue, 24 Jun 2014 17:52:00 +0530
Message-ID: <53A96D68.8070303@gmail.com>
References: <1402914392-6028-1-git-send-email-antoine.tenart@free-electrons.com> <1402914392-6028-2-git-send-email-antoine.tenart@free-electrons.com> <53A9685E.9090501@ti.com> <53A96A1C.5030800@gmail.com> <20140624121525.GM13803@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140624121525.GM13803@lee--X1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On 06/24/2014 05:45 PM, Lee Jones wrote:
> On Tue, 24 Jun 2014, Varka Bhadram wrote:
>> On 06/24/2014 05:30 PM, Kishon Vijay Abraham I wrote:
>>> On Monday 16 June 2014 03:56 PM, Antoine T=C3=A9nart wrote:
>>>> The Berlin SoC has a two SATA ports. Add a PHY driver to handle th=
em.
>>>>
>>>> The mode selection can let us think this PHY can be configured to =
fit
>>>> other purposes. But there are reasons to think the SATA mode will =
be
>>>> the only one usable: the PHY registers are only accessible indirec=
tly
>>>> through two registers in the SATA range, the PHY seems to be integ=
rated
>>>> and no information tells us the contrary. For these reasons, make =
the
>>>> driver a SATA PHY driver.
>>>>
>>>> Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.=
com>
>>>> ---
>>>>   drivers/phy/Kconfig           |   7 ++
>>>>   drivers/phy/Makefile          |   1 +
>>>>   drivers/phy/phy-berlin-sata.c | 232 ++++++++++++++++++++++++++++=
++++++++++++++
>>>>   3 files changed, 240 insertions(+)
>>>>   create mode 100644 drivers/phy/phy-berlin-sata.c

[...]

>>>> +static struct platform_driver phy_berlin_sata_driver =3D {
>>>> +	.probe	=3D phy_berlin_sata_probe,
>>>> +	.driver	=3D {
>>>> +		.name		=3D "phy-berlin-sata",
>>>> +		.owner		=3D THIS_MODULE,
>>>> +		.of_match_table	=3D phy_berlin_sata_of_match,
>> use of_match_ptr for of_match_table
> What use is this?
>
> [...]
>
of_match_table is NULL for Non-DT based. Better to use the of_match_ptr=
().
If driver is DT based 'of_match_table	=3D phy_berlin_sata_of_match'
else 'of_match_table	=3D NULL'

This is take care by of_match_ptr() macro.

Thanks,
Varka Bhadram


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
