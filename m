From: Karl Hiramoto <karl@hiramoto.org>
Subject: Re: PCI IRQ Pins
Date: Thu, 21 May 2009 18:19:39 +0200
Message-ID: <4A157F1B.2040708@hiramoto.org>
References: <4A13EC76.3020206@hiramoto.org>	<m3r5ykgd97.fsf@intrepid.localdomain>	<20090520205151.GC4095@n2100.arm.linux.org.uk>	<m3zld7cuxk.fsf@intrepid.localdomain> <4A14F160.6080605@hiramoto.org> <m3ab56g1iv.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:58915
	"EHLO spunkymail-a10.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753174AbZEUQTq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 May 2009 12:19:46 -0400
In-Reply-To: <m3ab56g1iv.fsf@intrepid.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "ath9k-devel@lists.ath9k.org" <ath9k-devel@lists.ath9k.org>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-ide@vger.kernel.org

Krzysztof Halasa wrote:
> Karl Hiramoto <karl@hiramoto.org> writes:
>
>   
>> Krzysztof, you mentioned clearing the IRQ in the platform code, is
>> there an example of this somewhere?
>>     
>
> Sure, e.g. in the patches I posted yesterday (not IRQ-related but
> you can do that the same way):
>
> static void __init gmlr_setup_nec(struct pci_dev *dev)
> {
> ...
> }
>
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
> 			 gmlr_setup_nec);
>
> Or:
> static int __init gmlr_pci_init(void)
>  {
> 	if (!machine_is_goramo_mlr())
> 		return 0;
>
> 	pci_common_init(&gmlr_hw_pci);
>
>  	if (xxx) {
> 		/* need to adjust number of USB ports on NEC chip */
> 		u32 value, addr = BIT(32 - SLOT_NEC) | 0xE0;
> 		if (!ixp4xx_pci_read(addr, NP_CMD_CONFIGREAD, &value)) {
> 			value &= ~7;
> 			value |= (hw_bits & CONFIG_HW_USB_PORTS);
> 			ixp4xx_pci_write(addr, NP_CMD_CONFIGWRITE, value);
> 		}
> 	}
> }
>
>   
>> There is a Compact flash on hda connected the the HPT371N,  looking at 
>> the IDE code it looks like the drive my not be ready,  or the drive may 
>> raise the IRQ..
>>     
>
> Non-DMA flash, I had issues with those and a VIA-based card.
>
>   
>> As soon as request_irq is called, the IRQ happens.
>>     
>
> Right. This means either the driver hasn't prepared the chip completely
> (perhaps there is some exception which isn't normally signalled?) or
> it's the other chip asking for interrupt.
>
> But
>
>   
>> irq 28: nobody cared (try booting with the "irqpoll" option)
>>     
> ...
>   
>> [<c0054bf8>] (request_threaded_irq+0x0/0xe0) from [<c01783c0>] 
>> (ide_host_register+0x444/0x60c)
>> [<c0177f7c>] (ide_host_register+0x0/0x60c) from [<c017c158>] 
>> (ide_pci_init_one+0xdc/0x10c)
>> [<c017c07c>] (ide_pci_init_one+0x0/0x10c) from [<c024cec0>] 
>> (hpt366_init_one+0x344/0x3a8)
>>  r8:c0321cac r7:c38737a0 r6:00000000 r5:c3814400 r4:c0321920
>> [<c024cb7c>] (hpt366_init_one+0x0/0x3a8) from [<c0015998>] 
>> (ide_scan_pcibus+0x50/0x124)
>>  r7:c0015948 r6:c0319330 r5:c3814400 r4:c0318fb4
>> [<c0015948>] (ide_scan_pcibus+0x0/0x124) from [<c0020290>] 
>> (do_one_initcall+0x58/0x190)
>>  r8:c0321cac r7:c0015948 r6:00000000 r5:c001c840 r4:c001c784
>> [<c0020238>] (do_one_initcall+0x0/0x190) from [<c0008744>] 
>>     
>
>   
>> handlers:
>> [<c0174bc0>] (ide_intr+0x0/0x220)
>>     
>
> And
>
>   
>> irq 28: nobody cared (try booting with the "irqpoll" option)
>>     
>
>   
>> [<c0054bf8>] (request_threaded_irq+0x0/0xe0) from [<bf0a65cc>] 
>> (ath_pci_probe+0x1a8/0x294 [ath9k])
>> [<bf0a6424>] (ath_pci_probe+0x0/0x294 [ath9k]) from [<c0152678>] 
>> (local_pci_probe+0x20/0x24)
>>     
>
>   
>> handlers:
>> [<c0174bc0>] (ide_intr+0x0/0x220)
>> [<bf09fde4>] (ath_isr+0x0/0x2cc [ath9k])
>> Disabling IRQ #28
>>     
>
> (it's ath9k and not ath5k as I previously thought).
>
> That means that both drivers (IRQ handlers) don't recognize the IRQ
> source. So either one of the drivers is very seriously broken (which
> I find hard to believe) or one of the chips generates an IRQ which isn't
> normally used (thus not checked for).
> But I would try to use a DMA-able CF first, perhaps it's the CF IRQ?
> And/or try to boot without the CF.
>   
Without the CF plugged in it also occurs.  :-(


-- 

--
Karl Hiramoto  

