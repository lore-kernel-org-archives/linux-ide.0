From: Philippe De Muyter <phdm@macqel.be>
Subject: Re: Intel ICH9M bug : sata unusable with usbserial
Date: Tue, 1 Mar 2011 13:34:52 +0100
Message-ID: <20110301123452.GA1954@frolo.macqel>
References: <20110228140149.GA18189@frolo.macqel> <20110228150553.66d02bc7@lxorguk.ukuu.org.uk> <20110228151618.GA16322@htj.dyndns.org> <20110228170556.GA29545@frolo.macqel> <20110228173634.GA23008@htj.dyndns.org> <20110228192700.GA3305@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:62843 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754051Ab1CAMfJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2011 07:35:09 -0500
Content-Disposition: inline
In-Reply-To: <20110228192700.GA3305@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org

On Mon, Feb 28, 2011 at 11:27:01AM -0800, Greg KH wrote:
> On Mon, Feb 28, 2011 at 06:36:34PM +0100, Tejun Heo wrote:
> > On Mon, Feb 28, 2011 at 06:05:56PM +0100, Philippe De Muyter wrote:
> > >   5:      17183    XT-PIC-XT-PIC    ata_piix, ata_piix, ehci_hcd:usb1, ehci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb5, uhci_hcd:usb6, uhci_hcd:usb7, uhci_hcd:usb8
> > 
> > So, usb7 and ata_piix share the same IRQ line.
> > 
> > > [    1.517781] usb 7-1: New USB device found, idVendor=067b, idProduct=2303
> > > [    1.517837] usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> > > [    1.517883] usb 7-1: Product: USB-Serial Controller
> > > [    1.517928] usb 7-1: Manufacturer: Prolific Technology Inc.
> > ...
> > > [    4.327431] usbcore: registered new interface driver usbserial
> > > [    4.327585] USB Serial support registered for generic
> > > [    4.327747] usbcore: registered new interface driver usbserial_generic
> > > [    4.327774] usbserial: USB Serial Driver core
> > ...
> > > [    4.419657] USB Serial support registered for pl2303
> > ...
> > > [    4.431805] usb 7-1: pl2303 converter now attached to ttyUSB0
> > > [    4.431846] usbcore: registered new interface driver pl2303
> > > [    4.431875] pl2303: Prolific PL2303 USB to serial adaptor driver
> > 
> > I believe this is the GPS thingie?
> > 
> > ...
> > > [  175.706014] ata1: lost interrupt (Status 0x50)
> > > [  175.706040] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> > > [  175.706050] ata1.00: failed command: READ DMA
> > > [  175.706062] ata1.00: cmd c8/00:08:28:41:01/00:00:00:00:00/e1 tag 0 dma 4096 in
> > > [  175.706064]          res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> > > [  175.706079] ata1.00: status: { DRDY }
> > 
> > There was no screaming IRQ but it definitely looks like IRQ delivery
> > is gone at this point.
> > 
> > > [  175.706091] ata1: hard resetting link
> > > [  176.162049] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > > [  181.165024] ata1.00: qc timeout (cmd 0x27)
> > > [  181.165034] ata1.00: failed to read native max address (err_mask=0x4)
> > > [  181.165043] ata1.00: revalidation failed (errno=-5)
> > 
> > Hardreset and IDENTIFY are executed by polling on ata_piix and
> > READ_NATIVE_MAX is the first command executed using IRQ and that's the
> > first thing in the recovery sequence which fails.
> > 
> > > [  181.165054] ata1: hard resetting link
> > > [  181.621053] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > > [  191.624025] ata1.00: qc timeout (cmd 0x27)
> > > [  191.624036] ata1.00: failed to read native max address (err_mask=0x4)
> > > [  191.624045] ata1.00: revalidation failed (errno=-5)
> > > [  191.624053] ata1: limiting SATA link speed to 1.5 Gbps
> > > [  191.624065] ata1: hard resetting link
> > > [  192.080046] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> > > [  202.083023] ata1.00: qc timeout (cmd 0x27)
> > > [  202.083033] ata1.00: failed to read native max address (err_mask=0x4)
> > > [  202.083042] ata1.00: revalidation failed (errno=-5)
> > > [  202.083049] ata1.00: disabled
> > > [  202.083066] ata1: hard resetting link
> > 
> > And it never comes back.  Specifying kernel parameter 'irqpoll' might
> > help but it looks like somehow the GPS thingie kills the IRQ line
> > completely.
> > 
> > cc'ing Greg and linux-usb.  Hey, USB folks, it seems accessing a USB
> > GPS device kills IRQ delivery to ata_piix sharing the same IRQ line as
> > the USB host.  Any ideas on what's going on?  The original messages
> > can be read from...
> > 
> >   http://www.spinics.net/lists/linux-ide/msg40425.html
> >   http://www.spinics.net/lists/linux-ide/msg40428.html
> 
> That really sounds like an interrupt issue that is higher up than the
> USB host driver, or the ata drivers.
> 
> ACPI perhaps?

I restarted this machine with acpi=off, but the problem remained exactly
the same.

But Greg, you had the letters right, but the order wrong : it turned out that
APIC (not ACPI) was disabled in the BIOS.  When I enable APIC in the BIOS,
I cannot reproduce the problem anymore.

Of course, with APIC enabled, the interrupts are assigned differently :

tmp199:~ # cat /proc/interrupts
           CPU0       CPU1
  0:        130          5   IO-APIC-edge      timer
  1:        419        434   IO-APIC-edge      i8042
  7:          0          0   IO-APIC-edge      parport0
  8:         20         19   IO-APIC-edge      rtc0
  9:          0          0   IO-APIC-fasteoi   acpi
 12:       6775       6680   IO-APIC-edge      i8042
 16:          0          0   IO-APIC-fasteoi   uhci_hcd:usb3
 17:         83         84   IO-APIC-fasteoi   firewire_ohci
 18:          0          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb8
 19:     299043     298696   IO-APIC-fasteoi   ata_piix, ata_piix, uhci_hcd:usb5, uhci_hcd:usb7
 21:          0          0   IO-APIC-fasteoi   uhci_hcd:usb4
 23:          2          0   IO-APIC-fasteoi   ehci_hcd:usb2, uhci_hcd:usb6
 40:      10242      10530   PCI-MSI-edge      i915
 41:      43710      44108   PCI-MSI-edge      eth0
 44:        158        151   PCI-MSI-edge      hda_intel
NMI:        107        105   Non-maskable interrupts
LOC:     718805     681028   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:        107        105   Performance monitoring interrupts
IWI:          0          0   IRQ work interrupts
RES:       2754       2700   Rescheduling interrupts
CAL:        119         91   Function call interrupts
TLB:       1528       1463   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:         12         12   Machine check polls
ERR:          1
MIS:          0
tmp199:~ # 

previously we had all but one usb interrupts on the same line as ata_piix :
  5:      17183    XT-PIC-XT-PIC    ata_piix, ata_piix, ehci_hcd:usb1, ehci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb5, uhci_hcd:usb6, uhci_hcd:usb7, uhci_hcd:usb8
while now they are spread on different lines : 16, 18, 19, 21 and 22

So I wonder if there is still a bug, but that it is not triggered anymore.

Is there a way to tell which interrupt line the USB GPS receiver is connected
to ?

Thanks

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
