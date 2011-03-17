From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: [PATCH V1 1/3] ahci_platform: add two clk pointer member into
 ahci_platform_data struct
Date: Thu, 17 Mar 2011 09:48:28 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE900D26FD@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1300345860-16574-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110317083724.GV29521@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:3840 "EHLO
	VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab1CQJsf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Mar 2011 05:48:35 -0400
In-Reply-To: <20110317083724.GV29521@pengutronix.de>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "eric.miao@linaro.org" <eric.miao@linaro.org>

Hi Sascha:
Thanks for your comments.

Best Regards
Richard Zhu


> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
> Sent: Thursday, March 17, 2011 4:37 PM
> To: Zhu Richard-R65037
> Cc: linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com;
> kernel@pengutronix.de; linux-ide@vger.kernel.org;
> avorontsov@ru.mvista.com; eric@eukrea.com; eric.miao@linaro.org
> Subject: Re: [PATCH V1 1/3] ahci_platform: add two clk pointer member
> into ahci_platform_data struct
>
> On Thu, Mar 17, 2011 at 03:10:58PM +0800, Richard Zhu wrote:
> > Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> > ---
> >  include/linux/ahci_platform.h |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/linux/ahci_platform.h
> > b/include/linux/ahci_platform.h index be3d9a7..86b5e24 100644
> > --- a/include/linux/ahci_platform.h
> > +++ b/include/linux/ahci_platform.h
> > @@ -26,6 +26,8 @@ struct ahci_platform_data {
> >     const struct ata_port_info *ata_port_info;
> >     unsigned int force_port_map;
> >     unsigned int mask_port_map;
> > +   struct clk *sata_clk;
> > +   struct clk *sata_ref_clk;
>
> No, ahci_platform_data shouldn't be the dump place for arbitrary board
> data. Keep this to your board.
Accepted, these modifications would be discarded.
>
> Sascha
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


