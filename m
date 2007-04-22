From: Arnd Hannemann <arnd@arndnet.de>
Subject: libata sata_sil error handling
Date: Sun, 22 Apr 2007 11:13:44 +0200
Message-ID: <462B2748.3080200@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:37306 "EHLO i-q-net.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754154AbXDVJpa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Apr 2007 05:45:30 -0400
Received: from [192.168.2.133] (solaris.kawo2.RWTH-Aachen.DE [134.130.181.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by i-q-net.de (Postfix) with ESMTP id 42AC813EA5
	for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2007 11:13:36 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

tried to use my SiI 3512 card in the 2nd slot of a riser card on my
mobo. Probably the BIOS did not assign a correct IRQ to the card, so I
got this error message when loading the sata_sil module on my 2.6.20.7
kernel:

> libata version 2.00 loaded.
> sata_sil 0000:00:0b.0: version 2.0
> sata_sil 0000:00:0b.0: Applying R_ERR on DMA activate FIS errata fix
> ata1: SATA max UDMA/100 cmd 0xEF980080 ctl 0xEF98008A bmdma 0xEF980000 irq 255
> ata2: SATA max UDMA/100 cmd 0xEF9800C0 ctl 0xEF9800CA bmdma 0xEF980008 irq 255
> sata_sil 0000:00:0b.0: irq 255 request failed: -22

Of course I don't blame libata for above, because the error seems to be
with my BIOS or riser card. But now when I tried to rmmod sata_sil, I
got these:

> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000010
>  printing eip:
> ef9c8b05
> *pde = 00000000
> Oops: 0000 [#1]
> Modules linked in: af_packet tun xt_state ipt_MASQUERADE ipt_REJECT ipt_recent ipt_LOG iptable_mangle iptax
> CPU:    0
> EIP:    0060:[<ef9c8b05>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.20.7 #2)
> EIP is at ata_host_remove+0x5/0xd0 [libata]
> eax: 00000000   ebx: b18d9400   ecx: b18d9448   edx: ef9cce20
> esi: 00000000   edi: ef97bbe4   ebp: e3a51000   esp: e3a51ef4
> ds: 007b   es: 007b   ss: 0068
> Process rmmod (pid: 4110, ti=e3a51000 task=e7444550 task.ti=e3a51000)
> Stack: b18d9400 b18d9448 ef97bbe4 ef9cce3a b18d9400 ef97bb94 b01dc036 b18d9448
>        b02262b4 b18d9448 ef97bb94 b02267e5 ef97bb94 ef97bb94 b033d180 b0225e89
>        ef97bb94 ef97bd00 00000000 b0226818 ef97bb60 b01dc10d 00000880 ef97bd00
> Call Trace:
>  [<ef9cce3a>] ata_pci_remove_one+0x1a/0x40 [libata]
>  [<b01dc036>] pci_device_remove+0x16/0x40
>  [<b02262b4>] __device_release_driver+0x64/0x90
>  [<b02267e5>] driver_detach+0x95/0xa0
>  [<b0225e89>] bus_remove_driver+0x69/0x90
>  [<b0226818>] driver_unregister+0x8/0x20
>  [<b01dc10d>] pci_unregister_driver+0xd/0x60
>  [<b01305d0>] sys_delete_module+0x140/0x1b0
>  [<b0142499>] remove_vma+0x39/0x50
>  [<b0142e37>] do_munmap+0x197/0x1f0
>  [<b0102cb0>] syscall_call+0x7/0xb
>  =======================
> Code: 74 24 04 8b 7c 24 08 8b 6c 24 0c 83 c4 10 e9 f3 cb fd ff 8d 76 00 0f ba b7 f0 1f 00 00 00 eb d0 8d b
> EIP: [<ef9c8b05>] ata_host_remove+0x5/0xd0 [libata] SS:ESP 0068:e3a51ef4

I don't know if there exists a clean way to bail out at this type of
error (i.e. is it possible refusing to load the module at all if IRQ
Request failed?) but just wanted to give you some input.

Best regards,
Arnd Hannemann
