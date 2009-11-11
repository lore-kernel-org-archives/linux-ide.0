From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: Clean up hard coded array size calculation.
Date: Wed, 11 Nov 2009 18:10:13 -0500
Message-ID: <4AFB4455.3040407@pobox.com>
References: <1257708657-1232-1-git-send-email-tfransosi@gmail.com> <4AF8F363.3010806@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54418 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759529AbZKKXKR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Nov 2009 18:10:17 -0500
In-Reply-To: <4AF8F363.3010806@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Thiago Farina <tfransosi@gmail.com>, mlord@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/10/2009 12:00 AM, Mark Lord wrote:
> Thiago Farina wrote:
>> Use ARRAY_SIZE macro of kernel api instead.
>>
>> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
>> ---
>> drivers/ata/sata_mv.c | 2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>> index 6f5093b..a8a7be0 100644
>> --- a/drivers/ata/sata_mv.c
>> +++ b/drivers/ata/sata_mv.c
>> @@ -2217,7 +2217,7 @@ static unsigned int mv_qc_issue_fis(struct
>> ata_queued_cmd *qc)
>> int err = 0;
>>
>> ata_tf_to_fis(&qc->tf, link->pmp, 1, (void *)fis);
>> - err = mv_send_fis(ap, fis, sizeof(fis) / sizeof(fis[0]));
>> + err = mv_send_fis(ap, fis, ARRAY_SIZE(fis));
>> if (err)
>> return err;
>>
> ..
>
> What's the point of this ?
>
> There is no "hardcoded array size" there to begin with,
> and using that silly macro obscures the actual calculation.
>
> So now, instead of being able to verify correctness at a glance,
> I have to go off and research some silly macro and verify that
> it does the right thing.

It is a standard cleanup for all kernel code, and it does make the code 
more readable to the casual reader / quick skimmer.

	Jeff




