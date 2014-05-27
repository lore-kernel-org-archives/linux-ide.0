From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] ahci: imx: Fix imx_ahci_resume()
Date: Tue, 27 May 2014 11:08:32 +0200
Message-ID: <1799210.gNXzq58kHr@amdc1032>
References: <1401132577-24999-1-git-send-email-fabio.estevam@freescale.com>
 <20140527082019.GB8860@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60871 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbaE0JIy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 May 2014 05:08:54 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N680032K6QS0J40@mailout2.samsung.com> for
 linux-ide@vger.kernel.org; Tue, 27 May 2014 18:08:52 +0900 (KST)
In-reply-to: <20140527082019.GB8860@dragon>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, tj@kernel.org, linux-ide@vger.kernel.org, festevam@gmail.com


Hi,

On Tuesday, May 27, 2014 04:20:20 PM Shawn Guo wrote:
> On Mon, May 26, 2014 at 04:29:37PM -0300, Fabio Estevam wrote:
> > The following warning is seen after suspend/resume sequence:
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 661 at drivers/ata/libahci.c:224 ahci_enable_ahci+0x74/0x8)
> > Modules linked in:
> > CPU: 0 PID: 661 Comm: sh Tainted: G        W     3.15.0-rc5-next-20140521-000027
> > Backtrace:
> > [<80011c90>] (dump_backtrace) from [<80011e2c>] (show_stack+0x18/0x1c)
> >  r6:803a22f4 r5:00000000 r4:00000000 r3:00000000
> > [<80011e14>] (show_stack) from [<80661e60>] (dump_stack+0x88/0xa4)
> > [<80661dd8>] (dump_stack) from [<80028fdc>] (warn_slowpath_common+0x70/0x94)
> >  r5:00000009 r4:00000000
> > [<80028f6c>] (warn_slowpath_common) from [<80029024>] (warn_slowpath_null+0x24/)
> >  r8:808f68c4 r7:00000000 r6:00000000 r5:00000000 r4:e0810004
> > [<80029000>] (warn_slowpath_null) from [<803a22f4>] (ahci_enable_ahci+0x74/0x80)
> > [<803a2280>] (ahci_enable_ahci) from [<803a2324>] (ahci_reset_controller+0x24/0)
> >  r8:ddcd9410 r7:80351178 r6:ddcd9444 r5:dde8b850 r4:e0810000 r3:ddf35e90
> > [<803a2300>] (ahci_reset_controller) from [<803a2c68>] (ahci_platform_resume_ho)
> >  r7:80351178 r6:ddcd9444 r5:dde8b850 r4:ddcd9410
> > [<803a2c30>] (ahci_platform_resume_host) from [<803a38f0>] (imx_ahci_resume+0x2)
> >  r5:00000000 r4:ddcd9410
> > [<803a38c4>] (imx_ahci_resume) from [<803511ac>] (platform_pm_resume+0x34/0x54)
> > ....
> > 
> > Add the missing ahci_platform_resume_host() call in order to fix the resume
> > of the driver.
> 
> As Bartlomiej already pointed out, you must mean
> ahci_platform_enable_resources() here.  Even with it, I'm not sure this
> is correct.  Calling ahci_platform_enable_resources() in .resume hook
> only makes sense in case that ahci_platform_disable_resources() is being
> called in .suspend hook.

Indeed.

> All ahci_platform_enable[disable]_resources() do is handling resources
> phy, clock and regulator, which should have been managed by
> imx_sata_enable[disable]() in imx case.

It is related to imxpriv->no_device handling (or rather lack of it) in
->suspend and ->resume.
 
> > Tested on imx6q-sabresd and imx53-qsb boards.
> 
> I'm still wondering why I cannot reproduce the issue on my imx6q-sabresd
> board.

Have you tried booting with no devices attached (like suggested by
Fabio) and then doing suspend/resume cycle?

ahci_imx_error_handler() calls imx_sata_disable(hpriv) and then sets
imxpriv->no_device to true.  Later during ->resume imx_sata_enable()
returns early (due to ->no_device flag being set) but still gives
zero as a return value.  Then ahci_platform_resume_host() tries to
enable AHCI host (please note that the device was previously disabled
by imx_sata_disable()) and fails on attempt to access the hardware
(this is what triggers WARN_ON in ahci_enable_ahci()).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Shawn
> 
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> >  drivers/ata/ahci_imx.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> > index 8befeb6..1941896 100644
> > --- a/drivers/ata/ahci_imx.c
> > +++ b/drivers/ata/ahci_imx.c
> > @@ -468,11 +468,25 @@ static int imx_ahci_resume(struct device *dev)
> >  	struct ahci_host_priv *hpriv = host->private_data;
> >  	int ret;
> >  
> > -	ret = imx_sata_enable(hpriv);
> > +	ret = ahci_platform_enable_resources(hpriv);
> >  	if (ret)
> >  		return ret;
> >  
> > -	return ahci_platform_resume_host(dev);
> > +	ret = imx_sata_enable(hpriv);
> > +	if (ret)
> > +		goto disable_resources;
> > +
> > +	ret = ahci_platform_resume_host(dev);
> > +	if (ret)
> > +		goto disable_sata;
> > +
> > +	return 0;
> > +
> > +disable_sata:
> > +	imx_sata_disable(hpriv);
> > +disable_resources:
> > +	ahci_platform_disable_resources(hpriv);
> > +	return ret;
> >  }
> >  #endif

