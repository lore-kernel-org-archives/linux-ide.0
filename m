From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 01/10] libata: power down controller only on PMSG_SUSPEND
Date: Tue, 13 Jun 2006 11:20:39 +0900
Message-ID: <448E20F7.4020604@gmail.com>
References: <11501274283030-git-send-email-htejun@gmail.com> <448D9709.30305@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:39857 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932482AbWFMCUp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 22:20:45 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1782246nze
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 19:20:45 -0700 (PDT)
In-Reply-To: <448D9709.30305@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> The controller only needs to be powered down on PMSG_SUSPEND.  Skip
>> powering down for all other messages.  This makes disk suspend prep
>> cycle more efficient and helps controllers which have problems waking
>> up from D3hot without intervening power removal.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> ---
>>
>>  drivers/scsi/libata-core.c |    5 ++++-
>>  1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> 85016ad86323924d10dc99ac9d7e9e5c0b967b8e
>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>> index 9a3bd15..51d3b4b 100644
>> --- a/drivers/scsi/libata-core.c
>> +++ b/drivers/scsi/libata-core.c
>> @@ -5661,7 +5661,10 @@ int ata_pci_device_suspend(struct pci_de
>>  {
>>      pci_save_state(pdev);
>>      pci_disable_device(pdev);
>> -    pci_set_power_state(pdev, PCI_D3hot);
>> +
>> +    if (state.event == PM_EVENT_SUSPEND)
>> +        pci_set_power_state(pdev, PCI_D3hot);
> 
> If this change makes sense for the D0->D3 transition, surely it would 
> make sense to cover the other operations (save-state, disable) as well?

It probably makes sense for disable but not for save-state.  Swsusp 
takes snapshot of memory after freezing all devices and resumes again to 
write the snapshot.  Resume must be able to reinitialize the hardware 
from scratch and it depends on PCI config regs saved w/ 
pci_save_state().  So, state must be saved during freeze.

I'll put pci_disable_device() in the if clause and retest.  That should 
work.

-- 
tejun
