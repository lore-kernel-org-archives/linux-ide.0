From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ATA ACPI (was Re: Linux 2.6.24-rc4)
Date: Tue, 04 Dec 2007 16:27:23 -0500
Message-ID: <4755C63B.7080608@garzik.org>
References: <alpine.LFD.0.9999.0712032055080.2981@woody.linux-foundation.org> <8db1092f0712041251w71768544o6f922454e2bb6758@mail.gmail.com> <4755C544.5060909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37287 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642AbXLDV10 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 16:27:26 -0500
In-Reply-To: <4755C544.5060909@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>> ata1: failed to recover some devices, retrying in 5 secs
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata1.00: ACPI cmd b1/c1:00:00:00:00:a0 failed (Emask=0x1 Stat=0x51 
>> Err=0x04)
>> ata1.00: ACPI on devcfg failed the second time, disabling (errno=-5)
>> ata1.00: revalidation failed (errno=1)
>> ata1: failed to recover some devices, retrying in 5 secs
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata1.00: configured for UDMA/133
>>
>> dmesg, lspci, hdparm:
>> http://www.unixy.pl/maciek/download/kernel/2.6.24-rc4/
> 
> Can you also post dmidecode output?
> 
> And may I presume that booting with libata module option 'noacpi=1' 
> fixes the problem?


Third question -- this is just cosmetic, right?

According to the output above, error recovery succeeded and you continue 
booting and talking to your disk?

	Jeff


