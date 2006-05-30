From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/13] libata-hp: implement bootplug
Date: Tue, 30 May 2006 13:29:58 +0900
Message-ID: <447BCA46.4000607@gmail.com>
References: <11488847361536-git-send-email-htejun@gmail.com> <447BC8AC.4060501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:20661 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932074AbWE3EaF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 May 2006 00:30:05 -0400
Received: by nz-out-0102.google.com with SMTP id s18so662227nze
        for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 21:30:04 -0700 (PDT)
In-Reply-To: <447BC8AC.4060501@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> +static int ata_boot_probe_wait(void *dummy)
>> +{
>> +    schedule();
> 
> schedule_timeout(1) is preferred

Can you elaborate?  AFAICS, the function is entered in 
TASK_UNINTERRUPTIBLE state.  No busy looping there.  It's called from 
wait_on_bit() which takes care of sleep/wakeup conditions.

>> +            spin_unlock_irqrestore(&ap->host_set->lock, flags);
>> +
>> +            wait_on_bit(&ap->flags, bit, ata_boot_probe_wait,
>> +                    TASK_UNINTERRUPTIBLE);
>> +
>> +            while (scsi_host_in_recovery(ap->host))
>> +                msleep(10);
> 
> Is this seemingly infinite loop _guaranteed_ to stop eventually?

Yeap.  Main thread is woken up after EH completes and EH is guaranteed 
to complete.

-- 
tejun
