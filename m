From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 04/12] libata: add detailed AC_ERR_* flags
Date: Sun, 22 Jan 2006 18:50:07 +0900
Message-ID: <43D3554F.7060105@gmail.com>
References: <11379167101842-git-send-email-htejun@gmail.com> <43D350B2.3020009@pobox.com> <43D35476.2060202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.199]:58919 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932330AbWAVJuM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 04:50:12 -0500
Received: by xproxy.gmail.com with SMTP id s14so518613wxc
        for <linux-ide@vger.kernel.org>; Sun, 22 Jan 2006 01:50:11 -0800 (PST)
In-Reply-To: <43D35476.2060202@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> Jeff Garzik wrote:
> 
>> Tejun Heo wrote:
>>
>>> Add detailed AC_ERR_* flags and use them.  Long-term goal is to
>>> describe all errors with err_mask and tf combination (tf for failed
>>> sector information, etc...).  After proper error diagnosis is
>>> implemented, sense data should also be generated from err_mask instead
>>> of directly from hardware tf registers as it is currently.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>>
>>> ---
>>>
>>>  drivers/scsi/ahci.c        |    6 ++----
>>>  drivers/scsi/libata-core.c |   12 ++++++------
>>>  drivers/scsi/sata_mv.c     |    2 +-
>>>  drivers/scsi/sata_sil24.c  |    2 +-
>>>  include/linux/libata.h     |   15 ++++++++++-----
>>>  5 files changed, 20 insertions(+), 17 deletions(-)
>>>
>>> 1939435a8f0e7b2b1578b84cedd49f8adcab1ea9
>>> diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
>>> index 30676b0..e7b937b 100644
>>> --- a/drivers/scsi/ahci.c
>>> +++ b/drivers/scsi/ahci.c
>>> @@ -680,7 +680,7 @@ static void ahci_eng_timeout(struct ata_
>>>            * not being called from the SCSI EH.
>>>            */
>>>          qc->scsidone = scsi_finish_command;
>>> -        qc->err_mask |= AC_ERR_OTHER;
>>> +        qc->err_mask |= AC_ERR_TIMEOUT;
>>>          ata_qc_complete(qc);
>>>      }
>>>  
>>> @@ -720,10 +720,8 @@ static inline int ahci_host_intr(struct          
>>> /* command processing has stopped due to error; restart */
>>>          ahci_restart_port(ap, status);
>>>  
>>> -        if (qc) {
>>> -            qc->err_mask |= AC_ERR_OTHER;
>>> +        if (qc)
>>>              ata_qc_complete(qc);
>>> -        }
>>
>>
>>
>> why are you erasing the error mask here?
>>
> 
> Oh.. I forgot to write about it.  About 10 lines above, detailed 
> err_mask is determined from irq status but qc->err_mask always used to 
> be set to AC_ERR_OTHER regardless of the determined value.
> 

And, yeah, I forgot to do qc->err_mask |= err_mask.  :-P

-- 
tejun
