From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: [QUESTION] ATA: abnormal status 0x80 on port 0xCC07
Date: Sat, 3 Feb 2007 19:44:35 +0100
Message-ID: <6bffcb0e0702031044v601e4fc3icf859544af292789@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:55485 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbXBCSoh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 13:44:37 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1015590uga
        for <linux-ide@vger.kernel.org>; Sat, 03 Feb 2007 10:44:36 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Jeff,

What does this mean?

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd c8/00:08:67:40:68/00:00:00:00:00/e3 tag 0 cdb 0x0 data 4096 in
         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd c8/00:00:c3:52:43/00:00:00:00:00/ea tag 0 cdb 0x0 data 131072 in
         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd c8/00:00:c3:52:43/00:00:00:00:00/ea tag 0 cdb 0x0 data 131072 in
         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO
or FUA
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO
or FUA
ATA: abnormal status 0x80 on port 0xCC07
ATA: abnormal status 0x80 on port 0xCC07
ATA: abnormal status 0x80 on port 0xCC07
ata1.00: limiting speed to UDMA/100
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd ca/00:38:8f:7a:01/00:00:00:00:00/e0 tag 0 cdb 0x0 data 28672 out
         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: soft resetting port
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO                                             or FUA
ATA: abnormal status 0x80 on port 0xCC07
ATA: abnormal status 0x80 on port 0xCC07
ATA: abnormal status 0x80 on port 0xCC07
ata1.00: limiting speed to UDMA/66
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd ca/00:40:ab:e2:4a/00:00:00:00:00/ea tag 0 cdb 0x0 data 32768 out
         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: soft resetting port
ata1.00: configured for UDMA/66
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO                                             or FUA

Is this a hardware problem?

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
