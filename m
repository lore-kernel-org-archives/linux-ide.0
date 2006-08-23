From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATA Sil680 Warm Plug Caused 2.6.18-rc2 Kernel Internel Error
Date: Wed, 23 Aug 2006 12:24:25 -0400
Message-ID: <44EC8139.7030008@pobox.com>
References: <8202f4270608230906r73b1d91bj279bfc0ef4b7a39d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:27084 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965032AbWHWQYa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Aug 2006 12:24:30 -0400
In-Reply-To: <8202f4270608230906r73b1d91bj279bfc0ef4b7a39d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, Tejun Heo <htejun@gmail.com>

Fajun Chen wrote:
> ata2.00: qc timeout (cmd 0xec)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata2.00: revalidation failed (errno=-5)
> ata2.00: disabled
> ata2: EH complete
> ata2: soft resetting port
> ata2.00: ATA-7, max UDMA/100, 625142448 sectors: LBA48
> ata2.00: configured for UDMA/100
> ata2: EH complete
> Unable to handle kernel paging request at virtual address 6f020091
> pgd = c0004000
> [6f020091] *pgd=00000000
> Internal error: Oops: f3 [#1]
> Modules linked in:
> CPU: 0
> PC is at scsi_device_get+0x40/0x98
> LR is at kobject_get+0x18/0x20
> pc : [<c00f6728>]    lr : [<c00c8274>]    Not tainted
> sp : c0b5ff10  ip : c0b5feec  fp : c0b5ff24
> r10: c0b68298  r9 : 00000000  r8 : 60000013
> r7 : c0b68298  r6 : 00000000  r5 : c0bba090  r4 : c0bba000
> r3 : 6f020045  r2 : fffffffa  r1 : c0197340  r0 : c0bba090
> Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
> Control: 397F  Table: 02EB8000  DAC: 00000017
> Process ata_aux (pid: 13, stack limit = 0xc0b5e250)
> Stack: (0xc0b5ff10 to 0xc0b60000)
> ff00:                                     c0bba000 c0b68424 c0b5ff50 
> c0b5ff28
> ff20: c0112d28 c00f66f4 c0b50b20 20000013 c0112c98 c0b50b28 00000001 
> 00000000
> ff40: fffffffc c0b5ff70 c0b5ff54 c0047e4c c0112ca4 c0b50b30 c0b50b28 
> c0b5ff90
> ff60: c0b50b20 c0b5ffc0 c0b5ff74 c0047fb4 c0047da4 ffffffff ffffffff 
> 00000001
> ff80: 00000000 c003406c 00010000 00000000 00000000 c0b5b940 c003406c 
> 00100100
> ffa0: 00200200 c0b50b20 c0b5e000 c0befefc c0047ea0 c0b5fff4 c0b5ffc4 
> c004b670
> ffc0: c0047eac 00000001 ffffffff ffffffff 00000000 00000000 00000000 
> 00000000
> ffe0: 00000000 00000000 00000000 c0b5fff8 c0039d24 c004b590 906f8a57 
> c8a970b5
> Backtrace:
> [<c00f66e8>] (scsi_device_get+0x0/0x98) from [<c0112d28>]
> (ata_scsi_hotplug+0x90/0x188)
> r5 = C0B68424  r4 = C0BBA000
> [<c0112c98>] (ata_scsi_hotplug+0x0/0x188) from [<c0047e4c>]
> (run_workqueue+0xb4/0x108)
> [<c0047d98>] (run_workqueue+0x0/0x108) from [<c0047fb4>]
> (worker_thread+0x114/0x16c)
> r7 = C0B50B20  r6 = C0B5FF90  r5 = C0B50B28  r4 = C0B50B30
> [<c0047ea0>] (worker_thread+0x0/0x16c) from [<c004b670>] 
> (kthread+0xec/0x11c)


That's interesting.  Looks like a scsidev refcounting problem...

	Jeff

