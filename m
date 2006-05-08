From: Nicolas STRANSKY <Nico@stransky.cx>
Subject: IRQ problem with sata_sil
Date: Mon, 08 May 2006 12:00:29 +0200
Message-ID: <e3n4ru$ktd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:36305 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750939AbWEHKFE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 May 2006 06:05:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Fd2bu-0007WL-Fk
	for linux-ide@vger.kernel.org; Mon, 08 May 2006 12:05:02 +0200
Received: from fbx.stransky.cx ([82.67.244.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 08 May 2006 12:05:02 +0200
Received: from Nico by fbx.stransky.cx with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 08 May 2006 12:05:02 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

I've encountered a problem when trying to use a SATA card with a Silico=
n
Image SIL 3112 host controller chip. When inserting the module, the
kernel made this error:

> May  7 21:15:18 aneto kernel: sata_sil 0000:02:0c.0: version 1.0
> May  7 21:15:18 aneto kernel: PCI: Found IRQ 10 for device 0000:02:0c=
=2E0
> May  7 21:15:18 aneto kernel: PCI: Sharing IRQ 10 with 0000:02:05.0
> May  7 21:15:18 aneto kernel: ata1: SATA max UDMA/100 cmd 0xF8FBC080 =
ctl 0xF8FBC08A bmdma 0xF8FBC000 irq 10
> May  7 21:15:18 aneto kernel: ata2: SATA max UDMA/100 cmd 0xF8FBC0C0 =
ctl 0xF8FBC0CA bmdma 0xF8FBC008 irq 10
> May  7 21:15:18 aneto kernel: ata1: SATA link up 1.5 Gbps (SStatus 11=
3 SControl 310)
> May  7 21:15:18 aneto kernel: irq 10: nobody cared (try booting with =
the "irqpoll" option)
> May  7 21:15:18 aneto kernel: <c0131ad3> __report_bad_irq+0x2b/0x69  =
 <c0131cd8> note_interrupt+0x1c7/0x1f7
> May  7 21:15:18 aneto kernel: <c0131660> __do_IRQ+0x8d/0xcd   <c01043=
ad> do_IRQ+0x1d/0x28
> May  7 21:15:18 aneto kernel: <c0102cc2> common_interrupt+0x1a/0x20  =
 <c0118237> __do_softirq+0x2c/0x7d
> May  7 21:15:18 aneto kernel: <c01182aa> do_softirq+0x22/0x26   <c011=
837f> irq_exit+0x29/0x34
> May  7 21:15:18 aneto kernel: <c01043b2> do_IRQ+0x22/0x28   <c0102cc2=
> common_interrupt+0x1a/0x20
> May  7 21:15:18 aneto kernel: <c016034c> __d_lookup+0x62/0x123   <c01=
57fa4> do_lookup+0x25/0x13f
> May  7 21:15:18 aneto kernel: <c015839e> __link_path_walk+0x2e0/0xbf6=
   <c01767b1> proc_delete_inode+0x22/0x75
> May  7 21:15:18 aneto kernel: <c0158cfd> link_path_walk+0x49/0xbb   <=
c015919b> do_path_lookup+0x1a4/0x1d5
> May  7 21:15:18 aneto kernel: <c01593db> do_unlinkat+0x2f/0xff   <c03=
57ca7> syscall_call+0x7/0xb
> May  7 21:15:18 aneto kernel: <c035007b> xfrm_aalg_get_byid+0x27/0x39
> May  7 21:15:18 aneto kernel: handlers:
> May  7 21:15:18 aneto kernel: [<c02d2c90>] (ata_interrupt+0x0/0x13f)
> May  7 21:15:18 aneto kernel: Disabling IRQ #10
> May  7 21:15:18 aneto kernel: ata1: dev 0 cfg 49:2f00 82:346b 83:7d01=
 84:4003 85:3469 86:3c01 87:4003 88:207f
> May  7 21:15:18 aneto kernel: ata1: dev 0 ATA-6, max UDMA/133, 312581=
808 sectors: LBA48
> May  7 21:15:18 aneto kernel: ata1: dev 0 configured for UDMA/100
> May  7 21:15:18 aneto kernel: scsi1 : sata_sil
> May  7 21:15:18 aneto kernel: ata2: SATA link down (SStatus 0 SContro=
l 310)
> May  7 21:15:18 aneto kernel: scsi2 : sata_sil
> May  7 21:15:18 aneto kernel: Vendor: ATA       Model: ST3160827AS   =
    Rev: 3.42
> May  7 21:15:18 aneto kernel: Type:   Direct-Access                  =
    ANSI SCSI revision: 05
> May  7 21:15:18 aneto kernel: SCSI device sda: 312581808 512-byte hdw=
r sectors (160042 MB)
> May  7 21:15:18 aneto kernel: sda: Write Protect is off
> May  7 21:15:18 aneto kernel: sda: Mode Sense: 00 3a 00 00
> May  7 21:15:18 aneto kernel: SCSI device sda: drive cache: write bac=
k
> May  7 21:15:18 aneto kernel: SCSI device sda: 312581808 512-byte hdw=
r sectors (160042 MB)
> May  7 21:15:18 aneto kernel: sda: Write Protect is off
> May  7 21:15:18 aneto kernel: sda: Mode Sense: 00 3a 00 00

I've tried with both 2.6.16 and 2.6.17-rc3-mm1, each time with or
without the "irqpoll" boot option, but it always ended with the same er=
ror.

Please let me know if I can provide any additional information.

Thanks for support,
--=20
Nico
L'esprit nous sert quelquefois =E0 faire hardiment des sottises.
	-+- Fran=E7ois de La Rochefoucauld (1613-1680), Maximes 415 -+-

