From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] implement and use port_task
Date: Tue, 07 Mar 2006 16:01:11 +0900
Message-ID: <440D2FB7.9000109@gmail.com>
References: <11415401073423-git-send-email-htejun@gmail.com> <440D2497.7050504@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:5562 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752085AbWCGHBY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Mar 2006 02:01:24 -0500
Received: by zproxy.gmail.com with SMTP id 14so1438311nzn
        for <linux-ide@vger.kernel.org>; Mon, 06 Mar 2006 23:01:24 -0800 (PST)
In-Reply-To: <440D2497.7050504@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Albert Lee wrote:
> Hi Jeff,
> 
>>This patchset implements port_task and replace pio_task and
>>packet_task with it.  port_task isn't very different from pio_task or
>>packet_task - it's straight forward generalization.  The port_task is
>>a per-port task avaliable to low level drivers which is managed by
>>libata core layer.
>>
>>Differences from pio/packet task.
>>
>>* Not limited to PIO HSM implementation.  Other drivers can use it.
>>
>>* Synchronization against EH core layer is done within libata core
>>  layer, not in PIO HSM implementation (ata_qc_timeout()).
>>
>>Thanks.
>>
>>--
>>tejun
>>
> 
> 
> Something related to the PIO HSM.
> After the task renaming by this patchset, the task name is changed from pio_task to port_task.
> Should we add polling DMA support to the polling HSM?
> It could make the polling HSM more complete.
> 
> Polling DMA does no performance gain. However, DMA has crc check,
> so it won't be worse than PIO when irq is not working.
> 

Hmmm... Does irq-pio branch still have polling pio support? I hope we 
can implement polling without impacting normal code path in some generic 
way (pseudo periodic interrupts and each interrupt handler returning 
without doing any harm if nothing has happened should work). I don't 
think complicating HSM with DMA-by-polling is a good idea. It's not like 
all low level drivers can share single implementation of HSM.

Thanks.

-- 
tejun
