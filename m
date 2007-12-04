From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 2.6.24-rc4
Date: Tue, 4 Dec 2007 13:06:44 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712041258530.32379@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0712032055080.2981@woody.linux-foundation.org> <8db1092f0712041251w71768544o6f922454e2bb6758@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33515 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754364AbXLDVIX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 16:08:23 -0500
In-Reply-To: <8db1092f0712041251w71768544o6f922454e2bb6758@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>



On Tue, 4 Dec 2007, Maciej Rutecki wrote:

> ata1: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq 220
> ata2: SATA max UDMA/133 abar m1024@0xe8585000 port 0xe8585180 irq 220
> ata3: SATA max UDMA/133 abar m1024@0xe8585000 port 0xe8585200 irq 220
> ata4: SATA max UDMA/133 abar m1024@0xe8585000 port 0xe8585280 irq 220
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: ACPI cmd b1/c1:00:00:00:00:a0 failed (Emask=0x1 Stat=0x51 Err=0x04)
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

Can you make a real bug report, which includes things like whether this 
ever worked without that timeout, and if so, when it last worked and what 
the dmesg was then?

(Also, it's almost totally pointless to make me the primary To: target for 
something like this. Jeff Garzik hopefully picks this up from the 
linux-ide list, but I'm adding him to the Cc too)

			Linus
