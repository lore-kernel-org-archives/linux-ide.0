From: Mike I <mihrcke@gmail.com>
Subject: Re: Problem w/ hotplug on =?utf-8?b?c2F0YV9zaWwyNA==?= w/ PMP (sil3726)
Date: Thu, 13 Oct 2011 02:09:34 +0000 (UTC)
Message-ID: <loom.20111013T040710-432@post.gmane.org>
References: <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local> <20110713133425.GP2872@htj.dyndns.org> <20110713143936.GQ2872@htj.dyndns.org> <359604ECF8F440408B9634E6146249B4321C2695@mail.scl.local> <20110714071459.GB3455@htj.dyndns.org> <359604ECF8F440408B9634E6146249B4322F1E0A@mail.scl.local> <20110721090022.GF3455@htj.dyndns.org> <359604ECF8F440408B9634E6146249B4322F2566@mail.scl.local> <20110722095037.GJ2622@htj.dyndns.org> <359604ECF8F440408B9634E6146249B4322F26B6@mail.scl.local> <20110730125456.GN2622@htj.dyndns.org> <loom.20110930T233659-338@post.gmane.org> <CAMHSBOWbaLjbWZ7PNwTa-AsZRAzrOGLgSip=q2=u+qVQW4u3mQ@mail.gmail.com> <CAKGin7UjCxF23FnHLcUtbTJJBqGpm2r0e8HZTC7YwG_oDzAGjw@mail.gmail.com> <CAKGin7UB-6n9XhwyLQebuBLaTzixoH6_KPZXHHWmMg2PtoLPzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:35725 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084Ab1JMCJv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Oct 2011 22:09:51 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1REAk0-0001P7-JU
	for linux-ide@vger.kernel.org; Thu, 13 Oct 2011 04:09:49 +0200
Received: from cpe-173-89-37-68.wi.res.rr.com ([173.89.37.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 13 Oct 2011 04:09:48 +0200
Received: from mihrcke by cpe-173-89-37-68.wi.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 13 Oct 2011 04:09:48 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Working much better now...this is what I get when I hot plug a drive that was
giving me problems before:

[  211.873069] ata3.01: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[  211.873075] ata3.01: SError: { PHYRdyChg CommWake DevExch }
[  211.873181] ata3.01: limiting SATA link speed to 1.5 Gbps
[  211.873188] ata3.01: hard resetting link
[  212.750032] ata3.01: softreset failed (SRST command error)
[  212.850022] ata3.01: failed to read SCR 0 (Emask=0x1)
[  212.850026] ata3.01: reset failed (errno=-85), retrying in 10 secs
[  221.870023] ata3.01: reset failed, giving up
[  221.870029] ata3.15: hard resetting link
[  221.870032] ata3: controller in dubious state, performing PORT_RST
[  224.140057] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  224.140364] ata3.02: limiting SATA link speed to 1.5 Gbps
[  224.140402] ata3.03: limiting SATA link speed to 1.5 Gbps
[  224.140440] ata3.04: limiting SATA link speed to 1.5 Gbps
[  224.140477] ata3.05: limiting SATA link speed to 1.5 Gbps
[  224.140481] ata3.00: hard resetting link
[  224.550272] ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  224.550311] ata3.01: hard resetting link
[  225.020043] ata3.01: softreset failed (SRST command error)
[  225.020069] ata3.01: failed to read SCR 0 (Emask=0x40)
[  225.020073] ata3.01: reset failed (errno=-85), retrying in 10 secs
[  234.550024] ata3.01: reset failed, giving up
[  234.550032] ata3.15: hard resetting link
[  234.550036] ata3: controller in dubious state, performing PORT_RST
[  236.810049] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  236.810336] ata3.00: hard resetting link
[  237.230271] ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  237.230310] ata3.01: hard resetting link
[  237.920270] ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  237.920309] ata3.02: hard resetting link
[  238.270420] ata3.02: SATA link down (SStatus 0 SControl 310)
[  238.270492] ata3.03: hard resetting link
[  238.610434] ata3.03: SATA link down (SStatus 0 SControl 310)
[  238.610504] ata3.04: hard resetting link
[  238.960436] ata3.04: SATA link down (SStatus 0 SControl 310)
[  238.960508] ata3.05: hard resetting link
[  239.310401] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  239.413575] ata3.00: configured for UDMA/100
[  239.420008] ata3.01: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
[  239.420012] ata3.01: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  239.426691] ata3.01: configured for UDMA/100
[  239.426763] ata3: EH complete
[  239.426967] scsi 2:1:0:0: Direct-Access     ATA      SAMSUNG HD154UI  1AG0
PQ: 0 ANSI: 5
[  239.427123] sd 2:1:0:0: Attached scsi generic sg6 type 0
[  239.427138] sd 2:1:0:0: [sde] 2930277168 512-byte logical blocks: (1.50
TB/1.36 TiB)
[  239.427182] sd 2:1:0:0: [sde] Write Protect is off
[  239.427185] sd 2:1:0:0: [sde] Mode Sense: 00 3a 00 00
[  239.427206] sd 2:1:0:0: [sde] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[  239.427348]  sde: sde1
[  239.581901] sd 2:1:0:0: [sde] Attached SCSI disk

Thank you,
Mike


