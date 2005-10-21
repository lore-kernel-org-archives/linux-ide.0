From: wsong <wsong.cn@gmail.com>
Subject: Re: [PATCH 2.6.14-rc3] sis5513.c: enable ATA133 for the SiS965 southbridge
Date: Fri, 21 Oct 2005 16:35:03 -0400
Message-ID: <6f9b6d3e0510211335x202a437co1919df4f7e5aeb2f@mail.gmail.com>
References: <20051005205906.GA4320@farad.aurel32.net>
	 <58cb370e0510060240x2f2e31c3kd0609a06172d86a4@mail.gmail.com>
	 <20051007094135.GA16386@farad.aurel32.net>
	 <4346A41E.3020505@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:38901 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965150AbVJUUfI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Oct 2005 16:35:08 -0400
Received: by wproxy.gmail.com with SMTP id 57so318440wri
        for <linux-ide@vger.kernel.org>; Fri, 21 Oct 2005 13:35:04 -0700 (PDT)
In-Reply-To: <4346A41E.3020505@verizon.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

This patch has conflict with sata_sis driver. They both register this
id 0x0180. But pci ide driver is loaded first. So if you have sata
drive connected as root, dang, you'll get kernel panic. I had this
problem with 2.6.14_rc4-mm1. Simply delete the third line from
structure sis5513_pci_tbl resolved it.

I know it's just a work around.

Can somebody tell me how to track file history under mm- tree?

On 10/7/05, Wes Newell <w.newell@verizon.net> wrote:
> Aurelien Jarno wrote:
>
> >On Thu, Oct 06, 2005 at 11:40:15AM +0200, Bartlomiej Zolnierkiewicz wrote:
> >
> >
> >>Hi,
> >>
> >>On 10/5/05, Aurelien Jarno <aurelien@aurel32.net> wrote:
> >>
> >>
> >>>Hi,
> >>>
> >>>Here is a patch that enables the ATA133 mode for the SiS965 southbridge
> >>>in the SiS5513 driver.
> >>>
> >>>
> >>The patch for SIS965(L) support is already in -mm tree:
> >>http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/broken-out/sis5513-support-sis-965l.patch
> >>
> >>
> >>
> >
> >Oops, I forget to look at the -mm tree for this driver. You're right, it
> >works, and it seems the patch is cleaner than mine. So please ignore my
> >patch.
> >
> >Thanks,
> >Aurelien
> >
> >
> >
> It appears to me that this patch will try and apply itself to the real
> SIS_180 which has the same true_id of 0x180. Can someone tell me what
> will happen then?
>
>
> --
> KT133 MB, CPU @2400MHz (24x100): SIS755 MB CPU @2330MHz (10x233)
> Need good help? Provide all system info with question.
> My server http://wesnewell.no-ip.com/cpu.php
> Verizon server http://mysite.verizon.net/res0exft/cpu.htm
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
