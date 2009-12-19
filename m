From: Jeff Garzik <jeff@garzik.org>
Subject: Re: pata_cmd64x broken in 2.6.33-rc1 on sparc64
Date: Sat, 19 Dec 2009 17:33:16 -0500
Message-ID: <4B2D54AC.3080509@garzik.org>
References: <alpine.SOC.1.00.0912200017540.17801@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:56913 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828AbZLSWdT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Dec 2009 17:33:19 -0500
In-Reply-To: <alpine.SOC.1.00.0912200017540.17801@math.ut.ee>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>

On 12/19/2009 05:23 PM, Meelis Roos wrote:
> This running on Sun Ultra 5 with CMD646 onboard ide.
>
> scsi0 : pata_cmd64x
> scsi1 : pata_cmd64x
> ata1: PATA max MWDMA2 cmd 0x1fe02c00000 ctl 0x1fe02c00008 bmdma 0x1fe02c00020 irq 14
> ata2: PATA max MWDMA2 cmd 0x1fe02c00010 ctl 0x1fe02c00018 bmdma 0x1fe02c00028 irq 14
> pata_cmd64x: active 10 recovery 10 setup 3.
> pata_cmd64x: active 10 recovery 10 setup 3.
> PCI: Enabling device: (0000:01:01.1), cmd 2
> sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
> eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:f8:c7:72
> mice: PS/2 mouse device common for all mice
> ------------[ cut here ]------------
> WARNING: at drivers/ata/pata_cmd64x.c:268 cmd64x_bmdma_stop+0x3c/0x60()
> Modules linked in:
> Call Trace:
>   [000000000064987c] cmd64x_bmdma_stop+0x3c/0x60
>   [0000000000644610] ata_sff_post_internal_cmd+0x30/0x60
>   [0000000000635910] ata_exec_internal_sg+0x310/0x4e0
>   [0000000000635b30] ata_exec_internal+0x50/0x80
>   [0000000000635ddc] ata_do_dev_read_id+0x1c/0x40
>   [0000000000635fb0] ata_dev_read_id+0x1b0/0x5c0
>   [00000000006423a8] ata_eh_recover+0x5c8/0x1280
>   [0000000000643288] ata_do_eh+0x28/0xa0
>   [0000000000643e94] ata_scsi_error+0x374/0x600
>   [00000000006221ec] scsi_error_handler+0xcc/0x460
>   [000000000046fdc0] kthread+0x60/0x80
>   [000000000042b4b0] kernel_thread+0x30/0x60
>   [000000000046fd1c] kthreadd+0x9c/0xe0
> ---[ end trace 61a1d617a7f4a94d ]---


linux-ide CC added.

Does backing out the following commit fix things?

	commit d43744390e460dce6626fb8de2c02a24ff650005
	Author: Alan Cox <alan@linux.intel.com>
	Date:   Mon Nov 30 13:22:54 2009 +0000

	    pata_cmd64x: implement serialization as per notes

Although quite unlikely, commit f0353813afe784330622596ff141e7525ccd99de 
may also change things.  Try backing that out, if backing out the first 
commit (d43744...) fails to improve behavior.

	Jeff


