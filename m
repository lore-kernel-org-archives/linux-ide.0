From: Vinayak Kale <vinayak.kale@gmail.com>
Subject: Re: [PATCH] libata: add support for NCQ commands for SG interface
Date: Mon, 19 Oct 2015 12:25:09 +0530
Message-ID: <CACLWs=UA9rrT8_Sr1D-6m4qyXcBukt=thrGho1t+XK+TZEZwog@mail.gmail.com>
References: <1445082519-8160-1-git-send-email-vinayak.kale@seagate.com>
 <5622386C.2000905@cogentembedded.com> <CACLWs=V_XXAojGmczSQpwvswU_yrWnZSWtih9rTp1hxEEeoQTg@mail.gmail.com>
 <562296AB.4010500@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34356 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbbJSGzt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Oct 2015 02:55:49 -0400
In-Reply-To: <562296AB.4010500@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sumit.g.gupta@seagate.com, Vinayak Kale <vinayak.kale@seagate.com>

On Sun, Oct 18, 2015 at 12:12 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 10/17/2015 3:25 PM, Vinayak Kale wrote:
>
>>>> From: Vinayak Kale <vinayak.kale@seagate.com>
>>>>
>>>> This patch is needed to make NCQ commands with FPDMA protocol value
>>>> (eg READ/WRITE FPDMA) work over SCSI Generic (SG) interface.
>>>>
>>>> Signed-off-by: Vinayak Kale <vinayak.kale@seagate.com>
>>>> ---
>>>>    drivers/ata/libata-scsi.c | 10 ++++++++--
>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>>> index 0d7f0da..5b0a5ab 100644
>>>> --- a/drivers/ata/libata-scsi.c
>>>> +++ b/drivers/ata/libata-scsi.c
>>>
>>>
>>> [...]
>>>>
>>>>
>>>> @@ -2963,7 +2965,7 @@ static unsigned int ata_scsi_pass_thru(struct
>>>> ata_queued_cmd *qc)
>>>>                          tf->hob_lbal = cdb[7];
>>>>                          tf->hob_lbam = cdb[9];
>>>>                          tf->hob_lbah = cdb[11];
>>>> -                       tf->flags |= ATA_TFLAG_LBA48;
>>>> +                       tf->flags |= (ATA_TFLAG_LBA48 | ATA_TFLAG_LBA);
>>>
>>>
>>>
>>>     Parens not needed here.
>>
>> That's quite neat :-) Thanks, will change it in V2.
>
>
>     Looking at this hunk again, it seems an unrelated change.

I added ATA_TFLAG_LBA to tf->flags just to conform with similar piece
of code in libata-core.c.
FPDMA Read/Write commands run smoothly even without this flag.
I wouldn't mind removing this change from current patch if it's deemed
unfit here.

>
> MBR, Sergei
>
