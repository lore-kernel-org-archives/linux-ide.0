From: Jan <M.Lutzer@gmx.de>
Subject: Sil 3112A + Seagate Barracuda NCQ 300GB = freeze
Date: Sat, 21 May 2005 12:09:28 +0200
Message-ID: <428F08D8.8030306@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:46282 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261720AbVEUKJ3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 May 2005 06:09:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello!
I bought a new Seagate Barracuda SATA harddisk with NCQ and a capacity
of 300GB. I attached it to my Sil 3112A Controller but Linux freezes
while booting. I am using this controller with a Seagate Barracuda 150GB
without problems for a long time. Note that the new problematic harddisk
is the second SATA harddisk (ata2 ?)connected to the controller. I had
written the error messages to a paper and typed in again.

ata1(0): applying Seagate errate fix
ata1: dev 0 configured for UDMA/100
scsi0: sata_sil
irq10: nobody cared
    [<c013645a>] __report_bad_irq +0x2a/0xa0
    ... a lot of messages starting with a number like [<c013645a>] ...
Disabling IRQ #10

My kernel version is 2.6.11-ck. I tried also the Silicon Image IDE
driver (different to sata_sil) with a similar result.

Any idea what to do? Thanks alot! Jan
