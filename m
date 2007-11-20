From: noah <noah123@gmail.com>
Subject: Re: Possibly SATA related freeze killed networking and RAID
Date: Tue, 20 Nov 2007 23:16:29 +0100
Message-ID: <d00698fb0711201416n30b54d26kd8d5887896d3da83@mail.gmail.com>
References: <d00698fb0711201109m23ff096eiabeb22c8f9a917dc@mail.gmail.com>
	 <20071120220512.46b9e975@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:54746 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242AbXKTWQb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Nov 2007 17:16:31 -0500
Received: by py-out-1112.google.com with SMTP id u77so6793119pyb
        for <linux-ide@vger.kernel.org>; Tue, 20 Nov 2007 14:16:30 -0800 (PST)
In-Reply-To: <20071120220512.46b9e975@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

2007/11/20, Alan Cox <alan@lxorguk.ukuu.org.uk>:
> >  kernel: [734344.717844] irq 21: nobody cared (try booting with the
> > "irqpoll" option)
> >  kernel: [734344.717866]
>
> Your machine decided to emit interrupt 21 without an apparent reason.
> Whatever caused that made the kernel shut down IRQ 21 at which point the
> disk drives on that IRQ were no longer being serviced. Everything on IRQ
> 21 would have died - which may be why your networking failed too.
>
> What do you have on IRQ 21 and is this a one off ?

I've had other freezes before but this was the first time I was able
to see what was actually going on.
IRQ 21 appears to be shared between sata_nv and ethernet.

Does this mean my hardware/BIOS is broken somehow?
I'm running the latest BIOS available.

# cat /proc/interrupts            CPU0       CPU1
  0:      26497    3603163   IO-APIC-edge      timer
  1:          0          2   IO-APIC-edge      i8042
  8:          0          0   IO-APIC-edge      rtc
 9:          0          0   IO-APIC-fasteoi   acpi
 12:          0          6   IO-APIC-edge      i8042
 16:       4851     669159   IO-APIC-fasteoi   shpchp, libata
 20:          0          0   IO-APIC-fasteoi   sata_nv
 21:      36443    4775430   IO-APIC-fasteoi   sata_nv, eth0
 22:      31261    4531218   IO-APIC-fasteoi   ohci_hcd:usb1, sata_nv
 23:          4       1649   IO-APIC-fasteoi   HDA Intel, ehci_hcd:usb2
NMI:          0          0
LOC:    3629562    3629543
ERR:          0

  -- noah
