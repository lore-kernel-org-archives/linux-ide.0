From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 1/3] ahci: exynos: add ahci sata support on Exynos platform
Date: Fri, 11 Oct 2013 15:49:04 +0900
Message-ID: <000001cec64d$fa1cdca0$ee5695e0$%han@samsung.com>
References: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>
 <1380609183-21430-2-git-send-email-yuvaraj.cd@samsung.com>
 <1534631.KrL0vInDuc@amdc1032>
 <003f01cec099$4eb706b0$ec251410$%han@samsung.com>
 <CAKuRcOJi5C1C63Y41dSJ0-YsaTni1AL=d3qH2Cjz74C8ardEpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:40551 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab3JKGtH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Oct 2013 02:49:07 -0400
In-reply-to: <CAKuRcOJi5C1C63Y41dSJ0-YsaTni1AL=d3qH2Cjz74C8ardEpQ@mail.gmail.com>
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Yuvaraj Kumar' <yuvaraj.cd@gmail.com>
Cc: 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, tj@kernel.org, kgene.kim@samsung.com, 'Grant Likely' <grant.likely@linaro.org>, 'Rob Herring' <rob.herring@calxeda.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, kishon@ti.com, s.nawrocki@samsung.com, ks.giri@samsung.com, aditya.ps@samsung.com, 'Yuvaraj Kumar C D' <yuvaraj.cd@samsung.com>, rogerq@ti.com, 'Jingoo Han' <jg1.han@samsung.com>

On Tuesday, October 08, 2013 8:45 PM, Yuvaraj Kumar wrote:
> On Fri, Oct 4, 2013 at 6:03 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> > On Thursday, October 03, 2013 8:32 PM, Bartlomiej Zolnierkiewicz wrote:
> >> On Tuesday, October 01, 2013 12:03:01 PM Yuvaraj Kumar C D wrote:
> >> > Exynos5250 contains one Synopsys AHCI SATA controller.The avalaible
> >> > ahci_platform driver is not sufficient to handle the AHCI PHY and PHY
> >> > clock related initialization.
> >> >
> >> > This patch adds exynos specific ahci sata driver,contained the exynos
> >> > specific initialized codes, re-use the generic ahci_platform driver, and
> >> > keep the generic ahci_platform driver clean as much as possible.
> >> >
> >> > This patch depends on the below patch
> >> >     [1].drivers: phy: add generic PHY framework
> >> >             by Kishon Vijay Abraham I<kishon@ti.com>
> >> >
> >> > Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> >> > ---
> >> >  drivers/ata/Kconfig       |    9 ++
> >> >  drivers/ata/Makefile      |    1 +
> >> >  drivers/ata/ahci_exynos.c |  226 +++++++++++++++++++++++++++++++++++++++++++++
> >> >  3 files changed, 236 insertions(+)
> >> >  create mode 100644 drivers/ata/ahci_exynos.c
> >> >
> >
> >
> > [.....]
> >
> >> > +   priv->phy = devm_phy_get(dev , "sata-phy");
> >> > +   if (IS_ERR(priv->phy))
> >> > +           return PTR_ERR(priv->phy);
> >
> > [.....]
> >
> >> Also please take a look at the following patch:
> >>
> >> https://lkml.org/lkml/2013/9/19/173
> >>
> >> it adds PHY support to ahci_platform driver, maybe it can be used
> >> for your needs as well.
> >
> > I also agree with Bartlomiej Zolnierkiewicz's opinion.
> > 'ahci_exynos.c' just calls PHY API, without any additional control
> > for Exynos AHCI IP.
> In addition to PHY handling,it also deals with the special clock
> sclk_sata which is not dealt in ahci_platform.c(certainly exynos
> specific).

Handling the special clock 'sclk_sata' is another issue.
Please, look at that other 'sclk_*'s are handled.
Also, if possible, please add 'the code handling the special clock'
to 'ahci_platform.c'.

> 
> Morever there is a wrapper driver to handle the platform specific
> things for the sata.Please refer the  patch[1]
> [1]ata: ti_sata: Add Texas Instruments SATA Wrapper driver
> https://lkml.org/lkml/2013/9/19/166

As Roger Quadros mentioned, 'ti_sata' driver will be dropped.

> [2]ahci_imx: add ahci sata support on imx platforms
> 

'ahci_imx' is necessary, because 'ahci_imx' controls some
specific registers.

However, 'ahci_exynos.c' does not control any registers.

> I think, if we have platform specific driver like ahci_xxx.c , it
> would be better to handle the sata PHY in ahci_xxx.c so that we can
> retain and re-use the ahci_platform.c as it is.

I think that the platform specific driver like ahci_xxx.c is not
necessary, because 'ahci_exynos.c' does not control any special
registers.

Best regards,
Jingoo Han

> 
> Further comments will be much appreciated.
> 


