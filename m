From: Reuben Farrelly <reuben-lkml@reub.net>
Subject: Re: Problems with SATA/AHCI with 'nosmp'  boot option
Date: Thu, 06 Oct 2005 02:27:18 +1300
Message-ID: <4343D4B6.9060707@reub.net>
References: <43312397.9080501@reub.net>	<43425A0E.9050500@pobox.com> <20051004190401.11bc4c7e.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tornado.reub.net ([202.89.145.182]:22151 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S965167AbVJEN1X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2005 09:27:23 -0400
In-Reply-To: <20051004190401.11bc4c7e.rdunlap@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hi Randy,

On 5/10/2005 3:04 p.m., Randy.Dunlap wrote:
> On Tue, 04 Oct 2005 06:31:42 -0400 Jeff Garzik wrote:
> 
>> Reuben Farrelly wrote:
>>> Hi,
>>>
>>> While trying to gather more info about a problem with the latest sky2.c 
>>> Gig ethernet driver hanging, I thought I'd boot my SMP built kernel (on 
>>> an SMP/HT machine) with the 'nosmp' boot option.
>>>
>>> However when I did this, I could no longer boot the machine, because the 
>>> ahci
>>> driver reported timeouts when probing the drives attached to the SATA 
>>> ports, like this:
>>>
>>> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>>> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>>> ICH6: IDE controller at PCI slot 0000:00:1f.1
>>> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 73
>>> ICH6: chipset revision 3
>>> ICH6: not 100% native mode: will probe irqs later
>>>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
>>>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
>>> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 81
>>> ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl 
>>> SATA mode
>>> ahci(0000:00:1f.2) flags: 64bit ncq led slum part
>>> ata1: SATA max UDMA/133 cmd 0xF8806D00 ctl 0x0 bmdma 0x0 irq 81
>>> ata2: SATA max UDMA/133 cmd 0xF8806D80 ctl 0x0 bmdma 0x0 irq 81
>>> ata3: SATA max UDMA/133 cmd 0xF8806E00 ctl 0x0 bmdma 0x0 irq 81
>>> ata4: SATA max UDMA/133 cmd 0xF8806E80 ctl 0x0 bmdma 0x0 irq 81
>>> ata1 is slow to respond, please be patient
>>> ata1 failed to respond (30 secs)
>>> scsi0 : ahci
>>> ata2 is slow to respond, please be patient
>>> ata2 failed to respond (30 secs)
>> Sounds like AHCI or MSI is broken.
> 
> Reuben, is AHCI trying to use MSI interrupts in this case?
> (reported in /proc/interrupts)
> 
> If so, I've seen problems with Linux and MSI interrupts
> when "nomsp" is used too.  Can you disable CONFIG_PCI_MSI
> or is this a vendor kernel with it already enabled?

It's a self-built kernel, however it has PCI express support, so I've been
building with PCI-E and MSI-X support.

With the box up now, and not even attempting to use 'nosmp', nothing at all is 
using MSI - everything including is using either level or edge triggered.  Not 
sure why but AHCI is not even showing up - should it be listed as well as 
libata?  [both are built in, not modular]

[root@tornado ~]# cat /proc/interrupts
            CPU0       CPU1
   0:     143311          0    IO-APIC-edge  timer
   4:        400          0    IO-APIC-edge  serial
   8:          1          0    IO-APIC-edge  rtc
   9:          0          0   IO-APIC-level  acpi
  16:        132          0   IO-APIC-level  uhci_hcd:usb5
  17:          0          0   IO-APIC-level  sky2
  18:          4          0   IO-APIC-level  uhci_hcd:usb4
  19:      35332          0   IO-APIC-level  uhci_hcd:usb3, libata, eth0
  20:          3          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2
  21:      23666          0   IO-APIC-level  aic7xxx
NMI:          0          0
LOC:     143226     143220
ERR:          0
MIS:          0
[root@tornado ~]

   If you still think it would be handy to test with 'nosmp' and a non-MSI 
enabled kernel then I'll give it a go..

As both drives are SATA, and aren't detected with 'nosmp', I guess I can't 
really look at /proc/interrupts as it never boots up that far.

> I posted a patch about 1 week ago that disables MSI interrupts
> if "nomsp" or some similar options are used.  It's in Andrew's
> -mm patch set afaik.  or I just put it at
>   http://www.xenotime.net/linux/patches/msi_disable2.patch
> if you care to try it.

Cool, I'm running -mm anyway so I guess it's all in there.  However my board 
has PCI-E support, which according to Documentation/MSI-HOWTO.txt talks about 
MSI-X being "a required feature for PCI Express devices".
If that is the case then the kbuild system probably needs a dependency to 
check for it (it lets me choose no MSI while retaining PCI-E).

It's not a particularly big problem for me, but it's always nice if the 
options which are handy for tracking down other problems, work.  And of 
course, it could be hiding a bug that shows up in other circumstances too, I 
guess.

Reuben


