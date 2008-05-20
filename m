From: "Brian & Chamaigne Scamman" <scammanbc@earthlink.net>
Subject: RE: [PATCHSET #upstream-fixes] git tree available
Date: Mon, 19 May 2008 21:35:16 -0400
Message-ID: <006501c8ba19$c1f53340$6917a8c0@parents>
References: <12111273141039-git-send-email-htejun@gmail.com> <48305961.2050509@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0066_01C8B9F8.3AE39340"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:51969 "EHLO
	elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754708AbYETBfV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 21:35:21 -0400
In-Reply-To: <48305961.2050509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>, jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca

This is a multi-part message in MIME format.

------=_NextPart_000_0066_01C8B9F8.3AE39340
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Tejun-

The hotplug fixes didn't solve the problem. After adding some "logic
monitoring" statements, I found that the successful discovery of the drives
depends on the response from sil24_exec_polled_cmd.

If the call from ata_wait_register is 327680, the drives are recognized; if
the response is 262144 the drives have timed out.

I've also noticed that the drives respond to the EH entering with DevExch
vs. PHY RDY changed.

Bottom line, the drives seem to be recognized almost every time I attach
them to the PMP after the EH has completed processing the empty PMP.  If the
drives are attached to the PMP before the PMP is attached to the controller,
the drives are almost never recognized (EH times out).

I've attached some more dmesg output (with my logic monitoring statements
included).

-Brian

