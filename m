From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 1/2] pata_atiixp: simplex clear
Date: Sun, 30 Mar 2008 08:48:29 +0900
Message-ID: <47EED54D.7040301@gmail.com>
References: <200803282133.m2SLXupx011467@imap1.linux-foundation.org> <47EE6B2C.5010903@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:28198 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbYC2Xsg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 19:48:36 -0400
Received: by wf-out-1314.google.com with SMTP id 28so867670wff.4
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 16:48:36 -0700 (PDT)
In-Reply-To: <47EE6B2C.5010903@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: alan@lxorguk.ukuu.org.uk, akpm@linux-foundation.org, linux-ide@vger.kernel.org, alan@redhat.com

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
> 
> This patch triggered an audit which led me to... bug city.
> 
> 1) This call occurs before resources are guaranteed to be present, which 
> happens when pci[m]_enable_device() is called.
> 
> 2) Auditing the other ata_pci_clear_simplex() uses, it seems the others 
> are equally broken.
> 
> 3) Further, looking at pata_amd, I notice that the resume code twiddles 
> bits before the PCI device is even bought into D0 state!
> 
> 4) ata_pci_clear_simplex() does its work before resources are mapped, 
> and assumes PCI IDE and PCI BAR #4 behavior.  This works at present, but 
> is less robust than it could be.
> 
> 
> Anyway, my suggestion would be to add a "post-enable" function pointer 
> to ata_pci_init_one() arguments, and call ata_pci_clear_simplex() from 
> that hook.  That would permit this patch and other 
> ata_pci_clear_simplex() callsites to be fixed.

Jeff, already fixed in upstream by commit 
1a5c8724e2f8239c6890a95fc87d0ae04edac001.

-- 
tejun
