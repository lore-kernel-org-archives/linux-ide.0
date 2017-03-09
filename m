From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Thu, 09 Mar 2017 13:21:22 +0100
Message-ID: <20128022.ebp5ZnzlHx@amdc3058>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <a3161cfc-56f7-4577-c37f-3798cdb03713@ti.com>
 <ab44a3c1-f078-4476-4583-de92ee68632c@cogentembedded.com>
 <CGME20170309122125epcas5p415b1f2266f68d5b999d2eb4ced94e9f3@epcas5p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56192 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932065AbdCIMVe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Mar 2017 07:21:34 -0500
In-reply-to: <ab44a3c1-f078-4476-4583-de92ee68632c@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>


Hi,

On Thursday, March 09, 2017 12:25:47 PM Sergei Shtylyov wrote:
> Hello!
> 
> On 3/9/2017 11:39 AM, Sekhar Nori wrote:
> 
> >>> It took a while to get to it but here is the draft driver patch
> >>> against v4.11-rc1.  Please test.
> >>
> >> I tested this on DM6446 EVM. I was able to mount existing partitions on
> >> the hard disk and see that the directory listing looks good[1]. I will do
> >> more tests (including comparing performance with old driver) tomorrow. I
> >
> > I completed the tests I wanted to, including some read/write/data
> > integrity tests. Performance is same as before too.
> >
> > Tested-by: Sekhar Nori <nsekhar@ti.com>
> >
> > Here are the additional changes I did. These changes do not clash with
> > what I have already queued for v4.12. That said, its probably better if
> > I carry the platform pieces through my tree. Let me know how you want
> > to proceed.
> >
> > Thanks,
> > Sekhar
> >
> > ---8<---
> > diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
> > index b9a7cb98ffda..67db82999c06 100644
> > --- a/arch/arm/configs/davinci_all_defconfig
> > +++ b/arch/arm/configs/davinci_all_defconfig
> [...]
> > diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
> > index 023480b75244..60a1f23890cd 100644
> > --- a/arch/arm/mach-davinci/board-dm644x-evm.c
> > +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> > @@ -744,7 +744,7 @@ static int davinci_phy_fixup(struct phy_device *phydev)
> >  	return 0;
> >  }
> >
> > -#define HAS_ATA		IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
> > +#define HAS_ATA		IS_ENABLED(CONFIG_PATA_BK3710)
> 
>     I think it would be more correct to check for both libata and IDE drivers 
> here...

Thanks for noticing.

To make both drivers work depending on config options selected I'll:
- fix these HAS_ATA macros
- use "palm_bk3710" as platform driver name in the new driver
- drop IDE platform device & IDE clock name changes

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

