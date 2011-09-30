From: Mike I <mihrcke@gmail.com>
Subject: Re: Problem w/ hotplug on =?utf-8?b?c2F0YV9zaWwyNA==?= w/ PMP (sil3726)
Date: Fri, 30 Sep 2011 21:54:22 +0000 (UTC)
Message-ID: <loom.20110930T233659-338@post.gmane.org>
References: <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local> <20110713133425.GP2872@htj.dyndns.org> <20110713143936.GQ2872@htj.dyndns.org> <359604ECF8F440408B9634E6146249B4321C2695@mail.scl.local> <20110714071459.GB3455@htj.dyndns.org> <359604ECF8F440408B9634E6146249B4322F1E0A@mail.scl.local> <20110721090022.GF3455@htj.dyndns.org> <359604ECF8F440408B9634E6146249B4322F2566@mail.scl.local> <20110722095037.GJ2622@htj.dyndns.org> <359604ECF8F440408B9634E6146249B4322F26B6@mail.scl.local> <20110730125456.GN2622@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:57509 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757313Ab1I3WAJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Sep 2011 18:00:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1R9l7n-0006tg-E2
	for linux-ide@vger.kernel.org; Sat, 01 Oct 2011 00:00:07 +0200
Received: from cpe-173-89-37-68.wi.res.rr.com ([173.89.37.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 01 Oct 2011 00:00:07 +0200
Received: from mihrcke by cpe-173-89-37-68.wi.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 01 Oct 2011 00:00:07 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

tj <at> kernel.org <tj <at> kernel.org> writes:

> 
> Hello,
> 
> How did that go?
> 
> Thanks.
> 

Like Derry who started this thread, I too had seen an old thread from
October/November 2008 with what appeared to be no resolution to this problem. 
Now, finding this thread, again, with no apparent resolution to this problem.

I'm currently running Ubuntu 10.04 (lucid), kernel 2.6.32-33-generic.  I've no
experience with applying these git patches, and my searching to figure out how
it works have not helped.

I'm using an Addonics eSATA PCI-X controller with the SiI3124 chipset, and I
have an Addonics PM in an external enclosure, with a 5 bay/tray DAS.  Some of
my drives give me this problem: (this occurs for me with pretty much ALL 
Samsung hard drives)
[12888.470308] ata9.01: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[12888.470313] ata9.01: SError: { PHYRdyChg CommWake DevExch }
[12888.470385] ata9.01: hard resetting link
[12889.211597] ata9.01: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[12889.211686] ata9.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[12889.211692] ata9.15: hard resetting link
[12891.430086] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[12891.430397] ata9.00: hard resetting link
[12891.780786] ata9.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[12894.211103] ata9.01: hard resetting link
[12894.560424] ata9.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[12894.560466] ata9.02: hard resetting link
[12894.914176] ata9.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[12894.914222] ata9.03: hard resetting link
[12895.264141] ata9.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[12895.264169] ata9.04: hard resetting link
[12895.612930] ata9.04: SATA link down (SStatus 0 SControl 320)
[12895.613007] ata9.05: hard resetting link
[12895.964143] ata9.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[12896.065908] ata9.00: configured for UDMA/100
[12896.065970] ata9.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[12896.065977] ata9.15: hard resetting link
[12898.283804] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[12898.284128] ata9.00: hard resetting link
[12898.634174] ata9.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[12899.562524] ata9.01: hard resetting link
[12899.914147] ata9.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[12899.914180] ata9.02: hard resetting link
[12900.261682] ata9.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[12900.261724] ata9.03: hard resetting link
[12900.610413] ata9.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[12900.961283] ata9.05: hard resetting link
[12901.310385] ata9.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[12901.397241] ata9.00: configured for UDMA/100
[12901.397300] ata9.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[12901.397305] ata9.01: failed to recover link after 3 tries, disabling
[12901.397311] ata9.15: hard resetting link
[12903.613694] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[12903.960564] ata9.00: hard resetting link
[12904.311125] ata9.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[12905.260154] ata9.02: hard resetting link
[12905.602929] ata9.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[12905.611319] ata9.03: hard resetting link
[12905.962555] ata9.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[12905.962592] ata9.04: hard resetting link
[12906.312931] ata9.04: SATA link down (SStatus 0 SControl 320)
[12906.313004] ata9.05: hard resetting link
[12906.660409] ata9.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[12906.753619] ata9.00: configured for UDMA/100
[12906.766586] ata9.02: configured for UDMA/100
[12906.771917] ata9.03: configured for UDMA/100
[12907.121462] ata9: EH complete

If I hot plug the same drive using a port directly off my mobo(no PM in the
mix), I get this result(drive connects/mounts/works):
[27997.097104] ata5: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 
0xe frozen
[27997.097108] ata5: irq_stat 0x00400040, connection status changed
[27997.097111] ata5: SError: { PHYRdyChg CommWake DevExch }
[27997.097116] ata5: hard resetting link
[28007.147622] ata5: softreset failed (device not ready)
[28007.147627] ata5: hard resetting link
[28010.630028] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[28010.748595] ata5.00: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
[28010.748599] ata5.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[28010.755227] ata5.00: configured for UDMA/133
[28010.755237] ata5: EH complete
[28010.756338] scsi 4:0:0:0: Direct-Access     ATA      SAMSUNG HD154UI  1AG0
PQ: 0 ANSI: 5
[28010.756475] sd 4:0:0:0: Attached scsi generic sg10 type 0
[28010.756572] sd 4:0:0:0: [sdj] 2930277168 512-byte logical blocks: (1.50
TB/1.36 TiB)
[28010.756613] sd 4:0:0:0: [sdj] Write Protect is off
[28010.756616] sd 4:0:0:0: [sdj] Mode Sense: 00 3a 00 00
[28010.756636] sd 4:0:0:0: [sdj] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[28010.756760]  sdj: sdj1
[28010.816161] sd 4:0:0:0: [sdj] Attached SCSI disk

I've been using Ubuntu for a few years now, and have been living with the
problem...working around it with USB docking stations and such.  But, I'd
really hope to see/find this problem worked out.

Thoughts/tips/suggestions?  Since I'm pretty much a novice when it comes to
patching, a link to a guide for git patching would be appreciated too.

Thank You,
Mike

