From: Eric Miao <eric.miao@linaro.org>
Subject: Re: [PATCH V6 3/5] MX53 Enable the AHCI SATA on MX53 ARD board
Date: Mon, 29 Aug 2011 16:47:08 +0800
Message-ID: <CAMPhdO944uQtpBfq12h1yHeXNzkTFiscPfZ6PbuMy6g2u0SDOw@mail.gmail.com>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org> <1314602339-18392-3-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62173 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab1H2Ir2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2011 04:47:28 -0400
Received: by qwk3 with SMTP id 3so3148538qwk.19
        for <linux-ide@vger.kernel.org>; Mon, 29 Aug 2011 01:47:28 -0700 (PDT)
In-Reply-To: <1314602339-18392-3-git-send-email-richard.zhu@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-ide@vger.kernel.org, eric@eukrea.com, avorontsov@ru.mvista.com, jgarzik@pobox.com

On Mon, Aug 29, 2011 at 3:18 PM, Richard Zhu <richard.zhu@linaro.org> w=
rote:
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> ---
> =C2=A0arch/arm/mach-mx5/board-mx53_ard.c | =C2=A0 =C2=A07 +++++++
> =C2=A01 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/b=
oard-mx53_ard.c
> index 76a67c4..d265cee 100644
> --- a/arch/arm/mach-mx5/board-mx53_ard.c
> +++ b/arch/arm/mach-mx5/board-mx53_ard.c
> @@ -27,6 +27,7 @@
> =C2=A0#include <mach/common.h>
> =C2=A0#include <mach/hardware.h>
> =C2=A0#include <mach/iomux-mx53.h>
> +#include <mach/ahci_sata.h>
>
> =C2=A0#include <asm/mach-types.h>
> =C2=A0#include <asm/mach/arch.h>
> @@ -220,6 +221,11 @@ static struct platform_device *devices[] __initd=
ata =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&ard_smsc_lan9220_device,
> =C2=A0};
>
> +static struct ahci_platform_data sata_data =3D {
> + =C2=A0 =C2=A0 =C2=A0 .init =3D sata_init,
> + =C2=A0 =C2=A0 =C2=A0 .exit =3D sata_exit,
> +};
> +

As this platform data is same across most of these boards, I'd suggest =
we
keep a common/default platform_data in

arch/arm/plat-mxc/devices/platform-imx-ahci.c

And pass NULL in these board files, making use of the above default one=
=2E
=46or those boards with exceptions (e.g. special operations like GPIO t=
o
enable/disable something at init/exit), one can still have platform dat=
a
and pass the pointer.

> =C2=A0static void __init mx53_ard_board_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0imx53_soc_init();
> @@ -234,6 +240,7 @@ static void __init mx53_ard_board_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0imx53_add_imx_i2c(1, &mx53_ard_i2c2_data);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0imx53_add_imx_i2c(2, &mx53_ard_i2c3_data);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0imx_add_gpio_keys(&ard_button_data);
> + =C2=A0 =C2=A0 =C2=A0 imx53_add_ahci_imx(0, &sata_data);
> =C2=A0}
>
> =C2=A0static void __init mx53_ard_timer_init(void)
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
