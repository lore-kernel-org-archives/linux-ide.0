From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Mon, 12 Dec 2016 13:21:56 +0100
Message-ID: <2575141.gMpqs59WaB@amdc3058>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
 <20161202170705.GB6033@htj.duckdns.org>
 <CAP8WD_bUW9cAAQpvenL73sxvpoxNYwZdRqpj92YWEyanK51+0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:42947 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750712AbcLLMcA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Dec 2016 07:32:00 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OI201RNGNOM9PA0@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Mon, 12 Dec 2016 21:21:58 +0900 (KST)
In-reply-to: <CAP8WD_bUW9cAAQpvenL73sxvpoxNYwZdRqpj92YWEyanK51+0g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: whiteheadm@acm.org
Cc: Tejun Heo <tj@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org


Hi,

On Monday, December 05, 2016 09:19:35 AM tedheadster wrote:
> Tejun,
>   that new patch worked better.
> 
> Here is the dmesg output:
> 
> [   34.347350] scsi0 : pata_legacy
> [   34.367366] ata1: PATA max PIO4 cmd 0x1f0 ctl 0x3f6 irq 14
> [   34.523330] ata1.00: ATA-4: QUANTUM FIREBALL CR8.4A, A5U.1200, max UDMA/66
> [   34.524804] ata1.00: 16514064 sectors, multi 0: LBA
> [   34.525747] ata1.00: configured for PIO
> [   34.569330] scsi 0:0:0:0: Direct-Access     ATA      QUANTUM
> FIREBALL A5U. PQ: 0 ANSI: 5
> [   34.655313] sd 0:0:0:0: [sda] 16514064 512-byte logical blocks:
> (8.45 GB/7.87 GiB)
> [   34.674309] sd 0:0:0:0: [sda] Write Protect is off
> [   34.675683] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [   34.689347] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [   34.691283] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [   34.800293]  sda: sda1 sda2 sda3 sda4
> [   34.890325] sd 0:0:0:0: [sda] Attached SCSI disk
> [   34.976270] scsi1 : pata_legacy
> [   34.999263] ata2: PATA max PIO4 cmd 0x170 ctl 0x376 irq 15
> [   35.448191] scsi2 : pata_legacy
> [   35.486192] ata3: PATA max PIO4 cmd 0x1e8 ctl 0x3ee irq 11
> [   35.997114] scsi3 : pata_legacy
> [   36.051103] ata4: PATA max PIO4 cmd 0x168 ctl 0x36e irq 10
> [   36.384057] genirq: Flags mismatch irq 8. 00000000 (platform) vs.
> 00000000 (rtc0)
> [   36.571024] scsi4 : pata_legacy
> [   36.626014] ata5: PATA max PIO4 cmd 0x160 ctl 0x366 irq 12
> [   42.143223] EXT4-fs (sda4): mounting ext3 file system using the
> ext4 subsystem
> 
> and /proc/interrupts looks good:
> 
>            CPU0
>   0:     558552    XT-PIC-XT-PIC    timer
>   1:        337    XT-PIC-XT-PIC    i8042
>   2:          0    XT-PIC-XT-PIC    cascade
>   4:          1    XT-PIC-XT-PIC
>   8:          0    XT-PIC-XT-PIC    rtc0
>  14:      51538    XT-PIC-XT-PIC    platform

Thank you for testing.

Tejun, is this information sufficient to fix the issue or do you still
want Matthew to test your last debug patch?

[ http://marc.info/?l=linux-ide&m=148096582017930&w=2 ]

> I would still like to get my patch in. If you have a motherboard where
> you cannot disable the secondary hard drive controllers, the
> pata_legacy driver will detect them and allocate the interrupt. Some

If there are no devices attached to the controller, the driver will
free the resources so I don't quite get what would be the issue here.
Could you please explain it more?

> way to disable this behavior is useful.
> 
> - Matthew

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

