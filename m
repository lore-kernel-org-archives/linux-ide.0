From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] PA-RISC update to 87415
Date: Wed, 3 Nov 2004 21:21:02 +0100
Message-ID: <58cb370e04110312215ee851e4@mail.gmail.com>
References: <20041103200059.GC17672@colo.lackof.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.201]:39443 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261865AbUKCUVK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Nov 2004 15:21:10 -0500
Received: by rproxy.gmail.com with SMTP id a36so146667rnf
        for <linux-ide@vger.kernel.org>; Wed, 03 Nov 2004 12:21:03 -0800 (PST)
In-Reply-To: <20041103200059.GC17672@colo.lackof.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@parisc-linux.org>
Cc: matthew@wil.cx, linux-ide@vger.kernel.org

On Wed, 3 Nov 2004 13:00:59 -0700, Grant Grundler
<grundler@parisc-linux.org> wrote:
> Bartlomiej,
> Here's a "final" patch to cleanup the exporting of IDE data
> to suckyio support. I sent this before but it wasn't "verified"
> at the time:
> http://marc.theaimsgroup.com/?l=linux-ide&m=109587104530498&w=2
> 
> It's verified now to work and should be applied.

thanks, looks OK

I only wonder about this change:

> @@ -132,10 +212,6 @@ static void __init init_hwif_ns87415 (id
>         hwif->autodma = 0;
>         hwif->selectproc = &ns87415_selectproc;
> 
> -       /* Set a good latency timer and cache line size value. */
> -       (void) pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
> -       /* FIXME: use pci_set_master() to ensure good latency timer value */
> -
>         /*
>          * We cannot probe for IRQ: both ports share common IRQ on INTA.
>          * Also, leave IRQ masked during drive probing, to prevent infinite

?
