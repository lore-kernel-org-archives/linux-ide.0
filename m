From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [v1 2/3] ata: ahci_platform: enable imx6q ahci sata support
Date: Tue, 18 Jun 2013 02:19:52 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D303700@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1371462767-16630-1-git-send-email-r65037@freescale.com>
 <1371462767-16630-3-git-send-email-r65037@freescale.com>,<20130618020153.GB28381@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:39458
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752616Ab3FRCT5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jun 2013 22:19:57 -0400
In-Reply-To: <20130618020153.GB28381@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

Hi Tejun&Shawn:
Thanks for your comments.

Hi Tejun:
I looked through the for-next branch of the libata git-repo, there mayb=
e a merge conflict.
"
static const struct of_device_id ahci_of_match[] =3D {=20
        { .compatible =3D "snps,spear-ahci", },
        { .compatible =3D "snps,exynos5440-ahci", },
        {},=20
};
MODULE_DEVICE_TABLE(of, ahci_of_match);
"

How about to re-change the patch, based on for-next branch of the libat=
a git-repo.

Hi Shawn:
About the one similar IP, multiple platform specific strings inventions=
=2E
Waiting for DT's people=92s opinion.


Best Regards
Richard Zhu
________________________________________
=46rom: Shawn Guo [shawn.guo@linaro.org]
Sent: Tuesday, June 18, 2013 10:01 AM
To: Richard Zhu
Cc: linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com; linux-ide@=
vger.kernel.org; Zhu Richard-R65037; devicetree-discuss@lists.ozlabs.or=
g
Subject: Re: [v1 2/3] ata: ahci_platform: enable imx6q ahci sata suppor=
t

On Mon, Jun 17, 2013 at 05:52:46PM +0800, Richard Zhu wrote:
> imx6q contains the Synopsys AHCI SATA controller which shares
> ahci_platform driver with other controllers.
>
> This patch updates the DT compatible list for ahci_platform,
> and enable the imx6q ahci sata support.
>
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  drivers/ata/ahci_platform.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.=
c
> index 7a8a284..61f2142 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -327,6 +327,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspen=
d, ahci_resume);
>
>  static const struct of_device_id ahci_of_match[] =3D {
>       { .compatible =3D "snps,spear-ahci", },
> +     { .compatible =3D "snps,imx-ahci", },

I'm not sure it makes much sense to invent multiple platform specific
strings for an IP which is completely compatible between them.
Why don't we just have a generic compatible string like "snps,ahci"
for all those compatible platforms, and only add platform specific
string when there is incompatibility on particular platform to deal
with?

Added devicetree-discuss to get DT people's opinion.

Shawn

>       {},
>  };
>  MODULE_DEVICE_TABLE(of, ahci_of_match);
> --
> 1.7.5.4
>

