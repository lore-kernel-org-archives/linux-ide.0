From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/02] libata: implement ata_eh_wait()
Date: Fri, 09 Jun 2006 12:53:45 +0900
Message-ID: <4488F0C9.7040002@gmail.com>
References: <20060531101932.GA8106@htj.dyndns.org> <20060531102005.GB8106@htj.dyndns.org> <44888D59.9010000@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:23963 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965133AbWFIDxy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Jun 2006 23:53:54 -0400
Received: by py-out-1112.google.com with SMTP id x31so838853pye
        for <linux-ide@vger.kernel.org>; Thu, 08 Jun 2006 20:53:54 -0700 (PDT)
In-Reply-To: <44888D59.9010000@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> +    spin_lock_irqsave(&ap->host_set->lock, flags);
>> +
>> +    while (ap->flags & (ATA_FLAG_EH_PENDING | 
>> ATA_FLAG_EH_IN_PROGRESS)) {
>> +        prepare_to_wait(&ap->eh_wait_q, &wait, TASK_UNINTERRUPTIBLE);
>> +        spin_unlock_irqrestore(&ap->host_set->lock, flags);
>> +        schedule();
>> +        spin_lock_irqsave(&ap->host_set->lock, flags);
>> +    }
> 
> 
> Two comments:
> 
> * why not use completions?

Mainly because there can be more than one waiters and also because the 
waiting doesn't really fit completion semantics.  In some places, 
eh_wait is used just to flush EH without actually scheduling EH.  In 
such cases, there's no synchronization point to start waiting for 
completion.

> * don't use schedule().  If there's nothing to schedule, it IMO chews up 
> too much CPU busy-waiting.  schedule_timeout(1) will at least wait for 
> the next timer tick.

I don't really understand your point here.  All that schedule_timeout() 
does is adding a timer to wake it up after the given jiffies pass.  It 
only adds wake up condition.  ie. it only makes sleeps shorter not 
longer.  e.g. both of the following code snippets result in busy 
sleep/wake up loop.

__set_current_state(TASK_RUNNING);
while (some_condition)
	schedule();

-------

__set_current_state(TASK_RUNNING);
while (some_condition)
	schedule_timeout(1);

The only behavior difference between above two code snippets is that the 
latter registers and unregisters timer every iteration which probably 
never expires as the thread would usually get scheduled again before a 
full tick passes.

AFAICS, schedule_timeout() is to be used when the wait should be 'timed 
out' when the thread has other wake up condition it's waiting for but it 
doesn't want to wait forever.  As a special case, when the condition is 
nil, it works as unconditional sleep.

Whether a thread gets rescheduled or not is determined by 
current->task_state.  If it's RUNNING, it will get rescheduled 
immediately.  If it's UNINTERRUPTIBLE or INTERRUPTIBLE, it will wait 
till gets woken up.  schedule() simply means the caller is done with the 
CPU at the moment and giving it away.

In eh_wait(), prepare_to_wait() is called w/ TASK_UNINTERRUPTIBLE before 
calling schedule, which sets current->task_state to UNINTERRUPTIBLE. 
The thread won't be scheduled again until the wait condition triggers 
and restores task_state to RUNNING.

Oops, I forgot calling finish_wait() after exiting the loop.  I'll 
submit a patch as soon as #upstream is updated.  Sorry.

Anyways, please read workqueue.c::flush_cpu_workqueue() and 
sched.c::wait_for_completion().  These two functions use similar waiting 
loops.

Thanks.

-- 
tejun
