From: Tejun Heo <htejun@gmail.com>
Subject: Re: SCSI EH tidbit
Date: Thu, 13 Oct 2005 11:51:40 +0900
Message-ID: <434DCBBC.70106@gmail.com>
References: <434D263A.1070708@pobox.com> <434D2B57.4010806@gmail.com> <434D6B4C.3010001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:65294 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751109AbVJMCvs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2005 22:51:48 -0400
Received: by zproxy.gmail.com with SMTP id i11so313908nzi
        for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2005 19:51:47 -0700 (PDT)
In-Reply-To: <434D6B4C.3010001@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


  Hello, Jeff.

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>>
>>  Hi, Jeff.
>>
>> Jeff Garzik wrote:
>>
>>>
>>> I'm thinking that __scsi_done() might be more appropriate than 
>>> scsi_finish_command(), for use in completing commands in the EH path. 
>>> There may need to be some timer-related mods somewhere to make that 
>>> work, though.
>>
>>
>>
>>  Can you elaborate on why you think that would be a good idea?  I see 
>> cons but not many pros.  My cons are...
>>
>> * SCSI EH uses scsi_finish_command()
>>
>> * iodone/err counters will be incremented twice
>>
>> * has possibility of looping
> 
> 
> 
> scsi_finish_command unconditionally completes the command, rather than 
> running it through scsi_decide_disposition() decision tree again.  That 
> prevents us from using the standard command-retry path, for PCI/ATA bus 
> errors where we want to resubmit the command.

  That can be done by finishing with scsi_queue_insert as done by the 
current SCSI EH implementation.  And, yes, that also can be done by 
generating appropriate sense data and run it through __scsi_done again.

  The thing is that I don't really see much difference between finishing 
with scsi_queue_insert/scsi_queue_insert and using __scsi_done.  I'm 
opting for not using __scsi_done mainly because that's how the current 
SCSI EH implementation is implemented and I don't really think it would 
be a good idea to do things differently from SCSI EH without clear reason.

  Also, please note that for some errors, there might not be clearly 
matching sense code.  We can read_scsi_decide_dispostion() and find out 
sense code which does what we want and then emulate that value, but I 
don't know.  It just doesn't seem like a very good idea to me.

> There would be no loop, as __scsi_done() simply raises a softirq.  There 
> are just a few details to consider in case you're in the error handler.

  I don't know whether you already have decided ATAPI sense data should 
be collected outside EH as you haven't replied to my message yet, but 
let's say we perform request sensing in EH.  The sequence would be...

1. ATAPI error occurs
2. somehow __scsi_done is called, which raises SOFTIRQ
3. scsi_softirq kicks in and sees that there's no sense data
4. SCSI EH invoked, libata EH invoked
5. EH requests SENSE

  Let's assume that request sense returns NO SENSE here.

6. EH invokes __scsi_done
7. softirq raised
8. scsi_softirq runs cmd through scsi_decide_disposition
9. disposition is FAILED, invoke scsi_eh_scmd_add
10. the scmd enters EH again

  Note that any sense data which returns FAILED from 
scsi_decide_disposition will trigger the same sequence.  We can of 
course change sense data to something for which 
scsi_decide_disposition() does not return FAILED, but I think that would 
be a bit fragile.

  The situation is similar when generating sense data.  We can always 
generate sense data for which scsi_decide_disposition() would never 
return FAILED.  But IMHO it doesn't look like a very good idea.

  Thanks.

-- 
tejun
