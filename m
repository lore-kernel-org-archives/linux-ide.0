From: Eric Miao <eric.miao@linaro.org>
Subject: Re: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
 different features
Date: Mon, 29 Aug 2011 16:51:46 +0800
Message-ID: <CAMPhdO-vuExLKVSmsr_kR1HnHfEBPp_Ae7pgs=XaVYiKGFRo-A@mail.gmail.com>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
 <1314602339-18392-2-git-send-email-richard.zhu@linaro.org> <20110829083649.GB24524@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56540 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340Ab1H2IwI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2011 04:52:08 -0400
Received: by qwk3 with SMTP id 3so3150549qwk.19
        for <linux-ide@vger.kernel.org>; Mon, 29 Aug 2011 01:52:07 -0700 (PDT)
In-Reply-To: <20110829083649.GB24524@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Richard Zhu <richard.zhu@linaro.org>, eric@eukrea.com, linux-ide@vger.kernel.org, kernel@pengutronix.de, avorontsov@ru.mvista.com, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org

On Mon, Aug 29, 2011 at 4:36 PM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
> On Mon, Aug 29, 2011 at 03:18:55PM +0800, Richard Zhu wrote:
>> On imx53 AHCI, soft reset fails with IPMS set when PMP
>> is enabled but SATA HDD/ODD is connected to SATA port,
>> do soft reset again to port 0.
>> So the 'ahci_pmp_retry_srst_ops' is required when imx53
>> ahci is present.
>>
>> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
>> ---
>> =C2=A0drivers/ata/ahci_platform.c | =C2=A0 44 ++++++++++++++++++++++=
+++++++++++++++-----
>> =C2=A01 files changed, 38 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform=
=2Ec
>> index 6fef1fa..f32c91e 100644
>> --- a/drivers/ata/ahci_platform.c
>> +++ b/drivers/ata/ahci_platform.c
>> @@ -23,6 +23,41 @@
>> =C2=A0#include <linux/ahci_platform.h>
>> =C2=A0#include "ahci.h"
>>
>> +enum ahci_type {
>> + =C2=A0 =C2=A0 AHCI, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* standard=
 platform ahci */
>> + =C2=A0 =C2=A0 IMX53_AHCI, =C2=A0 =C2=A0 /* ahci on i.mx53 */
>
> How about making all the IMX*-naming more generic because other SoC m=
ight need
> this somewhen, too?

=46rom a practical point of view, we can start with what we know alread=
y.
As the SATA controller on "other SoC" so far, we don't know yet if they
show the same issue (which we have to use ahci_pmp_retry_srst_ops).

So Wolfram, how about we consider a generic one once more controllers
are being added?

>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Wolfram Sang =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
