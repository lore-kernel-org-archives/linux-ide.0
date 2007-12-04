From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: Re: ATA ACPI (was Re: Linux 2.6.24-rc4)
Date: Tue, 4 Dec 2007 23:48:03 +0100
Message-ID: <8db1092f0712041448t5a3da9ecna73730e421626450@mail.gmail.com>
References: <alpine.LFD.0.9999.0712032055080.2981@woody.linux-foundation.org>
	 <8db1092f0712041251w71768544o6f922454e2bb6758@mail.gmail.com>
	 <4755C544.5060909@garzik.org> <4755C63B.7080608@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:21323 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbXLDWsI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 17:48:08 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6543785wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 14:48:06 -0800 (PST)
In-Reply-To: <4755C63B.7080608@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org

2007/12/4, Jeff Garzik <jeff@garzik.org>:
> Jeff Garzik wrote:
> >> ata1: failed to recover some devices, retrying in 5 secs
> >> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >> ata1.00: ACPI cmd b1/c1:00:00:00:00:a0 failed (Emask=0x1 Stat=0x51
> >> Err=0x04)
> >> ata1.00: ACPI on devcfg failed the second time, disabling (errno=-5)
> >> ata1.00: revalidation failed (errno=1)
> >> ata1: failed to recover some devices, retrying in 5 secs
> >> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >> ata1.00: configured for UDMA/133
> >>
> >> dmesg, lspci, hdparm:
> >> http://www.unixy.pl/maciek/download/kernel/2.6.24-rc4/
> >
> > Can you also post dmidecode output?

http://www.unixy.pl/maciek/download/kernel/2.6.24-rc4/dmidecode.txt.gz

> >
> > And may I presume that booting with libata module option 'noacpi=1'
> > fixes the problem?

noacpi=1 kernel command line or module parameters?

First, no change:
http://www.unixy.pl/maciek/download/kernel/2.6.24-rc4/dmesg_noacpi.txt.gz
Kernel command line: root=/dev/sda2 ro vga=0x318 resume=/dev/sda3
selinux=1 enforcing=1  noacpi=1

How to add this option to module? Sorry I'm newbie ;-)

BTW My config:
http://www.unixy.pl/maciek/download/kernel/2.6.24-rc4/config-2.6.24-rc4

>
>
> Third question -- this is just cosmetic, right?

Linux works fine, but because of this message  I have about 10 seconds delay.

Unfortunately, until Sunday I don't have free time. Any suggestions I
can test on Sunday/Monday.
-- 
Maciej Rutecki
http://www.maciek.unixy.pl
