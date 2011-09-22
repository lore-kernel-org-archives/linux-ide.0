From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [V8 PATCH 5/5] MX53 Enable the AHCI SATA on MX53 SMD board
Date: Thu, 22 Sep 2011 07:36:41 -0300
Message-ID: <CAOMZO5CRB_tXYw1-B+LPKPAaEdTaMUbG2zT3m+UF3vp_6m+2=g@mail.gmail.com>
References: <1316686488-4684-1-git-send-email-richard.zhu@linaro.org>
	<1316686488-4684-6-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:61495 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab1IVKgm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2011 06:36:42 -0400
Received: by gwj16 with SMTP id 16so1513928gwj.1
        for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2011 03:36:41 -0700 (PDT)
In-Reply-To: <1316686488-4684-6-git-send-email-richard.zhu@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, eric.miao@linaro.org, linux-ide@vger.kernel.org, eric@eukrea.com, avorontsov@ru.mvista.com, jgarzik@pobox.com

On Thu, Sep 22, 2011 at 7:14 AM, Richard Zhu <richard.zhu@linaro.org> w=
rote:
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> ---
> =C2=A0arch/arm/mach-mx5/board-mx53_smd.c | =C2=A0 16 ++++++++++++++++
> =C2=A01 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/b=
oard-mx53_smd.c
> index bc02894..9d06fbe 100644
> --- a/arch/arm/mach-mx5/board-mx53_smd.c
> +++ b/arch/arm/mach-mx5/board-mx53_smd.c
> @@ -35,6 +35,7 @@
> =C2=A0#include "devices-imx53.h"
>
> =C2=A0#define SMD_FEC_PHY_RST =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0IMX_GPIO_NR(7, 6)
> +#define MX53_SMD_SATA_PWR_EN =C2=A0 =C2=A0IMX_GPIO_NR(3, 3)
>
> =C2=A0static iomux_v3_cfg_t mx53_smd_pads[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
> @@ -111,6 +112,19 @@ static const struct imxi2c_platform_data mx53_sm=
d_i2c_data __initconst =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.bitrate =3D 100000,
> =C2=A0};
>
> +static inline void mx53_smd_ahci_pwr_on(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Enable SATA PWR */
> + =C2=A0 =C2=A0 =C2=A0 ret =3D gpio_request(MX53_SMD_SATA_PWR_EN, "ah=
ci-sata-pwr");

Please use gpio_request_one.

> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "f=
ailed to get SATA_PWR_EN: %d\n", ret);

You can use pr_err instead.

Regards,

=46abio Estevam
