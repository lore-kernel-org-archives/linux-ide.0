From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v10 5/8] ata: ahci_platform: add a generic AHCI compatible
Date: Fri, 18 Jul 2014 16:30:38 +0200
Message-ID: <53C92F8E.5000906@redhat.com>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com> <1405686607-8126-6-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40919 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934407AbaGRObs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Jul 2014 10:31:48 -0400
In-Reply-To: <1405686607-8126-6-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 07/18/2014 02:30 PM, Antoine T=C3=A9nart wrote:
> The ahci_platform driver is a generic driver using the libahci_platfo=
rm
> functions. Add a generic compatible to avoid having an endless list o=
f
> compatibles with no differences for the same driver.
>=20
> Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com=
>
> ---
>  drivers/ata/ahci_platform.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.=
c
> index 95f9ca82082a..61b15e784020 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -77,6 +77,8 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform=
_suspend,
>  			 ahci_platform_resume);
> =20
>  static const struct of_device_id ahci_of_match[] =3D {
> +	{ .compatible =3D "generic-ahci", },
> +	/* Keep the following compatibles for device tree compatibility */
>  	{ .compatible =3D "snps,spear-ahci", },
>  	{ .compatible =3D "snps,exynos5440-ahci", },
>  	{ .compatible =3D "ibm,476gtr-ahci", },
>=20

I'm not against this, I've introduced the same for the ehci / uhci plat=
form
driver after all, but this should be documented in Documentation/device=
tree,
and please make sure to mention in the docs that the correct way to use=
 this
inside a dts file is:

	compatible =3D "manufacturer,soc-model-ahci", "generic-ahci";

So that we can later add quirks for the specific soc if necessary witho=
ut
needing to change the dts.

Regards,

Hans
