From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH alt2] libata resume fixes
Date: Sat, 27 May 2006 15:44:00 -0400
Message-ID: <4478AC00.1020208@rtr.ca>
References: <20060527191323.GA26671@havoc.gtf.org> <4478A6C5.2040201@rtr.ca> <4478A74F.8070008@garzik.org> <4478A855.2070104@rtr.ca> <4478A898.6050005@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:34990 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751143AbWE0ToC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 15:44:02 -0400
In-Reply-To: <4478A898.6050005@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, axboe@suse.de

Jeff Garzik wrote:
> Mark Lord wrote:
>> Jeff Garzik wrote:
>>> On the working patch, can you verify that ata_pci_device_resume() is 
>>> called before ata_scsi_device_resume() ?
>>
>> You mean on Linus's one-liner patch?
> 
> Yes.

Okay, here's the syslog.  Find the lines that begin with ">>>>>  ",
and you'll see ata_pci_device_resume followed by two ata_scsi_device_resume.

...
May 27 15:38:42 localhost kernel: ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 16 (level, low) -> IRQ 16
May 27 15:38:42 localhost kernel: PCI: Setting latency timer of device 0000:00:1e.2 to 64
May 27 15:38:42 localhost kernel: >>>>>  ata_pci_device_resume  <<<<<
May 27 15:38:42 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 18
May 27 15:38:42 localhost kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
May 27 15:38:42 localhost kernel: ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 18 (level, low) -> IRQ 19
May 27 15:38:42 localhost kernel: ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 19 (level, low) -> IRQ 17
May 27 15:38:42 localhost kernel: PCI: Enabling device 0000:03:01.1 (0000 -> 0002)
May 27 15:38:42 localhost kernel: ACPI: PCI Interrupt 0000:03:01.1[B] -> GSI 18 (level, low) -> IRQ 19
May 27 15:38:42 localhost kernel: pnp: Device 00:04 does not support activation.
May 27 15:38:42 localhost kernel: pnp: Device 00:05 does not support activation.
May 27 15:38:42 localhost kernel: >>>>>  ata_scsi_device_resume  <<<<<
May 27 15:38:42 localhost kernel: ata1: dev 0 configured for UDMA/100
May 27 15:38:42 localhost kernel: >>>>>  ata_scsi_device_resume  <<<<<
May 27 15:38:42 localhost kernel: ata2: dev 0 configured for UDMA/33
May 27 15:38:42 localhost kernel: Restarting tasks... done
...

One thought about Linus's one-liner (and the original patch),
is that two seconds may be too short --> I'd suggest a 10-second
timeout there for notebook drive spin-up.  Or one could be very
paranoid and use the standard ATA 31-second timeout.

I wonder if your faster 64-bit machine had that problem?
(two seconds not long enough, whereas my 32-bit machine is slower
gettting to that point, so two-seconds is then enough?).

Cheers
