From: Tejun Heo <htejun@gmail.com>
Subject: Re: Adaptec 1220SA (Sil3132) & sata_sil24 question
Date: Mon, 12 Mar 2007 20:05:28 +0900
Message-ID: <45F533F8.3050401@gmail.com>
References: <45E65540.6090308@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:45322 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965562AbXCLLF1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 07:05:27 -0400
Received: by wr-out-0506.google.com with SMTP id i7so2070725wra
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 04:05:27 -0700 (PDT)
In-Reply-To: <45E65540.6090308@metaparadigm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Clark <jclark@metaparadigm.com>
Cc: linux-ide@vger.kernel.org

Hello,

James Clark wrote:
> I have an Adaptec 1220SA which I originally thought was just a re-badged
> Sil3132 design. Externally it appears that way (the stamp on the chip
> reads 3132), however it identifies as a Silicon Image type 0x0242
> according to lspci.  sata_sil24 does not attach.
> 
> I made the trivial addition to sata_sil24 device id table and it appears
> to work. Performance is about the same as I get with the same drives on
> the onboard sata_via (about 78MB/s sequential read, 72MB/s write) and
> md mirror resyncing reflects this.

I'll ask SIMG about it.

> This is on a FC6 system (2.6.19-1.2911.fc6  SMP x86_64).
> I compared with 2.6.20 sources and sata_sil24 seems to have some
> cosmetic changes, but nothing that would help this it seems.
> 
> When the patched module loads I see a 'failed to IDENTIFY' and spurious
> interrupt message. These do not seem to recur during use. Anything to
> worry about?
> I note that lspci reports a subvendor of Adaptec, type 0x242. Is it
> correct to just patch (like below) where one vendor appears to have
> 'cloaked' a generic board?

Yeap, the patch looks fine.

> 04:00.0 RAID bus controller: Silicon Image, Inc. Unknown device 0242
> (rev 01) (prog-if 01)
>     Subsystem: Adaptec Unknown device 0242
>     Flags: bus master, fast devsel, latency 0, IRQ 32
>     Memory at dc004000 (64-bit, non-prefetchable) [size=128]
>     Memory at dc000000 (64-bit, non-prefetchable) [size=16K]
>     I/O ports at 9000 [size=128]
>     Expansion ROM at db000000 [disabled] [size=512K]
>     Capabilities: [54] Power Management version 2
>     Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0
> Enable-
>     Capabilities: [70] Express Legacy Endpoint IRQ 0
>     Capabilities: [100] Advanced Error Reporting
> 
> ---
> 
> --- drivers/ata/sata_sil24.c.orig    2006-11-30 05:57:37.000000000 +0800
> +++ drivers/ata/sata_sil24.c    2007-02-28 19:08:18.000000000 +0800
> @@ -347,6 +347,7 @@
>      { PCI_VDEVICE(CMD, 0x3124), BID_SIL3124 },
>      { PCI_VDEVICE(INTEL, 0x3124), BID_SIL3124 },
>      { PCI_VDEVICE(CMD, 0x3132), BID_SIL3132 },
> +    { PCI_VDEVICE(CMD, 0x0242), BID_SIL3132 },
>      { PCI_VDEVICE(CMD, 0x3131), BID_SIL3131 },
>      { PCI_VDEVICE(CMD, 0x3531), BID_SIL3131 },
> 
> ---
> 
> sata_sil24 0000:04:00.0: version 0.3
> ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 32 (level, low) -> IRQ 32
> PCI: Setting latency timer of device 0000:04:00.0 to 64
> ata3: SATA max UDMA/100 cmd 0xFFFFC20012378000 ctl 0x0 bmdma 0x0 irq 32
> ata4: SATA max UDMA/100 cmd 0xFFFFC2001237A000 ctl 0x0 bmdma 0x0 irq 32
> scsi2 : sata_sil24
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
> ata3: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive 0x0)

But this is weird.  libata somehow thought the drive is a really old one
and tried to do INIT_DEV_PARAMS on it.  Does this always happen?  Can
you give a shot at 2.6.20 with your patch applied?

Thanks.

-- 
tejun
