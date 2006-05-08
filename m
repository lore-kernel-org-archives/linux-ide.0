From: "Paul M." <paul@gpmidi.net>
Subject: Re: IRQ problem with sata_sil
Date: Mon, 8 May 2006 10:19:12 +0000
Message-ID: <dd43dcfb0605080319t59c8d152lc12f872917d9c8bf@mail.gmail.com>
References: <e3n4ru$ktd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:40006 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751082AbWEHKTN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 May 2006 06:19:13 -0400
Received: by py-out-1112.google.com with SMTP id x31so1424643pye
        for <linux-ide@vger.kernel.org>; Mon, 08 May 2006 03:19:12 -0700 (PDT)
In-Reply-To: <e3n4ru$ktd$1@sea.gmane.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas STRANSKY <Nico@stransky.cx>
Cc: linux-ide@vger.kernel.org

I had a similar error with my system's on board SI controller while
accessing a 3ware controller at high speeds. Personally I'm probably
going to avoid the whole problem and try to boot from the 3ware array.
-Paul

(My email to the Xen list)
To: xen-users@lists.xensource.com
Date: Apr 29, 2006 9:23 AM
Subject: SATA Controller Loosing Interrupt During High Speed Access To
RAID Array

A server I've been setting up has been experiencing "lockups" during
sustained high speed access to its hardware RAID controller. The
"lockup" is actual the system loosing access to the SATA disk that the
system partitions reside on. The error message reported to the console
leads me to believe that the SATA disk/controller "lost" its
interrupt.
I'm fairly sure that this isn't power or hardware related. And I'm
betting that 3ware's Linux drives on amd64 are stable. But I won't be
able to rule these out for sure until I run a few more tests. After I
finish this I'll capture the error message if it still looks to be Xen
related.
I'm posting this now to see if this sort of thing has been seen before.

Hard:
1x dual core opteron 275
4GB RAM
Silicone Image SATA controller
w/ 1x SATA drive
3WARE ESCALAD 9550SX-4LP SATA
w/ 2x SATA drives

Soft:
Xen 3.0.1 & 3.0.2
dom0 Debian 31r0a
Using a custom compiled kernel

I run into problems when I use dd to either read or write a >=3D8GB fil=
e
to the drive. Light disk access does not cause problems. When I ran
the array in RAID1 (~75MB/s sustained write) I didn't get any errors.
When I switched it to RAID0 (~150MB/s sustained write) the errors came
back.

Lemme know if you have any thoughts on this. I'll repost when I have
more information.


-Paul

On 5/8/06, Nicolas STRANSKY <Nico@stransky.cx> wrote:
> Hi all,
>
> I've encountered a problem when trying to use a SATA card with a Sili=
con
> Image SIL 3112 host controller chip. When inserting the module, the
> kernel made this error:
>
> > May  7 21:15:18 aneto kernel: sata_sil 0000:02:0c.0: version 1.0
> > May  7 21:15:18 aneto kernel: PCI: Found IRQ 10 for device 0000:02:=
0c.0
> > May  7 21:15:18 aneto kernel: PCI: Sharing IRQ 10 with 0000:02:05.0
> > May  7 21:15:18 aneto kernel: ata1: SATA max UDMA/100 cmd 0xF8FBC08=
0 ctl 0xF8FBC08A bmdma 0xF8FBC000 irq 10
> > May  7 21:15:18 aneto kernel: ata2: SATA max UDMA/100 cmd 0xF8FBC0C=
0 ctl 0xF8FBC0CA bmdma 0xF8FBC008 irq 10
> > May  7 21:15:18 aneto kernel: ata1: SATA link up 1.5 Gbps (SStatus =
113 SControl 310)
> > May  7 21:15:18 aneto kernel: irq 10: nobody cared (try booting wit=
h the "irqpoll" option)
> > May  7 21:15:18 aneto kernel: <c0131ad3> __report_bad_irq+0x2b/0x69=
   <c0131cd8> note_interrupt+0x1c7/0x1f7
