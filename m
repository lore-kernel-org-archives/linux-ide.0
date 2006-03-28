From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: + fix-ide-dma-resource-managment.patch added to -mm tree
Date: Tue, 28 Mar 2006 16:11:02 +0200
Message-ID: <58cb370e0603280611l78e5742fs44f761ecba485696@mail.gmail.com>
References: <200603212323.k2LNNSnJ006228@shell0.pdx.osdl.net>
	 <58cb370e0603261309p126fdc64j1140bbf437ffe06e@mail.gmail.com>
	 <4427C467.5030300@ru.mvista.com> <4427CE99.6000004@ru.mvista.com>
	 <44293628.3030103@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.182]:12820 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932271AbWC1OLD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Mar 2006 09:11:03 -0500
Received: by pproxy.gmail.com with SMTP id m51so507083pye
        for <linux-ide@vger.kernel.org>; Tue, 28 Mar 2006 06:11:03 -0800 (PST)
In-Reply-To: <44293628.3030103@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On 3/28/06, Sergei Shtylylov <sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Sergei Shtylylov wrote:
>
> >> Bartlomiej Zolnierkiewicz wrote:
>
> [skipped]
>
> >>>> - release the channel's secondary DMA I/O ports for real
>
> >>> NAK, looking and the code - secondary DMA base is only used
> >>> by siimage.c and sgiioc4.c (both use ->mmio == 2, for siimage
> >>> ->dma_base2
> >>> is unused, for sgiioc4 it is used for some weird DMA transfer ending
> >>> stuff)
>
>     Hm, concerning the other field of ide_hwif_t, dma_master: I currently see
> no users to it but pdc202xx_old.c. The way it's computed makes it dependent on
> what channels are enabled (though all channels are forced present in that
> driver by the most recent patch) which makes it invalid if the primary channel
> happens to be disabled. I'd like to replace it with extra_base fields which
> would point to the extra DMA ports regardless of the channels present/enabled,
> is this OK?

Isn't it better to just use pci_resource_start(dev, 4) in pdc202xx_old.c?

Bartlomiej
