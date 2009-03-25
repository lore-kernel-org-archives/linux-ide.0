From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata-rb532-cf: platform_get_irq() failure ignored
Date: Tue, 24 Mar 2009 22:16:43 -0400
Message-ID: <49C9940B.5050704@garzik.org>
References: <49AD2ADA.5030109@gmail.com> <49AFC43A.3040206@garzik.org> <20090306164318.GF23767@nuty.nwl.cc> <200903131541.46648.florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56688 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756539AbZCYCRK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 22:17:10 -0400
In-Reply-To: <200903131541.46648.florian@openwrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <florian@openwrt.org>
Cc: Phil Sutter <n0-1@freewrt.org>, Roel Kluin <roel.kluin@gmail.com>, jgarzik@redhat.com, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

=46lorian Fainelli wrote:
> Hi,
>=20
> Le Friday 06 March 2009 17:43:18 Phil Sutter, vous avez =E9crit :
>> Hi,
>>
>> On Thu, Mar 05, 2009 at 07:23:22AM -0500, Jeff Garzik wrote:
>>> Roel Kluin wrote:
>>>> ------------------------------>8-------------8<-------------------=
------
>>>> -------- platform_get_irq() can return -ENXIO, but since 'irq' is =
an
>>>> unsigned int, it
>>>> does not show when the IRQ resource wasn't found.
>>>>
>>>> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
>>>> ---
>>>> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_=
cf.c
>>>> index ebfcda2..fe8178c 100644
>>>> --- a/drivers/ata/pata_rb532_cf.c
>>>> +++ b/drivers/ata/pata_rb532_cf.c
>>>> @@ -173,11 +173,12 @@ static __devinit int
>>>> rb532_pata_driver_probe(struct platform_device *pdev)
>>>> 		return -EINVAL;
>>>> 	}
>>>>
>>>> -	irq =3D platform_get_irq(pdev, 0);
>>>> -	if (irq <=3D 0) {
>>>> +	ret =3D platform_get_irq(pdev, 0);
>>>> +	if (ret <=3D 0) {
>>>> 		dev_err(&pdev->dev, "no IRQ resource found\n");
>>>> 		return -ENOENT;
>>>> 	}
>>>> +	irq =3D ret;
>>>>
>>>> 	gpio =3D irq_to_gpio(irq);
>>> ACK from Phil or Florian?
>> That's fine for me, though I didn't test it (I managed to break my
>> build-machine somehow, in an attempt to having the mainboard properl=
y
>> grounded).
>>
>> One could simplify the patch by making the variable 'irq' be signed
>> instead of unsigned. This would also prevent "abusing" the variable
>> 'ret'. What do you think?
>=20
> I agree with this proposal, abusing the ret value is not that good. W=
hat about the patch below :
> --
> From: Florian Fainelli <florian@openwrt.org>
> Subject: [PATCH v2] pata-rb532-cf: platform_get_irq() failure ignored
>=20
> platform_get_irq() can return -ENXIO, but since 'irq' is an
> unsigned int, it does not show when the IRQ resource wasn't found.
> Make irq an int so that we can use a single variable to test the
> platform_get_irq() return value.
>=20
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> --
> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.=
c
> index ebfcda2..da05518 100644
> --- a/drivers/ata/pata_rb532_cf.c
> +++ b/drivers/ata/pata_rb532_cf.c
> @@ -160,7 +160,7 @@ static void rb532_pata_setup_ports(struct ata_hos=
t *ah)
> =20
>  static __devinit int rb532_pata_driver_probe(struct platform_device =
*pdev)
>  {
> -	unsigned int irq;
> +	int irq;
>  	int gpio;
>  	struct resource *res;
>  	struct ata_host *ah;

applied


