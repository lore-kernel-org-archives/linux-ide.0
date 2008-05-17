From: "Brian & Chamaigne Scamman" <scammanbc@earthlink.net>
Subject: RE: Unable to access drives via PortMultiplier and SATA/IDE bridge
Date: Sat, 17 May 2008 15:01:13 -0400
Message-ID: <003601c8b850$60e14690$6917a8c0@parents>
References: <31125479.1210696397791.JavaMail.root@elwamui-norfolk.atl.sa.earthlink.net> <482A5F48.1060901@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0037_01C8B82E.D9CFA690"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-junco.atl.sa.earthlink.net ([209.86.89.63]:44815 "EHLO
	elasmtp-junco.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755042AbYEQTBQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 May 2008 15:01:16 -0400
In-Reply-To: <482A5F48.1060901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0037_01C8B82E.D9CFA690
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Tejun-

Sorry for the delay in getting back with you - I wanted to build a clean
machine and do some more testing before I replied.

I've installed Fedora Core 9 (2.6.25-14.fc9.i686) along with a single SiI
3124-based 4 port controller.

As I mentioned in an earlier email, I'm using a JM20330 based SATA to IDE
bridge to connect an IDE solid state drive. The SSD and bridge work fine
when attached directly to a SATA port, but don't work when attached to a
port multipler (SiI 3726-based). (For reference, no problems when using
Windows XP)

After some experimentation, I found out that if I connected the port
multipler first (with no drive attached or a standard SATA drive) and then
attached the SSD/bridge drive, the drive was immediately recognized by the
kernel.

I've attached two dmesg log files:
- dmesg_one_drive_at_a_time.txt is when the PMP was attached with a standard
SATA drive on port 0 and the SSD/bridge were attached to port 1 later.
- dmesg_ssd_drive_only_after_pmp.txt is when the PMP was attached with the
SSD/bridge attached to port 0; after EH timeout, the sata cable was detached
from port 0 and then re-inserted.

I've also run cases where the PMP was attached to the computer empty (no
drives on any ports) and then attached the SSD/bridge with success (port
independent).

Let me know if you need more dmesg logs.

Thanks,
Brian


-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Tuesday, May 13, 2008 11:41 PM
To: Brian & Chamaigne Scamman
Subject: Re: Unable to access drives via PortMultiplier and SATA/IDE bridge

Brian & Chamaigne Scamman wrote:
> If I attach a real SATA drive to port 0 of the PMP, it is recognized
> and writeable; however, IDE solid state drives attached via a JM20330
> (to ports 2 and 3) at the same time receive the SCR 2 error.

Can you please cc linux-ide@vger.kernel.org when you reply?

Can you please post the log from that configuration?  So, SATA drive at 
port 0 and solid drives at port 1 and 2, right?

-- 
tejun

------=_NextPart_000_0037_01C8B82E.D9CFA690
Content-Type: text/plain;
	name="dmesg_ssd_drive_only_after_pmp.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg_ssd_drive_only_after_pmp.txt"

ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa frozen=20
ata6: irq_stat 0x00b40090, PHY RDY changed=20
ata6: hard resetting link=20
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 0)=20
ata6.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0xl/0x9
ata6.00: hard resetting link=20
ata6.00: softreset failed (timeout)=20
ata6.00: hard resetting link=20
ata6.15: qc timeout (cmd 0xe4)=20
ata6.00: failed to read SCR 2 (Emask=3D0x4)=20
ata6.00: failed to read SCR 2 (Emask=3D0x40)=20
ata6.00: COMRESET failed (errno=3D-5)=20
ata6.00: failed to read SCR 0 (Emask=3D0x40)=20
ata6.00: reset failed, giving up=20
ata6.15: hard resetting link=20
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)=20
ata6.00: hard resetting link=20
ata6.00: softreset failed (timeout)=20
ata6.00: hard resetting link=20
ata6.15: qc timeout (cmd 0xe4)=20
ata6.00: failed to read SCR 2 (Emask=3D0x4)=20
ata6.00: failed to read SCR 2 (Emask=3D0x40)=20
ata6.00: COMRESET failed (errno=3D-5)=20
ata6.00: failed to read SCR 0 (Emask=3D0x40)=20
ata6.00: reset failed, giving up=20
ata6.15: hard resetting link=20
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)=20
ata6.00: hard resetting link=20
ata6.00: softreset failed (timeout)=20
ata6.00: hard resetting link=20
ata6.15: qc timeout (cmd 0xe4)=20
ata6.00: failed to read SCR 2 (Emask=3D0x4)=20
ata6.00: failed to read SCR 2 (Emask=3D0x40)=20
ata6.00: COMRESET failed (errno=3D-5)=20
ata6.00: failed to read SCR 0 (Emask=3D0x40)=20
ata6.00: reset failed, giving up=20
ata6.00: failed to recover link after 3 tries, disabling=20
ata6: failed to recover PMP, retrying in 5 secs=20
ata6.15: hard resetting link=20
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl. 0)=20
ata6.01: hard resetting link=20
ata6.01: SATA link down (SStatus 0 SControl 320)=20
ata6.02: hard resetting link=20
ata6.02: SATA link down (SStatus 0 SControl 320)=20
ata6.03: hard resetting link=20
ata6.03: SATA link down (SStatus 0 SControl 320)=20
ata6.04: hard resetting link=20
ata6.04: SATA link down (SStatus 0 SControl 320)=20
ata6.05: hard resetting link=20
ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)=20
ata6: EH complete=20
ata6.00: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xb=20
ata6: SError: { PHYRdyChg CommWake DevExch }=20
ata6.00: hard resetting link=20
ata6.00: SATA link down (SStatus 0 SControl 320)=20
ata6: EH complete=20
ata6.00: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xb=20
ata6: SError: { PHYRdyChg CommWake DevExch }=20
ata6.00: hard resetting link=20
ata6.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)=20
ata6.00: ATA-6: Super Talent Tech, Rev 2.11, max UDMA/133=20
ata6.00: 127923200 sectors, multi 1: LBA=20
ata6.00: applying bridge limits=20
ata6.00: configured for UDMA/100=20
ata6: EH complete=20
scsi 5:0:0:0: Direct-Access     ATA      Super Talent Tec Rev PQ: 0 =
ANSI: 5
sd 5:0:0:0: [sdc] 127923200 512-byte hardware sectors (65497 MB)=20
sd 5:0:0:0: [sdc] Write Protect is off=20
Sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
Sd 5:0:0:0: [sdc] Write cache: disabled, read cache: enabled, doesn=92t =
support DPO or FUA
sd 5:0:0:0: [sdc] 127923200 512-byte hardware sectors (65497 MB)
sd 5:0:0:0: [sdc] Write Protect is off
sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdc] Write cache: disabled, read cache: enabled, doesn=92t =
support DPO or FUA
 sdc: sdc1=20
