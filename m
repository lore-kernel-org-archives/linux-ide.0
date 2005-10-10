From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH libata-dev-2.6:passthru] passthru fixes
Date: Mon, 10 Oct 2005 16:39:06 -0400
Message-ID: <434AD16A.8080200@rtr.ca>
References: <20050913142636.GB5679@google.com> <43429028.5010901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:26544 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751189AbVJJUjK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Oct 2005 16:39:10 -0400
In-Reply-To: <43429028.5010901@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jeff Raubitschek <jhr@google.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Jeff Raubitschek wrote:
..
>> - passthru sense routines were refering to tf->command
>>   which is not read in tf_read, instead use drv_stat for
>>   status register.
>> - passthru sense passed back to user on ata_task_ioctl
>  
> ISTR there were some reported problems after applying this? 

Yes.  smartctl stops working when those patches are applied
(the buffer allocate failure patch was okay, though).

-ml
