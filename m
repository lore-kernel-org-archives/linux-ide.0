From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] atiixp.c: remove unused code
Date: Tue, 9 Jan 2007 15:10:00 +0100
Message-ID: <58cb370e0701090610k586ffc5aqffc371144485bc8f@mail.gmail.com>
References: <5767b9100701060411h13324086uf6552a5166641534@mail.gmail.com>
	 <58cb370e0701061812s49c4b1f5p5c5e99e5eea3bb89@mail.gmail.com>
	 <5767b9100701090328o4b78fd4x2b18a42a996608d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:46821 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112AbXAIOKB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Jan 2007 09:10:01 -0500
Received: by ug-out-1314.google.com with SMTP id 44so6577750uga
        for <linux-ide@vger.kernel.org>; Tue, 09 Jan 2007 06:10:00 -0800 (PST)
In-Reply-To: <5767b9100701090328o4b78fd4x2b18a42a996608d9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Conke Hu <conke.hu@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, linux-ide@vger.kernel.org

On 1/9/07, Conke Hu <conke.hu@gmail.com> wrote:
> On 1/7/07, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > On 1/6/07, Conke Hu <conke.hu@gmail.com> wrote:
> > > A previous patch to atiixp.c was removed but some code has not been
> >
> > This one?
> >
> > http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ab17443a3df35abe4b7529e83511a591aa7384f3
> >
> > Doesn't it break existing setups without giving ANY warning?
> >
> > theoretical (I don't have hardware in question) scenario:
> > - user uses atiixp and has modular libata/ahci (or no libata/ahci et all)
> > - user does kernel upgrade
> > - boot fails
> > - ...
> >
> > If this is true please add something like
> >
> > printk(KERN_WARNING "PCI: setting SB600 SATA to AHCI mode"
> > " (please use ahci driver instead of atiixp)\n");
> >
> > to quirk_sb600_sata() so people will at least know what is wrong...
> >
> > > cleaned. Now we remove these code sine they are no use any longer.
> >
> > Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >
> > [ but the patch is line wrapped and unfortunately doesn't apply ]
> >
> > PS: please always cc: linux-ide@vger.kernel.org on PATA/SATA patches
> >
> > Thanks,
> > Bart
> >
>
>
> Hi Bart,
>     I've tried to access the following link to make sure which it is,
> but failed. The internet here   is almost broken.
>     http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ab17443a3df35abe4b7529e83511a591aa7384f3

Yeah, kernel.org is heaving some load related problems.

>    I sent out 2 patches for the same SB600 legacy IDE issue. the later
> (sb600 pci qurik) is better so we should clean the previous patch
> which was applied to atiixp.c. -- that is what this patch does.

Yep, I was talking about "PCI: ATI sb600 sata quirk" which was merged
into -rc2.

>     BTW, I re-create and re-send the patch (see below) based on
> 2.6.20-rc4, in last patch I fogot to rename atiixp.c.1 to atiixp.c
> which may lead to patch fail, nothing else different.
>     And maybe no need to re-ACK if last one is accepted:)

As stated in the other mail - these patches are in -mm kernel already.

Thanks,
Bart