sd 5:0:0:0: [sdc] Attached SCSI disk=20
sd 5:0:0:0: Attached scsi generic sg3 type 0=20


------=_NextPart_000_0037_01C8B82E.D9CFA690
Content-Type: text/plain;
	name="dmesg_one_drive_at_a_time.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg_one_drive_at_a_time.txt"

ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa frozen=20
ata6: irq_stat 0x00b40090, PHY RDY changed=20
ata6: hard resetting link=20
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 0)=20
ata6.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9=20
ata6.00: hard resetting link=20
ata6.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)=20
ata6.01: hard resetting link=20
ata6.01: SATA link down (SStatus 0 SControl 320)=20
ata6.02: hard resetting link=20
ata6.02: SATA link down (SStatus 0 SControl 320)=20
ata6.03: hard resetting link=20
ata6.03: SATA link down (SStatus 0 SControl 320)=20
ata6.04: hard resetting link=20
ata6.04: SATA link down (SStatus 0 SControl 320)=20
ata6.05: hard resetting link=20
ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)=20
ata6.00: ATA-7: ST910021AS, 3.04, max UDMA/133=20
ata6.00: 195371568 sectors, multi 16: LBA48 NCQ (depth 31/32)=20
ata6.00: configured for UDMA/100=20
ata6: EH complete=20
scsi 5:0:0:0: Direct-Access     ATA ST910021AS            3.04 PQ: 0 =
ANSI: 5=20
sd 5:0:0:0: [sdc] 195371568 512-byte hardware sectors (100030 MB)=20
sd 5:0:0:0: [sdc] Write Protect is off=20
sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00=20
sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn=92t =
support DPO or FUA=20
sd 5:0:0:0: [sdc] 195371568 512-byte hardware sectors (100030 MB)=20
sd 5:0:0:0: [sdc] Write Protect is off=20
sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00=20
Sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn=92t =
support DPO or FUA=20
 sdc: unknown partition table=20
sd 5:0:0:0: [sdc] Attached SCSI disk=20
sd 5:0:0:0: Attached scsi generic sg3 type 0=20
ata6.01: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action 0xb=20
ata6: SError: { CommWake DevExch }=20
ata6.01: hard resetting link=20
ata6.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)=20
ata6.01: ATA-6: Super Talent Tech, Rev 2.11, max UDMA/133=20
ata6.01: 127923200 sectors, multi 1: LBA=20
ata6.01: applying bridge limits=20
ata6.01: configured for UDMA/100=20
ata6: EH complete=20
scsi 5:1:0:0: Direct-Access     ATA      Super Talent Tec Rev  PQ: 0 =
ANSI: 5=20
sd 5:1:0:0: [sde] 127923200 512-byte hardware sectors (65497 MB)=20
sd 5:1:0:0: [sde] Write Protect is off=20
sd 5:1:0:0: [sde] Mode Sense: 00 3a 00 00=20
sd 5:1:0:0: [sde] Write cache: disabled, read cache: enabled, doesn=92t =
support DPO or FUA=20
sd 5:1:0:0: [sde] 127923200 512-byte hardware sectors (65497 MB)=20
sd 5:1:0:0: [sde] Write Protect is off=20
sd 5:1:0:0: [sde] Mode Sense: 00 3a 00 00=20
sd 5:1:0:0: [sde] Write cache: disabled, read cache: enabled, doesn=92t =
support DPO or FUA=20
 sde: sdel=20
sd 5:1:0:0: [sde] Attached SCSI disk=20
sd 5:1:0:0: Attached scsi generic sg5 type 0=20


------=_NextPart_000_0037_01C8B82E.D9CFA690--

