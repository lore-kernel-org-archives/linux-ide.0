From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: disable port while unloading ATA controller driver
Date: Tue, 29 Nov 2016 15:44:13 -0500
Message-ID: <20161129204413.GC4959@htj.duckdns.org>
References: <20161127231856.11466-1-vz@mleia.com>
 <20161128183425.GA19096@htj.duckdns.org>
 <a498fb9f-822e-45aa-aac1-c7afae7a44e3@mleia.com>
 <09c7866c-ecd4-f48a-5112-6cf3c6786cd9@mleia.com>
 <20161129190025.GC22330@htj.duckdns.org>
 <cf257dae-7811-0338-3b59-050f34c1ae29@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33720 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbcK2UoP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Nov 2016 15:44:15 -0500
Received: by mail-yw0-f195.google.com with SMTP id s68so13180919ywg.0
        for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2016 12:44:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <cf257dae-7811-0338-3b59-050f34c1ae29@mleia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

Hello, Vladimir.

On Tue, Nov 29, 2016 at 10:04:14PM +0200, Vladimir Zapolskiy wrote:
> > Not really.  Is this from the unloading test config?
> 
> Correct, I always get the warning with CONFIG_DEBUG_TEST_DRIVER_REMOVE
> option enabled.
> 
> I understand that a working solution might be just to disable the
> option rather than handle this case, however because it is wanted
> to test other drivers for potential errors also (e.g. the same ATA
> controller driver regardless of the false positive in the ATA core), 
> in my opinion the issue should not be ignored.

So, the problem is that CONFIG_DEBUG_TEST_DRIVER_REMOVE is introducing
a condition which isn't otherwise possible, so it's triggering pseudo
bugs.  The solution here is to make CONFIG_DEBUG_TEST_DRIVER_REMOVE
flush async calls before trying to remove the driver.

> > Control doesn't get passed to userland until async probings are
> > flushed, so this shouldn't normally be possible.
> > 
> 
> I'm not an expert in ATA, can you please show me the synchronization
> point?

async_synchronize_full() call in kernel_init() for booting and in
delete_module() for module unloading.

Thanks.

-- 
tejun
