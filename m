From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 04/12] libata-hp-prep: update ata_scsi_find_dev() and
 friends
Date: Tue, 30 May 2006 13:43:30 +0900
Message-ID: <447BCD72.4080607@gmail.com>
References: <11488839582103-git-send-email-htejun@gmail.com> <447BC3BD.30301@pobox.com> <447BC980.40808@gmail.com> <447BCBF6.9030005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:29668 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932132AbWE3Eng (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 May 2006 00:43:36 -0400
Received: by wr-out-0506.google.com with SMTP id i7so1023440wra
        for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 21:43:36 -0700 (PDT)
In-Reply-To: <447BCBF6.9030005@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Tejun Heo wrote:
>>>> +static struct ata_device * ata_find_dev(struct ata_port *ap, int id)
>>>> +{
>>>> +    if (likely(id == 0 || (id == 1 && ap->flags & 
>>>> ATA_FLAG_SLAVE_POSS)))
>>>> +        return &ap->device[id];
>>>> +    return NULL;
>>>
>>>>  static struct ata_device *
>>>>  ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device 
>>>> *scsidev)
>>>>  {
>>>> -    struct ata_device *dev;
>>>> -
>>>> -    /* skip commands not addressed to targets we simulate */
>>>> -    if (likely(scsidev->id < ATA_MAX_DEVICES))
>>>> -        dev = &ap->device[scsidev->id];
>>>> -    else
>>>> -        return NULL;
>>>
>>>
>>> You replace a '<' test with a more complex test, which must then be 
>>> modified when we start supporting Port Multipliers.
>>>
>>> It is more simple, and easier, to keep the 'id < ATA_MAX_DEVICES' 
>>> test AFAICS.
>>
>> The change is to catch user warm plug request for impossible devices.  
>> I think it's worth to change it two times as it makes user visible 
>> interface consistent.
> 
> Warm plug isn't a fast path, but this is...  I would rather filter out 
> bad IDs elsewhere; and the code itself will catch bad IDs anyway, 
> eventually.

Okay, I'll drop the change.

-- 
tejun
