From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: [PATCH V2 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
Date: Fri, 8 Apr 2011 08:49:28 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE900D942F@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1300355883-28484-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1300355883-28484-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110408073625.GU7285@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:5621 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab1DHIuR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Apr 2011 04:50:17 -0400
In-Reply-To: <20110408073625.GU7285@pengutronix.de>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "eric.miao@linaro.org" <eric.miao@linaro.org>

Hi Sascha:
Thanks a lot for your comments.

please see my comments marked by [Richard]

Best Regards
Richard Zhu


> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
> Sent: Friday, April 08, 2011 3:36 PM
> To: Zhu Richard-R65037
> Cc: linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com;
> kernel@pengutronix.de; linux-ide@vger.kernel.org;
> avorontsov@ru.mvista.com; eric@eukrea.com; eric.miao@linaro.org
> Subject: Re: [PATCH V2 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
>
> On Thu, Mar 17, 2011 at 05:58:03PM +0800, Richard Zhu wrote:
> > Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> > ---
> >  arch/arm/mach-mx5/board-mx53_loco.c |   88
> +++++++++++++++++++++++++++++++++++
> >  1 files changed, 88 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-mx5/board-mx53_loco.c
> > b/arch/arm/mach-mx5/board-mx53_loco.c
> > index 0a18f8d..336273b 100644
> > --- a/arch/arm/mach-mx5/board-mx53_loco.c
> > +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> > @@ -23,11 +23,13 @@
> >  #include <linux/fec.h>
> >  #include <linux/delay.h>
> >  #include <linux/gpio.h>
> > +#include <linux/ahci_platform.h>
> >
> >  #include <mach/common.h>
> >  #include <mach/hardware.h>
> >  #include <mach/imx-uart.h>
> >  #include <mach/iomux-mx53.h>
> > +#include <mach/ahci_sata.h>
> >
> >  #include <asm/mach-types.h>
> >  #include <asm/mach/arch.h>
> > @@ -38,6 +40,8 @@
> >
> >  #define LOCO_FEC_PHY_RST           IMX_GPIO_NR(7, 6)
> >
> > +static struct clk *sata_clk, *sata_ref_clk;
> > +
> >  static iomux_v3_cfg_t mx53_loco_pads[] = {
> >     /* FEC */
> >     MX53_PAD_FEC_MDC__FEC_MDC,
> > @@ -203,6 +207,89 @@ static const struct imxi2c_platform_data
> mx53_loco_i2c_data __initconst = {
> >     .bitrate = 100000,
> >  };
> >
> > +/* HW Initialization, if return 0, initialization is successful. */
> > +static int sata_init(struct device *dev, void __iomem *addr) {
> > +   int ret = 0;
> > +   u32 tmpdata;
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
>
> When I read code like this I think that a devm_clk_get is overdue.
>
> Also, the ahci driver should handle the regular
[Richard]Sorry, I can't catch what's the exact means of this comment.

>
> > +
> > +   tmpdata = readl(addr + HOST_CAP);
> > +   if (!(tmpdata & HOST_CAP_SSS)) {
> > +           tmpdata |= HOST_CAP_SSS;
> > +           writel(tmpdata, addr + HOST_CAP);
> > +   }
>
> According to the AHCI spec this bit is read only.
>
> > +
> > +   if (!(readl(addr + HOST_PORTS_IMPL) & 0x1))
> > +           writel((readl(addr + HOST_PORTS_IMPL) | 0x1),
> > +                   addr + HOST_PORTS_IMPL);
>
> This is also readonly.
>
[Richard]:About the RO marked bits defined in the SPEC, there are used
 as R/W bits in MX53 AHCI implementation actually.
Here are the hack debug log:
----------Log--------------------
HOST_CAP: 0x6726ff80
HOST_CAP: 0x6f26ff80 <------------ After set the SSS bit.
HOST_PT_IMPL: 0x0
HOST_PT_IMPL: 0x1    <------------ After set the IMPL bit
ahci: SSS flag set, parallel bus scan disabled
ahci ahci.0: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl platform mode
ahci ahci.0: flags: ncq sntf stag pm led clo only pmp pio slum part ccc
scsi0 : ahci
ata1: SATA max UDMA/133 irq_stat 0x00000040, connection status changed irq 28
MXC MTD nand Driver 3.0
----------End--------------------
> > +
> > +   tmpdata = clk_get_rate(clk) / 1000;
> > +   clk_put(clk);
> > +   writel(tmpdata, addr + HOST_TIMER1MS);
>
> This should be in a more generic place as it needs to be done for every
> board. We can put this into some i.MX53 startup function.
>
[Richard]How about put these codes into one standalone file in .../arch/arm/plat-mxc/ folder,
 and export the sata_init and sata_exit out for kinds of MX53 boards?

>
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> |


