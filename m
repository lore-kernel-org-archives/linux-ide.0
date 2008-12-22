From: Tejun Heo <htejun@gmail.com>
Subject: Re: Help interpreting AHCI failure messages
Date: Mon, 22 Dec 2008 18:54:57 +0900
Message-ID: <494F63F1.3020207@gmail.com>
References: <4942D651.1050306@goop.org> <4943317C.8000807@shaw.ca>	 <49434EC9.4070408@goop.org> <49446DD0.3030600@gmail.com>	 <494BCC08.4070206@goop.org> <494F11FD.1040606@gmail.com> <f4527be0812220117v6fcc72c6v8012247ec443f636@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:8299 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbYLVJzG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Dec 2008 04:55:06 -0500
In-Reply-To: <f4527be0812220117v6fcc72c6v8012247ec443f636@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lyon <andrew.lyon@gmail.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Xen-devel <xen-devel@lists.xensource.com>, Gerd Hoffmann <kraxel@redhat.com>

Hello,

Andrew Lyon wrote:
>>>>> Furthermore, ata2 - which is sharing the same interrupt - seems to have
>>>>> managed to read the DVD drive's information, so something must be
>>>>> working.  But why is it failing for the disk?
>>>> Can you try irqpoll on it?
>>> Here's a log of a run where everything works initially, but then it
>>> starts to fail (about half way into the log).  ATA_DEBUG is enabled, so
>>> its pretty verbose.
>>>
>>> http://kraxel.fedorapeople.org/for-jeremy/xeni.log
>>>
>>> Does anything stand out?
>> Can you please exclude pata_acpi from the initrd and see whether
>> anything changes?
> 
> I have already tried using a kernel with pata_acpi disabled, it does not help.

There's a BUG messages in the log and several IRQ enable/disable
messages && once timeout happens on one of the ata port, the other one
begins to time out too.  I'm out of ideas and think this really needs
a look from someone who knows xen.  It doesn't seem to be a libata
problem at this point.

Thanks.

-- 
tejun
