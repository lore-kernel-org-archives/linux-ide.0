From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 11/16] libata-eh-fw: implement new EH scheduling via timeout
Date: Thu, 13 Apr 2006 12:36:49 +0900
Message-ID: <443DC751.8090209@gmail.com>
References: <1144762974340-git-send-email-htejun@gmail.com> <443D8106.4000607@pobox.com> <443DBA20.9050508@gmail.com> <443DC2E8.8000005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.207]:38487 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964775AbWDMDhE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Apr 2006 23:37:04 -0400
Received: by xproxy.gmail.com with SMTP id t10so1108133wxc
        for <linux-ide@vger.kernel.org>; Wed, 12 Apr 2006 20:37:04 -0700 (PDT)
In-Reply-To: <443DC2E8.8000005@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> The problem is that the timeout handler doesn't have anyway to 
>> determine whether the timeout is from real timeout or from DMA error, 
>> and the 
> 
> Not true at all.  Just read BMDMA status.  Take a look at what 
> drivers/ide does.

Yeap, what I meant was the current timeout handler implementation 
doesn't have any way to do that, so later in the previous reply, I 
talked about ->timeout_autopsy.

> 
>> timeout handler is responsible for transferring the ownership the 
>> failed port to EH.  EH, on entry, must be guaranteed that it owns the 
>> port if it's not frozen.
>>
>> One way around this would be making a new callback, say, 
>> ->timeout_autopsy and let it decide whether the port needs freezing or 
>> not, but it would be an overkill.  The only side effect of being 
>> frozen is that the port will get a softreset to thaw it, which isn't 
>> so bad - I want my controller to get a good spanking in the ass after 
>> sitting idle for 30secs.
> 
> When presented with standard, documented DMA error behavior, a reset is 
> inappropriate.  Just ACK the DMA error and move on with life.  If 
> continuous DMA errors occur, reset and/or step down the speed as was 
> discussed many months ago.

The speeding down part is the same whether the port is frozen or not. 
The only difference is how EH recovers the port after the error.  Failed 
devices on a not frozen port are just revalidated while a frozen port 
gets a reset.

Here is another method to deal with it as adding ->timeout_autopsy or 
anything similar is too unattractive.  A new interface, say, 
ata_eh_thaw_port() can be implemented which thaws the port without 
resetting it.  Then, in BMDMA autopsy, after determining that a timeout 
was caused by DMA error, it can thaw the port and adjust qc->err_mask to 
AC_ERR_HOST_BUS.  How does it sound to you?

> Get the user back up and talking to their disk as fast as possible.

Command timeout is 30 secs (which, I think is a bit too long for ATA 
disk devices).  If resetting succeeds, it takes less than two seconds. 
I don't think it will make any difference to the user.

-- 
tejun
