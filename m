From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ata, pcmcia: problem with irq and ata_dev_read_id()
Date: Mon, 31 May 2010 17:55:59 -0600
Message-ID: <4C044C8F.8050406@gmail.com>
References: <4C034FAE.9090605@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62051 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab0EaX4C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 May 2010 19:56:02 -0400
Received: by gye5 with SMTP id 5so667700gye.19
        for <linux-ide@vger.kernel.org>; Mon, 31 May 2010 16:56:01 -0700 (PDT)
In-Reply-To: <4C034FAE.9090605@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hs@denx.de
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 05/30/2010 11:57 PM, Heiko Schocher wrote:
> Hello Jeff,
>
> I have ported Linux 2.6.34 for a 8xx based board using the m8xx_pcmcia.c
> driver in drivers/pcmcia/ with two slots and CONFIG_ATA, CONFIG_PATA_PCMCIA
> defined.
>
> All works fine, except with one CF card type, I get:
>
> rtc-pcf8563 0-0051: setting system clock to 2010-05-31 05:18:41 UTC (1275283121)
> pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
> pcmcia 0.0: pcmcia: registering new device pcmcia0.0
> scsi0 : pata_pcmcia
> ata1: PATA max PIO4 cmd 0x0 ctl 0xe irq 25
> ata1.00: CFA: TOSHIBA THNCF512MDG, 3.00, max MWDMA2
> ata1.00: 1000944 sectors, multi 1: LBA
> ata1.00: configured for PIO4
> ata1.00: configured for PIO4
> ata1: EH complete
> isa bounce pool size: 16 pages
> scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA THNCF512 3.00 PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 1000944 512-byte logical blocks: (512 MB/488 MiB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
>   sda: sda1 sda2 sda3 sda4
> pcmcia_socket pcmcia_socket1: pccard: PCMCIA card inserted into slot 1
> pcmcia 1.0: pcmcia: registering new device pcmcia1.0
> sd 0:0:0:0: [sda] Attached SCSI removable disk
> scsi1 : pata_pcmcia
> ata2: PATA max PIO4 cmd 0x10 ctl 0x1e irq 26
> irq 26: nobody cared (try booting with the "irqpoll" option)
> Call Trace:
> [c0327c70] [c0006ac0] show_stack+0x44/0x16c (unreliable)
> [c0327cb0] [c004b7b4] __report_bad_irq+0x34/0xb8
> [c0327cd0] [c004b9f0] note_interrupt+0x1b8/0x224
> [c0327d00] [c004c9a8] handle_level_irq+0xa8/0x124
> [c0327d10] [c0004de8] do_IRQ+0x98/0xb4
> [c0327d30] [c000e788] ret_from_except+0x0/0x14
> [c0327df0] [00009032] 0x9032
> [c0327e30] [c0004b38] do_softirq+0x58/0x5c
> [c0327e40] [c0023d90] irq_exit+0x98/0x9c
> [c0327e50] [c0004dec] do_IRQ+0x9c/0xb4
> [c0327e70] [c000e788] ret_from_except+0x0/0x14
> [c0327f30] [c00440ac] tick_nohz_stop_sched_tick+0x404/0x4d0
> [c0327f90] [c0007ac8] cpu_idle+0x50/0xe8
> [c0327fb0] [c0002930] rest_init+0x5c/0x6c
> [c0327fc0] [c02f088c] start_kernel+0x240/0x2c4
> [c0327ff0] [c000222c] start_here+0x4c/0xb0
> handlers:
> [<c0193bc4>] (ata_sff_interrupt+0x0/0x208)
> Disabling IRQ #26
> IP-Config: Complete:
>       device=eth0, addr=192.168.120.4, mask=255.255.0.0, gw=192.168.1.254,
>       host=kup4k, domain=, nis-domain=(none),
>       bootserver=192.168.1.1, rootserver=192.168.1.1, rootpath=
> ata2.00: CFA: TOSHIBA THNCF032MBA, 2.00, max PIO2
> ata2.00: 63488 sectors, multi 0: LBA
> ata2.00: configured for PIO2
> ata2.00: configured for PIO2
> ata2: EH complete
> scsi 1:0:0:0: Direct-Access     ATA      TOSHIBA THNCF032 2.00 PQ: 0 ANSI: 5
> sd 1:0:0:0: [sdb] 63488 512-byte logical blocks: (32.5 MB/31.0 MiB)
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 1:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
>   sdb: sdb1
> sd 1:0:0:0: [sdb] Attached SCSI removable disk
> Looking up port of RPC 100003/2 on 192.168.1.1
> [...]
>
> -bash-3.2# cat /proc/interrupts
>             CPU0
>   17:          0   CPM PIC          Level        error
>   18:          0   MPC8XX SIU       Level        tbint
>   19:         59   CPM PIC          Level        cpm_uart
>   21:          4   CPM PIC          Level        mpc8xxx_spi
>   22:          0   MPC8XX SIU       Edge         ads7846
>   23:      19950   MPC8XX SIU       Level        fs_enet-mac
>   24:          0   MPC8XX SIU       Level        m8xx-pcmcia
>   25:          9   MPC8XX SIU       Level        pata_pcmcia
>   26:     100000   MPC8XX SIU       Level        pata_pcmcia
>   27:         55   CPM PIC          Level        cpm_i2c
> LOC:      15403   Local timer interrupts
> SPU:          0   Spurious interrupts
> CNT:          0   Performance monitoring interrupts
> MCE:          0   Machine check exceptions
> -bash-3.2#
>
> I found out, that this card raise an irq when
> ata_dev_read_id() is called, and because
> ata_dev_read_id() sets the ATA_TFLAG_POLLING flag,
> the irq don;t get acked in ata_sff_interrupt()
> (So the irq comes endless (100000 times before it
>   get disabled))

Sounds like that card doesn't obey the nIEN flag to disable the 
interrupt, at least not on the identify command. Ugh.. Maybe we should 
be acking the interrupt anyway if we get one on a polling command? Not 
sure if that risks breaking anything or not..
