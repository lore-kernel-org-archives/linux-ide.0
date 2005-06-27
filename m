From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-dev-2.6-ncq: rewrite __ata_qc_complete
Date: Mon, 27 Jun 2005 20:13:42 +0900
Message-ID: <42BFDF66.3010402@gmail.com>
References: <20050626144110.GD24968@htj.dyndns.org> <42BEE593.7050004@pobox.com> <20050627082709.GO19550@suse.de> <42BFC68E.3020707@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:25315 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261727AbVF0LNv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2005 07:13:51 -0400
Received: by zproxy.gmail.com with SMTP id f1so159685nzc
        for <linux-ide@vger.kernel.org>; Mon, 27 Jun 2005 04:13:51 -0700 (PDT)
In-Reply-To: <42BFC68E.3020707@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Albert Lee wrote:
> 
> Tejun Heo wrote:
> 
>> Also, remove spurious clearing of ATA_QCFLAG_ACTIVE from
>> ata_qc_complete().
>>
> Hi Tejun:
> 
> Clearing the ATA_QCFLAG_ACTIVE in ata_qc_complete() is needed. We have to
> prevent the interrupt handler from racing with the error handler in ATAPI.
> (Please see the following link for the detail:
> http://marc.theaimsgroup.com/?l=linux-ide&m=111476734016857&w=2)
> 
> Albert
> 

  Hello, Albert.

  Ah... I see.  Sorry, I didn't check the ATAPI code (Is any SATA ATAPI 
device selling in retail shops?  I want one for testing but cannot find 
one).  I'll remove that removal ;-) and add some comment there to 
clarify things.  it also means that ATAPI handling of my NCQ helpers is 
broken

  BTW, now that I've read how libata defers command completion to EH 
using qc_complete return value, I have a question.  While I was writing 
NCQ EH, the biggest problem was that we're called differently from 
several places and EH conventions differ in each case.

  1. from libata core: we don't have associated SCSI command and EH 
won't be entered.
  2. from SCSI midlayer (SCSI special cmds): we have associated SCSI 
command but EH won't be entered on failure (scsidone is overrided).
  3. from blk via SCSI (SCSI normal cmds): we have associated SCSI 
command and EH will be entered on failure.

  I couldn't defer qc-completion on error interrupt to EH, as I don't 
know whether it will be entered or not.  So, NCQ helpers always 
qc-completes commands and NCQ EH helper deals with what's left.  It 
seems that the current ATAPI code doesn't account for these differences 
when handling errors.  Is EH-entrance guaranteed on ATAPI failures?

  TIA.

-- 
tejun
