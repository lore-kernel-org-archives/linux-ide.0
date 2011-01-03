From: Steffen Moser <lists@steffen-moser.de>
Subject: Re: IOMMU and DMA mode of pata_jmicron
Date: Mon, 03 Jan 2011 21:15:59 +0100
Message-ID: <4D222E7F.5080305@steffen-moser.de>
References: <4D1A7628.3050704@steffen-moser.de> <4D1A881C.3080109@garzik.org> <20110103112952.GA2100@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110103112952.GA2100@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi Joerg,

On 01/03/2011 12:29 PM, Roedel, Joerg wrote:
> On Tue, Dec 28, 2010 at 08:00:12PM -0500, Jeff Garzik wrote:
>> (CC'd linux-ide, Joerg)
>> 
>> On 12/28/2010 06:43 PM, Steffen Moser wrote:
>> > I've encountered a problem with my AMD 890FX based system
>> > and linux-2.6.35.10 (x86_64 platform).
>> >
>> > After activating the option "IOMMU" in the mainboard's BIOS
>> > setup, the onboard P-ATA controller "JMicron Technology Corp.
>> > JMB361 AHCI/IDE (rev 02)" puts itself back in the PIO mode.
>> > When loading the module, the kernel reports:
>> >
>> >    pata_jmicron 0000:06:00.1: BMDMA: failed to set dma mask, \
>> >                               falling back to PIO
>> [...]
>> > As soon as I deactivate IOMMU in BIOS setup, the P-ATA channel
>> > runs in the DMA mode again. The S-ATA controllers don't seem
>> > to be affected.
>> >
>> > My question is: Is this a known behavior? Are there any
>> > things I have to consider when activating IOMMU (which seems
>> > to be AMD-Vi) on an 890FX based system? Is it a problem of
>> > the chipset and/or the controller or is it related to a
>> > problem in the libata area?
>> >
>> > Some information about the affected system:
>> >
>> >  - Mainboard:    ASUS M4A89TD Pro/USB3
>> >  - BIOS version: 1101 (most recent version)
>> >  - Chipset:      AMD 890FX
>> >  - Processor:    AMD Phenom 1090T
>> >  - Memory:       4 x 4 GB (Kingston KVR1333D3E9S/4G)
>> >  - Distribution: openSUSE 11.3
>> >  - Kernel:       2.6.35.10 (from "kernel.org"), x86_64
>> >
>> 
>> This condition occurs when the PCI API cannot set the PCI device's DMA 
>> mask to the 32-bit value
>> 	#define ATA_DMA_MASK            0xffffffffULL
>> 
>> That is an unusual failure for such a modern system, which certainly can 
>> handle 32-bit masks like that, one would think.
> 
> Luckily I have exactly the same motherboard under my desk. It shows the
> same issue. The problem is that the PCI device of the PATA controler
> (4:00.1 in my case) is not described in the IVRS ACPI table. So the
> IOMMU driver does not feel responsible for it and the dma_supported()
> call on this device will fail. This also makes pci_set_dma_mask() fail
> on this device. So it comes down to a BIOS bug. 

That sounds quite comprehensible for me.

> I look into it to find a workaround.

Thank you.

Beside a possible work-around, do you think, it makes sense to
report the problem to ASUS as the straight way should be to have
a correct IVRS table for the board?

Kind regards,
Steffen
