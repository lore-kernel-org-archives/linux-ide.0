From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/6] libata: separate out ata_dev_read_id()
Date: Tue, 28 Feb 2006 11:56:19 -0500
Message-ID: <440480B3.8080609@gmail.com>
References: <11404555313091-git-send-email-htejun@gmail.com> <43FA5845.1050800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:14570 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751680AbWB1Cy6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Feb 2006 21:54:58 -0500
Received: by zproxy.gmail.com with SMTP id 13so1061747nzn
        for <linux-ide@vger.kernel.org>; Mon, 27 Feb 2006 18:54:57 -0800 (PST)
In-Reply-To: <43FA5845.1050800@pobox.com>
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
> 
> 
> applied 1-2, will get to the rest a bit later, after other work and some 
> testing of this work.

Hello, Jeff.

How is this going? Just checking as it's been more than a week.

-- 
tejun
