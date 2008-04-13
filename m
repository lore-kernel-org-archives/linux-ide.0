From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 1/2] pata_atiixp: simplex clear
Date: Sun, 13 Apr 2008 09:39:51 +0900
Message-ID: <48015657.9060306@gmail.com>
References: <200803282133.m2SLXupx011467@imap1.linux-foundation.org> <48003B91.4070701@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:59282 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbYDMAj7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 20:39:59 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1040641wff.4
        for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 17:39:58 -0700 (PDT)
In-Reply-To: <48003B91.4070701@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

Jeff Garzik wrote:
> akpm@linux-foundation.org wrote:
>> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>>
>> Some of the other quirks changes seem to have left some users with the 
>> simplex
>> bits mis-set by the time the driver loads.  Clear simplex mode before 
>> we probe
>> the controller therefore.
>>
>> Signed-off-by: Alan Cox <alan@redhat.com>
>> Cc: Jeff Garzik <jeff@garzik.org>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
>>  drivers/ata/pata_atiixp.c |    7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff -puN drivers/ata/pata_atiixp.c~pata_atiixp-simplex-clear 
>> drivers/ata/pata_atiixp.c
>> --- a/drivers/ata/pata_atiixp.c~pata_atiixp-simplex-clear
>> +++ a/drivers/ata/pata_atiixp.c
>> @@ -22,7 +22,7 @@
>>  #include <linux/libata.h>
>>  
>>  #define DRV_NAME "pata_atiixp"
>> -#define DRV_VERSION "0.4.6"
>> +#define DRV_VERSION "0.4.7"
>>  
>>  enum {
>>      ATIIXP_IDE_PIO_TIMING    = 0x40,
>> @@ -243,6 +243,9 @@ static int atiixp_init_one(struct pci_de
>>          .port_ops = &atiixp_port_ops
>>      };
>>      const struct ata_port_info *ppi[] = { &info, NULL };
>> +    /* Some of the quirk reconfiguration messes up the simplex
>> +       flag, so clear it again */
>> +    ata_pci_clear_simplex(dev);
>>      return ata_pci_init_one(dev, ppi, &atiixp_sht, NULL);
>>  }
>>  
>> @@ -279,7 +282,7 @@ static void __exit atiixp_exit(void)
>>  }
>>  
>>  MODULE_AUTHOR("Alan Cox");
>> -MODULE_DESCRIPTION("low-level driver for ATI IXP200/300/400");
>> +MODULE_DESCRIPTION("low-level driver for ATI IXP series");
>>  MODULE_LICENSE("GPL");
>>  MODULE_DEVICE_TABLE(pci, atiixp);
> 
> Since I saw some automated akpm mail about this...  this patch is 
> obsolete.  Needs ata_pci_bmdma_clear_simplex() at least.
> 
> Also, Tejun, you had some thoughts on this?

That was about calling pci functions before enabling them.

> In current #upstream, we still call ata_pci_bmdma_clear_simplex() before 
> pcim_enable_device() in some cases, so the problem remains...

Care to point where?  It should be easy to fix.  Just adding 
pcim_enable_device() early in the init function should do.

-- 
tejun
