From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: VIA SATA not recognizing drives
Date: Wed, 19 May 2004 22:14:38 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40AC148E.9090404@pobox.com>
References: <20040508193100.GA31122@buici.com> <409D5126.2060205@pobox.com> <20040509073914.GA4881@buici.com> <40A078A3.50102@pobox.com> <20040511161237.GB25243@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53229 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264822AbUETCOv
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2004 22:14:51 -0400
In-Reply-To: <20040511161237.GB25243@buici.com>
List-Id: linux-ide@vger.kernel.org
To: Marc Singer <elf@buici.com>
Cc: linux-ide@vger.kernel.org

Marc Singer wrote:
> In a cursory overview of libata, here's what stands out in my
> special-needs case.
> 
>   1) PIO stands for port-IO which I interpret as register-level IO
>      which, I assume, contrasts with task-file or mailbox type IO.

There are two different things known as PIO:
a) x86-style 'IN' and 'OUT' instructions for bus IO
b) data transfer via ATA's Data register.  In some bizarre situations 
you have PIO over DMA, initiated by MMIO.  :)

so be prepared to be confused ;-)


>   2) Libata does have an MMIO mode, nice.  My platform is ARM.  While
>      these calls will work, I have a further requirement that all
>      register IO must be followed by the hokey-pokey to work around
>      some oddities in the hardware.  Yes, I've suggested that they fix
>      the problem in hardware.  So, how can be make this configurable?
>      For me, it is OK that all IDE io would require the hack.  In
>      other words, even if there were another IDE controller that
>      worked properly it would be OK for both to need the hack.

Everything is done via custom hooks you provide, in struct 
ata_port_operations.


>   3) If a device has no DMA, how do you plan to handle the data
>      transfer?  Is this what ata_pio_sector() is doing?

Correct.


>   4) Is ata_piix.c the model? 

I don't know your hardware at all, so I cannot say.

All of drivers/scsi/ata_*.c drivers/scsi/sata_*.c are the model :)


> It doesn't really look that tough.  The only thing I'm unclear about
> is how to handle read/write with the requisite hokey-pokey.

libata needs a hook for PIO data xfer, since it is currently hardcoded 
to use outsl() and insl().  Other than that, existing 
ata_port_operations hooks can do that "hokey-pokey".

	Jeff



