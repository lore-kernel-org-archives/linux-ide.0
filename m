From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [Linux 2.6.21.3] CDRW drive not recognised by PATA (ata_piix)
Date: Sun, 03 Jun 2007 10:23:16 -0400
Message-ID: <4662CED4.1000506@garzik.org>
References: <336034.8278.qm@web52901.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37813 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbXFCOXT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Jun 2007 10:23:19 -0400
In-Reply-To: <336034.8278.qm@web52901.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Chris Rankin wrote:
> Hi,
> 
> I have tried replacing the old IDE layer on my dual P4 machine with the PATA driver instead, but
> the CDRW drive on the second IDE bus (the old /dev/hdd drive) is never recognised:
> 
> ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ffa0 irq 14
> ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ffa8 irq 15
> scsi0 : ata_piix
> ata1.00: ATA-6: IC35L090AVV207-0, V23OA66A, max UDMA/100
> ata1.00: 156250000 sectors, multi 8: LBA48 
> ata1.00: configured for UDMA/100
> scsi1 : ata_piix
> ata2.00: ATAPI, max UDMA/33
> ata2.01: ATAPI, max UDMA/33
> ata2.00: configured for UDMA/33
> ata2.01: qc timeout (cmd 0xef)
> ata2.01: failed to set xfermode (err_mask=0x4)

Grab the 'always use polling SETXFER' patch...

	Jeff



