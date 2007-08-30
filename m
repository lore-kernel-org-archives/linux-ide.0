From: John Sigler <linux.kernel@free.fr>
Subject: Re: hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete
 Error }
Date: Thu, 30 Aug 2007 10:17:13 +0200
Message-ID: <46D67D09.6090101@free.fr>
References: <46D59ED2.4000900@free.fr> <20070829174657.09c7de3c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:57549 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754264AbXH3IR1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Aug 2007 04:17:27 -0400
In-Reply-To: <20070829174657.09c7de3c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:

> John Sigler wrote:
>
>> Standards:
>>          Likely used: 1
> 
> Prehistory

The tragic bit is that we were sold similar DOMs in 2007...
(It's probably time to change suppliers?)

>>          LBA, IORDY not likely
> 
> No DMA, nothing above PIO2

OK. (Grumble)

>>          Buffer type: 0002: dual port, multi-sector
>>          Buffer size: 1.0kB      bytes avail on r/w long: 4
>>          Cannot perform double-word IO
> 
> Can't even do double word I/O

Double word is 32 bits, right? Isn't "Cannot perform double-word IO" in 
contradiction with the following statements?

  IO_support    =  1 (32-bit)

         Buffer size: 1.0kB      bytes avail on r/w long: 4

(Assuming an 8-bit byte, 4 bytes = 32 bits)

> The messages with old IDE should be harmless and the current libata IDE
> should drive it politely (I debugged a problem the same hardware showed
> up for someone else).

When you say "the current libata IDE" do you mean PATA_VIA (in my case)?
I've avoided this driver because it is marked EXPERIMENTAL. Would there 
be any benefit in using it over the legacy ATA/MFM/RLL driver?

> Basically your dinosaur is working correctly.

What do the warnings mean? :-)

Regards.
