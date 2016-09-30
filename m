From: "Y.T. Tang" <yuantian.tang@nxp.com>
Subject: RE: [PATCH] ahci: qoriq: Revert "ahci: qoriq: Disable NCQ on ls2080a
 SoC"
Date: Fri, 30 Sep 2016 06:29:25 +0000
Message-ID: <DB6PR0402MB2837CD00CECD4FDEA52A988EF0C10@DB6PR0402MB2837.eurprd04.prod.outlook.com>
References: <1475215954-48395-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-db5eur01on0053.outbound.protection.outlook.com ([104.47.2.53]:20475
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932348AbcI3TE0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 30 Sep 2016 15:04:26 -0400
In-Reply-To: <1475215954-48395-1-git-send-email-yuantian.tang@nxp.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Y.T. Tang" <yuantian.tang@nxp.com>, "tj@kernel.org" <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Please ignore this, it is a duplicated patch.

Regards,
Yuantian

> -----Original Message-----
> From: yuantian.tang@nxp.com [mailto:yuantian.tang@nxp.com]
> Sent: Friday, September 30, 2016 2:13 PM
> To: tj@kernel.org; linux-ide@vger.kernel.org
> Cc: Y.T. Tang <yuantian.tang@nxp.com>; Y.T. Tang <yuantian.tang@nxp.com>
> Subject: [PATCH] ahci: qoriq: Revert "ahci: qoriq: Disable NCQ on ls2080a=
 SoC"
>=20
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
>=20
> This reverts commit 640847298e2b7f19 ("ahci: qoriq: Disable NCQ on ls2080=
a
> SoC")
>=20
> The erratum has been fixed in ls2080a v2.0 and later soc.
> In reality, customer will not get any ls2080a v1.0 soc. Neither apply to =
any
> products. So reverting this commit won't create any side effect.
>=20
> Blacklisting v2.0 could also be a option, but that needs to check the soc
> version which is not suitable in the driver.
>=20
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> ---
>  drivers/ata/ahci_qoriq.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c index
> 925c4b6..1eba8df 100644
> --- a/drivers/ata/ahci_qoriq.c
> +++ b/drivers/ata/ahci_qoriq.c
> @@ -136,7 +136,7 @@ static struct ata_port_operations ahci_qoriq_ops =3D =
{
>  	.hardreset	=3D ahci_qoriq_hardreset,
>  };
>=20
> -static struct ata_port_info ahci_qoriq_port_info =3D {
> +static const struct ata_port_info ahci_qoriq_port_info =3D {
>  	.flags		=3D AHCI_FLAG_COMMON | ATA_FLAG_NCQ,
>  	.pio_mask	=3D ATA_PIO4,
>  	.udma_mask	=3D ATA_UDMA6,
> @@ -221,12 +221,6 @@ static int ahci_qoriq_probe(struct platform_device
> *pdev)
>  	if (rc)
>  		goto disable_resources;
>=20
> -	/* Workaround for ls2080a */
> -	if (qoriq_priv->type =3D=3D AHCI_LS2080A) {
> -		hpriv->flags |=3D AHCI_HFLAG_NO_NCQ;
> -		ahci_qoriq_port_info.flags &=3D ~ATA_FLAG_NCQ;
> -	}
> -
>  	rc =3D ahci_platform_init_host(pdev, hpriv, &ahci_qoriq_port_info,
>  				     &ahci_qoriq_sht);
>  	if (rc)
> --
> 2.1.0.27.g96db324

