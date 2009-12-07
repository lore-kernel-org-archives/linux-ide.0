From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH 3/6] sata_mv: add power management support for the
	platform driver
Date: Sun, 6 Dec 2009 22:14:56 -0800
Message-ID: <da824cf30912062214s46158e96med5744d3451fed89@mail.gmail.com>
References: <1260116782-31714-1-git-send-email-saeed@marvell.com>
	 <1260116782-31714-2-git-send-email-saeed@marvell.com>
	 <1260116782-31714-3-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:15482 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbZLGGPB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 01:15:01 -0500
Received: from spaceape10.eur.corp.google.com (spaceape10.eur.corp.google.com [172.28.16.144])
	by smtp-out.google.com with ESMTP id nB76F0Lo009107
	for <linux-ide@vger.kernel.org>; Mon, 7 Dec 2009 06:15:05 GMT
Received: from ewy23 (ewy23.prod.google.com [10.241.103.23])
	by spaceape10.eur.corp.google.com with ESMTP id nB76EukW017629
	for <linux-ide@vger.kernel.org>; Sun, 6 Dec 2009 22:14:58 -0800
Received: by ewy23 with SMTP id 23so3158772ewy.4
        for <linux-ide@vger.kernel.org>; Sun, 06 Dec 2009 22:14:56 -0800 (PST)
In-Reply-To: <1260116782-31714-3-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org, liml@rtr.ca, nico@fluxnic.net, buytenh@wantstofly.org

On Sun, Dec 6, 2009 at 8:26 AM, Saeed Bishara <saeed@marvell.com> wrote=
:
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
> =C2=A0drivers/ata/sata_mv.c | =C2=A0 43 +++++++++++++++++++++++++++++=
++++++++++++++
> =C2=A01 files changed, 43 insertions(+), 0 deletions(-)
> =C2=A0mode change 100644 =3D> 100755 drivers/ata/sata_mv.c
>
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> old mode 100644
> new mode 100755
> index 0906df4..17a138b
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4112,9 +4112,52 @@ static int __devexit mv_platform_remove(struct=
 platform_device *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> +#ifdef CONFIG_PM
> +static int mv_platform_suspend(struct platform_device *pdev, pm_mess=
age_t state)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ata_host *host =3D dev_get_drvdata(&pde=
v->dev);
> + =C2=A0 =C2=A0 =C2=A0 if (host)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ata_host_su=
spend(host, state);
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;

Just curious: Is this really enough?

Most drivers in drivers/ata/ are setting ata_pci_device_suspend() as
their .suspend function. This calls ata_host_suspend().

ata_piix seems to be the only driver that calls  ata_pci_device_do_susp=
end().

Please add "Reviewed-by: Grant Grundler <grundler@google.com>" once
the above is clarified.

thanks,
grant

> +}
> +
> +static int mv_platform_resume(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ata_host *host =3D dev_get_drvdata(&pde=
v->dev);
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (host) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mv_host_pri=
v *hpriv =3D host->private_data;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct mv_sa=
ta_platform_data *mv_platform_data =3D \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pdev->dev.platform_data;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* (Re-)progr=
am MBUS remapping windows if we are asked to.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mv_platform_da=
ta->dram !=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mv_conf_mbus_windows(hpriv, mv_platform_data->dram);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* initialize adap=
ter */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mv_init_ho=
st(host, chip_soc);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 printk(KERN_ERR DRV_NAME ": Error during HW init\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return ret;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ata_host_resume(ho=
st);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +#else
> +#define mv_platform_suspend NULL
> +#define mv_platform_resume NULL
> +#endif
> +
> =C2=A0static struct platform_driver mv_platform_driver =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D mv_platform_probe,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D __devexit_p(mv_platform_remove),
> + =C2=A0 =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D mv_platform_suspend,
> + =C2=A0 =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D mv_platform_resume,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D DRV_NAME,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D THIS_MODUL=
E,
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
