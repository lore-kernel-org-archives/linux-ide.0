From: Dustin Harrison <d.harrison@sutus.com>
Subject: Re: ata_check_status_mmio exception kernel panic
Date: Fri, 03 Apr 2009 10:56:48 -0700
Message-ID: <49D64DE0.8060400@sutus.com>
References: <3fb94e50903312006y12717b8dh7dd7769f3f5b1dda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from office.office.sutus.com ([216.18.10.60]:43916 "EHLO
	office.sutuscentral.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765466AbZDCSEl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Apr 2009 14:04:41 -0400
In-Reply-To: <3fb94e50903312006y12717b8dh7dd7769f3f5b1dda@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sagar Borikar <sagar.borikar@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>

Sagar Borikar wrote:
> Hi,
>
> We are facing random kernel panics on drive removal when IO is
> happening to RAID. Note that kernel panic is random and not every time
> it happens. This is mips based production system and kernel is 2.6.18.
> Unfortunately we can't upgrade the kernel as its on field.
>
> Here is the log that we have got,
>
> Data bus error, epc == 80377358, ra == 80377384
> Oops[#1]:
> Cpu 0
> $ 0   : 00000000 804d0024 c001e0c7 0001000b
> $ 4   : 811a829c 811a8d5c 00000260 804d358c
> $ 8   : 90008000 1000001f 00000000 852c4000
> $12   : 87a2bb80 00006764 00000000 00000000
> $16   : 811a8d5c 811a829c 811a829c 00000001
> $20   : 80513d98 00000000 00000000 00000000
> $24   : 00000000 2b0c2ba0
> $28   : 80512000 80513be0 00000000 80377384
> Hi    : 00000000
> Lo    : 00000000
> epc   : 80377358 ata_check_status_mmio+0x4/0x10     Not tainted
> ra    : 80377384 ata_check_status+0x20/0x3c
> Status: 90008003    KERNEL EXL IE
> Cause : 0000201c
> PrId  : 000034c1
> Modules linked in: aes
> Process swapper (pid: 0, threadinfo=80512000, task=80514fc8)
> Stack : 00000000 803ff4bc 00000000 00000000 80377240 80364204 8703c6a8 805bccc8
>         8011d1a8 80434840 811a829c 811a8ccc 8037731c 871bf660 00000001 805bccc8
>         8703c6a8 00000000 8037068c 8538db80 805345d8 80513cd8 00000001 805ce368
>         811a8348 00000001 80378e54 00000001 82560238 82560238 8011dfd8 00000001
>         00010000 811a829c 811a829c c001e000 80378f60 871bf660 871bf660 00000000
>         ...
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
>   
Hi Sagar,

I also run a MIPS platform and have seen this problem in 2.6.22.  It 
stems from the Sil3512 (and possibly others) not allowing read access to 
the taskfile registers while a DMA transfer is active.  What happens for 
me is that when DMA_ENABLE is true the Sil3512 (in my case) will 
disallow reads to the taskfile registers.  So any event that triggers a 
port freeze during an interrupt while DMA is active causes a bus error 
to be thrown when the ata_check_status call fires.  I cannot reproduce 
this on x86.  I assume it handles the taskfile read error differently.

As a workaround I have used this patch on sata_sil.c to cover up the 
problem and stop the kernel panics.  But I don't think this is the best 
approach.

--- drivers/ata/sata_sil.c.orig 2009-04-01 18:15:55.000000000 -0700
+++ drivers/ata/sata_sil.c      2009-04-03 10:51:56.000000000 -0700
@@ -454,6 +454,23 @@
  err_hsm:
        qc->err_mask |= AC_ERR_HSM;
  freeze:
+
+       /* Before we do a port freeze we need to ensure DMA_ENABLE is off.
+       * This is because the controller will not give us access to the 
taskfile
+       * registers while a DMA is in progress and ata_qc_complete is 
the first
+       * function executed in ata_port_freeze. ata_port_freeze will 
attempt to
+       * access the tf registers and give us a host bus error kernel panic.
+       *
+       * This code is repeated from ata_bmdma_stop because we may not 
have a
+       * valid qc to pass to ata_bmdma_stop.
+       */
+       iowrite8(ioread8(ap->ioaddr.bmdma_addr) & ~SIL_DMA_ENABLE, 
ap->ioaddr.bmdma_addr);
+
+       /* According to ata_bmdma_stop, an HDMA transition requires on 
PIO cycle.
+        *  But we can't read a taskfile register.
+       */
+       ioread8(ap->ioaddr.bmdma_addr)
+
        ata_port_freeze(ap);
 }



