From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 11/16] libata-eh-fw: implement new EH scheduling via timeout
Date: Thu, 27 Apr 2006 07:33:23 -0400
Message-ID: <4450AC03.303@pobox.com>
References: <1144762974340-git-send-email-htejun@gmail.com> <443D8106.4000607@pobox.com> <443DBA20.9050508@gmail.com> <443DC2E8.8000005@pobox.com> <443DC751.8090209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:31911 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964946AbWD0Ld2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Apr 2006 07:33:28 -0400
In-Reply-To: <443DC751.8090209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Here is another method to deal with it as adding ->timeout_autopsy or 
> anything similar is too unattractive.  A new interface, say, 
> ata_eh_thaw_port() can be implemented which thaws the port without 
> resetting it.  Then, in BMDMA autopsy, after determining that a timeout 
> was caused by DMA error, it can thaw the port and adjust qc->err_mask to 
> AC_ERR_HOST_BUS.  How does it sound to you?

Seems rational.


>> Get the user back up and talking to their disk as fast as possible.
> 
> Command timeout is 30 secs (which, I think is a bit too long for ATA 
> disk devices).  If resetting succeeds, it takes less than two seconds. I 
> don't think it will make any difference to the user.

Well overall I want to minimize the change from existing behavior, since 
there is enough change as it is.  In current libata and drivers/ide, it 
can continue after a properly indicated DMA error without doing a reset.

And I just think its rude, to reset hardware when it doesn't need 
resetting.  Its sorta like the Windows mentality -- "just reboot it, 
that will fix stuff"  Linux shouldn't be rude to hardware, when it need 
not be :)

	Jeff


