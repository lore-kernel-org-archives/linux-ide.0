From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: + fix-ide-dma-resource-managment.patch added to -mm tree
Date: Mon, 27 Mar 2006 14:33:35 +0200
Message-ID: <58cb370e0603270433q4f23f08andfc39b3f85ab4d5e@mail.gmail.com>
References: <200603212323.k2LNNSnJ006228@shell0.pdx.osdl.net>
	 <58cb370e0603261309p126fdc64j1140bbf437ffe06e@mail.gmail.com>
	 <4427C467.5030300@ru.mvista.com>
	 <58cb370e0603270407v3329fa74n8148638a331b8419@mail.gmail.com>
	 <4427D8DF.5000905@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:47838 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750961AbWC0Md6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Mar 2006 07:33:58 -0500
Received: by pproxy.gmail.com with SMTP id w49so1268959pyg
        for <linux-ide@vger.kernel.org>; Mon, 27 Mar 2006 04:33:57 -0800 (PST)
In-Reply-To: <4427D8DF.5000905@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On 3/27/06, Sergei Shtylylov <sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Bartlomiej Zolnierkiewicz wrote:
> > On 3/27/06, Sergei Shtylylov <sshtylyov@ru.mvista.com> wrote:
>
> [skipped]
>
> >>>please fix siimage.c and core code instead
> >>>(please see libata-core.c and ata_host_stop() etc.)
>
> >>>>- release the same number of DMA I/O ports that was requested by a driver
>
> >>>please fix trm290.c to use ->mmio == 2 instead
>
> >>    It's a _really_ old chipset (pre SFF-8038i) and has _no_ memory mapped
> >>regs AFAIK...
>
> > ->mmio == 2 means _only_ that host driver is responsible
> > for reserving/releasing resources - it doesn't mean that host driver
> > is using MMIO (a bit confusing but this is what the current code does)
>
>     So, your point is that ide_setup_dma() should _never_ do anything for the
> (mmio == 2) case? Maybe it shouldn't even be called? I guess we surely need

No, my point is that for ->mmio == 2 core code may not try to manage
IO or MMIO resources, only that.  ide_setup_dma() call is still needed for
calling ide_allocate_dma_engine() and setting up ->dma_* / ->ide_dma_*
fields.

> some driver cleanup hook to call ftom ide_release_dma()...

Yep.

Bartlomiej
