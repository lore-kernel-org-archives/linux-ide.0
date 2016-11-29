From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] ata: disable port while unloading ATA controller driver
Date: Tue, 29 Nov 2016 22:04:14 +0200
Message-ID: <cf257dae-7811-0338-3b59-050f34c1ae29@mleia.com>
References: <20161127231856.11466-1-vz@mleia.com>
 <20161128183425.GA19096@htj.duckdns.org>
 <a498fb9f-822e-45aa-aac1-c7afae7a44e3@mleia.com>
 <09c7866c-ecd4-f48a-5112-6cf3c6786cd9@mleia.com>
 <20161129190025.GC22330@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:57530 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751203AbcK2UER (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 29 Nov 2016 15:04:17 -0500
In-Reply-To: <20161129190025.GC22330@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

On 11/29/2016 09:00 PM, Tejun Heo wrote:
> Hello, Vladimir.
> 
> On Tue, Nov 29, 2016 at 08:54:11PM +0200, Vladimir Zapolskiy wrote:
>> tracing on the board shows a race between driver initialization and
>> deinitialization, when async_port_probe() is scheduled after driver
>> removal, this causes the reported problem.
>>
>> Since it is a race, it should be possible to fuzz the kernel by
>> introducing a delay (e.g. in ata_port_probe()) to get enough time
>> to reproduce the problem reliably and to verify a fix.
>>
>> imx_ahci_probe()
>>   ahci_platform_init_host()
>>     ata_host_alloc_pinfo()
>>       ata_host_alloc()
>>         ata_port_alloc()    ---> sets ATA_PFLAG_INITIALIZING flag
>>           ata_link_init()
>>           ....
>>     ahci_host_activate()
>>       ata_host_activate()
>>         ata_host_start()
>>           ata_eh_freeze_port()
>>         ata_port_desc()
>>         ata_host_register() ---> schedules async_port_probe()
>>   ....
>>
>> *** at this point the driver probe is completed, thus it can be removed ***
> 
> Not really.  Is this from the unloading test config?

Correct, I always get the warning with CONFIG_DEBUG_TEST_DRIVER_REMOVE
option enabled.

I understand that a working solution might be just to disable the
option rather than handle this case, however because it is wanted
to test other drivers for potential errors also (e.g. the same ATA
controller driver regardless of the false positive in the ATA core), 
in my opinion the issue should not be ignored.

> Control doesn't get passed to userland until async probings are
> flushed, so this shouldn't normally be possible.
> 

I'm not an expert in ATA, can you please show me the synchronization
point?

In parallel I'll test the fuzzed kernel with an added artificial
delay in ata_port_probe() to get a runtime confirmation.

--
With best wishes,
Vladimir
