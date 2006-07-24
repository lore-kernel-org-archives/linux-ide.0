From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/3] libata: implement hotplug by polling
Date: Mon, 24 Jul 2006 16:06:37 +0900
Message-ID: <44C4717D.6080700@gmail.com>
References: <11531196481023-git-send-email-htejun@gmail.com> <44BE9CBC.2000601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:61978 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751217AbWGXJ4k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Jul 2006 05:56:40 -0400
Received: by py-out-1112.google.com with SMTP id t32so2506058pyc
        for <linux-ide@vger.kernel.org>; Mon, 24 Jul 2006 02:56:07 -0700 (PDT)
In-Reply-To: <44BE9CBC.2000601@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> NAK, there is no reason why a global poll list is needed.  Simply having 
> a struct workqueue in each schedule-able entity implicitly creates such 
> a list.  But regardless, this is another example of adding 
> cross-controller synchronization, where none is needed.
> 
> If the worker fired per-host_set, then you could use an ata_port dynamic 
> flag to indicate the poll-active ports, for the ata_hp_poll_worker() loop.
> 
> If the worker fires per-port, then no loop or mutex is needed at all. 
> You could simply call the hp_poll hook.

It was basically an optimization to reduce storage usage and spread all 
polling operations at least by polling interval even when there are many 
ports to poll.  Cross-port synchronization aside, it's very simple too. 
  Hmm... I don't think it makes much difference either way though.  I'll 
convert to per-port workqueue + timer.

>> @@ -633,6 +637,10 @@ struct ata_port_operations {
>>      void (*error_handler) (struct ata_port *ap);
>>      void (*post_internal_cmd) (struct ata_queued_cmd *qc);
>>  
>> +    void (*hp_poll_activate) (struct ata_port *ap);
>> +    void (*hp_poll_deactivate) (struct ata_port *ap);
>> +    int (*hp_poll) (struct ata_port *ap);
>> +
>>      irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
>>      void (*irq_clear) (struct ata_port *);
>>  
> 
> All new hooks require at least a one-two sentence description in the 
> DocBook docs, telling driver writers how to use them.

Will do.

-- 
tejun

