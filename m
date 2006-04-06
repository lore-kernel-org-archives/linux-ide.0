From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/8] libata: separate out sil24_poll_register()
Date: Thu, 06 Apr 2006 12:56:16 -0400
Message-ID: <44354830.7080004@pobox.com>
References: <1144243742725-git-send-email-htejun@gmail.com> <4435450E.2080600@pobox.com> <20060406164806.GG31998@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45240 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932197AbWDFQ4T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Apr 2006 12:56:19 -0400
In-Reply-To: <20060406164806.GG31998@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> On Thu, Apr 06, 2006 at 12:42:54PM -0400, Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> This will be used by later patches.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>>
>>> ---
>>>
>>> drivers/scsi/sata_sil24.c |   34 +++++++++++++++++++++++-----------
>>> 1 files changed, 23 insertions(+), 11 deletions(-)
>>>
>>> dbf21a7fbc3fe926671416fecebfea70aef78c8a
>>> diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
>>> index 86233ac..0941f74 100644
>>> --- a/drivers/scsi/sata_sil24.c
>>> +++ b/drivers/scsi/sata_sil24.c
>>> @@ -431,6 +431,24 @@ static void sil24_tf_read(struct ata_por
>>> 	*tf = pp->tf;
>>> }
>>>
>>> +static int sil24_poll_register(void __iomem *reg, u32 mask, u32 val,
>>> +			       unsigned long interval_msec,
>>> +			       unsigned long timeout_msec)
>>> +{
>>> +	unsigned long timeout;
>>> +	u32 tmp;
>>> +
>>> +	timeout = jiffies + (timeout_msec * HZ) / 1000;
>>> +	do {
>>> +		tmp = readl(reg);
>>> +		if ((tmp & mask) == val)
>>> +			return 0;
>>> +		msleep(interval_msec);
>>> +	} while (time_before(jiffies, timeout));
>>> +
>> Let's not duplicate code in AHCI.  Initially the common code could live 
>> in libata, but let's think about the best place in the kernel for this 
>> function to live.
>>
> 
> Three copies are my tipping point.  Yeah, but two are good enough for
> me too.  Any ideas where this utility should live?

libata-core.c for now.  Long term?  Tough question.  Probably create a 
new file in lib/ directory, or add it to lib/iomap.c.

	Jeff



