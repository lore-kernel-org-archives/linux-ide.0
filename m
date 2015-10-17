From: Vinayak Kale <vinayak.kale@gmail.com>
Subject: Re: [PATCH] libata: add support for NCQ commands for SG interface
Date: Sat, 17 Oct 2015 17:55:57 +0530
Message-ID: <CACLWs=V_XXAojGmczSQpwvswU_yrWnZSWtih9rTp1hxEEeoQTg@mail.gmail.com>
References: <1445082519-8160-1-git-send-email-vinayak.kale@seagate.com> <5622386C.2000905@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35906 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbbJQM0h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Oct 2015 08:26:37 -0400
In-Reply-To: <5622386C.2000905@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sumit.g.gupta@seagate.com, Vinayak Kale <vinayak.kale@seagate.com>

On Sat, Oct 17, 2015 at 5:30 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 10/17/2015 2:48 PM, vinayak.kale@gmail.com wrote:
>
>> From: Vinayak Kale <vinayak.kale@seagate.com>
>>
>> This patch is needed to make NCQ commands with FPDMA protocol value
>> (eg READ/WRITE FPDMA) work over SCSI Generic (SG) interface.
>>
>> Signed-off-by: Vinayak Kale <vinayak.kale@seagate.com>
>> ---
>>   drivers/ata/libata-scsi.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 0d7f0da..5b0a5ab 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>
> [...]
>>
>> @@ -2963,7 +2965,7 @@ static unsigned int ata_scsi_pass_thru(struct
>> ata_queued_cmd *qc)
>>                         tf->hob_lbal = cdb[7];
>>                         tf->hob_lbam = cdb[9];
>>                         tf->hob_lbah = cdb[11];
>> -                       tf->flags |= ATA_TFLAG_LBA48;
>> +                       tf->flags |= (ATA_TFLAG_LBA48 | ATA_TFLAG_LBA);
>
>
>    Parens not needed here.
That's quite neat :-) Thanks, will change it in V2.
>
> [...]
>
> MBR, Sergei
>
