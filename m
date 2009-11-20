From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: Clean up hard coded array size calculation.
Date: Fri, 20 Nov 2009 17:05:41 -0500
Message-ID: <4B0712B5.7070405@pobox.com>
References: <1257708657-1232-1-git-send-email-tfransosi@gmail.com>	 <4B0215E3.2020400@pobox.com> <a4c8a6d00911201115s276bb2a7i2a2c546356b71842@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43054 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392AbZKTWFk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Nov 2009 17:05:40 -0500
In-Reply-To: <a4c8a6d00911201115s276bb2a7i2a2c546356b71842@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
Cc: mlord@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/20/2009 02:15 PM, Thiago Farina wrote:
> Hi Jeff,
>
> On Tue, Nov 17, 2009 at 1:17 AM, Jeff Garzik<jgarzik@pobox.com>  wrote:
>> On 11/08/2009 02:30 PM, Thiago Farina wrote:
>>>
>>> Use ARRAY_SIZE macro of kernel api instead.
>>>
>>> Signed-off-by: Thiago Farina<tfransosi@gmail.com>
>>> ---
>>>   drivers/ata/sata_mv.c |    2 +-
>>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>>> index 6f5093b..a8a7be0 100644
>>> --- a/drivers/ata/sata_mv.c
>>> +++ b/drivers/ata/sata_mv.c
>>> @@ -2217,7 +2217,7 @@ static unsigned int mv_qc_issue_fis(struct
>>> ata_queued_cmd *qc)
>>>         int err = 0;
>>>
>>>         ata_tf_to_fis(&qc->tf, link->pmp, 1, (void *)fis);
>>> -       err = mv_send_fis(ap, fis, sizeof(fis) / sizeof(fis[0]));
>>> +       err = mv_send_fis(ap, fis, ARRAY_SIZE(fis));
>>>         if (err)
>>
>> applied
>
> Was it applied to this tree
> http://git.kernel.org/?p=linux/kernel/git/jgarzik/libata-dev.git?

Yes.

	Jeff




