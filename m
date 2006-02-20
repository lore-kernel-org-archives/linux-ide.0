From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/7] libata: separate out ata_dev_read_id()
Date: Tue, 21 Feb 2006 00:04:01 +0900
Message-ID: <43F9DA61.40809@gmail.com>
References: <1139995449455-git-send-email-htejun@gmail.com> <43F99B67.5050504@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:57953 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030273AbWBTPEF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 10:04:05 -0500
Received: by zproxy.gmail.com with SMTP id z31so865815nzd
        for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 07:04:04 -0800 (PST)
In-Reply-To: <43F99B67.5050504@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Separate out ata_dev_read_id() from ata_dev_identify().  This is the
>> first half of splitting ata_dev_identify().  ata_dev_read_id() will
>> also be used for revalidation.  This patch does not make any behavior
>> change.
>>
>> ata_dev_read_id() doesn't modify any of libata-internal data
>> structures.  It simply reads IDENTIFY page and returns error code on
>> failure.  INIT_DEV_PARAMS and EDD wrong class code are also handled by
>> this function.
>>
>> Re-reading IDENTIFY after INIT_DEV_PARAMS is performed by jumping to
>> retry: instead of calling ata_dev_reread_id().  This is done because
>> 1. there's retry label anyway 2. ata_dev_reread_id() cannot be used
>> anywhere else so there's no reason to keep it.
>>
>> This function is probably the place to set transfer mode to PIO0
>> before IDENTIFY.  However, reset -> identify -> init_dev_params order
>> should be kept for pre-ATA4 devices so we cannot set transfer mode
>> before IDENTIFY for them.  How do we know if a device is post-ATA4
>> before IDENTIFY?
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
> 
> I think you should order this patch before the dev->id[0] reworked patch.

Will do.

> In particular, "p_id = id" appears to stomp on the existing dev->id 
> allocation.

Hmmm... ata_dev_read_id() is responsible for allocating id array and the 
caller is responsible for making sure what p_id points to is 
deallocated. e.g. ata_dev_revalidate() frees dev->id before passing it 
to ata_dev_read_id().  Seems problemetic?

-- 
tejun
