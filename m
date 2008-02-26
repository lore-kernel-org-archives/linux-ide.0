From: Daniel Schroeder <sec@dschroeder.info>
Subject: WD1000FYPS problem
Date: Tue, 26 Feb 2008 14:54:20 +0100
Message-ID: <47C41A0C.2080405@dschroeder.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50138 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbYBZNyY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 08:54:24 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by isla-magica.localdomain (Postfix) with ESMTP id 445D2F467F
	for <linux-ide@vger.kernel.org>; Tue, 26 Feb 2008 14:54:20 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hi there,

new WD 1TB disk, esata case, kernel-2.6.24.3, SiI 3132. Turned case 
on...disk sounds strange and repetitive and this is the kern.log, two 
times "strange sounds" then turned the case off.

<quote>
Feb 26 14:43:45 isla-magica ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 
action 0xa frozen
Feb 26 14:43:45 isla-magica ata3: irq_stat 0x00800080, device exchanged
Feb 26 14:43:45 isla-magica ata3: hard resetting link
Feb 26 14:43:55 isla-magica ata3: softreset failed (timeout)
Feb 26 14:43:55 isla-magica ata3: hard resetting link
Feb 26 14:43:58 isla-magica ata3: SATA link up 3.0 Gbps (SStatus 123 
SControl 0)
Feb 26 14:43:58 isla-magica ata3.00: ATA-8: WDC WD1000FYPS-01ZKB0, 
02.01B01, max UDMA/133
Feb 26 14:43:58 isla-magica ata3.00: 1953525168 sectors, multi 0: LBA48 
NCQ (depth 31/32)
Feb 26 14:43:58 isla-magica ata3.00: configured for UDMA/100
Feb 26 14:43:58 isla-magica ata3: EH complete
Feb 26 14:43:58 isla-magica scsi 2:0:0:0: Direct-Access     ATA      WDC 
WD1000FYPS-0 02.0 PQ: 0 ANSI: 5
Feb 26 14:43:58 isla-magica sd 2:0:0:0: [sdc] 1953525168 512-byte 
hardware sectors (1000205 MB)
Feb 26 14:43:58 isla-magica sd 2:0:0:0: [sdc] Write Protect is off
Feb 26 14:43:58 isla-magica sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
Feb 26 14:43:58 isla-magica sd 2:0:0:0: [sdc] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA
Feb 26 14:43:58 isla-magica sd 2:0:0:0: [sdc] 1953525168 512-byte 
hardware sectors (1000205 MB)
Feb 26 14:43:58 isla-magica sd 2:0:0:0: [sdc] Write Protect is off
Feb 26 14:43:58 isla-magica sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
Feb 26 14:43:58 isla-magica sd 2:0:0:0: [sdc] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA
Feb 26 14:44:04 isla-magica sdc:
Feb 26 14:44:58 isla-magica ata3.00: exception Emask 0x0 SAct 0x1 SErr 
0x0 action 0x2 frozen
Feb 26 14:44:58 isla-magica ata3.00: cmd 
60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
Feb 26 14:44:58 isla-magica res 40/00:01:09:4f:c2/00:00:00:00:00/00 
Emask 0x4 (timeout)
Feb 26 14:44:58 isla-magica ata3.00: status: { DRDY }
Feb 26 14:44:58 isla-magica ata3: hard resetting link
Feb 26 14:45:02 isla-magica ata3: SATA link up 3.0 Gbps (SStatus 123 
SControl 0)
Feb 26 14:45:02 isla-magica ata3.00: configured for UDMA/100
Feb 26 14:45:02 isla-magica ata3: EH complete
Feb 26 14:46:02 isla-magica ata3.00: exception Emask 0x0 SAct 0x1 SErr 
0x0 action 0x2 frozen
Feb 26 14:46:02 isla-magica ata3.00: cmd 
60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
Feb 26 14:46:02 isla-magica res 40/00:01:09:4f:c2/00:00:00:00:00/00 
Emask 0x4 (timeout)
Feb 26 14:46:02 isla-magica ata3.00: status: { DRDY }
Feb 26 14:46:02 isla-magica ata3: hard resetting link
Feb 26 14:46:05 isla-magica ata3: SATA link up 3.0 Gbps (SStatus 123 
SControl 0)
Feb 26 14:46:05 isla-magica ata3.00: configured for UDMA/100
Feb 26 14:46:05 isla-magica ata3: EH complete
Feb 26 14:46:10 isla-magica ata3.00: exception Emask 0x10 SAct 0x1 SErr 
0x80000 action 0xa frozen
Feb 26 14:46:10 isla-magica ata3.00: irq_stat 0x01100010, PHY RDY changed
Feb 26 14:46:10 isla-magica ata3: SError: { 10B8B }
Feb 26 14:46:10 isla-magica ata3.00: cmd 
60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
Feb 26 14:46:10 isla-magica res 50/00:00:af:6d:70/00:00:74:00:00/e0 
Emask 0x10 (ATA bus error)
Feb 26 14:46:10 isla-magica ata3.00: status: { DRDY }
Feb 26 14:46:10 isla-magica ata3: hard resetting link
Feb 26 14:46:12 isla-magica ata3: SATA link down (SStatus 0 SControl 0)
Feb 26 14:46:12 isla-magica ata3: failed to recover some devices, 
retrying in 5 secs
Feb 26 14:46:17 isla-magica ata3: hard resetting link
Feb 26 14:46:19 isla-magica ata3: SATA link down (SStatus 0 SControl 0)
Feb 26 14:46:19 isla-magica ata3: failed to recover some devices, 
retrying in 5 secs
Feb 26 14:46:24 isla-magica ata3: hard resetting link
Feb 26 14:46:26 isla-magica ata3: SATA link down (SStatus 0 SControl 0)
Feb 26 14:46:26 isla-magica ata3.00: disabled
Feb 26 14:46:26 isla-magica ata3: EH complete
Feb 26 14:46:26 isla-magica sd 2:0:0:0: [sdc] Result: hostbyte=0x04 
driverbyte=0x00
Feb 26 14:46:26 isla-magica end_request: I/O error, dev sdc, sector 0
Feb 26 14:46:26 isla-magica Buffer I/O error on device sdc, logical block 0
Feb 26 14:46:26 isla-magica sd 2:0:0:0: [sdc] Result: hostbyte=0x04 
driverbyte=0x00
Feb 26 14:46:26 isla-magica end_request: I/O error, dev sdc, sector 0
Feb 26 14:46:26 isla-magica Buffer I/O error on device sdc, logical block 0
Feb 26 14:46:26 isla-magica unable to read partition table
Feb 26 14:46:26 isla-magica sd 2:0:0:0: [sdc] Attached SCSI disk
Feb 26 14:46:26 isla-magica sd 2:0:0:0: Attached scsi generic sg2 type 0
Feb 26 14:46:26 isla-magica ata_id[11248]: main: HDIO_GET_IDENTITY 
failed for '/dev/.tmp-8-32'
</quote>

tia
daniel
