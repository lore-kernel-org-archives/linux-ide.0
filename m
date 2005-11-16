From: Edward Falk <efalk@google.com>
Subject: Re: [PATCH 5/5] sil24:  make error_intr less verbose
Date: Wed, 16 Nov 2005 10:35:57 -0800
Message-ID: <437B7C0D.1030405@google.com>
References: <20051116080935.GE22807@htj.dyndns.org> <437B285C.8020809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.12]:41246 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030429AbVKPSg3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Nov 2005 13:36:29 -0500
In-Reply-To: <437B285C.8020809@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org


>> -    printk(KERN_ERR DRV_NAME " ata%u: error interrupt on port%d\n"
>> -           "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
>> -           ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, 
>> sstatus, serror);
>> +    DPRINTK("ata%u: error interrupt on port%d\n"
>> +        "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
>> +        ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, 
>> serror);
> 
> 
> Mild NAK.

Agreed.  Bear in mind that it's an extrordinarily exceptional 
circumstance for the driver to reach this point.  If this happens, then 
something has truly gone wrong and the message should be logged.

Note that this point in the driver is *not* reached for an ordinary ATA 
errors, but only for the kind of errors that libata can't handle.

	-ed falk
