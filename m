From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: sata_sil problems (lockup at boottime)
Date: Sun, 5 Dec 2004 17:10:33 +0100
Message-ID: <58cb370e04120508104243799a@mail.gmail.com>
References: <41B2499E.1080905@nv-systems.net>
	 <200412050908.33124.bausi@bausi.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.201]:47625 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261246AbULEQKe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Dec 2004 11:10:34 -0500
Received: by wproxy.gmail.com with SMTP id 37so7038wra
        for <linux-ide@vger.kernel.org>; Sun, 05 Dec 2004 08:10:34 -0800 (PST)
In-Reply-To: <200412050908.33124.bausi@bausi.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Oliver Bausinger <bausi@bausi.org>
Cc: linux-ide@vger.kernel.org, Gerald Hopf <gerald.hopf@nv-systems.net>

On Sun, 5 Dec 2004 09:08:32 +0100, Oliver Bausinger <bausi@bausi.org> wrote:
> Hi,
> 
> 
> 
> On Sunday 05 December 2004 00:34, you wrote:
> > Hello everyone,
> >
> > i'm having some really strange problems with the sata_sil driver.
> >
> > My hardware:
> > Asus A7N8X Deluxe Rev 1.x with onboard Sil3112 Controller
> > - Samsung SP1614C SATA Harddrive
> > - for further testing : PATA to SATA Adapter that came with an ABIT
> > Mainboard
> 
> I have the same problem with this hardware. The harddisk is a SAMSUNG SP1614C
> again and the controller is this one:
> 
> 0000:00:0a.0 Unknown mass storage controller: Silicon Image, Inc. (formerly
> CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev
> 01)
>         Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112
> [SATALink/SATARaid] Serial ATA Controller
>         Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 5
>         I/O ports at a000 [size=8]
>         I/O ports at 9800 [size=4]
>         I/O ports at 9400 [size=8]
>         I/O ports at 9000 [size=4]
>         I/O ports at 8800 [size=16]
>         Memory at e2000000 (32-bit, non-prefetchable)
> 
> Trying to insert the sata_sil module on 2.6.{7,8,9,10-rc3} gives
> 
> libata version 1.10 loaded.
> sata_sil version 0.8
> PCI: Found IRQ 5 for device 0000:00:0a.0
> ata1: SATA max UDMA/100 cmd 0xD0800080 ctl 0xD080008A bmdma 0xD0800000 irq 5
> ata2: SATA max UDMA/100 cmd 0xD08000C0 ctl 0xD08000CA bmdma 0xD0800008 irq 5
> irq 5: nobody cared!
>  [<c012e5aa>] __report_bad_irq+0x2a/0x90
>  [<c012df60>] handle_IRQ_event+0x30/0x70
>  [<c012e69c>] note_interrupt+0x6c/0xd0
>  [<c012e0d0>] __do_IRQ+0x130/0x160
>  [<c01042b9>] do_IRQ+0x19/0x30
>  [<c0102896>] common_interrupt+0x1a/0x20
>  [<c0117ab0>] __do_softirq+0x30/0x90
>  [<c0117b36>] do_softirq+0x26/0x30
>  [<c012df24>] irq_exit+0x34/0x40
>  [<c01042be>] do_IRQ+0x1e/0x30
>  [<c0102896>] common_interrupt+0x1a/0x20
>  [<c01005f0>] default_idle+0x0/0x30
>  [<c0100613>] default_idle+0x23/0x30
>  [<c010068a>] cpu_idle+0x3a/0x60
>  [<c032678d>] start_kernel+0x16d/0x1b0
>  [<c0326360>] unknown_bootoption+0x0/0x1b0
> handlers:
> [<d0962490>] (ata_interrupt+0x0/0x1c0 [libata])
> Disabling IRQ #5
> ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c68 86:3c01 87:4003
> 88:20ff
> ata1: dev 0 ATA, max UDMA7, 312581808 sectors: lba48

Looks like some other device is using the same IRQ
(it is not handled correctly and gets disabled).

> I think I can rule out hardware problems because a FreeBSD 5.3 install
> worked flawlessly on this disk.
> 
> [The other possible thing to do is to use the siimage driver in drivers/ide,
> but this one stopped working with 2.6.8 and further. The siimage driver works
> quite good with 2.6.7, so this is another proof for no hardware problems]

Please try narrowing problem down to specific 2.6.7-bk snapshot.  Thanks.

> > This problem has been there in all of the latest 2.6.X kernel revisions.
> > I'm currently using 2.6.10-rc3 (which came out today), but i've allready
> > had this problem in 2.6.9 and 2.6.8 and probably even 2.6.7 if i
> > remember correctly.

Was it working before 2.6.7?
