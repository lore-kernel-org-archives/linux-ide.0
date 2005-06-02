From: Rudolf Marek <r.marek@sh.cvut.cz>
Subject: sata_sil siimage OOPS
Date: Thu, 02 Jun 2005 20:30:30 +0200
Message-ID: <429F5046.9050707@sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from service.sh.cvut.cz ([147.32.127.214]:23995 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S261218AbVFBSac
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Jun 2005 14:30:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by service.sh.cvut.cz (Postfix) with ESMTP id A5F4C1A343B
	for <linux-ide@vger.kernel.org>; Thu,  2 Jun 2005 20:30:31 +0200 (CEST)
Received: from service.sh.cvut.cz ([127.0.0.1])
	by localhost (service [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 20935-05 for <linux-ide@vger.kernel.org>;
	Thu, 2 Jun 2005 20:30:30 +0200 (CEST)
Received: from desitka.sh.cvut.cz (desitka.sh.cvut.cz [147.32.127.224])
	by service.sh.cvut.cz (Postfix) with SMTP id 0D6BD1A343C
	for <linux-ide@vger.kernel.org>; Thu,  2 Jun 2005 20:30:30 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, acm@acmik.org

Hello,

My friend just switched to new motherboard and wanted to use his PCI
0000:03:04.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)

To his surprise both siimage and sata_sil oopsed.

I track down a oops to:
writeb(cls, mmio_base + SIL_FIFO_W2);

Code;  e098150a <pg0+2035050a/3f9cd400>   <=====
   0:   88 83 41 02 00 00         mov    %al,0x241(%ebx)   <=====

I checked ioremap and have seen that it requests only 512B while this offset is 0x241 bytes.

In lspci there was also only 512B for this memory region.
cat /proc/iomem

dfec0000-dfedffff : 0000:03:03.0
  dfec0000-dfedffff : e100
dfefe000-dfefefff : 0000:03:03.0
  dfefe000-dfefefff : e100
dfeffe00-dfefffff : 0000:03:04.0
    ^^^^^
    0x200 only

dffff900-dffff9ff : 0000:00:1f.5
dffff900-dffff9ff : Intel 82801DB-ICH4

I have some questions:

Whos fault is it?

1) Fault of bios inside the card
2) Fault of main bios
3) Linux ???

Proposed actions:

1) add check into sata_sil and siimage to see if the memory region is large enough
2) add pci/quirks.c entry

static void __devinit muj_quirk(struct pci_dev *dev)
{
        struct resource *r = &dev->resource[5];

/* some if here to check actual region else fix: */
                r->start = 0;
                r->end = 0x400;

}
/*fix the numbers and routine name */
DECLARE_PCI_FIXUP_HEADER(0x1095,0x3112,muj_quirk );

After applying the quirk.c:

20000000-200003ff : 0000:00:1f.1
20000800-20000c00 : 0000:03:04.0

It works OK now.

I can create neccessary patches if needed.

regards

Rudolf

Linux acm-office 2.6.12-rc5 #6 Thu Jun 2 19:38:07 CEST 2005 i686 GNU/Linux

0000:00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 11)
0000:00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 11)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller (rev 01)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC Bridge (rev 01)
0000:00:1f.1 IDE interface: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) UltraATA-100 IDE Controller (rev 01)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 01)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500]
0000:03:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0c)
0000:03:04.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)

0000:03:04.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
        Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) Asus A7N8X
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 11
        I/O ports at bc00 [size=8]
        I/O ports at b800 [size=4]
        I/O ports at b400 [size=8]
        I/O ports at b000 [size=4]
        I/O ports at ac00 [size=16]
        Memory at 20000800 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at dfe00000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2


Motherboard:
               Manufacturer: Micro-Star Inc.
                Product Name: MS-6566E
		 BIOS Information
                Vendor: American Megatrends Inc.
                Version: 07.00T
                Release Date: 04/02/01

Unable to handle kernel paging request at virtual address e0987041
e098150a
*pde = 01533067
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<e098150a>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202   (2.6.12-rc5)
eax: 00000002   ebx: e0986e00   ecx: 00000008   edx: ccd75eb3
esi: 00000030   edi: dff20c00   ebp: ccd75edc   esp: ccd75ebc
ds: 007b   es: 007b   ss: 0068
Stack: dff20c00 00000200 00000000 d4372c00 00000002 e09825e0 ffffffed dff20c00
       ccd75ef8 c02df3dd dff20c00 e0982500 e09825e0 dff20c00 e098260c ccd75f08
       c02df41c e09825e0 dff20c00 ccd75f20 c02df44c e09825e0 dff20c00 e098260c
Call Trace:
 [<c0102def>] show_stack+0x7f/0xa0
 [<c0102f96>] show_registers+0x156/0x1c0
 [<c0103188>] die+0xc8/0x140
 [<c010e706>] do_page_fault+0x376/0x6d4
 [<c0102a33>] error_code+0x4f/0x54
 [<c02df3dd>] pci_device_probe_static+0x4d/0x60
 [<c02df41c>] __pci_device_probe+0x2c/0x30
 [<c02df44c>] pci_device_probe+0x2c/0x50
 [<c03297ce>] driver_probe_device+0x2e/0x80
 [<c032991c>] driver_attach+0x5c/0xa0
 [<c0329eaa>] bus_add_driver+0xaa/0xe0
 [<c02df6cf>] pci_register_driver+0x4f/0x60
 [<e0984012>] sil_init+0x12/0x16 [sata_sil]
 [<c012fa82>] sys_init_module+0x152/0x1f0
 [<c0102819>] syscall_call+0x7/0xb
Code: 4d f0 3b 8a f4 01 00 00 72 a7 8b 7d 08 89 3c 24 e8 0c fb ff ff 84 c0 0f 84 bd 00 00 00 c0 e8 03 fe c0 88 43 40 88 43 41
 88 43 44 <88> 83 41 02 00 00 8b 45 0c 83 78 18 01 0f 84 7b 00 00 00 ba 00
