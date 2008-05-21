From: "Brian & Chamaigne Scamman" <scammanbc@earthlink.net>
Subject: RE: [PATCHSET #upstream-fixes] git tree available
Date: Tue, 20 May 2008 21:32:01 -0400
Message-ID: <00a501c8bae2$7815f7e0$6917a8c0@parents>
References: <12111273141039-git-send-email-htejun@gmail.com> <48305961.2050509@gmail.com> <006501c8ba19$c1f53340$6917a8c0@parents> <48323E4F.3050806@rtr.ca> <4832535B.1080505@gmail.com> <483256FF.1010200@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00A6_01C8BAC0.F10457E0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:58376 "EHLO
	elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752904AbYEUBcF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 May 2008 21:32:05 -0400
In-Reply-To: <483256FF.1010200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>, 'Mark Lord' <liml@rtr.ca>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00A6_01C8BAC0.F10457E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
>Can you please test whether the attached patch fixes the detection problem?

Tejun-
The patch worked great; see dmesg log below...
I didn't test the sslep(5) command since the patch worked; do you still need
me to test it?

One remaining issue is the "failed to IDENTIFY (I/O error, err mask=0xll)"
message. If the PMP, bridges and drives are powered up before I insert the
eSATA cable in to the controller, I don't receive the message. The message
appears when only when I have the eSATA cable attached to the controller and
then simultaneously power on the PMP and drives. In the attached dmesg log,
the drive is eventually recognized; however there have been a couple of
times when the drives aren't recognized. An eSATA cable remove/re-insert
fixes the problem.

-Brian


------=_NextPart_000_00A6_01C8BAC0.F10457E0
Content-Type: text/plain;
	name="dmesg_pmp_success.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg_pmp_success.txt"

ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata3: irq_stat 0x00b40090, PHY RDY changed=20
ata3: hard resetting link=20
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)=20
ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0xl/0x9
ata3.00: hard resetting link=20
ata3.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)=20
ata3.01: hard resetting link
ata3.01: SATA link down (SStatus 0 SControl 320)
ata3.02: hard resetting link
ata3.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.03: hard resetting link
ata3.03: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata3.04: hard resetting link
ata3.04: SATA link down (SStatus 0 SControl 320)
ata3.05: hard resetting link
ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata3.00: failed to IDENTIFY (I/O error, err mask=3D0xll)
ata3.15: hard resetting link=20
ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)=20
ata3.00: hard resetting link=20
ata3.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)=20
ata3.02: hard resetting link=20
ata3.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)=20
ata3.03: hard resetting link=20
ata3.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)=20
ata3.05: hard resetting link=20
ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)=20
ata3.00: ATA-6: Super Talent Tech, Rev 2.11, max UDMA/133
ata3.00: 127923200 sectors, multi 1: LBA=20
ata3.00: applying bridge limits=20
ata3.00: configured for UDMA/100=20
ata3.02: ATA-6: Super Talent Tech, Rev 2.11, max UDMA/133
ata3.02: 127923200 sectors, multi 1: LBA=20
ata3.02: applying bridge limits=20
ata3.02: configured for UDMA/100=20
ata3.03: failed to IDENTIFY (I/O error, err mask=3D0xll)=20
ata3.15: hard resetting link=20
ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata3.00: hard resetting link=20
ata3.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata3.01: hard resetting link=20
ata3.01: SATA link down (SStatus 0 SControl 320)=20
ata3.02: hard resetting link=20
ata3.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.03: hard resetting link=20
ata3.03: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata3.04: hard resetting link=20
ata3.04: SATA link down (SStatus 0 SControl 320)=20
ata3.05: hard resetting link=20
ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata3.00: configured for UDMA/100=20
ata3.02: configured for UDMA/100
ata3.03: ATA-6: Super Talent Tech, Rev 2.11, max UDMA/133
ata3.03: 127923200 sectors, multi 1: LBA
ata3.03: applying bridge limits
ata3.03: configured for UDMA/100
ata3: EH complete=20
scsi 2:0:0:0: Direct-Access     ATA      Super Talent Tec Rev  PQ: 0 =
ANSI: 5=20
sd 2:0:0:0: [sda] 127923200 512-byte hardware sectors (65497 MB)=20
sd 2:0:0:0: [sda] Write Protect is off=20
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00=20
sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn=92t =
support DPO or FUA
sd 2:0:0:0: [sda] 127923200 512-byte hardware sectors (65497 MB)=20
sd 2:0:0:0: [sda] Write Protect is off=20
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00=20
sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn=92t =
support DPO or FUA=20
 sda: sda1=20
sd 2:0:0:0: [sda] Attached SCSI disk=20
sd 2:0:0:0: Attached scsi generic sg0 type 0=20
scsi 2:2:0:0: Direct-Access     ATA      Super Talent Tec Rev  PQ: 0 =
ANSI: 5
sd 2:2:0:0: [sdb] 127923200 512-byte hardware sectors (65497 MB)=20
sd 2:2:0:0: [sdb] Write Protect is off=20
sd 2:2:0:0: [sdb] Mode Sense: 00 3a 00 00=20
sd 2:2:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn=92t =
support DPO or FUA
sd 2:2:0:0: [sdb] 127923200 512-byte hardware sectors (65497 MB)=20
sd 2:2:0:0: [sdb] Write Protect is off=20
sd 2:2:0:0: [sdb] Mode Sense: 00 3a 00 00=20
sd 2:2:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn=92t =
support DPO or FUA
 sdb: sdb1=20
sd 2:2:0:0: [sdb] Attached SCSI disk=20
sd 2:2:0:0: Attached scsi generic sg1 type 0=20
scsi 2:3:0:0: Direct-Access     ATA      Super Talent Tec Rev  PQ: 0 =
ANSI: 5
sd 2:3:0:0: [sdc] 127923200 512-byte hardware sectors (65497 MB)=20
sd 2:3:0:0: [sdc] Write Protect is off=20
sd 2:3:0:0: [sdc] Mode Sense: 00 3a 00 00=20
sd 2:3:0:0: [sdc] Write cache: disabled, read cache: enabled, doesn=92t =
support DPO or FUA
sd 2:3:0:0: [sdc] 127923200 512-byte hardware sectors (65497 MB)=20
sd 2:3:0:0: [sdc] Write Protect is off=20
sd 2:3:0:0: [sdc] Mode Sense: 00 3a 00 00=20
sd 2:3:0:0: [sdc] Write cache: disabled, read cache: enabled, doesn=92t =
support DPO or FUA
 sdc: sdc1=20
sd 2:3:0:0: [sdc] Attached SCSI disk=20
sd 2:3:0:0: Attached scsi generic sg2 type 0=20


------=_NextPart_000_00A6_01C8BAC0.F10457E0--

