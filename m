From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/4] libata: fix handling of race between timeout and
 completion
Date: Thu, 09 Feb 2006 01:33:22 -0500
Message-ID: <43EAE232.40108@pobox.com>
References: <11388093703309-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:19609 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422814AbWBIGd0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 01:33:26 -0500
In-Reply-To: <11388093703309-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> If a qc completes after SCSI timer expires but before libata EH kicks
> in, the qc gets completed but the scsicmd still gets passed to libata
> EH resulting in ->eng_timeout invocation with NULL qc.  Currently none
> of ->eng_timeout callbacks handles this properly.  This patch makes
> ata_scsi_error() bypass ->eng_timeout and handle this rare case.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

OK in general (I acknowledge the problem you point out), but NAK for 
this patch.


> +		scmd = list_entry(host->eh_cmd_q.next,
> +				  struct scsi_cmnd, eh_entry);
> +		sb = scmd->sense_buffer;
> +
> +		/* Timeout, fake parity for now */
> +		scmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
> +		sb[0] = 0x70;
> +		sb[7] = 0x0a;
> +		sb[2] = ABORTED_COMMAND;
> +		sb[12] = 0x47;
> +		sb[13] = 0x00;
> +
> +		printk(KERN_WARNING "ata%u: interrupt and timer raced for "
> +		       "scsicmd %p\n", ap->id, scmd);
> +
> +		scsi_eh_finish_cmd(scmd, &ap->eh_done_q);

OK in general, but I disagree with the handling of the qc==NULL case.

If you hit the "if scsi timer already fired" shortcut in scsi_done(), 
that demonstrates clear intent to complete the scsi command.  Thus, when 
libata EH handling starts, our only task for that scsi command is to 
complete it.

Signalling an aborted command stomps all over the current, valid SCSI 
command results.

As a side note, this area of code is part of the reason why I was 
thinking I wanted ...FLAG_EH_TIMEOUT.  My thought was that libata sets 
that in ->eh_timed_out(). ata_qc_complete() would check that flag, and 
refuse to call __ata_qc_complete() if it was set.  Doing so causes both 
the qc and the scsi command to be completed inside the EH handler.  But 
that's just an off-the-cuff thought...

	Jeff


