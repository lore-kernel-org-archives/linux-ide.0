From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 18/19] ide: add ide_use_fast_pio() helper
Date: Fri, 12 Jan 2007 15:43:51 +0100
Message-ID: <58cb370e0701120643l5274bd5bn9d9f3661808a455c@mail.gmail.com>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
	 <20070112042800.28794.95095.sendpatchset@localhost.localdomain>
	 <20070112100836.58738dbc@localhost.localdomain>
	 <58cb370e0701120600pc65b237w4865c9637fc1b6e6@mail.gmail.com>
	 <20070112143037.7d5bf10f@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:4343 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbXALOny (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 09:43:54 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1245409nfa
        for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 06:43:53 -0800 (PST)
In-Reply-To: <20070112143037.7d5bf10f@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 1/12/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> >               if(strstr(id->model, "Integrated Technology Express")) {
> >                       /* In raid mode the ident block is slightly buggy
> >                          We need to set the bits so that the IDE layer knows
> >                          LBA28. LBA48 and DMA ar valid */
> >                       id->capability |= 3;            /* LBA28, DMA */
> >
> > and we are better off using generic helper if we can
> > (which may later allow us to use generic tuning code).
>
> IT8212 in smart mode has no tuning at all, the real modes are hidden by
> the controller. Some firmware versions don't seem to be like being fed
> set features commands either hence the total lack of tuning.

[ The discussed "ide: add ide_use_fast_pio() helper" patch doesn't fix it
  but it doesn't break anything either (it doesn't change the current
behavior). ]

It seems that it821x_tune_chipset() is buggy since it sends SET FEATURES
command even when in smart mode.  Shouldn't there be "don't tune" flag
in it812x_fixups() to tell it821x_tune_chipset() to not send SET FEATURES
commands?

Bart
