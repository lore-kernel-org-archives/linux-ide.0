From: Eric Miao <eric.miao@linaro.org>
Subject: Re: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
 different features
Date: Mon, 29 Aug 2011 17:54:23 +0800
Message-ID: <CAMPhdO8k-boE0p0J_60VrS3LBdNaJRfJ6z_HCHLiRbQtESOJFw@mail.gmail.com>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
 <1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
 <20110829083649.GB24524@pengutronix.de> <CAMPhdO-vuExLKVSmsr_kR1HnHfEBPp_Ae7pgs=XaVYiKGFRo-A@mail.gmail.com>
 <20110829093746.GE24524@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51133 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab1H2Jyo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2011 05:54:44 -0400
Received: by vxi9 with SMTP id 9so4093797vxi.19
        for <linux-ide@vger.kernel.org>; Mon, 29 Aug 2011 02:54:43 -0700 (PDT)
In-Reply-To: <20110829093746.GE24524@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: eric@eukrea.com, linux-ide@vger.kernel.org, Richard Zhu <richard.zhu@linaro.org>, kernel@pengutronix.de, avorontsov@ru.mvista.com, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org

On Mon, Aug 29, 2011 at 5:37 PM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
> On Mon, Aug 29, 2011 at 04:51:46PM +0800, Eric Miao wrote:
>> On Mon, Aug 29, 2011 at 4:36 PM, Wolfram Sang <w.sang@pengutronix.de=
> wrote:
>> > On Mon, Aug 29, 2011 at 03:18:55PM +0800, Richard Zhu wrote:
>> >> On imx53 AHCI, soft reset fails with IPMS set when PMP
>> >> is enabled but SATA HDD/ODD is connected to SATA port,
>> >> do soft reset again to port 0.
>> >> So the 'ahci_pmp_retry_srst_ops' is required when imx53
>> >> ahci is present.
>> >>
>> >> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
>> >> ---
>> >> =C2=A0drivers/ata/ahci_platform.c | =C2=A0 44 +++++++++++++++++++=
++++++++++++++++++-----
>> >> =C2=A01 files changed, 38 insertions(+), 6 deletions(-)
>> >>
>> >> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platf=
orm.c
>> >> index 6fef1fa..f32c91e 100644
>> >> --- a/drivers/ata/ahci_platform.c
>> >> +++ b/drivers/ata/ahci_platform.c
>> >> @@ -23,6 +23,41 @@
>> >> =C2=A0#include <linux/ahci_platform.h>
>> >> =C2=A0#include "ahci.h"
>> >>
>> >> +enum ahci_type {
>> >> + =C2=A0 =C2=A0 AHCI, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* stand=
ard platform ahci */
>> >> + =C2=A0 =C2=A0 IMX53_AHCI, =C2=A0 =C2=A0 /* ahci on i.mx53 */
>> >
>> > How about making all the IMX*-naming more generic because other So=
C might need
>> > this somewhen, too?
>>
>> From a practical point of view, we can start with what we know alrea=
dy.
>> As the SATA controller on "other SoC" so far, we don't know yet if t=
hey
>> show the same issue (which we have to use ahci_pmp_retry_srst_ops).
>>
>> So Wolfram, how about we consider a generic one once more controller=
s
>> are being added?
>
> If we do so later, and we then also change the platform_device_id to =
something
> generic, we then also have to change all users, too. Is it so bad to =
change
> IMX53_AHCI (and imx53-ahci and alike) to something like "ahci-pmp-ret=
ry-srst"
> (or similar) now?

There are other fields in ata_port_info which might be different betwee=
n
boards. Using a SoC specific name as an index to an array of ata_port_i=
nfo
will be more flexible, as is adopted in drivers/ata/ahci.c - the PCI dr=
iver.