-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Sunday, May 18, 2008 12:29 PM
To: jeff@garzik.org; linux-ide@vger.kernel.org
Cc: liml@rtr.ca; Brian & Chamaigne Scamman
Subject: Re: [PATCHSET #upstream-fixes] git tree available

Git tree available at...

 
http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=hot
plug-fixes
 git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git
hotplug-fixes

Brian, the original thread is

 http://thread.gmane.org/gmane.linux.ide/31572

and it might fix your device detection problem.  Please test.
If you don't git, patch against v2.6.26-rc2 is available at...

 http://master.kernel.org/~tj/v2.6.26-rc2-to-hotplug-fixes.patch

Thanks.

-- 
tejun

------=_NextPart_000_0066_01C8B9F8.3AE39340
Content-Type: text/plain;
	name="ssd_not_working.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ssd_not_working.txt"

ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata3: irq stat 0x00b40090, PHY RDY changed=20
ata3: BJS: Prep for recovery=20
ata3: BJS: dev 0=20
ata3: BJS: Prep for EH=20
ata3: BJS: Reset=20
ata3: hard resetting link=20
ata3: BJS: follow-up softreset required=20
ata3: BJS: orig timeout (7812)=20
ata3: BJS: IRQ port (11862016)=20
ata3: BJS: rc=3D0=20
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)=20
ata3: BJS: The Rest...=20
ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9=20
ata3.00: BJS: Prep for recovery=20
ata3.00: BJS: dev 0=20
ata3.01: BJS: Prep for recovery=20
ata3.01: BJS: dev 0=20
ata3.02: BJS: Prep for recovery=20
ata3.02: BJS: dev 0=20
ata3.03: BJS: Prep for recovery=20
ata3.03: BJS: dev 0=20
ata3.04: BJS: Prep for recovery=20
ata3.04: BJS: dev 0=20
ata3.05: BJS: Prep for recovery=20
ata3.05: BJS: dev 0=20
ata3.00: BJS: Prep for EH=20
ata3.01: BJS: Prep for EH=20
ata3.02: BJS: Prep for EH=20
ata3.03: BJS: Prep for EH=20
ata3.04: BJS: Prep for EH=20
ata3.05: BJS: Prep for EH=20
ata3.00: BJS: Reset=20
ata3.00: hard resetting link=20
ata3.00: BJS: follow-up softreset required=20
ata3.00: BJS: orig timeout (9680)=20
ata3: BJS: IRQ port (262144)=20
ata3: BJS: IRQ !complete=20
ata3.00: softreset failed (timeout)=20
ata3.00: BJS: rc=3D-5=20
ata3.15: qc timeout (cmd 0xe4)=20
ata3.00: failed to read SCR 0 (Emask=3D0x4)=20
ata3.00: reset failed, giving up=20
ata3.15: hard resetting link=20
ata3.15: BJS: follow-up softreset required=20
ata3.15: BJS: orig timeout (7816)=20
ata3: BJS: IRQ port (11862016)=20
ata3.15: BJS: rc=3D0=20
ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)=20
ata3.00: BJS: Prep for recovery=20
ata3.00: BJS: dev 0=20
ata3.01: BJS: Prep for recovery=20
ata3.01: BJS: dev 0=20
ata3.02: BJS: Prep for recovery=20
ata3.02: BJS: dev 0=20
ata3.03: BJS: Prep for recovery=20
ata3.03: BJS: dev 0=20
ata3.04: BJS: Prep for recovery=20
ata3.04: BJS: dev 0=20
ata3.05: BJS: Prep for recovery=20
ata3.05: BJS: dev 0=20
ata3.00: BJS: Prep for EH=20
ata3.01: BJS: Prep for EH=20
ata3.02: BJS: Prep for EH=20
ata3.03: BJS: Prep for EH=20
ata3.04: BJS: Prep for EH=20
ata3.05: BJS: Prep for EH=20
ata3.00: BJS: Reset=20
ata3.00: hard resetting link=20
ata3.00: BJS: follow-up softreset required=20
ata3.00: BJS: orig timeout (9680)=20
ata3: BJS: IRQ port (262144)=20
ata3: BJS: IRQ complete=20
ata3.00: softreset failed (timeout)=20
ata3.00: BJS: rc=3D-5=20
ata3.15: qc timeout (cmd 0xe4)=20
ata3.00: failed to read SCR 0 (Emask=3D0x4)=20
ata3.00: reset failed, giving up=20
ata3.15: hard resetting link=20
ata3.15: BJS: follow-up softreset required=20
ata3.15: BJS: orig timeout (7816)=20
ata3: BJS: IRQ port (11862016)=20
ata3.15: BJS: rc=3D0=20
ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)=20
ata3.00: BJS: Prep for recovery=20
ata3.00: BJS: dev 0=20
ata3.01: BJS: Prep for recovery=20
ata3.01: BJS: dev 0=20
ata3.02: BJS: Prep for recovery=20
ata3.02: BJS: dev 0=20
ata3.03: BJS: Prep for recovery=20
ata3.03: BJS: dev 0=20
ata3.04: BJS: Prep for recovery=20
ata3.04: BJS: dev 0=20
ata3.05: BJS: Prep for recovery=20
ata3.05: BJS: dev 0=20
ata3.00: BJS: Prep for EH=20
ata3.01: BJS: Prep for EH=20
ata3.02: BJS: Prep for EH=20
ata3.03: BJS: Prep for EH=20
ata3.04: BJS: Prep for EH=20
ata3.05: BJS: Prep for EH=20
ata3.00: BJS: Reset=20
ata3.00: hard resetting link=20
ata3.00: BJS: follow-up softreset required=20
ata3.00: BJS: orig timeout (9680)=20
ata3: BJS: IRQ port (262144)=20
ata3: BJS: IRQ !complete=20
ata3.00: softreset failed (timeout)=20
ata3.00: BJS: rc=3D-5=20
ata3.15: qc timeout (cmd 0xe4)=20
ata3.00: failed to read SCR 0 (Emask=3D0x4)=20
ata3.00: reset failed, giving up=20
ata3.00: failed to recover link after 3 tries, disabling=20
ata3: failed to recover PMP, retrying in 5 secs=20
ata3.15: hard resetting link=20
ata3.15: BJS: follow-up softreset required=20
ata3.15: BJS: orig timeout (7816)=20
ata3: BJS: IRQ port (11862016)=20
ata3.15: BJS: rc=3D0=20
ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)=20
ata3.00: BJS: Prep for recovery=20
ata3.00: BJS: dev 0=20
ata3.01: BJS: Prep for recovery=20
ata3.01: BJS: dev 0=20
ata3.02: BJS: Prep for recovery=20
ata3.02: BJS: dev 0=20
ata3.03: BJS: Prep for recovery=20
ata3.03: BJS: dev 0=20
ata3.04: BJS: Prep for recovery=20
ata3.04: BJS: dev 0=20
ata3.05: BJS: Prep for recovery=20
ata3.05: BJS: dev 0=20
ata3.00: BJS: Prep for EH
ata3.01: BJS: Prep for EH
ata3.02: BJS: Prep for EH
ata3.03: BJS: Prep for EH
ata3.04: BJS: Prep for EH
ata3.05: BJS: Prep for EH
ata3.00: BJS: Reset
ata3.01: BJS: Reset
ata3.01: hard resetting link
ata3.01: SATA link down (SStatus 0 SControl 320)
ata3.02: BJS: Reset
ata3.02: hard resetting link
ata3.02: SATA link down (SStatus 0 SControl 320)
ata3.03: BJS: Reset
ata3.03: hard resetting link
ata3.03: SATA link down (SStatus 0 SControl 320)
ata3.04: BJS: Reset
ata3.04: hard resetting link
ata3.04: SATA link down (SStatus 0 SControl 320)
ata3.05: BJS: Reset
ata3.05: hard resetting link
ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata3.00: BJS: The Rest...
ata3.01: BJS: The Rest...
ata3.02: BJS: The Rest...
ata3.03: BJS: The Rest...
ata3.04: BJS: The Rest...
ata3.05: BJS: The Rest...
ata3.00: BJS: Prep for recovery
ata3.00: BJS: dev 0
ata3.01: BJS: Prep for recovery
ata3.01: BJS: dev 0
ata3.02: BJS: Prep for recovery
ata3.02: BJS: dev 0
ata3.03: BJS: Prep for recovery
ata3.03: BJS: dev 0
ata3.04: BJS: Prep for recovery
ata3.04: BJS: dev 0
ata3.05: BJS: Prep for recovery
ata3.05: BJS: dev 0
ata3.00: BJS: Prep for EH
ata3.01: BJS: Prep for EH
ata3.02: BJS: Prep for EH
ata3.03: BJS: Prep for EH
ata3.04: BJS: Prep for EH
ata3.05: BJS: Prep for EH
ata3.00: BJS: Reset
ata3.01: BJS: Reset
ata3.02: BJS: Reset
ata3.03: BJS: Reset
ata3.04: BJS: Reset
ata3.05: BJS: Reset
ata3.00: BJS: The Rest...
ata3.01: BJS: The Rest...
ata3.02: BJS: The Rest...
ata3.03: BJS: The Rest...
ata3.04: BJS: The Rest...
ata3.05: BJS: The Rest...
ata3: EH complete=20
ata3.00: exception Emask 0xl0 SAct 0x0 SErr 0x4010000 action 0xf
ata3: SError: { PHYRdyChg DevExch }=20
ata3.00: BJS: Prep for recovery=20
ata3.00: BJS: dev 0=20
ata3.01: BJS: Prep for recovery=20
ata3.01: BJS: dev 0=20
ata3.02: BJS: Prep for recovery=20
ata3.02: BJS: dev 0=20
ata3.03: BJS: Prep for recovery=20
ata3.03: BJS: dev 0=20
ata3.04: BJS: Prep for recovery
ata3.04: BJS: dev 0=20
ata3.05: BJS: Prep for recovery
ata3.05: BJS: dev 0=20
ata3.00: BJS: Prep for EH
ata3.01: BJS: Prep for EH
ata3.02: BJS: Prep for EH
ata3.03: BJS: Prep for EH
ata3.04: BJS: Prep for EH
ata3.05: BJS: Prep for EH
ata3.00: BJS: Reset=20
ata3.00: hard resetting link=20
ata3.00: SATA link down (SStatus 0 SControl 320)=20
ata3.01: BJS: Reset=20
ata3.02: BJS: Reset=20
ata3.03: BJS: Reset=20
ata3.04: BJS: Reset=20
ata3.05: BJS: Reset=20
ata3.00: BJS: The Rest...=20
ata3.01: BJS: The Rest...=20
ata3.02: BJS: The Rest...=20
ata3.03: BJS: The Rest...=20
ata3.04: BJS: The Rest...=20
ata3.05: BJS: The Rest...=20
ata3: EH complete=20
ata3.00: exception Emask 0xl0 SAct 0x0 SErr 0x4040000 action 0xf=20
ata3: SError: { CommWake DevExch }
ata3.00: BJS: Prep for recovery
ata3.00: BJS: dev 0
ata3.01: BJS: Prep for recovery
ata3.01: BJS: dev 0
ata3.02: BJS: Prep for recovery
ata3.02: BJS: dev 0
ata3.03: BJS: Prep for recovery
ata3.03: BJS: dev 0
ata3.04: BJS: Prep for recovery
ata3.04: BJS: dev 0
ata3.05: BJS: Prep for recovery
ata3.05: BJS: dev 0
ata3.00: BJS: Prep for EH
ata3.01: BJS: Prep for EH
ata3.02: BJS: Prep for EH
ata3.03: BJS: Prep for EH
ata3.04: BJS: Prep for EH
ata3.05: BJS: Prep for EH
ata3.00: BJS: Reset
ata3.00: hard resetting link
ata3.00: BJS: follow-up softreset required
ata3.00: BJS: orig timeout (9276)
ata3: BJS: IRQ port (327680)=20
ata3.00: BJS: rc=3D0=20
ata3.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)=20
ata3.01: BJS: Reset=20
ata3.02: BJS: Reset=20
ata3.03: BJS: Reset=20
ata3.04: BJS: Reset=20
ata3.05: BJS: Reset
ata3.00: BJS: The Rest...
ata3.00: ATA-6: Super Talent Tech, Rev 2.11, max UDMA/133
ata3.00: 127923200 sectors, multi 1: LBA
ata3.00: applying bridge limits
ata3.00: configured for UDMA/100
ata3.01: BJS: The Rest...
ata3.02: BJS: The Rest...
ata3.03: BJS: The Rest...
ata3.04: BJS: The Rest...
ata3.05: BJS: The Rest...=20
ata3: EH complete=20
scsi 2:0:0:0: Direct-Access     ATA      Super Talent Tec Rev PQ: 0 =
ANSI: 5=20
sd 2:0:0:0: [sda] 127923200 512-byte hardware sectors (65497 MB)=20
sd 2:0:0:0: [sda] Write Protect is off=20
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00=20
sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn=92t =
support DPO or FUA=20
sd 2:0:0:0: [sda] 127923200 512-byte hardware sectors (65497 MB)=20
sd 2:0:0:0: [sda] Write Protect is off=20
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00=20
sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn=92t =
support DPO or FUA=20
 sda: sda1=20
