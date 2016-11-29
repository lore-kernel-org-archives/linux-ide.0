From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: disable port while unloading ATA controller driver
Date: Tue, 29 Nov 2016 14:00:25 -0500
Message-ID: <20161129190025.GC22330@htj.duckdns.org>
References: <20161127231856.11466-1-vz@mleia.com>
 <20161128183425.GA19096@htj.duckdns.org>
 <a498fb9f-822e-45aa-aac1-c7afae7a44e3@mleia.com>
 <09c7866c-ecd4-f48a-5112-6cf3c6786cd9@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33040 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbcK2TA1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Nov 2016 14:00:27 -0500
Received: by mail-yw0-f193.google.com with SMTP id s68so12978618ywg.0
        for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2016 11:00:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <09c7866c-ecd4-f48a-5112-6cf3c6786cd9@mleia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

Hello, Vladimir.

On Tue, Nov 29, 2016 at 08:54:11PM +0200, Vladimir Zapolskiy wrote:
> tracing on the board shows a race between driver initialization and
> deinitialization, when async_port_probe() is scheduled after driver
> removal, this causes the reported problem.
> 
> Since it is a race, it should be possible to fuzz the kernel by
> introducing a delay (e.g. in ata_port_probe()) to get enough time
> to reproduce the problem reliably and to verify a fix.
> 
> imx_ahci_probe()
>   ahci_platform_init_host()
>     ata_host_alloc_pinfo()
>       ata_host_alloc()
>         ata_port_alloc()    ---> sets ATA_PFLAG_INITIALIZING flag
>           ata_link_init()
>           ....
>     ahci_host_activate()
>       ata_host_activate()
>         ata_host_start()
>           ata_eh_freeze_port()
>         ata_port_desc()
>         ata_host_register() ---> schedules async_port_probe()
>   ....
> 
> *** at this point the driver probe is completed, thus it can be removed ***

Not really.  Is this from the unloading test config?  Control doesn't
get passed to userland until async probings are flushed, so this
shouldn't normally be possible.

Thanks.

-- 
tejun
