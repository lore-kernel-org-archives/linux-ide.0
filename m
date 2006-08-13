From: Philipp Wagner <mail@philipp-wagner.com>
Subject: Re: Hotplug with sata_nv
Date: Sun, 13 Aug 2006 09:58:44 +0200
Message-ID: <44DEDBB4.8080007@philipp-wagner.com>
References: <44BE9B67.7020901@philipp-wagner.com> <44CD17F5.5010800@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080705030903040900020705"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from turbohermes.planet-school.de ([194.116.187.5]:25496 "EHLO
	turbohermes.planet-school.de") by vger.kernel.org with ESMTP
	id S1750747AbWHMH6s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Aug 2006 03:58:48 -0400
In-Reply-To: <44CD17F5.5010800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------080705030903040900020705
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hello,
Thank you for your reply. I am only home on weekends, so it took some
time to try your patch.

I applied the patch to 2.6.18-rc4.
At first the good thing: hotplug is working, the device is properly
removed and re-added.
But now the bad side: The device names are changed. When I remove
/dev/sdb, and add it again, it is named /dev/sdc. When I remove /dev/sda
afterwards, it is named /dev/sdd.

Furthermore I am still looking for a solution which automatically starts
the RAID recovery process when the device is re-added.

I attached the relevant parts of /var/log/messages (removal of /dev/sdb
and it being /dev/sdc afterwards).

Philipp


--------------080705030903040900020705
Content-Type: text/plain;
 name="messages-sata"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages-sata"

Aug 12 17:38:17 srv1 kernel: ata2: exception Emask 0x10 SAct 0x0 SErr 0x1810000 action 0x2 frozen
Aug 12 17:38:18 srv1 kernel: ata2: hard resetting port
Aug 12 17:38:19 srv1 kernel: ata2: SATA link down (SStatus 0 SControl 300)
Aug 12 17:38:19 srv1 kernel: ata2: failed to recover some devices, retrying in 5 secs
Aug 12 17:38:24 srv1 kernel: ata2: hard resetting port
Aug 12 17:38:25 srv1 kernel: ata2: SATA link down (SStatus 0 SControl 300)
Aug 12 17:38:25 srv1 kernel: ata2: failed to recover some devices, retrying in 5 secs
Aug 12 17:38:30 srv1 kernel: ata2: hard resetting port
Aug 12 17:38:31 srv1 kernel: ata2: SATA link down (SStatus 0 SControl 300)
Aug 12 17:38:31 srv1 kernel: ata2.00: disabled
Aug 12 17:38:32 srv1 kernel: ata2: EH pending after completion, repeating EH (cnt=4)
Aug 12 17:38:32 srv1 kernel: ata2: EH complete
Aug 12 17:38:32 srv1 kernel: ata2.00: detaching (SCSI 1:0:0:0)
Aug 12 17:38:52 srv1 kernel: ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
Aug 12 17:38:52 srv1 kernel: ata2: waiting for device to spin up (8 secs)
Aug 12 17:38:52 srv1 kernel: ata2: hard resetting port
Aug 12 17:39:00 srv1 kernel: ata2: port is slow to respond, please be patient
Aug 12 17:39:02 srv1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 12 17:39:02 srv1 kernel: ata2.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 0/32)
Aug 12 17:39:02 srv1 kernel: ata2.00: configured for UDMA/133
Aug 12 17:39:02 srv1 kernel: ata2: EH pending after completion, repeating EH (cnt=4)
Aug 12 17:39:02 srv1 kernel: ata2: EH complete
Aug 12 17:39:02 srv1 kernel:   Vendor: ATA       Model: ST3500630AS       Rev: 3.AA
Aug 12 17:39:02 srv1 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Aug 12 17:39:02 srv1 kernel: SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
Aug 12 17:39:02 srv1 kernel: sdc: Write Protect is off
Aug 12 17:39:02 srv1 kernel: SCSI device sdc: drive cache: write back
Aug 12 17:39:02 srv1 kernel: SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
Aug 12 17:39:02 srv1 kernel: sdc: Write Protect is off
Aug 12 17:39:02 srv1 kernel: SCSI device sdc: drive cache: write back
Aug 12 17:39:02 srv1 kernel:  sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 >
Aug 12 17:39:02 srv1 kernel: sd 1:0:0:0: Attached scsi disk sdc
Aug 12 17:39:02 srv1 kernel: sd 1:0:0:0: Attached scsi generic sg1 type 0
--------------080705030903040900020705--
