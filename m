From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: [PATCH V4 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
Date: Wed, 13 Apr 2011 03:06:58 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE900D9E8E@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1302587472-20435-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1302587472-20435-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <4DA43740.9050806@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:25047
	"EHLO VA3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756389Ab1DMDHB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Apr 2011 23:07:01 -0400
In-Reply-To: <4DA43740.9050806@ru.mvista.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "eric.miao@linaro.org" <eric.miao@linaro.org>

Hi Sergei:
Got that. Thanks for your kindly comments.
Would change them later.

Best Regards
Richard Zhu


> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
> Sent: Tuesday, April 12, 2011 7:28 PM
> To: Zhu Richard-R65037
> Cc: linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com;
> kernel@pengutronix.de; linux-ide@vger.kernel.org;
> avorontsov@ru.mvista.com; eric@eukrea.com; eric.miao@linaro.org
> Subject: Re: [PATCH V4 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
>
> Hello.
>
> On 12-04-2011 9:51, Richard Zhu wrote:
>
> > Signed-off-by: Richard Zhu<Hong-Xing.Zhu@freescale.com>
> > ---
> >   arch/arm/mach-mx5/board-mx53_loco.c |   76
> +++++++++++++++++++++++++++++++++++
> >   1 files changed, 76 insertions(+), 0 deletions(-)
>
> > diff --git a/arch/arm/mach-mx5/board-mx53_loco.c
> > b/arch/arm/mach-mx5/board-mx53_loco.c
> > index 0a18f8d..644aaa2 100644
> > --- a/arch/arm/mach-mx5/board-mx53_loco.c
> > +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> [...]
> > @@ -203,6 +206,78 @@ static const struct imxi2c_platform_data
> mx53_loco_i2c_data __initconst = {
> >     .bitrate = 100000,
> >   };
> >
> > +/* HW Initialization, if return 0, initialization is successful. */
> > +static int mx53_loco_sata_init(struct device *dev, void __iomem
> > +*addr) {
> > +   u32 tmpdata;
> > +   int ret = 0;
> > +   struct clk *clk;
> > +
> > +   sata_clk = clk_get(dev, NULL);
> > +   if (IS_ERR(sata_clk)) {
> > +           dev_err(dev, "no sata clock.\n");
> > +           return PTR_ERR(sata_clk);
> > +   }
> > +   ret = clk_enable(sata_clk);
> > +   if (ret) {
> > +           dev_err(dev, "can't enable sata clock.\n");
> > +           clk_put(sata_clk);
>
>     Why duplicate clk_put() which you already have at the end of function?
> Just define another label there.
>
> > +           return ret;
> > +   }
> > +
> > +   /* FSL IMX AHCI SATA uses the internal usb phy1 clk on loco */
> > +   sata_ref_clk = clk_get(NULL, "usb_phy1");
> > +   if (IS_ERR(sata_ref_clk)) {
> > +           dev_err(dev, "no sata ref clock.\n");
> > +           ret = PTR_ERR(sata_ref_clk);
> > +           goto release_sata_clk;
> > +   }
> > +   ret = clk_enable(sata_ref_clk);
> > +   if (ret) {
> > +           dev_err(dev, "can't enable sata ref clock.\n");
> > +           clk_put(sata_ref_clk);
>
>     Same question.
>
> > +           goto release_sata_clk;
> > +   }
> > +
> > +   /* Get the AHB clock rate, and configure the TIMER1MS reg later */
> > +   clk = clk_get(NULL, "ahb");
> > +   if (IS_ERR(clk)) {
> > +           dev_err(dev, "no ahb clock.\n");
> > +           ret = PTR_ERR(clk);
> > +           goto release_sata_ref_clk;
> > +   }
> > +   tmpdata = clk_get_rate(clk) / 1000;
> > +   clk_put(clk);
> > +
> > +   sata_init(addr, tmpdata);
> > +
> > +   return ret;
> > +
> > +release_sata_ref_clk:
> > +   clk_disable(sata_ref_clk);
> > +   clk_put(sata_ref_clk);
> > +
> > +release_sata_clk:
> > +   clk_disable(sata_clk);
> > +   clk_put(sata_clk);
> > +
> > +   return ret;
> > +}
>
> WBR, Sergei


