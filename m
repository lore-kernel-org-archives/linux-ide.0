From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATAPI corruption found
Date: Thu, 06 Oct 2005 23:33:36 +0900
Message-ID: <434535C0.5040007@gmail.com>
References: <4343A564.2060308@pobox.com> <4344C064.80103@gmail.com> <4344F4BB.20707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:51317 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751021AbVJFOdr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 10:33:47 -0400
Received: by wproxy.gmail.com with SMTP id i2so213094wra
        for <linux-ide@vger.kernel.org>; Thu, 06 Oct 2005 07:33:46 -0700 (PDT)
In-Reply-To: <4344F4BB.20707@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Albert Lee <albertcc@tw.ibm.com>


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
>>> When atapi_qc_complete() takes the error path, completes the SCSI 
>>> command, SCSI EH runs, and the code attempts to complete the SCSI 
>>> command again, this time with scsi_finish_command().
>>
>>
>>
>>  Umm.. that's how it worked until now by design.  Can you elaborate 
>> how corruption occurs?
> 
> 
> It completes the SCSI command twice.  Once in atapi_qc_complete(), and 
> once in ata_qc_timeout().

  I hope I'm not completely misunderstanding what you're saying.  If so, 
please be kind enough to point out.

  When a SCSI LLDD reports failure of a command to midlayer, several 
actions can be taken.  scsi_decide_disposition() determines what to do 
depending on which result code LLDD reports and what content the sense 
buffer contains.  Some commands are just reported upward 
(scsi_finish_command), some retried and other are passed on to EH for 
further recovery action.

  When a scmd is handed off to EH,

- it isn't finished yet.
- it will be finished or retried by calling either scsi_finish_command()
   or scsi_queue_insert().

  So, when EH is needed, SCSI ML passes the scmd to EH without finishing 
it and EH is responsible of what to do with the scmd.

  This is exactly what's going on w/ ATAPI request sensing.  libata asks 
SCSI ML to invoke EH for the scmd by completing a scmd with CHECK_SENSE 
but without sense data, so SCSI ML invokes EH to read sense data and 
actually determine what to do.  libata EH is invoked and it reads sense 
data and finishes the scmd with the sense data.  AFAIK, this is how SCSI 
EH works.

> And I doubt it has ever -really- worked as hoped...

  With proper fixes to libata EH, it works.  I can definitely tell you 
that and I think Albert can also verify that ATAPI request sensing 
works.  libata EH currently has some issues with stuff like 
synchronization with normal processing and etc, but it's nothing 
fundamental.  After all, that's how SCSI EH works.

  If I'm being stupid here, please point out.  I'll hit my head as hard 
as I can and take a long tearful shower.  :-)

  Thanks.

-- 
tejun
