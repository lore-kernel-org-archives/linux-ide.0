From: Richard Zhu <richard.zhu@linaro.org>
Subject: Re: [PATCH V6 3/5] MX53 Enable the AHCI SATA on MX53 ARD board
Date: Mon, 29 Aug 2011 17:16:54 +0800
Message-ID: <CAJNCFVJySmnVXahb0PGBwmLQQwwqB55_rR4mdhyJ6q5nCTGqJA@mail.gmail.com>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
	<1314602339-18392-3-git-send-email-richard.zhu@linaro.org>
	<CAMPhdO944uQtpBfq12h1yHeXNzkTFiscPfZ6PbuMy6g2u0SDOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65257 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab1H2JQ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2011 05:16:57 -0400
Received: by gxk21 with SMTP id 21so4622989gxk.19
        for <linux-ide@vger.kernel.org>; Mon, 29 Aug 2011 02:16:56 -0700 (PDT)
In-Reply-To: <CAMPhdO944uQtpBfq12h1yHeXNzkTFiscPfZ6PbuMy6g2u0SDOw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eric Miao <eric.miao@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-ide@vger.kernel.org, eric@eukrea.com, avorontsov@ru.mvista.com, jgarzik@pobox.com

Hi Eric:
I agree with your suggestion.
One more exception about ahci on imx53 smd board.
one sata_pwr_en is used to control the pwr supply on smd board.
It's better to enable this pwer_en obviously although that this pin is
enabled reserved.

the ahci driver use the default sata platform data on ard and loco boar=
ds, and
 the smd platform data on smd board refer to the sata_pwr_en usage.

Best Regards
Richard Zhu

On 29 August 2011 16:47, Eric Miao <eric.miao@linaro.org> wrote:
> On Mon, Aug 29, 2011 at 3:18 PM, Richard Zhu <richard.zhu@linaro.org>=
 wrote:
>> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
>> ---
>> =A0arch/arm/mach-mx5/board-mx53_ard.c | =A0 =A07 +++++++
>> =A01 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/=
board-mx53_ard.c
>> index 76a67c4..d265cee 100644
>> --- a/arch/arm/mach-mx5/board-mx53_ard.c
>> +++ b/arch/arm/mach-mx5/board-mx53_ard.c
>> @@ -27,6 +27,7 @@
>> =A0#include <mach/common.h>
>> =A0#include <mach/hardware.h>
>> =A0#include <mach/iomux-mx53.h>
>> +#include <mach/ahci_sata.h>
>>
>> =A0#include <asm/mach-types.h>
>> =A0#include <asm/mach/arch.h>
>> @@ -220,6 +221,11 @@ static struct platform_device *devices[] __init=
data =3D {
>> =A0 =A0 =A0 =A0&ard_smsc_lan9220_device,
>> =A0};
>>
>> +static struct ahci_platform_data sata_data =3D {
>> + =A0 =A0 =A0 .init =3D sata_init,
>> + =A0 =A0 =A0 .exit =3D sata_exit,
>> +};
>> +
>
> As this platform data is same across most of these boards, I'd sugges=
t we
> keep a common/default platform_data in
>
> arch/arm/plat-mxc/devices/platform-imx-ahci.c
>
> And pass NULL in these board files, making use of the above default o=
ne.
> For those boards with exceptions (e.g. special operations like GPIO t=
o
> enable/disable something at init/exit), one can still have platform d=
ata
> and pass the pointer.
>
>> =A0static void __init mx53_ard_board_init(void)
>> =A0{
>> =A0 =A0 =A0 =A0imx53_soc_init();
>> @@ -234,6 +240,7 @@ static void __init mx53_ard_board_init(void)
>> =A0 =A0 =A0 =A0imx53_add_imx_i2c(1, &mx53_ard_i2c2_data);
>> =A0 =A0 =A0 =A0imx53_add_imx_i2c(2, &mx53_ard_i2c3_data);
>> =A0 =A0 =A0 =A0imx_add_gpio_keys(&ard_button_data);
>> + =A0 =A0 =A0 imx53_add_ahci_imx(0, &sata_data);
>> =A0}
>>
>> =A0static void __init mx53_ard_timer_init(void)
>> --
>> 1.7.1
>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
