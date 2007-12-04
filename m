From: Jeff Garzik <jeff@garzik.org>
Subject: ATA ACPI (was Re: Linux 2.6.24-rc4)
Date: Tue, 04 Dec 2007 16:23:16 -0500
Message-ID: <4755C544.5060909@garzik.org>
References: <alpine.LFD.0.9999.0712032055080.2981@woody.linux-foundation.org> <8db1092f0712041251w71768544o6f922454e2bb6758@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55100 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbXLDVX0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 16:23:26 -0500
In-Reply-To: <8db1092f0712041251w71768544o6f922454e2bb6758@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org

Maciej Rutecki wrote:
> ata1: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq 220
> ata2: SATA max UDMA/133 abar m1024@0xe8585000 port 0xe8585180 irq 220
> ata3: SATA max UDMA/133 abar m1024@0xe8585000 port 0xe8585200 irq 220
> ata4: SATA max UDMA/133 abar m1024@0xe8585000 port 0xe8585280 irq 220
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: ACPI cmd b1/c1:00:00:00:00:a0 failed (Emask=0x1 Stat=0x51 Err=0x04)

ATA command:  DEVICE CONFIGURATION FREEZE LOCK

Prevents "accidental modification" of device configuration, after this 
command has been submitted.

Some BIOS writer probably thought that was a good idea, but maybe not 
for Linus.


> ata1: failed to recover some devices, retrying in 5 secs
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: ACPI cmd b1/c1:00:00:00:00:a0 failed (Emask=0x1 Stat=0x51 Err=0x04)
> ata1.00: ACPI on devcfg failed the second time, disabling (errno=-5)
> ata1.00: revalidation failed (errno=1)
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/133
> 
> dmesg, lspci, hdparm:
> http://www.unixy.pl/maciek/download/kernel/2.6.24-rc4/

Can you also post dmidecode output?

And may I presume that booting with libata module option 'noacpi=1' 
fixes the problem?

We just turned on ATA ACPI support, which sends commands the BIOS has 
prepared for us to the device...  which is generally a good thing that 
makes suspend/resume and BIOS passwords work.  But it's also trusting a 
BIOS to get ATA commands right -- and it does not appear to, in your case.

	Jeff



