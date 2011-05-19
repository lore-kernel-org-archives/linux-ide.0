From: Michal Suchanek <hramrach@centrum.cz>
Subject: SATA PMP support
Date: Thu, 19 May 2011 17:12:02 +0200
Message-ID: <BANLkTi=4oJvigsq7GPMuB8meX0XnDh4VWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57864 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932781Ab1ESPMW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 May 2011 11:12:22 -0400
Received: by gwaa18 with SMTP id a18so948799gwa.19
        for <linux-ide@vger.kernel.org>; Thu, 19 May 2011 08:12:22 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I bought an eSATA enclosure (evolve doubledock) and I wonder if it can
be used as a PMP.

My eSATA port is connected to ICH10 AHCI controller which reportedly
supports CBS  PMP.

When I connect the dock kernel sees the port going up and I get access
to one of the drives.

I can access a drive in either slot but if both are populated only the
primary slot (marked source) is visible.

Attaching and detaching drives in the enclosure does not cause hotplug events.

When I eg. remove a drive from the primary slot the port is quietly
switched to the secondary slot and the kernel subsequently reports
that the drive name does not match.

I have no traces of PMP in the log.

I am running Debian's linux-image 2.6.38-2-amd64 which is linux 2.6.38.4

Is there a way to tell if the enclosure is PMP capable?
Is it possible that it would support FBS but not CBS (and the other
way around with the AHCI controller)?

Thanks

Michal

PS please CC me

[2504756.072791] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4040000
action 0xe frozen
[2504756.072795] ata6: irq_stat 0x00000040, connection status changed
[2504756.072798] ata6: SError: { CommWake DevExch }
[2504756.072805] ata6: hard resetting link
[2504761.836017] ata6: link is slow to respond, please be patient (ready=0)
[2504766.092013] ata6: COMRESET failed (errno=-16)
[2504766.092019] ata6: hard resetting link
[2504771.856012] ata6: link is slow to respond, please be patient (ready=0)
[2504772.696019] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[2504772.740202] ata6.00: ATA-7: ST3200820AS, 3.AAE, max UDMA/133
[2504772.740205] ata6.00: 390721968 sectors, multi 0: LBA48
[2504772.806841] ata6.00: configured for UDMA/133
[2504772.806848] ata6: EH complete
[2504772.806941] scsi 5:0:0:0: Direct-Access     ATA      ST3200820AS
    3.AA PQ: 0 ANSI: 5
[2504772.807146] sd 5:0:0:0: [sdh] 390721968 512-byte logical blocks:
(200 GB/186 GiB)
[2504772.807181] sd 5:0:0:0: Attached scsi generic sg8 type 0
[2504772.807207] sd 5:0:0:0: [sdh] Write Protect is off
[2504772.807210] sd 5:0:0:0: [sdh] Mode Sense: 00 3a 00 00
[2504772.807235] sd 5:0:0:0: [sdh] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[2504774.445829]  sdh: sdh1 sdh2
[2504774.446301] sd 5:0:0:0: [sdh] Attached SCSI disk
[2504904.851780] ata6.00: exception Emask 0x50 SAct 0x0 SErr 0x40d0802
action 0xe frozen
[2504904.851784] ata6.00: irq_stat 0x00400040, connection status changed
[2504904.851787] ata6: SError: { RecovComm HostInt PHYRdyChg CommWake
10B8B DevExch }
[2504904.851790] ata6.00: failed command: READ DMA
[2504904.851794] ata6.00: cmd c8/00:08:3f:00:00/00:00:00:00:00/e0 tag
0 dma 4096 in
[2504904.851795]          res 50/00:00:07:00:00/00:00:00:00:00/e0
Emask 0x50 (ATA bus error)
[2504904.851797] ata6.00: status: { DRDY }
[2504904.851802] ata6: hard resetting link
[2504910.612012] ata6: link is slow to respond, please be patient (ready=0)
[2504914.868013] ata6: COMRESET failed (errno=-16)
[2504914.868020] ata6: hard resetting link
[2504916.824021] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[2504916.824631] ata6.00: model number mismatch 'ST3200820AS' !=
'Hitachi HDS721010KLA330'
[2504916.824633] ata6.00: revalidation failed (errno=-19)
[2504916.824637] ata6: limiting SATA link speed to 1.5 Gbps
[2504921.824018] ata6: hard resetting link
[2504922.480024] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[2504922.480652] ata6.00: model number mismatch 'ST3200820AS' !=
'Hitachi HDS721010KLA330'
[2504922.480656] ata6.00: revalidation failed (errno=-19)
[2504922.480659] ata6.00: disabled
[2504927.480012] ata6: hard resetting link
