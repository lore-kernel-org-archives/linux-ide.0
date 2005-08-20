From: Tejun Heo <htejun@gmail.com>
Subject: Re: More libata EH data points
Date: Sun, 21 Aug 2005 02:11:44 +0900
Message-ID: <43076450.4030007@gmail.com>
References: <4306D2F2.9000309@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:57960 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932584AbVHTRMJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Aug 2005 13:12:09 -0400
Received: by wproxy.gmail.com with SMTP id i2so797121wra
        for <linux-ide@vger.kernel.org>; Sat, 20 Aug 2005 10:12:02 -0700 (PDT)
In-Reply-To: <4306D2F2.9000309@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>

Jeff Garzik wrote:
> Check out this lkml thread: 
> http://marc.theaimsgroup.com/?t=111709353400001&r=1&w=2
> 
> It may help to turn on CONFIG_DEBUG_SLAB...
> 

  Hello, Jeff.  Hello, Mark.

  The thread is reporting the following two problems.

  1. w/o patch, scmd is accessed after deallocated.
  2. w/ patch, scmd is freed twice.

  I'm aware of both problems and have just verified both with test 
cases.  The first problem is caused by not clearing eh_cmdq in 
ata_scsi_error.  This leaves eh_cmd_q pointing at freed scmd after eh is 
complete.

  After the first eh is complete, eh_cmd_q is pointing to freed scmd(s). 
  When the next error occurs, scsi_softirq() calls scsi_eh_scmd_add(), 
which adds the command to shost->eh_cmd_q.  As eh_cmd_q contains 
dangling pointers, this corrupts freed memory causing #1 (and infinite 
loop depending on circumstances).

  The patch modifies ATAPI eh path to use ata_qc_timeout_done instead of 
scsi_finish_cmd and scmd's are finished by scsi_invoke_strategy_handler 
using scsi_eh_flush_done_q.  As ATA timeout path isn't modified, when an 
ATA timeout occurs, a scmd is finished first in ata_qc_timeout and again 
in scsi_invoke_strategy_handler causing double free.

  With INIT_LIST_HEAD(&host->eh_cmd_q) one liner patch, both problems 
don't occur.  As for Mark's lockup problem, I think that it's probably a 
different issue.  One of probable lockup scenario is...

  1. ATAPI command gets issued for probing. (PROT_ATAPI_NODATA)
  2. atapi_packet_task sends cdb
  3. interrupt occurs and command is failed
  4. EH entered, sense requested (PROT_ATAPI_PIO, ATA_NIEN set)
  5. Machine enters sleep state
  6. Machine wakes up
  7. Power event raises an interrupt.
  8. *BOOM* We're in a screaming interrupt lockup.

  It might be that Mark was experiencing both freed memory corruption 
problem and above scenario.  Although I don't see how the broken fix 
patch would prevent some lockup which would occur with the one liner, 
as, AFAIK, the one liner does everything that the broken patch tries to 
do.  The only difference is that the one liner doesn't clear 
scmd->eh_entry, but this shouldn't cause any trouble.

  When and if time permits, it would be very helpful for Mark to gather 
some information about the lockups.  We currently don't even know if 
we're looking at the same problem.  Especially as the current libata 
implementation is not ready for suspending/resuming and doesn't 
synchronize with polling tasks.

  Thanks.

-- 
tejun
