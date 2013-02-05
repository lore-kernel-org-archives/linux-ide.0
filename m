From: Alex Williamson <alex.l.williamson@gmail.com>
Subject: Re: options to disable 2nd channel on pata_via?
Date: Mon, 4 Feb 2013 20:23:29 -0700
Message-ID: <CAEMbtcJcjb=Y0A_SOtrCrGR7WwkbRm9Vc0akR6QWo2rkdwNsqg@mail.gmail.com>
References: <CAEMbtc+U-bfsnPzVUhkjFguCVMSE9h2vsEg0B=GKS0n3zqKO0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:64326 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab3BEDXb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2013 22:23:31 -0500
Received: by mail-la0-f52.google.com with SMTP id fs12so5231285lab.39
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2013 19:23:29 -0800 (PST)
In-Reply-To: <CAEMbtc+U-bfsnPzVUhkjFguCVMSE9h2vsEg0B=GKS0n3zqKO0w@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Sat, Jan 26, 2013 at 11:40 AM, Alex Williamson
<alex.l.williamson@gmail.com> wrote:
> Hi,
>
> I've got a very old and underpowered x86 thin client that makes use of
> a via ide controller.  The system only has a connection for the first
> pata channel, but when probed both ata1 and ata2 are enabled:
>
> [   39.868935] pata_via 0000:00:11.1: version 0.3.4
> [   40.608489] scsi0 : pata_via
> [   40.656186] scsi1 : pata_via
> [   40.740964] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xd400 irq 14
> [   40.769302] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xd408 irq 15
> [   40.948947] ata1.00: CFA:  256MB ATA Flash Disk, ADBA217H, max PIO4
> [   40.949003] ata1.00: 501760 sectors, multi 0: LBA
> [   40.974450] ata1.00: configured for PIO4
> [   40.995461] scsi 0:0:0:0: Direct-Access     ATA       256MB ATA
> Flash ADBA PQ: 0 ANSI: 5
> [   41.011318] sd 0:0:0:0: [sda] 501760 512-byte logical blocks: (256
> MB/245 MiB)
> [   41.018358] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [   41.024696] ata2: port disabled--ignoring
> [   41.050498] sd 0:0:0:0: [sda] Write Protect is off
> [   41.050556] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [   41.097776] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
> enabled, doesn't support DPO or FUA
> [   41.378651]  sda: sda1
> [   41.565716] sd 0:0:0:0: [sda] Attached SCSI disk
>
> This of course works, but my ethernet controller is also using irq 15
> and now needlessly shares it with pata_via.  I wouldn't mind, but I'm
> actually seeing 10%+ cpu time from irq/15-pata_via in top, so it's
> actually degrading the performance of this already slow system.
> Ideally I'd like to only enable the first IDE channel on irq 14 and
> leave irq 15 exclusively to the ethernet controller.  Is this
> possible?  In the past I've used the noprobe option to ide_core, which
> ISTR allowed this.  I'm not finding anything similar in libata.
> Suggestions?  Please cc, I'm not on this list.  Thanks,

I haven't heard anything better, so I'll at least make note of my
workaround in case someone else runs into this.  The device ID and
subsystem ID on this box are not unique, so there's not much
opportunity to change the device table.  It's probably not worth
trying to do something with DMI, so instead I just added a kprobe
module to replace the device table locally.  Here's a link in case it
helps anyone:

https://github.com/awilliam/pata_via_singlechannel/blob/master/pata_via_singlechannel.c

Thanks,
Alex
