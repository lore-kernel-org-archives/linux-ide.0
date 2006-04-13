From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 11/16] libata-eh-fw: implement new EH scheduling via timeout
Date: Wed, 12 Apr 2006 23:18:00 -0400
Message-ID: <443DC2E8.8000005@pobox.com>
References: <1144762974340-git-send-email-htejun@gmail.com> <443D8106.4000607@pobox.com> <443DBA20.9050508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:28349 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932435AbWDMDSM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Apr 2006 23:18:12 -0400
In-Reply-To: <443DBA20.9050508@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> The problem is that the timeout handler doesn't have anyway to determine 
> whether the timeout is from real timeout or from DMA error, and the 

Not true at all.  Just read BMDMA status.  Take a look at what 
drivers/ide does.


> timeout handler is responsible for transferring the ownership the failed 
> port to EH.  EH, on entry, must be guaranteed that it owns the port if 
> it's not frozen.
> 
> One way around this would be making a new callback, say, 
> ->timeout_autopsy and let it decide whether the port needs freezing or 
> not, but it would be an overkill.  The only side effect of being frozen 
> is that the port will get a softreset to thaw it, which isn't so bad - I 
> want my controller to get a good spanking in the ass after sitting idle 
> for 30secs.

When presented with standard, documented DMA error behavior, a reset is 
inappropriate.  Just ACK the DMA error and move on with life.  If 
continuous DMA errors occur, reset and/or step down the speed as was 
discussed many months ago.

Get the user back up and talking to their disk as fast as possible.

	Jeff


