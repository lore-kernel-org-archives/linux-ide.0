From: kenneth johansson <ken@kenjo.org>
Subject: Re: lost external eSATA port
Date: Mon, 30 Mar 2009 22:27:17 +0200
Message-ID: <1238444837.14922.17.camel@duo>
References: <gqnpi3$jq2$1@ger.gmane.org>  <49D0866D.4070200@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:38506 "EHLO
	amd.kenjo.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755914AbZC3VPX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Mar 2009 17:15:23 -0400
In-Reply-To: <49D0866D.4070200@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Mon, 2009-03-30 at 17:44 +0900, Tejun Heo wrote:
> kenneth johansson wrote:
> > After an error on the external disk the port no longer work with any disk.
> > When the error happened the /dev/sdx was removed. if I change disk its never recreated.
> > I get no log output from kernel indicating any type of action at all.
> > 
> > Is there a way to reset the port ?? 
> 
> The device seems to have checked out.  Is it a WD mybook?  Can you
> please attach full kernel log including the boot messages?

I rebooted and have not got that problem again. the disk was a WD3000

[    9.463422] ata1: SATA max UDMA/133 abar m8192@0xfe9fe000 port 0xfe9fe100 irq 16
[    9.784539] ata1: SATA link down (SStatus 0 SControl 300)

cat /proc/interrupts
 16:     115918          0   IO-APIC-fasteoi   uhci_hcd:usb1, ahci, nvidia



this is the log when I attach the disk

[ 4463.912008] ata1: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action 0xe frozen
[ 4463.912013] ata1: irq_stat 0x00000040, connection status changed
[ 4463.912017] ata1: SError: { CommWake DevExch }
[ 4463.912024] ata1: hard resetting link
[ 4465.360536] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 4465.361625] ata1.00: ATA-6: WDC WD3000JD-00KLB0, 08.05J08, max UDMA/100
[ 4465.361629] ata1.00: 586072368 sectors, multi 0: LBA48 
[ 4465.362996] ata1.00: configured for UDMA/100
[ 4465.363007] ata1: EH complete
[ 4465.363119] scsi 0:0:0:0: Direct-Access     ATA      WDC WD3000JD-00K 08.0 PQ: 0 ANSI: 5
[ 4465.365480] sd 0:0:0:0: [sdb] 586072368 512-byte hardware sectors: (300 GB/279 GiB)
[ 4465.365500] sd 0:0:0:0: [sdb] Write Protect is off
[ 4465.365502] sd 0:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 4465.365532] sd 0:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 4465.365638] sd 0:0:0:0: [sdb] 586072368 512-byte hardware sectors: (300 GB/279 GiB)
[ 4465.365655] sd 0:0:0:0: [sdb] Write Protect is off
[ 4465.365658] sd 0:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 4465.365687] sd 0:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 4465.365691]  sdb: unknown partition table
[ 4465.375416] sd 0:0:0:0: [sdb] Attached SCSI disk
[ 4465.375537] sd 0:0:0:0: Attached scsi generic sg2 type 0


the is no partition on the disk so this is expected.

