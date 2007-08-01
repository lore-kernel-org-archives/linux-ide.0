From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: Marvell 7042 (sata_mv) fails to initialize drive
Date: Wed, 1 Aug 2007 21:13:26 +0200
Message-ID: <6bffcb0e0708011213q1c8908e2p1c87967745b977b5@mail.gmail.com>
References: <46AEAAB1.801@gutschke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:1772 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758427AbXHATN3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 15:13:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so277642wah
        for <linux-ide@vger.kernel.org>; Wed, 01 Aug 2007 12:13:26 -0700 (PDT)
In-Reply-To: <46AEAAB1.801@gutschke.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Markus Gutschke <markus@gutschke.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hi Markus,

On 31/07/07, Markus Gutschke <markus@gutschke.com> wrote:
> I just tried hooking up a Hitachi 1TB SATA-II drive to a Marvell 7042
> based controller, and the most recent Linux kernel (2.6.23-rc1) fails to
> properly initialize the interface.

Does 2.6.22.1 work?

> Here are the relevant kernel messages:
>
> > kernel: [43.312417] sata_mv 0000:06:00.0: version 0.81
> > kernel: [43.312752] ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
> > kernel: [43.312757] ACPI: PCI Interrupt 0000:06:00.0[A] -> Link [APC5] -> GSI 16 (level, low) -> IRQ 16
> > kernel: [43.312788] sata_mv 0000:06:00.0: Applying 60X1C0 workarounds to unknown rev
> > kernel: [43.314443] sata_mv 0000:06:00.0: Gen-IIE 32 slots 4 ports SCSI mode IRQ via INTx
> > kernel: [43.314535] scsi0 : sata_mv
> > kernel: [43.314581] scsi1 : sata_mv
> > kernel: [43.314614] scsi2 : sata_mv
> > kernel: [43.314640] scsi3 : sata_mv
> > kernel: [43.314660] ata1: SATA max UDMA/133 cmd 0x0000000000000000 ctl 0xffffc20003522120 bmdma 0x0000000000000000 irq 16
> > kernel: [43.314663] ata2: SATA max UDMA/133 cmd 0x0000000000000000 ctl 0xffffc20003524120 bmdma 0x0000000000000000 irq 16
> > kernel: [43.314666] ata3: SATA max UDMA/133 cmd 0x0000000000000000 ctl 0xffffc20003526120 bmdma 0x0000000000000000 irq 16
> > kernel: [43.314669] ata4: SATA max UDMA/133 cmd 0x0000000000000000 ctl 0xffffc20003528120 bmdma 0x0000000000000000 irq 16
> > kernel: [53.409086] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > kernel: [59.741602] ata1: EH pending after completion, repeating EH (cnt=4)
> > kernel: [59.777642] ata2: SATA link down (SStatus 0 SControl 300)
> > kernel: [59.809752] ata3: SATA link down (SStatus 0 SControl 300)
> > kernel: [59.841740] ata4: SATA link down (SStatus 0 SControl 300)
>
> The kernel never even registers the drive as an available disk device,
> whereas everything appears to work fine, if I connect the disk to one of
> the other controllers (JMicron AHCI, or NVidia sata_nv) on this motherboard.
>
> As I have two of those disks (in a RAID-1 array) and multiple
> independent controllers, it is relatively easy for me to do some testing
> here. The worst case scenario is that I need to wait a couple of hours
> for the array to rebuild itself after I am done experimenting.
>
> Let me know, if there is anything I can do to help you diagnose the root
> cause, or whether this is a known bug and you don't need any help
> testing at this point.
>
>
> Markus

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
