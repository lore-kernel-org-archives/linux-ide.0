From: Andy Shaw <ashaw@seberg.co.uk>
Subject: Re: [BUGREPORT 1/3] Kernel Oops with HPT372A IDE controller
Date: Fri, 19 May 2006 8:36:03 +0100
Message-ID: <cadb0abbb3dd59f2fe9583e019508ef2@localhost>
References: <446CEB72.30302@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.bulldogdsl.com ([212.158.248.8]:51718 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932107AbWESHfs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 03:35:48 -0400
In-Reply-To: <446CEB72.30302@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: 101551.753@compuserve.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>



On Fri, 19 May 2006 01:47:30 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Hello, I wrote:
> 
>>>>> Kernel Oops with HighPoint RocketRAID ATA133 aka HPT372A/N since
>>>>> kernel 2.6
>>>>> Now tested with kernel 2.6.17-rc4
> 
>>>>> Kernel is on bootable CD-ROM
>>>>> Modules are loaded from initrd
> 
>>>>> This is what I copied from screen:
> 
>>>>> Loading hpt366
>>>>> [17179578.396000] HPT372A: IDE controller at PCI slot 0000:01:0a.0
>>>>> [17179578.400000] ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
>>>>> [17179578.404000] ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [APC1]
>>>>> -> GSI 16 (level, high) -> IRQ 18
>>>>> [17179578.408000] HPT372A: chipset revision 2
>>>>> [17179578.412000] HPT372A: 100% native mode on irq 18
>>>>> [17179578.416000] hpt: HPT372N detected, using 372N timing.
>>>>> [17179578.420000] FREQ: 125 PLL: 45
>>>>> [17179579.536000] No Clock Stabilization!!!
>>>>> [17179579.540000] hpt: no known IDE timings, disabling DMA
>>>>> [17179579.544000] hpt: HPT372N detected, using 372N timing.
>>>>> [17179579.548000] FREQ: 156 PLL: 66
>>>>> [17179579.664000] No Clock Stabilization!!!
> 
>>>>    Please try my latest patches. This one should fix this (and oops
>>>> should be gone):
> 
>>>> http://marc.theaimsgroup.com/?l=linux-ide&m=114677223914159&w=2
> 
>>> all patches applied, but I still get Kernel Oops :-(
> 
>>> some smal difference here:
> 
>>>   HPT372A: IDE controller at PCI slot 0000:01:0a.0
>>>   ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
>>>   ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [APC1] -> GSI 16 (level,
>>> high) -> IRQ 18
>>>   HPT372A: chipset revision 2
>>>   HPT372A: 100% native mode on irq 18
>>> + HPT37X: no clock data saved by BIOS
>>> + HPT3xxN detected, FREQ: 124, PLL: 45
>>> + HPT37xN unknown bus timing [48 4].
> 
>>    Hm, the BIOS seems to behave nastier than expected -- looks like it
>> reprograms DPLL but doesn't save the initial f_CNT (needed to determine
> the
>> PCI clock). Well, I know that it always sets DPLL to 50 MHz, no matter
>> what's the chip, so will try to work around this... :-/
> 
>     OTOH, there might be another reason to that: the BIOS saves f_CNT but
> the
> register it uses for this isn't mapped to the PCI config. space, only to
> the
> I/O space (it's undocumented, after all). Andy Shaw's report seems to
> confirm
> this -- his RAID BIOS seems to be modern enough to save the f_CNT but the
> driver probably fails to read it (I don't have the full boot log yet).
>     So, try the attached patch please. Foli, if this won't help, can you
> tell
> what version your HighPoint BIOS is?
> 
> MBR, Sergei
> 
> 

Sergei,

I can confirm that after applying your most recent patches my HighPoint card works. I have four disks attached to the two HPT IDE sockets and all four disks are picked up. I haven't been able to confirm whether DMA is supported yet but will update as soon as I get the chance.

For anyone interested these patches have been applied to kernel 2.6.17-rc4-mm1. The lspci entry for the card looks like:

0000:03:01.0 RAID bus controller: Triones Technologies, Inc. HPT372A/372N (rev 02)

Many thanks for your efforts.

Rgds
Andy 

