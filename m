From: Sagar Borikar <sagar.borikar@gmail.com>
Subject: Re: ata_check_status_mmio exception kernel panic
Date: Wed, 1 Apr 2009 08:38:26 +0530
Message-ID: <3fb94e50903312008v4d7bbfa6k70ce0d6792ae69ee@mail.gmail.com>
References: <3fb94e50903312006y12717b8dh7dd7769f3f5b1dda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:30743 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122AbZDADI2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Mar 2009 23:08:28 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3358113rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 31 Mar 2009 20:08:26 -0700 (PDT)
In-Reply-To: <3fb94e50903312006y12717b8dh7dd7769f3f5b1dda@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>

=46orgot to mention one point that it happens only with SIL3114 SATA co=
ntroller

Sagar

On Wed, Apr 1, 2009 at 8:36 AM, Sagar Borikar <sagar.borikar@gmail.com>=
 wrote:
> Hi,
>
> We are facing random kernel panics on drive removal when IO is
> happening to RAID. Note that kernel panic is random and not every tim=
e
> it happens. This is mips based production system and kernel is 2.6.18=
=2E
> Unfortunately we can't upgrade the kernel as its on field.
>
> Here is the log that we have got,
>
> Data bus error, epc =3D=3D 80377358, ra =3D=3D 80377384
> Oops[#1]:
> Cpu 0
> $ 0 =A0 : 00000000 804d0024 c001e0c7 0001000b
> $ 4 =A0 : 811a829c 811a8d5c 00000260 804d358c
> $ 8 =A0 : 90008000 1000001f 00000000 852c4000
> $12 =A0 : 87a2bb80 00006764 00000000 00000000
> $16 =A0 : 811a8d5c 811a829c 811a829c 00000001
> $20 =A0 : 80513d98 00000000 00000000 00000000
> $24 =A0 : 00000000 2b0c2ba0
> $28 =A0 : 80512000 80513be0 00000000 80377384
> Hi =A0 =A0: 00000000
> Lo =A0 =A0: 00000000
> epc =A0 : 80377358 ata_check_status_mmio+0x4/0x10 =A0 =A0 Not tainted
> ra =A0 =A0: 80377384 ata_check_status+0x20/0x3c
> Status: 90008003 =A0 =A0KERNEL EXL IE
> Cause : 0000201c
> PrId =A0: 000034c1
> Modules linked in: aes
> Process swapper (pid: 0, threadinfo=3D80512000, task=3D80514fc8)
> Stack : 00000000 803ff4bc 00000000 00000000 80377240 80364204 8703c6a=
8 805bccc8
> =A0 =A0 =A0 =A08011d1a8 80434840 811a829c 811a8ccc 8037731c 871bf660 =
00000001 805bccc8
> =A0 =A0 =A0 =A08703c6a8 00000000 8037068c 8538db80 805345d8 80513cd8 =
00000001 805ce368
> =A0 =A0 =A0 =A0811a8348 00000001 80378e54 00000001 82560238 82560238 =
8011dfd8 00000001
> =A0 =A0 =A0 =A000010000 811a829c 811a829c c001e000 80378f60 871bf660 =
871bf660 00000000
> =A0 =A0 =A0 =A0...
> Call Trace:
> [<80377358>] ata_check_status_mmio+0x4/0x10
> [<80377384>] ata_check_status+0x20/0x3c
> [<80377240>] ata_tf_read_mmio+0x1c/0xd8
> [<8037731c>] ata_tf_read+0x20/0x3c
> [<8037068c>] ata_qc_complete+0xb4/0x128
> [<80378e54>] ata_port_abort+0xc4/0x100
> [<80378f60>] ata_port_freeze+0x54/0x78
> [<8037b7b8>] sil_host_intr+0x208/0x220
> [<8037b8a4>] sil_interrupt+0xd4/0x108
> [<80145b58>] handle_IRQ_event+0x60/0xc8
> [<80145c78>] __do_IRQ+0xb8/0x140
> [<80104624>] do_IRQ+0x1c/0x34
> [<80100ef8>] pmc_sequoia_pci_isr+0x3c/0x98
> [<80100fc8>] do_extended_irq+0x74/0x80
> [<80101070>] plat_irq_dispatch+0x9c/0xac
> [<80102eb0>] ret_from_irq+0x0/0x10
>
>
> Code: 03e00008 =A0304200ff =A08c820054 <90420000> 03e00008 =A0304200f=
f
> 27bdffe8 =A0afbf0010 =A08c82000c
> Kernel panic - not syncing: Fatal exception in interrupt
>
> The problem is we don't see this exception every time the drive is
> pulled out.First level look at log indicates that the bus address is
> not right because of which the exception occurs.
> Has anyone observed similar issues before?
>
> Thanks
> Sagar
>
