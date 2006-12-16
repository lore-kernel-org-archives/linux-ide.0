From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Slow SATA detection on bootup
Date: Sat, 16 Dec 2006 12:02:03 -0500
Message-ID: <4584268B.9040903@pobox.com>
References: <20061025114504.450b3425@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34939 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932494AbWLPRCH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Dec 2006 12:02:07 -0500
In-Reply-To: <20061025114504.450b3425@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-ide@vger.kernel.org

Stephen Hemminger wrote:
> This laptop has long timeouts during bootup.  Something is
> wrong. This is a Sony VAIO NG170. On a positive note suspend works.
> 
> Here is the console log during the 40 seconds of dead time.
> 
> [    2.942000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
> [    2.942000] ata1: SATA max UDMA/133 cmd 0x18B0 ctl 0x18A6 bmdma 0x1890 irq 225
> [    2.942000] ata2: SATA max UDMA/133 cmd 0x18A8 ctl 0x18A2 bmdma 0x1898 irq 225
> [    2.942000] scsi0 : ata_piix
> [    3.094000] ata1.00: ATA-7, max UDMA/100, 234441648 sectors: LBA48 NCQ (depth 0/32)
> [    3.094000] ata1.00: ata1: dev 0 multi count 16
> [    3.097000] ata1.00: configured for UDMA/100
> [    3.097000] scsi1 : ata_piix
> [   10.144000] ata2: port is slow to respond, please be patient
> [   33.104000] ata2: port failed to respond (30 secs)
> [   33.255000] ata2: SRST failed (status 0xFF)
> [   33.255000] ata2: SRST failed (err_mask=0x100)
> [   33.255000] ata2: softreset failed, retrying in 5 secs
> [   38.407000] ata2: SRST failed (status 0xFF)
> [   38.407000] ata2: SRST failed (err_mask=0x100)
> [   38.407000] ata2: softreset failed, retrying in 5 secs
> [   43.560000] ata2: SRST failed (status 0xFF)
> [   43.560000] ata2: SRST failed (err_mask=0x100)
> [   43.560000] ata2: reset failed, giving up
> [   43.560000]   Vendor: ATA       Model: FUJITSU MHV2120B  Rev: 0000
> [   43.561000]   Type:   Direct-Access                      ANSI SCSI revision: 05
> [   43.567000] SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)

ACK or NAK -- does 2.6.20-rc1 fix this?

	Jeff



