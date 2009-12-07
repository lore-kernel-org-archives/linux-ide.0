From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH 6/6] sata_mv: add power management support for the PCI
	controllers.
Date: Sun, 6 Dec 2009 22:32:15 -0800
Message-ID: <da824cf30912062232i5e04a6f2u20f0ff8ed5aa51cb@mail.gmail.com>
References: <1260116782-31714-1-git-send-email-saeed@marvell.com>
	 <1260116782-31714-2-git-send-email-saeed@marvell.com>
	 <1260116782-31714-3-git-send-email-saeed@marvell.com>
	 <1260116782-31714-4-git-send-email-saeed@marvell.com>
	 <1260116782-31714-5-git-send-email-saeed@marvell.com>
	 <1260116782-31714-6-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:8987 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbZLGGcO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 01:32:14 -0500
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com [172.24.198.88])
	by smtp-out.google.com with ESMTP id nB76WIo2023719
	for <linux-ide@vger.kernel.org>; Sun, 6 Dec 2009 22:32:19 -0800
Received: from ey-out-1920.google.com (eyg4.prod.google.com [10.208.7.4])
	by wpaz24.hot.corp.google.com with ESMTP id nB76WF7x013155
	for <linux-ide@vger.kernel.org>; Sun, 6 Dec 2009 22:32:16 -0800
Received: by ey-out-1920.google.com with SMTP id 4so314727eyg.18
        for <linux-ide@vger.kernel.org>; Sun, 06 Dec 2009 22:32:15 -0800 (PST)
In-Reply-To: <1260116782-31714-6-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org, liml@rtr.ca, nico@fluxnic.net, buytenh@wantstofly.org

On Sun, Dec 6, 2009 at 8:26 AM, Saeed Bishara <saeed@marvell.com> wrote=
:
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
> =C2=A0drivers/ata/sata_mv.c | =C2=A0 29 +++++++++++++++++++++++++++++
> =C2=A01 files changed, 29 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 71ac62e..704d86f 100755
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4161,6 +4161,9 @@ static struct platform_driver mv_platform_drive=
r =3D {
> =C2=A0#ifdef CONFIG_PCI
> =C2=A0static int mv_pci_init_one(struct pci_dev *pdev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 const struct pci_device_id *ent);
> +#ifdef CONFIG_PM
> +static int mv_pci_device_resume(struct pci_dev *pdev);
> +#endif
>
>
> =C2=A0static struct pci_driver mv_pci_driver =3D {
> @@ -4168,6 +4171,11 @@ static struct pci_driver mv_pci_driver =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.id_table =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =3D mv_pci_tbl,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D mv_pci_init_one,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D ata_pci_remove_one,
> +#ifdef CONFIG_PM
> + =C2=A0 =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D ata_pci_device_suspend,
> + =C2=A0 =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D mv_pci_device_resume,
> +#endif

Saeed,
Apologies - Ignore my previous comment on the mv_platform_driver() patc=
h.
I should have been looking at this patch.

And interesting to see that sata_via is the only SATA driver setting
ata_pci_device_resume() for it's .resume call. The rest of the callers
are PATA drivers.

Reviewed-by: Grant Grundler <grundler@google.com>

thanks,
grant

> +
> =C2=A0};
>
> =C2=A0/* move to PCI layer or libata core? */
> @@ -4324,6 +4332,27 @@ static int mv_pci_init_one(struct pci_dev *pde=
v,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ata_host_activate(host, pdev->irq, =
mv_interrupt, IRQF_SHARED,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IS_GEN_I(hpriv) ? &mv5_sht :=
 &mv6_sht);
> =C2=A0}
> +
> +#ifdef CONFIG_PM
> +static int mv_pci_device_resume(struct pci_dev *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ata_host *host =3D dev_get_drvdata(&pde=
v->dev);
> + =C2=A0 =C2=A0 =C2=A0 int rc;
> +
> + =C2=A0 =C2=A0 =C2=A0 rc =3D ata_pci_device_do_resume(pdev);
> + =C2=A0 =C2=A0 =C2=A0 if (rc)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* initialize adapter */
> + =C2=A0 =C2=A0 =C2=A0 rc =3D mv_init_host(host);
> + =C2=A0 =C2=A0 =C2=A0 if (rc)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;
> +
> + =C2=A0 =C2=A0 =C2=A0 ata_host_resume(host);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +#endif
> =C2=A0#endif
>
> =C2=A0static int mv_platform_probe(struct platform_device *pdev);
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
