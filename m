From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] libata: add support for NCQ commands for SG interface
Date: Sat, 17 Oct 2015 21:42:51 +0300
Message-ID: <562296AB.4010500@cogentembedded.com>
References: <1445082519-8160-1-git-send-email-vinayak.kale@seagate.com>
 <5622386C.2000905@cogentembedded.com>
 <CACLWs=V_XXAojGmczSQpwvswU_yrWnZSWtih9rTp1hxEEeoQTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACLWs=V_XXAojGmczSQpwvswU_yrWnZSWtih9rTp1hxEEeoQTg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinayak Kale <vinayak.kale@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sumit.g.gupta@seagate.com, Vinayak Kale <vinayak.kale@seagate.com>
List-Id: linux-ide@vger.kernel.org

On 10/17/2015 3:25 PM, Vinayak Kale wrote:

>>> From: Vinayak Kale <vinayak.kale@seagate.com>
>>>
>>> This patch is needed to make NCQ commands with FPDMA protocol value
>>> (eg READ/WRITE FPDMA) work over SCSI Generic (SG) interface.
>>>
>>> Signed-off-by: Vinayak Kale <vinayak.kale@seagate.com>
>>> ---
>>>    drivers/ata/libata-scsi.c | 10 ++++++++--
>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>> index 0d7f0da..5b0a5ab 100644
>>> --- a/drivers/ata/libata-scsi.c
>>> +++ b/drivers/ata/libata-scsi.c
>>
>> [...]
>>>
>>> @@ -2963,7 +2965,7 @@ static unsigned int ata_scsi_pass_thru(struct
>>> ata_queued_cmd *qc)
>>>                          tf->hob_lbal = cdb[7];
>>>                          tf->hob_lbam = cdb[9];
>>>                          tf->hob_lbah = cdb[11];
>>> -                       tf->flags |= ATA_TFLAG_LBA48;
>>> +                       tf->flags |= (ATA_TFLAG_LBA48 | ATA_TFLAG_LBA);
>>
>>
>>     Parens not needed here.
> That's quite neat :-) Thanks, will change it in V2.

     Looking at this hunk again, it seems an unrelated change.

MBR, Sergei
