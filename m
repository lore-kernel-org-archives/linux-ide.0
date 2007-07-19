From: Stephen Clark <Stephen.Clark@seclark.us>
Subject: linux 2.6.22 ide regression
Date: Wed, 18 Jul 2007 20:18:07 -0400
Message-ID: <469EADBF.6090102@seclark.us>
Reply-To: Stephen.Clark@seclark.us
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpauth12.prod.mesa1.secureserver.net ([64.202.165.35]:53279
	"HELO smtpauth12.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1761379AbXGSASI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 20:18:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello List

My HP N5430 Laptop used to be udma/66 under the old ide driver. Is there 
a way
to get it back to that under the new drivers. The drive is plugged via a 
right angle
connector directly to the mother board - in otherwords there is no cable.

scsi0 : pata_ali
scsi1 : pata_ali
ata1: PATA max UDMA/66 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x00011000 irq 14
ata2: PATA max UDMA/66 cmd 0x00010170 ctl 0x00010376 bmdma 0x00011008 irq 15
ata1.00: ATA-5: HITACHI_DK23CA-20, 00H1A0A3, max UDMA/100
ata1.00: 39070080 sectors, multi 16: LBA
ata1.00: limited to UDMA/33 due to 40-wire cable
ata1.00: configured for UDMA/33

Any help would be appreciated.

Regards,
Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