sd 2:0:0:0: [sda] Attached SCSI disk=20
sd 2:0:0:0: Attached scsi generic sg0 type 0=20


------=_NextPart_000_0066_01C8B9F8.3AE39340
Content-Type: text/plain;
	name="ssd_working.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ssd_working.txt"

ata3: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xe frozen
ata3: irq_stat 0x00a40080, device exchanged=20
ata3: SError: { PHYRdyChg }=20
ata3: BJS: Prep for recovery=20
ata3: BJS: dev 0=20
ata3: BJS: Prep for EH=20
ata3: BJS: Reset=20
ata3: hard resetting link=20
ata3: BJS: follow-up softreset required=20
ata3: BJS: orig timeout (7816)=20
ata3: BJS: IRQ port (11862016)=20
ata3: BJS: rc=3D0=20
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)=20
ata3: BJS: The Rest...=20
ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9=20
ata3.00: BJS: Prep for recovery=20
ata3.00: BJS: dev 0=20
ata3.01: BJS: Prep for recovery=20
ata3.01: BJS: dev 0=20
ata3.02: BJS: Prep for recovery=20
ata3.02: BJS: dev 0=20
ata3.03: BJS: Prep for recovery=20
ata3.03: BJS: dev 0=20
ata3.04: BJS: Prep for recovery=20
ata3.04: BJS: dev 0=20
ata3.05: BJS: Prep for recovery=20
ata3.05: BJS: dev 0=20
ata3.00: BJS: Prep for EH=20
ata3.01: BJS: Prep for EH=20
ata3.02: BJS: Prep for EH=20
ata3.03: BJS: Prep for EH=20
ata3.04: BJS: Prep for EH=20
ata3.05: BJS: Prep for EH=20
ata3.00: BJS: Reset=20
ata3.00: hard resetting link=20
ata3.00: BJS: follow-up softreset required=20
ata3.00: BJS: orig timeout (9680)=20
ata3: BJS: IRQ port (327680)=20
ata3.00: BJS: rc=3D0
ata3.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata3.01: BJS: Reset
ata3.01: hard resetting link
ata3.01: SATA link down (SStatus 0 SControl 320)
ata3.02: BJS: Reset
ata3.02: hard resetting link
ata3.02: SATA link down (SStatus 0 SControl 320)
ata3.03: BJS: Reset
ata3.03: hard resetting link
ata3.03: SATA link down (SStatus 0 SControl 320)
ata3.04: BJS: Reset
ata3.04: hard resetting link
ata3.04: SATA link down (SStatus 0 SControl 320)
ata3.05: BJS: Reset
ata3.05: hard resetting link
ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata3.00: BJS: The Rest...
ata3.00: ATA-6: Super Talent Tech, Rev 2.11, max UDMA/133
ata3.00: 127923200 sectors, multi 1: LBA=20
ata3.00: applying bridge limits=20
ata3.00: configured for UDMA/100=20
ata3.01: BJS: The Rest...=20
ata3.02: BJS: The Rest. .=20
ata3.03: BJS: The Rest...=20
ata3.04: BJS: The Rest. .=20
ata3.05: BJS: The Rest...=20
ata3: EH complete=20
scsi 2:0:0:0: Direct-Access          ATA       Super Talent Tec Rev PQ: =
0 ANSI: 5=20
sd 2:0:0:0: [sda] 127923200 512-byte hardware Sectors (65497 MB)=20
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn=92t =
support DPO or FUA
sd 2:0:0:0: [sda] 127923200 512-byte hardware sectors (65497 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn=92t =
support DPO or FUA
 sda: sdal=20
sd 2:0:0:0: [sda] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg0 type 0

------=_NextPart_000_0066_01C8B9F8.3AE39340--

