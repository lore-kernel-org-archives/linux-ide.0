From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: question about SATA and IDE DVD/CD drives.
Date: Fri, 02 Jul 2004 16:55:42 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40E5857E.2030308@superbug.demon.co.uk>
References: <Pine.LNX.4.44.0407021403120.2190-100000@einstein.homenet> <40E5817D.4000408@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:6 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S263085AbUGBPyz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2004 11:54:55 -0400
In-Reply-To: <40E5817D.4000408@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tigran Aivazian <tigran@veritas.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tigran Aivazian wrote:
> 
>> Hi Jeff,
>>
>> I was a bit confused with the "SATA vs IDE" thing recently, namely the 
>> fact that if I compile _both_ IDE and SATA support into the kernel 
>> then IDE takes over and SATA gets a "busy" error, and as a result I 
>> get 3M/sec performance instead of 56M/sec.
>>
>> Now, realizing this error I have reconfigured the kernel to NOT 
>> include ide and ONLY include SATA plus chipset-specific ata_piix.c (I 
>> have ICH6 device 2652). However, now the new problem is that I can't 
>> see the IDE DVD-ROM drive anymore. Here is dmesg:
> 
> [...]
> 
>> As you see, sda is there, but where is my DVD drive gone?
> 
> 
> I am guessing that your DVD drive is connected to a PATA bus, but you 
> disabled the PATA driver (CONFIG_IDE) completely.
> 
> Enable CONFIG_IDE, and disable CONFIG_BLK_DEV_IDE_SATA, and that will 
> fix things I bet.
> 
>     Jeff
> 
> 

For some strange reason, you need the PATA HD driver compiled into the 
kernel, together with the SATA driver compiled into the kernel.
Then SATA takes the HDs, and the PATA HD driver is used to identify the 
DVD drive, and thus you can then load the PATA CD module, or the 
IDE-SCSI module to access the DVD drives.

I have a ICH5 chipset, so I had exactly the same problems as you.
The strange bit is needing the PATA HD driver compiled into the kernel, 
even though you only need PATA CD/DVD drivers.

Cheers
James
