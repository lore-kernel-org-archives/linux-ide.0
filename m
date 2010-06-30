From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Bug 16142] r8169: Kernel Panic when a lot of data is
 transferred through network interface
Date: Wed, 30 Jun 2010 08:54:26 +0200
Message-ID: <20100630065426.GA1857@liondog.tnic>
References: <20100617080726.GA13713@liondog.tnic>
 <20100617150008.16a5e653@cpc>
 <20100618074510.GD32368@liondog.tnic>
 <20100619005045.2173fcce@cpc>
 <20100619100511.GA31429@liondog.tnic>
 <20100619132708.030fe408@cpc>
 <20100623080200.GB5010@liondog.tnic>
 <20100625185846.72171be0@cpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:33552 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240Ab0F3Gyb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jun 2010 02:54:31 -0400
Content-Disposition: inline
In-Reply-To: <20100625185846.72171be0@cpc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans Mueller <hans42mueller@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

From: Hans Mueller <hans42mueller@googlemail.com>
Date: Fri, Jun 25, 2010 at 06:58:46PM +0200

Hi, sorry for the delay.

Right, and I had a suspicion about sharing IRQs with the NIC:

            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7
   0:      42503          0          0          0          0          0          0          0   IO-APIC-edge      timer
   1:          2          0          0          0          0          0          0          0   IO-APIC-edge      i8042
   4:          2          0          0          0          0          0          0          0   IO-APIC-edge
   9:          0          0          0          0          0          0          0          0   IO-APIC-fasteoi   acpi
  12:          4          0          0          0          0          0          0          0   IO-APIC-edge      i8042
  14:          0          0          0          0          0          0          0          0   IO-APIC-edge      ide2
  15:          0          0          0          0          0          0          0          0   IO-APIC-edge      ide3
  16:         26          0          0          0          0          0          0          0   IO-APIC-fasteoi   ehci_hcd:usb1
  17:        127          0          0          0          0          0          0          0   IO-APIC-fasteoi   hda_intel
  18:         47          0          0          0          0          0          0          0   IO-APIC-fasteoi   firewire_ohci, ahci
  19:        753          0          0          0          0          0          0          0   IO-APIC-fasteoi   ide0, ide1, eth0
  21:       3989          0          0          0          0          0          0          0   IO-APIC-fasteoi   ahci

so IRQ19 is shared between the nic and the first ide controller and the
sata controller is using another irq line which could explain why the
issue doesn't happen with libata. Is your nick a pluggable card and if
yes, can you move it to another PCI slot so that ide0 and ide1 don't
share the same irq line with eth0 and retest again? Before retesting
though, do 'cat /proc/interrupts' to make sure.

I'm guessing the problem will go away then...

Thanks.

-- 
Regards/Gruss,
    Boris.
