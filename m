From: Tejun <htejun@gmail.com>
Subject: Re: [PATCH 3/4] libata: fix handling of race between timeout and
 completion
Date: Thu, 09 Feb 2006 18:08:51 +0900
Message-ID: <43EB06A3.3050708@gmail.com>
References: <11388093703309-git-send-email-htejun@gmail.com> <43EAE232.40108@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.207]:63853 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965226AbWBIJI5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 04:08:57 -0500
Received: by xproxy.gmail.com with SMTP id s14so81473wxc
        for <linux-ide@vger.kernel.org>; Thu, 09 Feb 2006 01:08:56 -0800 (PST)
In-Reply-To: <43EAE232.40108@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> If a qc completes after SCSI timer expires but before libata EH kicks
>> in, the qc gets completed but the scsicmd still gets passed to libata
>> EH resulting in ->eng_timeout invocation with NULL qc.  Currently none
>> of ->eng_timeout callbacks handles this properly.  This patch makes
>> ata_scsi_error() bypass ->eng_timeout and handle this rare case.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> 
> OK in general (I acknowledge the problem you point out), but NAK for 
> this patch.
> 
> 
>> +        scmd = list_entry(host->eh_cmd_q.next,
>> +                  struct scsi_cmnd, eh_entry);
>> +        sb = scmd->sense_buffer;
>> +
>> +        /* Timeout, fake parity for now */
>> +        scmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
>> +        sb[0] = 0x70;
>> +        sb[7] = 0x0a;
>> +        sb[2] = ABORTED_COMMAND;
>> +        sb[12] = 0x47;
>> +        sb[13] = 0x00;
>> +
>> +        printk(KERN_WARNING "ata%u: interrupt and timer raced for "
>> +               "scsicmd %p\n", ap->id, scmd);
>> +
>> +        scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
> 
> 
> OK in general, but I disagree with the handling of the qc==NULL case.
> 
> If you hit the "if scsi timer already fired" shortcut in scsi_done(), 
> that demonstrates clear intent to complete the scsi command.  Thus, when 
> libata EH handling starts, our only task for that scsi command is to 
> complete it.
> 
> Signalling an aborted command stomps all over the current, valid SCSI 
> command results.

Good day, Jeff.

I tried that but the problem is that if scsi timeout expires and then qc 
completes before eh kicks in, we lost some of completion information and 
thus I figured aborting (thus retrying) the commands is the way to go, 
but you're right.  The scsi status and stuff are recorded in scmd and we 
should honor those.  Thanks for pointing out.

> As a side note, this area of code is part of the reason why I was 
> thinking I wanted ...FLAG_EH_TIMEOUT.  My thought was that libata sets 
> that in ->eh_timed_out(). ata_qc_complete() would check that flag, and 
> refuse to call __ata_qc_complete() if it was set.  Doing so causes both 
> the qc and the scsi command to be completed inside the EH handler.  But 
> that's just an off-the-cuff thought...

Hmmm... right.  I'm not very sure about how the synchronization should 
be done, but if it can be done that way, that sounds much better than my 
dangling scmd handling hack.  I'll give it a try.

-- 
tejun
