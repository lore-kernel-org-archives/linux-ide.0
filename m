From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SCSI EH tidbit
Date: Wed, 12 Oct 2005 16:00:12 -0400
Message-ID: <434D6B4C.3010001@pobox.com>
References: <434D263A.1070708@pobox.com> <434D2B57.4010806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:1513 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751524AbVJLUAS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2005 16:00:18 -0400
In-Reply-To: <434D2B57.4010806@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> 
>  Hi, Jeff.
> 
> Jeff Garzik wrote:
> 
>>
>> I'm thinking that __scsi_done() might be more appropriate than 
>> scsi_finish_command(), for use in completing commands in the EH path. 
>> There may need to be some timer-related mods somewhere to make that 
>> work, though.
> 
> 
>  Can you elaborate on why you think that would be a good idea?  I see 
> cons but not many pros.  My cons are...
> 
> * SCSI EH uses scsi_finish_command()
> 
> * iodone/err counters will be incremented twice
> 
> * has possibility of looping


scsi_finish_command unconditionally completes the command, rather than 
running it through scsi_decide_disposition() decision tree again.  That 
prevents us from using the standard command-retry path, for PCI/ATA bus 
errors where we want to resubmit the command.

There would be no loop, as __scsi_done() simply raises a softirq.  There 
are just a few details to consider in case you're in the error handler.

	Jeff


