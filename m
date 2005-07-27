From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH Linux 2.6.12 07/09] NCQ: stop dma before reset
Date: Wed, 27 Jul 2005 15:25:43 +0900
Message-ID: <42E728E7.4040900@gmail.com>
References: <20050626152105.D86561FB@htj.dyndns.org> <20050626152105.F3C5D2FC@htj.dyndns.org> <42E6A74A.80709@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.192]:56914 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262003AbVG0GZv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jul 2005 02:25:51 -0400
Received: by rproxy.gmail.com with SMTP id r35so168940rna
        for <linux-ide@vger.kernel.org>; Tue, 26 Jul 2005 23:25:48 -0700 (PDT)
In-Reply-To: <42E6A74A.80709@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: axboe@suse.de, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> 07_NCQ_ahci-stop-dma-before-reset.patch
>>
>>     AHCI 1.1 mandates stopping dma before issueing COMMRESET.  The
>>     original code didn't and it resulted in occasional lockup of
>>     the controller during EH recovery.  This patch fixes the
>>     problem.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>>  ahci.c |    2 ++
>>  1 files changed, 2 insertions(+)
>>
>> Index: work/drivers/scsi/ahci.c
>> ===================================================================
>> --- work.orig/drivers/scsi/ahci.c    2005-06-27 00:20:31.000000000 +0900
>> +++ work/drivers/scsi/ahci.c    2005-06-27 00:20:31.000000000 +0900
>> @@ -474,7 +474,9 @@ static void ahci_phy_reset(struct ata_po
>>      struct ata_device *dev = &ap->device[0];
>>      u32 tmp;
>>  
>> +    ahci_stop_dma(ap);
>>      __sata_phy_reset(ap);
>> +    ahci_start_dma(ap);
> 
> 
> This is a bit worrisome, because we really shouldn't be calling 
> ahci_phy_reset() when DMA is -not- stopped.  That's a violation of the 
> state machine.
> 
>     Jeff

  Hello, Jeff.

  The case occurs when qc's time out.  When qc's time out, we need to 
forcefully terminate those and reset the state machine, so the violation 
of the state machine is necessary there, I think.

  When EH kicks in, ATA_FLAG_RECOVERY gets set, and all non-preempt qc 
completions/errors are ignored until recovery completes.  Then, the 
device gets reset and recovery commands are issued.  IOW, the state 
machine violation occurs while all completion/error notifications from 
the device are being ignored, and, after reset is complete, the state 
machine is restarted from a determined state.

  If I missed something, please point out.

  Thanks.

-- 
tejun
