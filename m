From: Foli Ayivoh <it21@arcor.de>
Subject: Re: [BUGREPORT 1/3] Kernel Oops with HPT372A IDE controller
Date: Fri, 9 Jun 2006 11:51:29 +0200
Message-ID: <200606091151.29642.it21@arcor.de>
References: <200605142110.53348.it21@arcor.de> <446B34F7.60000@ru.mvista.com> <446CEB72.30302@ru.mvista.com>
Reply-To: 101551.753@compuserve.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:17388 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S964922AbWFIJty (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Jun 2006 05:49:54 -0400
In-Reply-To: <446CEB72.30302@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andy Shaw <ashaw@seberg.co.uk>, Stefan Smietanowski <stesmi@stesmi.com>

Sergei Shtylyov wrote:
> 
> Hello, I wrote:
> 
> >>>> Kernel Oops with HighPoint RocketRAID ATA133 aka HPT372A/N since 
> >>>> kernel 2.6
> >>>> Now tested with kernel 2.6.17-rc4
> 
> >>>> Kernel is on bootable CD-ROM
> >>>> Modules are loaded from initrd
> 
> >>>> This is what I copied from screen:
> 
> >>>> Loading hpt366
> >>>> [17179578.396000] HPT372A: IDE controller at PCI slot 0000:01:0a.0
> >>>> [17179578.400000] ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
> >>>> [17179578.404000] ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [APC1] 
> >>>> -> GSI 16 (level, high) -> IRQ 18
> >>>> [17179578.408000] HPT372A: chipset revision 2
> >>>> [17179578.412000] HPT372A: 100% native mode on irq 18
> >>>> [17179578.416000] hpt: HPT372N detected, using 372N timing.
> >>>> [17179578.420000] FREQ: 125 PLL: 45
> >>>> [17179579.536000] No Clock Stabilization!!!
> >>>> [17179579.540000] hpt: no known IDE timings, disabling DMA
> >>>> [17179579.544000] hpt: HPT372N detected, using 372N timing.
> >>>> [17179579.548000] FREQ: 156 PLL: 66
> >>>> [17179579.664000] No Clock Stabilization!!!
> 
> >>>    Please try my latest patches. This one should fix this (and oops 
> >>> should be gone):
> 
> >>> http://marc.theaimsgroup.com/?l=linux-ide&m=114677223914159&w=2
> 
> >> all patches applied, but I still get Kernel Oops :-(
> 
> >> some smal difference here:
> 
> >>   HPT372A: IDE controller at PCI slot 0000:01:0a.0
> >>   ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
> >>   ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [APC1] -> GSI 16 (level, 
> >> high) -> IRQ 18
> >>   HPT372A: chipset revision 2
> >>   HPT372A: 100% native mode on irq 18
> >> + HPT37X: no clock data saved by BIOS
> >> + HPT3xxN detected, FREQ: 124, PLL: 45
> >> + HPT37xN unknown bus timing [48 4].
> 
> >    Hm, the BIOS seems to behave nastier than expected -- looks like it
> > reprograms DPLL but doesn't save the initial f_CNT (needed to determine the
> > PCI clock). Well, I know that it always sets DPLL to 50 MHz, no matter 
> > what's the chip, so will try to work around this... :-/
> 
>     OTOH, there might be another reason to that: the BIOS saves f_CNT but the 
> register it uses for this isn't mapped to the PCI config. space, only to the 
> I/O space (it's undocumented, after all). Andy Shaw's report seems to confirm 
> this -- his RAID BIOS seems to be modern enough to save the f_CNT but the 
> driver probably fails to read it (I don't have the full boot log yet).
>     So, try the attached patch please. Foli, if this won't help, can you tell 
> what version your HighPoint BIOS is?
> 
> MBR, Sergei
> 
Hello Sergei,

I'm back.

SORRY! for the delay!

-----------------------------------------------------------------------------------------------------------------
this time patches tested with stable kernel 2.6.16.20


lspci -xxx -s 1:a (without hpt366 driver)

01:0a.0 RAID bus controller: Triones Technologies, Inc. HPT372A/372N (rev 02)
00: 03 11 05 00 05 00 30 02 02 00 04 01 08 40 00 00
10: 01 7c 00 00 01 80 00 00 01 84 00 00 01 88 00 00
20: 01 8c 00 00 00 00 00 00 00 00 00 00 03 11 01 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 08 08
40: 42 82 84 12 42 82 84 12 8a f4 c1 0a 8a f4 c1 0a
50: 05 00 00 00 05 00 00 00 1b 00 10 23 1e 00 20 00
60: 01 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 7d 00 f0 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


after applying your patches in following order:

HPT3xxN-clocking-fixes.patch
HPT37x-fix-timing-tables.patch
HPT3xx-fix-hotswap.patch
HPT3xx-fix-case-of-multiple-chips.patch
HPT3xx-use-f_CNT-saved-by-BIOS.patch
HPT3xx-optimize-timing-tables.patch
HPT3xx-rework-rate-filtering.patch
HPT37x-read-f_CNT-from-port.patch
HPT3xx-print-real-chip-name.patch
HPT3xx-use-pci_find_slot.patch
HPT3xx-cache-MCR-address.patch
HPT37x-merge-speedproc.patch
(for info: last two patches get the first two hunks rejeckted, only comments)

I get this:

HPT372N: IDE controller at PCI slot 0000:01:0a.0
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [APC1] -> GSI 16 (level, high) -> IRQ 185
HPT372N: chipset revision 2
HPT372N: 100% native mode on irq 185
HPT372N: FREQ: 80, PLL: 35
HPT372N: using 50MHz internal PLL
    ide2: BM-DMA at 0x8c00-0x8c07, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0x8c08-0x8c0f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: WDC WD800BB-00CAA1, ATA DISK drive
hdf: WDC WD800BB-00BSA0, ATA DISK drive
ide2 at 0x7c00-0x7c07,0x8002 on irq 185
hde: max request size: 128KiB
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hde: cache flushes not supported
 hde: hde1
hdf: max request size: 128KiB
hdf: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdf: cache flushes not supported
 hdf: hdf1
(for info: on ide3 no disks)


lspci -xxx -s 1:a (with patched hpt366 driver)

01:0a.0 RAID bus controller: Triones Technologies, Inc. HPT372A/372N (rev 02)
00: 03 11 05 00 05 00 30 02 02 00 04 01 00 78 00 00
10: 01 7c 00 00 01 80 00 00 01 84 00 00 01 88 00 00
20: 01 8c 00 00 00 00 00 00 00 00 00 00 03 11 01 00
30: 01 00 0a 50 60 00 00 00 00 00 00 00 0b 01 08 08
40: 42 82 84 12 42 82 84 12 8a f4 c1 0a 8a f4 c1 0a
50: 05 00 00 00 05 00 00 00 1b 00 00 21 23 00 25 00
60: 01 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 90 00 f0 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-----------------------------------------------------------------------------------------------------------------

thanks for your time and efforts!

can you also help how to access the RAID 1 set?


best regards
Foli