> > May  7 21:15:18 aneto kernel: <c0131660> __do_IRQ+0x8d/0xcd   <c010=
43ad> do_IRQ+0x1d/0x28
> > May  7 21:15:18 aneto kernel: <c0102cc2> common_interrupt+0x1a/0x20=
   <c0118237> __do_softirq+0x2c/0x7d
> > May  7 21:15:18 aneto kernel: <c01182aa> do_softirq+0x22/0x26   <c0=
11837f> irq_exit+0x29/0x34
> > May  7 21:15:18 aneto kernel: <c01043b2> do_IRQ+0x22/0x28   <c0102c=
c2> common_interrupt+0x1a/0x20
> > May  7 21:15:18 aneto kernel: <c016034c> __d_lookup+0x62/0x123   <c=
0157fa4> do_lookup+0x25/0x13f
> > May  7 21:15:18 aneto kernel: <c015839e> __link_path_walk+0x2e0/0xb=
f6   <c01767b1> proc_delete_inode+0x22/0x75
> > May  7 21:15:18 aneto kernel: <c0158cfd> link_path_walk+0x49/0xbb  =
 <c015919b> do_path_lookup+0x1a4/0x1d5
> > May  7 21:15:18 aneto kernel: <c01593db> do_unlinkat+0x2f/0xff   <c=
0357ca7> syscall_call+0x7/0xb
> > May  7 21:15:18 aneto kernel: <c035007b> xfrm_aalg_get_byid+0x27/0x=
39
> > May  7 21:15:18 aneto kernel: handlers:
> > May  7 21:15:18 aneto kernel: [<c02d2c90>] (ata_interrupt+0x0/0x13f=
)
> > May  7 21:15:18 aneto kernel: Disabling IRQ #10
> > May  7 21:15:18 aneto kernel: ata1: dev 0 cfg 49:2f00 82:346b 83:7d=
01 84:4003 85:3469 86:3c01 87:4003 88:207f
> > May  7 21:15:18 aneto kernel: ata1: dev 0 ATA-6, max UDMA/133, 3125=
81808 sectors: LBA48
> > May  7 21:15:18 aneto kernel: ata1: dev 0 configured for UDMA/100
> > May  7 21:15:18 aneto kernel: scsi1 : sata_sil
> > May  7 21:15:18 aneto kernel: ata2: SATA link down (SStatus 0 SCont=
rol 310)
> > May  7 21:15:18 aneto kernel: scsi2 : sata_sil
> > May  7 21:15:18 aneto kernel: Vendor: ATA       Model: ST3160827AS =
      Rev: 3.42
> > May  7 21:15:18 aneto kernel: Type:   Direct-Access                =
      ANSI SCSI revision: 05
> > May  7 21:15:18 aneto kernel: SCSI device sda: 312581808 512-byte h=
dwr sectors (160042 MB)
> > May  7 21:15:18 aneto kernel: sda: Write Protect is off
> > May  7 21:15:18 aneto kernel: sda: Mode Sense: 00 3a 00 00
> > May  7 21:15:18 aneto kernel: SCSI device sda: drive cache: write b=
ack
> > May  7 21:15:18 aneto kernel: SCSI device sda: 312581808 512-byte h=
dwr sectors (160042 MB)
> > May  7 21:15:18 aneto kernel: sda: Write Protect is off
> > May  7 21:15:18 aneto kernel: sda: Mode Sense: 00 3a 00 00
>
> I've tried with both 2.6.16 and 2.6.17-rc3-mm1, each time with or
> without the "irqpoll" boot option, but it always ended with the same =
error.
>
> Please let me know if I can provide any additional information.
>
> Thanks for support,
> --
> Nico
> L'esprit nous sert quelquefois =E0 faire hardiment des sottises.
>        -+- Fran=E7ois de La Rochefoucauld (1613-1680), Maximes 415 -+=
-
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
