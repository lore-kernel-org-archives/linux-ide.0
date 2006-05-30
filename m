From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/13] libata-hp: implement bootplug
Date: Tue, 30 May 2006 13:40:33 +0900
Message-ID: <447BCCC1.9070108@gmail.com>
References: <11488847361536-git-send-email-htejun@gmail.com> <447BC8AC.4060501@pobox.com> <447BCA46.4000607@gmail.com> <447BCB67.40405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:32482 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932122AbWE3Ekk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 May 2006 00:40:40 -0400
Received: by wr-out-0506.google.com with SMTP id i7so1023054wra
        for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 21:40:39 -0700 (PDT)
In-Reply-To: <447BCB67.40405@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Tejun Heo wrote:
>>>> +static int ata_boot_probe_wait(void *dummy)
>>>> +{
>>>> +    schedule();
>>>
>>> schedule_timeout(1) is preferred
>>
>> Can you elaborate?  AFAICS, the function is entered in 
>> TASK_UNINTERRUPTIBLE state.  No busy looping there.  It's called from 
>> wait_on_bit() which takes care of sleep/wakeup conditions.
> 
> Well, the purpose is to _wait, and so schedule_timeout() is more 
> appropriate than schedule().  I also that an unconditional schedule() is 
> a bit unfriendly if there is nothing useful to schedule at the moment.

Hmmm... I'm not very sure whether using schedule_timeout() inside 
wait_on_bit() is allowed or not.  I think it should work but I don't 
think it's supposed to be used that way.

Actually, I'm thinking about dropping the wait_on_bit() and implement 
generic helper to wait for EH completion as it's done in more than one 
places (during boot probing and unload unplugging and suspend/resume in 
future).  It probably will use completion.  Would that be better?

-- 
tejun
