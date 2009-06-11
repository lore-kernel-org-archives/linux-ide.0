From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: SATA: link online but device misclassified
Date: Thu, 11 Jun 2009 19:01:12 +0000
Message-ID: <1244746872.3998.88.camel@mulgrave.site>
References: <cfa4e840906101715r56b643f4tab58e1c859d119ba@mail.gmail.com>
	 <4A308798.6060803@gmail.com>
	 <cfa4e840906110231u4e90eb22wbeb2d4e748c5624a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42108 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759461AbZFKTBP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jun 2009 15:01:15 -0400
In-Reply-To: <cfa4e840906110231u4e90eb22wbeb2d4e748c5624a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bowes <marcbowes@gmail.com>
Cc: linux-ide@vger.kernel.org

On Thu, 2009-06-11 at 11:31 +0200, Marc Bowes wrote:
> I'm not sure if you can attach files, but here goes (attached as dmesg.txt)

Actually, this shows the problems are on two unoccupied ahci ports:


> [    0.685269] ahci 0000:0a:00.0: version 3.0
> [    0.685279] ahci 0000:0a:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> [    0.696040] ahci 0000:0a:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
> [    0.696283] ahci 0000:0a:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
> [    0.696453] ahci 0000:0a:00.0: setting latency timer to 64
> [    0.696592] scsi0 : ahci
> [    0.696907] scsi1 : ahci
> [    0.697224] ata1: SATA max UDMA/133 abar m8192@0xec400000 port 0xec400100 irq 16
> [    0.697461] ata2: SATA max UDMA/133 abar m8192@0xec400000 port 0xec400180 irq 16
> [    6.969039] ata1: link is slow to respond, please be patient (ready=0)
> [   10.743038] ata1: softreset failed (device not ready)
> [   10.743191] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   10.743344] ata1: link online but device misclassified, retrying
> [   17.015051] ata1: link is slow to respond, please be patient (ready=0)
> [   20.789041] ata1: softreset failed (device not ready)
...

Could you confirm that there are actually no devices it's supposed to be
detecting?

It looks like the AHCI controller at 00:0a:00.0 might be some form of
piix controller in the ICH10 bridge ... does lspci confirm this?  I
remember you said you had:

> The ATA controllers: Intel Corporation 82801JI (ICH10 Family) 2 port
> SATA IDE Controller.

Yet the log is finding six ports: four on the piix and two on the
problem ahci  .. is that right?

James


