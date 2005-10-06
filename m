From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ATAPI corruption found
Date: Thu, 06 Oct 2005 05:56:11 -0400
Message-ID: <4344F4BB.20707@pobox.com>
References: <4343A564.2060308@pobox.com> <4344C064.80103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:59360 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750778AbVJFJ4O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 05:56:14 -0400
In-Reply-To: <4344C064.80103@gmail.com>
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
>> When atapi_qc_complete() takes the error path, completes the SCSI 
>> command, SCSI EH runs, and the code attempts to complete the SCSI 
>> command again, this time with scsi_finish_command().
> 
> 
>  Umm.. that's how it worked until now by design.  Can you elaborate how 
> corruption occurs?

It completes the SCSI command twice.  Once in atapi_qc_complete(), and 
once in ata_qc_timeout().

And I doubt it has ever -really- worked as hoped...

	Jeff



