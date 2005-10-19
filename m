From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SCSI EH tidbit
Date: Tue, 18 Oct 2005 23:56:23 -0400
Message-ID: <4355C3E7.6090507@pobox.com>
References: <434D263A.1070708@pobox.com> <434D2B57.4010806@gmail.com> <434D6B4C.3010001@pobox.com> <434DCBBC.70106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:45982 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932451AbVJSD43 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Oct 2005 23:56:29 -0400
In-Reply-To: <434DCBBC.70106@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> scsi_finish_command unconditionally completes the command, rather than 
>> running it through scsi_decide_disposition() decision tree again.  
>> That prevents us from using the standard command-retry path, for 
>> PCI/ATA bus errors where we want to resubmit the command.
> 
> 
>  That can be done by finishing with scsi_queue_insert as done by the 
> current SCSI EH implementation.  And, yes, that also can be done by 
> generating appropriate sense data and run it through __scsi_done again.

good point.


>  The thing is that I don't really see much difference between finishing 
> with scsi_queue_insert/scsi_queue_insert and using __scsi_done.  I'm 
> opting for not using __scsi_done mainly because that's how the current 
> SCSI EH implementation is implemented and I don't really think it would 
> be a good idea to do things differently from SCSI EH without clear reason.

I like transport separation, since libata needs to be a bit closer to 
its "pure" form:  an ATA API, which is used by libata-scsi client.


>  The situation is similar when generating sense data.  We can always 
> generate sense data for which scsi_decide_disposition() would never 
> return FAILED.  But IMHO it doesn't look like a very good idea.

SCSI keeps an internal counter to make sure that commands are not 
retried forever.

	Jeff



