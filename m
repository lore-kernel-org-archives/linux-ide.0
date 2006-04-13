From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 11/16] libata-eh-fw: implement new EH scheduling via timeout
Date: Thu, 13 Apr 2006 11:40:32 +0900
Message-ID: <443DBA20.9050508@gmail.com>
References: <1144762974340-git-send-email-htejun@gmail.com> <443D8106.4000607@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:22823 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932430AbWDMCkp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Apr 2006 22:40:45 -0400
Received: by pproxy.gmail.com with SMTP id i49so1849018pye
        for <linux-ide@vger.kernel.org>; Wed, 12 Apr 2006 19:40:43 -0700 (PDT)
In-Reply-To: <443D8106.4000607@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Implement new EH scheduling from timeout.  ata_scsi_timedout() also
>> takes care of the race condition in which scsi_eh_schedule_qc() sets
>> ATA_QCFLAG_EH_SCHEDULED but fails to acutally schedule EH for the qc
>> because it loses to timeout.
>>
>> A timeout is HSM violation condition.  New EH assumes that on a
>> timeout the state of the controller and devices are unknown and
>> dangerous.  So, all active commands are aborted and the port is
>> frozen.  Note that commands which get aborted this way don't have its
>> qc->err_mask set and its retries count will be compensated.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> This is not always true:  With PCI IDE BMDMA devices, it is presumed 
> that a DMA error will be handled by timeout.  For this case, the 
> controller is in a known state.
> 

The problem is that the timeout handler doesn't have anyway to determine 
whether the timeout is from real timeout or from DMA error, and the 
timeout handler is responsible for transferring the ownership the failed 
port to EH.  EH, on entry, must be guaranteed that it owns the port if 
it's not frozen.

One way around this would be making a new callback, say, 
->timeout_autopsy and let it decide whether the port needs freezing or 
not, but it would be an overkill.  The only side effect of being frozen 
is that the port will get a softreset to thaw it, which isn't so bad - I 
want my controller to get a good spanking in the ass after sitting idle 
for 30secs.

-- 
tejun
