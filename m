From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Add a drivers/ide style  DMA disable
Date: Fri, 07 Sep 2007 18:47:23 -0400
Message-ID: <46E1D4FB.8030409@garzik.org>
References: <20070822233710.415faaf0@the-village.bc.nu> <46E0CC76.70101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39703 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbXIGWr1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Sep 2007 18:47:27 -0400
In-Reply-To: <46E0CC76.70101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Alan Cox wrote:
>> This is useful when debugging, handling problem systems, or for
>> distributions just to get the system installed so it can be sorted
>> out later.
>>
>> This is a bit smarter than the old IDE one and lets you do
>>
>> libata.pata_dma=0		Disable all PATA DMA like old IDE
>> libata.pata_dma=1		Disk DMA only
>> libata.pata_dma=2		ATAPI DMA only
>> libata.pata_dma=4		CF DMA only
>>
>> (or combinations thereof - 0,1,3 being the useful ones I suspect)
>>
>> (I've split CF as it seems to be a seperate case of pain and suffering
>> different to the others and caused by assorted PIO wired adapters etc)
>>
>> SATA is not affected - for one its not clear it makes sense to disable
>> DMA for SATA if even always possible, for two we've seen no failure 
>> evidence to justify needing to support this kind of hammer on SATA.
>>
>> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> Acked-by: Tejun Heo <htejun@gmail.com>

FWIW -- as I noted to Alan personally at KS, I would rather drop the 
"pata_" and have it apply to all, PATA or SATA.

It is far less useful on SATA, but I can still see a possibility that 
somebody might want to avoid DMA for whatever reason, chiefly, possibly 
keeping failing hardware alive by slowing things down via PIO.  And 
being able to avoid the DMA protocols can be useful for debugging or 
other things.

As an aside, it would be nice to get the EH in shape where it can pause 
all ports, so we can finally allow userspace to submit SET FEATURES - 
XFER MODE and have it handled cleanly and properly.

	Jeff



