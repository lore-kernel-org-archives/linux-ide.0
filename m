From: Lieven Marchand <mal@wyrd.be>
Subject: regression problem with Maxtor disk
Date: Sun, 12 Aug 2007 16:14:06 +0200
Message-ID: <87tzr4zvpt.fsf@wyrd.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213.219.169.154.adsl.dyn.edpnet.net ([213.219.169.154]:52679
	"EHLO black" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752665AbXHLO6A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Aug 2007 10:58:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi,

the following drive 

Aug 12 12:26:15 black kernel:   Vendor: ATA       Model: Maxtor 7H500F0    Rev:
HA43
Aug 12 12:26:15 black kernel:   Type:   Direct-Access                      ANSI
SCSI revision: 05

works fine under 2.6.18 and crashes the boot procedure under
2.6.22. Occasionally the boot continues but most of the times the
kernel crashes with an error message of a corrupt cpu context.

I've added the logs of a succesful boot here. When such a boot
succeeds, the system is noticeably slower than under 2.6.18.

Aug 11 10:27:51 black kernel: scsi 4:0:0:0: Direct-Access     ATA      Maxtor 7H
500F0   HA43 PQ: 0 ANSI: 5
Aug 11 10:27:51 black kernel: ata2: bounce limit 0xFFFFFFFFFFFFFFFF, segment bou
ndary 0xFFFFFFFF, hw segs 61
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x440
Aug 11 10:27:51 black kernel:          res 51/04:00:00:00:00/04:00:00:00:00/40 E
mask 0x1 (device error)
Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
Aug 11 10:27:51 black kernel: ata2: EH complete

Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x440
Aug 11 10:27:51 black kernel:          res 51/04:00:00:00:00/04:00:00:00:00/40 E
mask 0x1 (device error)
Aug 11 10:27:51 black last message repeated 2 times
Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
Aug 11 10:27:51 black kernel: ata2: EH complete
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY clear and ID
LE, stat=0x440
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x400
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY, stat=0x400
Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/04:00:00:00:00/40 E
mask 0x4 (timeout)
Aug 11 10:27:51 black last message repeated 2 times
Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 E
mask 0x4 (timeout)
Aug 11 10:27:51 black kernel: ata2: soft resetting port
Aug 11 10:27:51 black kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl
300)
Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
Aug 11 10:27:51 black kernel: ata2: EH complete
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY clear and ID
LE, stat=0x400
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x400
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY, stat=0x400
Aug 11 10:27:51 black kernel: ata2.00: NCQ disabled due to excessive errors
Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/04:00:00:00:00/40 E
mask 0x4 (timeout)
Aug 11 10:27:51 black last message repeated 2 times
Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 E
mask 0x4 (timeout)
Aug 11 10:27:51 black kernel: ata2: soft resetting port
Aug 11 10:27:51 black kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl
300)
Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
Aug 11 10:27:51 black kernel: ata2: EH complete
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY clear and ID
LE, stat=0x400
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x400
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY, stat=0x400
Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/04:00:00:00:00/40 E
mask 0x4 (timeout)
Aug 11 10:27:51 black kernel: ata2: soft resetting port
Aug 11 10:27:51 black kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl
300)
Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
Aug 11 10:27:51 black kernel: ata2: EH complete
