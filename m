From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: toshiba ide - ide dma setting
Date: Tue, 8 Feb 2005 23:04:57 +0100
Message-ID: <58cb370e050208140441bef38f@mail.gmail.com>
References: <28d670ae0502081139464d51c@mail.gmail.com>
	 <58cb370e050208124447c7b1e@mail.gmail.com>
	 <28d670ae0502081341467eb64f@mail.gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.201]:4541 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261552AbVBHWE5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2005 17:04:57 -0500
Received: by wproxy.gmail.com with SMTP id 67so1142363wri
        for <linux-ide@vger.kernel.org>; Tue, 08 Feb 2005 14:04:57 -0800 (PST)
In-Reply-To: <28d670ae0502081341467eb64f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marcin Kuk <marcin.kuk@gmail.com>
Cc: Linux IDE Mailing List <linux-ide@vger.kernel.org>

On Tue, 8 Feb 2005 22:41:45 +0100, Marcin Kuk <marcin.kuk@gmail.com> wrote:
> > Have you tried "Generic PCI IDE Chipset Support" ?
> 
> I thing that you are about:
> generic / default IDE chipset support (kernel 2.6.10) ?

No...

> Probably in 2.4 series the name was as you quoted.
> Yes. This option was compiled in kernel.
> 
> All kernels were compiled with setting all chipsets.
> I cared about set all of options responsible for IDE.
> All IDE drivers was compiled into kernel (not modules).

> CONFIG_BLK_DEV_GENERIC=y

...but you have it.

output of lspci command would be also helpful

> I think that the solution of my problem is here:
> http://marc.theaimsgroup.com/?l=linux-ide&m=109967556605057&w=2
> and here is your response:
> http://marc.theaimsgroup.com/?l=linux-ide&m=109969178814722&w=2
> 
> "AFAICS this option allows users to use generic code for
> unknown/unsupported devices which can result in unpredictable results
> (hangs, data corruptions)." BZ

This patch is in Alan's -ac tree.

Just get the latest patch for 2.6.10 from:
http://kernel.org/pub/linux/kernel/people/alan/linux-2.6/2.6.10/
