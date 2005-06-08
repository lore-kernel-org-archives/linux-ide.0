From: Sergio Navarro i Fajardo <navarro_ser@gva.es>
Subject: sata_sil: Fix FIFO PCI Bus Arbitration KERNEL OOPS!
Date: Wed, 8 Jun 2005 12:34:14 +0200
Message-ID: <200506081234.14415.navarro_ser@gva.es>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 201.red-82-159-136.user.auna.net ([82.159.136.201]:26810 "EHLO
	nicochan.gva.es") by vger.kernel.org with ESMTP id S262156AbVFHKh1
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jun 2005 06:37:27 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi!
Kernel 2.6.12-rc5 includes patch references on mail:
--
Re: [RFT, PATCH] sata_sil corruption / lockup fix
http://marc.theaimsgroup.com/?l=linux-ide&m=111818249232162&w=2
[PATCH] sata_sil: Fix FIFO PCI Bus Arbitration
--
But, this patch produces an oops on load modules sata_sil on my system:
sata_sil version 0.9
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 185
Unable to handle kernel paging request at virtual address d0909041
 printing eip:
 d090b547
 *pde = 0127b067
 *pte = 00000000
 Oops: 0002 [#1]
 Modules linked in: sata_sil
 CPU:    0
 EIP:    0060:[<d090b547>]    Not tainted VLI
 EFLAGS: 00010202   (2.6.12-rc6)
 EIP is at sil_init_one+0x277/0x3c0 [sata_sil]
 eax: 00000002   ebx: d0908e00   ecx: 00000008   edx: cd4f9ecb
 esi: 00000030   edi: cee23c78   ebp: 00000002   esp: cd4f9ed0
 ds: 007b   es: 007b   ss: 0068
 Process modprobe (pid: 2318, threadinfo=cd4f8000 task=cd4d1a20)
 Stack: cff32000 00000200 00000000 cee23c00 d090d0e0 ffffffed cff32000 
00000000
 c01e9ee2 cff32000 d090d000 cff32000 d090d0e0 d090d10c c01e9f3c d090d0e0
 cff32000 d090d0e0 cff32000 c01e9f7c d090d0e0 cff32000 d090d10c cff32044
 Call Trace:
 [<c01e9ee2>] pci_device_probe_static+0x52/0x70
 [<c01e9f3c>] __pci_device_probe+0x3c/0x50
 [<c01e9f7c>] pci_device_probe+0x2c/0x50
 [<c023a04f>] driver_probe_device+0x2f/0x80
 [<c023a19c>] driver_attach+0x5c/0xa0
 [<c023a70d>] bus_add_driver+0x9d/0xd0
 [<c01ea0c0>] pci_device_shutdown+0x0/0x30
 [<c01ea224>] pci_register_driver+0x64/0x90
 [<d080600f>] sil_init+0xf/0x11 [sata_sil]
 [<c012ddc2>] sys_init_module+0x132/0x1c0
 [<c0102a09>] syscall_call+0x7/0xb
 Code: 0c 3b a8 f4 01 00 00 72 ab 8b 54 24 24 89 14 24 e8 cf fa ff ff 84 c0
 0f 84 ab 00 00 00 c0 e8 03 fe c0 88 43 40 88 43 41 88 43 44 <88> 83 41 02
 00 00 8b 4c 2428 83 79 18 01 74 70 ba 00 00 c0 00

If I remove this patch, module loads ok, but kernel produces errors like this:
Jun  8 02:57:43 localhost kernel: ata4: status=0xd9 { Busy }
Jun  8 02:57:43 localhost kernel: SCSI error : <3 0 0 0> return code = 
0x8000002
Jun  8 02:57:43 localhost kernel: Current sdd: sense = 70 10
Jun  8 02:57:43 localhost kernel: Raw sense data:0x70 0x00 0x10 0x00 0x00 0x00 
0x00 0x0a 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
Jun  8 02:57:43 localhost kernel: end_request: I/O error, dev sdd, sector 
14372048
Jun  8 02:57:43 localhost kernel: Buffer I/O error on device sdd, logical 
block 1796506
Jun  8 02:57:43 localhost kernel: ATA: abnormal status 0xD9 on port 0xD0806AC7

I attach the dmesg and the lspci output in this mail:
http://marc.theaimsgroup.com/?l=linux-ide&m=111817362405381&w=2

Bye!

-- 
____________________________________________________________________

  Sergio Navarro i Fajardo
 
   snavarro@odec.es  --  sergio.navarro@uv.es
   GnuPG-Public-Key: 0x24E340FF
   Alginet / Valencia / Spain
