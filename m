From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 11/16] libata-eh-fw: implement new EH scheduling via
	timeout
Date: Sat, 29 Apr 2006 22:13:12 +0100
Message-ID: <1146345193.3302.32.camel@localhost.localdomain>
References: <1144762974340-git-send-email-htejun@gmail.com>
	 <443D8106.4000607@pobox.com> <443DBA20.9050508@gmail.com>
	 <443DC2E8.8000005@pobox.com> <443DC751.8090209@gmail.com>
	 <4450AC03.303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9447 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750770AbWD2VDe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Apr 2006 17:03:34 -0400
In-Reply-To: <4450AC03.303@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

On Iau, 2006-04-27 at 07:33 -0400, Jeff Garzik wrote:
> Well overall I want to minimize the change from existing behavior, since 
> there is enough change as it is.  In current libata and drivers/ide, it 
> can continue after a properly indicated DMA error without doing a reset.

Sometimes. But the smarts in it also break some hardware horribly
because the properly indicated DMA error doesn't neccessarily leave the
state machines on the chip sane, and worse it sometimes does resets then
recovery and thats ugly.

> And I just think its rude, to reset hardware when it doesn't need 
> resetting.  Its sorta like the Windows mentality -- "just reboot it, 
> that will fix stuff"  Linux shouldn't be rude to hardware, when it need 
> not be :)

Windows generally uses a 7 second timeout btw.

