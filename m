From: Karl Hiramoto <karl@hiramoto.org>
Subject: Re: PCI IRQ Pins
Date: Thu, 21 May 2009 10:06:50 +0200
Message-ID: <4A150B9A.7080700@hiramoto.org>
References: <4A13EC76.3020206@hiramoto.org>	<m3r5ykgd97.fsf@intrepid.localdomain>	<20090520205151.GC4095@n2100.arm.linux.org.uk>	<m3zld7cuxk.fsf@intrepid.localdomain> <4A14F160.6080605@hiramoto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:50000 "EHLO
	spunkymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750797AbZEUIHA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 May 2009 04:07:00 -0400
In-Reply-To: <4A14F160.6080605@hiramoto.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "ath9k-devel@lists.ath9k.org" <ath9k-devel@lists.ath9k.org>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-ide@vger.kernel.org

Karl Hiramoto wrote:
> Krzysztof Halasa wrote:
>   
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>>
>>   
>>     
>>> Normally you get a backtrace when a "nobody cared" message is issued -
>>> this should tell you which driver is probably the cause.
>>>     
>>>       
>> Right - or that the other device is the cause (stuck IRQ line). So,
>> Karl, please just post the backtrace.
>>   
>>     
>
> Krzysztof, you mentioned clearing the IRQ in the platform code, is there an example of this somewhere?
>
>
> There is a Compact flash on hda connected the the HPT371N,  looking at 
> the IDE code it looks like the drive my not be ready,  or the drive may 
> raise the IRQ..
>
> As soon as request_irq is called, the IRQ happens.
>
> CCing linux-IDE now, as it may be an issue with this driver.
>
>
> Backtrace below, sorry about some of the lines being wrapped.
>
>
>
>   
I think i see the problem:

In the platform code, i should save the frequency of 33 Mhz in the 
correct register.


> hpt366: HPT371N chipset detected
> hpt366 0000:00:01.0: IDE controller (0x1103:0x0007 rev 0x02)
> PCI: enabling device 0000:00:01.0 (0140 -> 0141)
> hpt366 0000:00:01.0: IDE port disabled
> hpt366 0000:00:01.0: no clock data saved by BIOS
> hpt366 0000:00:01.0: DPLL base: 77 MHz, f_CNT: 120, assuming 50 MHz PCI
> hpt366 0000:00:01.0: using 66 MHz DPLL clock
> hpt366 0000:00:01.0: 100% native mode on irq 28
> hda: KINGSTON, ATA DISK drive
> irq 28: nobody cared (try booting with the "irqpoll" option)
> Backtrace:
> [<c002440c>] (dump_backtrace+0x0/0x110) from [<c002486c>] 
> (dump_stack+0x18/0x1c)
>  r6:10000000 r5:00000000 r4:c0309cd8
> [<c0024854>] (dump_stack+0x0/0x1c) from [<c0055360>] 
> (__report_bad_irq+0x38/0x90)
> [<c0055328>] (__report_bad_irq+0x0/0x90) from [<c005551c>] 
> (note_interrupt+0x164/0x1d8)
>  r4:c0309cd8
> [<c00553b8>] (note_interrupt+0x0/0x1d8) from [<c0056110>] 
> (handle_level_irq+0x94/0xf0)
> [<c005607c>] (handle_level_irq+0x0/0xf0) from [<c0020054>] (_text+0x54/0x6c)
>  r5:c381dcd0 r4:0000001c
> [<c0020000>] (_text+0x0/0x6c) from [<c00209a4>] (__irq_svc+0x24/0x80)
> Exception stack(0xc381dc2c to 0xc381dc74)
> dc20:                            c032ad40 c381c000 00000000 20000013 c381c000
> dc40: 00000000 10000000 00000102 0000000a c032ad6c 00000000 c381dca4 c381dca8
> dc60: c381dc74 c0035c9c c00359c4 20000013 ffffffff
>  r5:0000001f r4:ffffffff
> [<c0035974>] (__do_softirq+0x0/0xf8) from [<c0035c9c>] (irq_exit+0x44/0x4c)
> [<c0035c58>] (irq_exit+0x0/0x4c) from [<c0020058>] (_text+0x58/0x6c)
> [<c0020000>] (_text+0x0/0x6c) from [<c00209a4>] (__irq_svc+0x24/0x80)
> Exception stack(0xc381dcd0 to 0xc381dd18)
> dcc0:                                     00000000 69054200 00000000 00000000
> dce0: c0309cd8 c3807f80 00000080 60000013 0000001c c386680c c0309cf8 c381dd40
> dd00: c381dccc c381dd18 c00295e8 c0054b44 60000013 ffffffff
>  r5:0000001f r4:ffffffff
> [<c0054950>] (__setup_irq+0x0/0x2a8) from [<c0054cac>] 
> (request_threaded_irq+0xb4/0xe0)
> [<c0054bf8>] (request_threaded_irq+0x0/0xe0) from [<c01783c0>] 
> (ide_host_register+0x444/0x60c)
> [<c0177f7c>] (ide_host_register+0x0/0x60c) from [<c017c158>] 
> (ide_pci_init_one+0xdc/0x10c)
> [<c017c07c>] (ide_pci_init_one+0x0/0x10c) from [<c024cec0>] 
> (hpt366_init_one+0x344/0x3a8)
>  r8:c0321cac r7:c38737a0 r6:00000000 r5:c3814400 r4:c0321920
> [<c024cb7c>] (hpt366_init_one+0x0/0x3a8) from [<c0015998>] 
> (ide_scan_pcibus+0x50/0x124)
>  r7:c0015948 r6:c0319330 r5:c3814400 r4:c0318fb4
> [<c0015948>] (ide_scan_pcibus+0x0/0x124) from [<c0020290>] 
> (do_one_initcall+0x58/0x190)
>  r8:c0321cac r7:c0015948 r6:00000000 r5:c001c840 r4:c001c784
> [<c0020238>] (do_one_initcall+0x0/0x190) from [<c0008744>] 
> (kernel_init+0x78/0xe4)
> [<c00086cc>] (kernel_init+0x0/0xe4) from [<c0033b28>] (do_exit+0x0/0x584)
>  r5:00000000 r4:00000000
> handlers:
> [<c0174bc0>] (ide_intr+0x0/0x220)
> Disabling IRQ #28
>   

