From: Eric Miao <eric.miao@linaro.org>
Subject: Re: [PATCH V7 2/5] ahci_plt Add the board_ids and pi refer to
 different features
Date: Wed, 31 Aug 2011 16:28:58 +0800
Message-ID: <CAMPhdO9Tvp9HeXYe=C8hHavAKSm2wO7ObKbv5n9PTeC4gQPJBg@mail.gmail.com>
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org> <1314762635-3923-3-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47467 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab1HaI3T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2011 04:29:19 -0400
Received: by vxi9 with SMTP id 9so252247vxi.19
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2011 01:29:18 -0700 (PDT)
In-Reply-To: <1314762635-3923-3-git-send-email-richard.zhu@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-ide@vger.kernel.org, eric@eukrea.com, avorontsov@ru.mvista.com, jgarzik@pobox.com

On Wed, Aug 31, 2011 at 11:50 AM, Richard Zhu <richard.zhu@linaro.org> =
wrote:
> On imx53 AHCI, soft reset fails with IPMS set when PMP
> is enabled but SATA HDD/ODD is connected to SATA port,
> do soft reset again to port 0.
> So the 'ahci_pmp_retry_srst_ops' is required when imx53
> ahci is present.
>
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> Acked-by: Eric Miao <eric.miao@linaro.org>
> ---
> =C2=A0drivers/ata/ahci_platform.c | =C2=A0 44 +++++++++++++++++++++++=
++++++++++++++-----
> =C2=A01 files changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.=
c
> index 6fef1fa..c03277d 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -23,6 +23,41 @@
> =C2=A0#include <linux/ahci_platform.h>
> =C2=A0#include "ahci.h"
>
> +enum ahci_type {
> + =C2=A0 =C2=A0 =C2=A0 AHCI, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* st=
andard platform ahci */
> + =C2=A0 =C2=A0 =C2=A0 IMX53_AHCI, =C2=A0 =C2=A0 /* ahci on i.mx53 */
> +};
> +
> +static struct platform_device_id ahci_devtype[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D "ahci",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .driver_data =3D A=
HCI,
> + =C2=A0 =C2=A0 =C2=A0 }, {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D "imx53-a=
hci",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .driver_data =3D I=
MX53_AHCI,
> + =C2=A0 =C2=A0 =C2=A0 }, {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* sentinel */
> + =C2=A0 =C2=A0 =C2=A0 }
> +};
> +MODULE_DEVICE_TABLE(platform, ahci_devtype);
> +

I still prefer this way as this is most flexible. We'll see how we can =
better
organize this along with newly added ahci controllers.

Jeff,

Can you take this patch through? Or if you are good with this, we can
also push this one along with the other  patches to go through sascha's
imx tree.

> +
> +static const struct ata_port_info ahci_port_info[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 /* by features */
> + =C2=A0 =C2=A0 =C2=A0 [AHCI] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D AHCI_FLAG_COMMON,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pio_mask =C2=A0 =C2=
=A0 =C2=A0 =3D ATA_PIO4,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .udma_mask =C2=A0 =
=C2=A0 =C2=A0=3D ATA_UDMA6,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .port_ops =C2=A0 =C2=
=A0 =C2=A0 =3D &ahci_ops,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 [IMX53_AHCI] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D AHCI_FLAG_COMMON,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pio_mask =C2=A0 =C2=
=A0 =C2=A0 =3D ATA_PIO4,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .udma_mask =C2=A0 =
=C2=A0 =C2=A0=3D ATA_UDMA6,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .port_ops =C2=A0 =C2=
=A0 =C2=A0 =3D &ahci_pmp_retry_srst_ops,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> =C2=A0static struct scsi_host_template ahci_platform_sht =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0AHCI_SHT("ahci_platform"),
> =C2=A0};
> @@ -31,12 +66,8 @@ static int __init ahci_probe(struct platform_devic=
e *pdev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &pdev->dev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ahci_platform_data *pdata =3D dev->=
platform_data;
> - =C2=A0 =C2=A0 =C2=A0 struct ata_port_info pi =3D {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D AHCI_FLAG_COMMON,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pio_mask =C2=A0 =C2=
=A0 =C2=A0 =3D ATA_PIO4,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .udma_mask =C2=A0 =
=C2=A0 =C2=A0=3D ATA_UDMA6,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .port_ops =C2=A0 =C2=
=A0 =C2=A0 =3D &ahci_ops,
> - =C2=A0 =C2=A0 =C2=A0 };
> + =C2=A0 =C2=A0 =C2=A0 const struct platform_device_id *id =3D platfo=
rm_get_device_id(pdev);
> + =C2=A0 =C2=A0 =C2=A0 struct ata_port_info pi =3D ahci_port_info[id-=
>driver_data];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct ata_port_info *ppi[] =3D { &p=
i, NULL };
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ahci_host_priv *hpriv;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ata_host *host;
> @@ -177,6 +208,7 @@ static struct platform_driver ahci_driver =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D "ahc=
i",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =3D THI=
S_MODULE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> + =C2=A0 =C2=A0 =C2=A0 .id_table =C2=A0 =C2=A0 =C2=A0 =3D ahci_devtyp=
e,
> =C2=A0};
>
> =C2=A0static int __init ahci_init(void)
> --
> 1.7.1
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
