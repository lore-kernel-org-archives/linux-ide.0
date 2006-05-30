From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 06/13] libata-hp: implement bootplug
Date: Tue, 30 May 2006 00:34:47 -0400
Message-ID: <447BCB67.40405@pobox.com>
References: <11488847361536-git-send-email-htejun@gmail.com> <447BC8AC.4060501@pobox.com> <447BCA46.4000607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:9701 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932075AbWE3EfD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:35:03 -0400
In-Reply-To: <447BCA46.4000607@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> +static int ata_boot_probe_wait(void *dummy)
>>> +{
>>> +    schedule();
>>
>> schedule_timeout(1) is preferred
> 
> Can you elaborate?  AFAICS, the function is entered in 
> TASK_UNINTERRUPTIBLE state.  No busy looping there.  It's called from 
> wait_on_bit() which takes care of sleep/wakeup conditions.

Well, the purpose is to _wait, and so schedule_timeout() is more 
appropriate than schedule().  I also that an unconditional schedule() is 
a bit unfriendly if there is nothing useful to schedule at the moment.

	Jeff



