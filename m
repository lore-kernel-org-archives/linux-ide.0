From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Implementing NVMHCI...
Date: Sat, 11 Apr 2009 15:54:41 -0400
Message-ID: <49E0F581.6010901@garzik.org>
References: <49E0D47B.9070205@garzik.org> <20090411203246.513a0892@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57674 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754655AbZDKTyp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Apr 2009 15:54:45 -0400
In-Reply-To: <20090411203246.513a0892@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>

Alan Cox wrote:
>> 	  The spec describes the sector size as
>> 	  "512, 1k, 2k, 4k, 8k, etc."   It will be interesting to reach
>> 	  "etc" territory.
> 
> Over 4K will be fun.
> 
>> - ahci.c becomes a tiny stub with a pci_device_id match table,
>>    calling functions in libahci.c.
> 
> It needs to a be a little bit bigger because of the folks wanting to do
> non PCI AHCI, so you need a little bit of PCI wrapping etc

True...


>>    With a brand new command set, might as well avoid SCSI completely IMO,
>>    and create a brand new block device.
> 
> Providing we allow for the (inevitable ;)) joys of NVHCI over SAS etc 8)

Perhaps...  from what I can tell, this is a direct, asynchronous NVM 
interface.  It appears to lack any concept of bus or bus enumeration. 
No worries about link up/down, storage device hotplug, etc.  (you still 
have PCI hotplug case, of course)

	Jeff



