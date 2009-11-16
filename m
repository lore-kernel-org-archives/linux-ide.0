From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH 1/1] ata/sata_sil24: MSI support, disabled by default
Date: Mon, 16 Nov 2009 09:37:34 -0800
Message-ID: <da824cf30911160937l38651a44sc25a3315efd24aea@mail.gmail.com>
References: <1258352362-11231-1-git-send-email-vivek.mahajan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:50393 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbZKPRhe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Nov 2009 12:37:34 -0500
Received: from spaceape13.eur.corp.google.com (spaceape13.eur.corp.google.com [172.28.16.147])
	by smtp-out.google.com with ESMTP id nAGHbbqo000706
	for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2009 17:37:38 GMT
Received: from gv-out-0910.google.com (gvfl14.prod.google.com [10.16.188.14])
	by spaceape13.eur.corp.google.com with ESMTP id nAGHbYKo014958
	for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2009 09:37:34 -0800
Received: by gv-out-0910.google.com with SMTP id l14so692011gvf.30
        for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2009 09:37:34 -0800 (PST)
In-Reply-To: <1258352362-11231-1-git-send-email-vivek.mahajan@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vivek Mahajan <vivek.mahajan@freescale.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Sun, Nov 15, 2009 at 10:19 PM, Vivek Mahajan
<vivek.mahajan@freescale.com> wrote:
> The following patch adds MSI support. Some platforms
> may have broken MSI, so those are defaulted to use
> legacy PCI interrupts.
>
> Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
> ---
> =C2=A0drivers/ata/sata_sil24.c | =C2=A0 =C2=A09 +++++++++
> =C2=A01 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index e6946fc..1370df6 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -417,6 +417,10 @@ static struct ata_port_operations sil24_ops =3D =
{
> =C2=A0#endif
> =C2=A0};
>
> +static int sata_sil24_msi; =C2=A0 =C2=A0/* Disable MSI */
> +module_param_named(msi, sata_sil24_msi, bool, S_IRUGO);
> +MODULE_PARM_DESC(msi, "Enable MSI (Default: false)");

Vivek,
Do we even still need the parameter? I'm thinking either MSI works
with a chipset
or it doesn't. The kernel has globals to "know" which state is true.

If the parameter is needed, when this driver is compiled into the kerne=
l, how
is "msi" parameter specified?
I think the parameter needs to be documented and fit in with other
"msi" parameters.
See "nomsi" in Documentation/kernel-parameters.txt.

If you want to keep this module parameter, can I suggest calling the
exported parameter "sata_sil24_msi"?

I'm not able to test this since the chipset I have sata_sil24 devices
plugged into don't support MSI (older AMD/Nvidia chipset). :(


> +
> =C2=A0/*
> =C2=A0* Use bits 30-31 of port_flags to encode available port numbers=
=2E
> =C2=A0* Current maxium is 4.
> @@ -1340,6 +1344,11 @@ static int sil24_init_one(struct pci_dev *pdev=
, const struct pci_device_id *ent)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sil24_init_controller(host);
>
> + =C2=A0 =C2=A0 =C2=A0 if (sata_sil24_msi && !!pci_msi_enable(pdev)) =
{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_printk(KERN_IN=
=46O, &pdev->dev, "Using MSI\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_intx(pdev, 0);

pci_intx() isn't documented in MSI-HOWTO.txt  - because it's already ca=
lled:
    pci_msi_enable() -> pci_msi_enable_block() -> msi_capability_init()
       -> pci_intx_for_msi(dev, 0) -> pci_intx(pdev, 0);

(thanks to willy (Mathew Wilcox) for pointing me at
msi_capability_init() - I overlooked it)

Please add "Reviewed-by: Grant Grundler <grundler@google.com>" once the
variable name is changed and the pci_intx() call is removed.

cheers,
grant

> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_set_master(pdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ata_host_activate(host, pdev->irq, =
sil24_interrupt, IRQF_SHARED,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &sil24_sht);
> --
> 1.5.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
