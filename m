From: Frederik Himpe <fhimpe@telenet.be>
Subject: [2.6.22-rc6] NForce4 soft and hard resetting ports and exceptions
Date: Tue, 26 Jun 2007 17:45:22 +0000 (UTC)
Message-ID: <pan.2007.06.26.17.45.21@telenet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759294AbXFZSaa@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

I tried Linux 2.6.22-rc6 on my machine with an Asus A8N-SlI Deluxe 
motherboard (NForce 4 chipset).

When booting, the system hangs for a long time, but it continues after a 
long wait. I found these kind of errors in the logs afterwards:

ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 
123392 in
         res 50/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM 
violation)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ATA: abnormal status 0xD0 on port 0xffffc2000001a59c
ATA: abnormal status 0xD0 on port 0xffffc2000001a59c
ATA: abnormal status 0xD0 on port 0xffffc2000001a59c
ATA: abnormal status 0xD0 on port 0xffffc2000001a59c
ATA: abnormal status 0xD0 on port 0xffffc2000001a59c
ATA: abnormal status 0xD0 on port 0xffffc2000001a59c
ata2.00: revalidation failed (errno=-2)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ata_hpa_resize 1: sectors = 390721968, hpa_sectors = 390721968
ata2.00: ata_hpa_resize 1: sectors = 390721968, hpa_sectors = 390721968
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 
123392 in
         res 50/00:00:af:f1:49/00:00:00:00:00/00 Emask 0x202 (HSM 
violation)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ATA: abnormal status 0xD0 on port 0xffffc2000001a59c
ATA: abnormal status 0xD0 on port 0xffffc2000001a59c
ATA: abnormal status 0xD0 on port 0xffffc2000001a59c
ATA: abnormal status 0xD0 on port 0xffffc2000001a59c
ATA: abnormal status 0xD0 on port 0xffffc2000001a59c
ATA: abnormal status 0xD0 on port 0xffffc2000001a59c
ata2.00: revalidation failed (errno=-2)
[...]

With Linux 2.6.21 this did not happen.

config, dmesg and lspci can be found here:
http://artipc10.vub.ac.be/kernelbug/

-- 
Frederik Himpe
