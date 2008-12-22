From: Tejun Heo <htejun@gmail.com>
Subject: Re: Help interpreting AHCI failure messages
Date: Mon, 22 Dec 2008 13:05:17 +0900
Message-ID: <494F11FD.1040606@gmail.com>
References: <4942D651.1050306@goop.org> <4943317C.8000807@shaw.ca> <49434EC9.4070408@goop.org> <49446DD0.3030600@gmail.com> <494BCC08.4070206@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:41786 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbYLVEFa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Dec 2008 23:05:30 -0500
In-Reply-To: <494BCC08.4070206@goop.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Xen-devel <xen-devel@lists.xensource.com>, Gerd Hoffmann <kraxel@redhat.com>

Hello,

Jeremy Fitzhardinge wrote:
>>> Furthermore, ata2 - which is sharing the same interrupt - seems to have
>>> managed to read the DVD drive's information, so something must be
>>> working.  But why is it failing for the disk?
>>
>> Can you try irqpoll on it?
> 
> Here's a log of a run where everything works initially, but then it
> starts to fail (about half way into the log).  ATA_DEBUG is enabled, so
> its pretty verbose.
> 
> http://kraxel.fedorapeople.org/for-jeremy/xeni.log
> 
> Does anything stand out?

Can you please exclude pata_acpi from the initrd and see whether
anything changes?

-- 
tejun
