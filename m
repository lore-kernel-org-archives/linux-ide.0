From: Pavel Andrianov <andrianov@ispras.ru>
Subject: Re: Potential race condition in drivers/ata/sata_mv.ko
Date: Thu, 11 Aug 2016 17:18:31 +0300
Message-ID: <904de563-24df-768a-9642-5aab5ed18f5e@ispras.ru>
References: <8d7d8958-1a77-7c39-d008-fb6362e15d57@ispras.ru>
 <20160810035133.GD25053@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160810035133.GD25053@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, Vaishali Thakkar <vaishali.thakkar@oracle.com>
List-Id: linux-ide@vger.kernel.org

Hi!

I have found such example:

... ->

ata_exec_internal_sg ->

     ata_qc_issue ->

         mv_qc_issue ->

             mv_clear_and_enable_port_irqs ->

                 mv_enable_port_irqs ->

                     mv_set_main_irq_mask


ata_exec_internal_sg acquires spin_lock(ap->lock) and call of the last 
function mv_set_main_irq_mask is with this lock. mv_interrupt acquires 
spin_lock(host->lock) before call of the same function. I am not sure is 
it correct to add one more spin_lock or move a call of request_irq in 
ata_host_activate, thus I can not easily fix the issue.

One more question is related to ata_exec_internal_sg. In comments there 
is an information the function is called without locking. However, 
ata_exec_internal_sg calls ata_eh_release before ata_eh_acquire (lines 
1650, 1655).There is a block of code under spinlock and eh context can 
not be acquired there. The comment may be wrong and eh_context is 
acquired somewhere before, but I also can not find it. Do you know where 
is the initial acquire of eh_context in this case?


10.08.2016 06:51, Tejun Heo пишет:
> Hello,
>
> On Fri, Aug 05, 2016 at 03:43:30PM +0300, Pavel Andrianov wrote:
>> In drivers/ata/sata_mv.ko function mv_set_main_irq_mask is called several
>> times. Twice with a spinlock, twice from init function and once without any
>> protection. The call without protection rises to several handlers from
>> ata_port_operations. The structure with the ata_port_operations is included
>> into a structure 'host' in mv_platform_probe and in mv_pci_init_one. At the
>> end of these functions ata_host operations are activated together with
>> interrupt handler. The conclusion is: interrupt handler may be executed in
>> parallel with handlers from ata_port_operations, or, more formally, it may
>> interrupt its execution.
>>
>> In mv_set_main_irq_mask and in interrupt handler mv_interrupt the interrupt
>> mask is modified, but, as I said, handlers from ata_port_operations do not
>> acquire any lock. Thus, the interrupt mask may be set incorrectly if the are
>> two conflicting modifications.
> It depends on which operations.  Most are only called from EH context
> and racing there isn't likely to cause any actual issues.  Care to
> submit a patch to fix the issue?
>
> Thanks.
>

-- 
Pavel Andrianov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
e-mail: andrianov@ispras.ru
