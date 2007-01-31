From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] libata: dump full ATA firmware revision to dmesg
Date: Tue, 30 Jan 2007 19:43:08 -0500
Message-ID: <45BFE61C.4050209@garzik.org>
References: <311601c90701301221o4cee44cat34547cf8891189ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52060 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932101AbXAaAnK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Jan 2007 19:43:10 -0500
In-Reply-To: <311601c90701301221o4cee44cat34547cf8891189ed@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Eric D. Mudama wrote:
> SCSI only supports a 4-character firmware revision string, while ATA
> uses 8 characters.  Since it can be useful for debugging drive/host
> issues, and because not everyone has a working hdparm on their system,
> dump the full ATA firmware revision into dmesg at drive detection.
> Only affects ATA devices connected via libata, and not ATAPI (since
> they likely use SCSI conventions anyway).
> 
> Sample output from my dmesg:
> 
> ata1.00: ATA-7, max UDMA/133, 488395055 sectors: LBA48 NCQ (depth 0/32)
> ata1.00: ata1: dev 0 multi count 16
> ata1.00: ata1: Firmware Revision: 3.AAC
> ata1.00: configured for UDMA/133
> ata2.00: ATA-7, max UDMA/133, 195813072 sectors: LBA48 NCQ (depth 0/32)
> ata2.00: ata2: dev 0 multi count 16
> ata2.00: ata2: Firmware Revision: VA111910
> ata2.00: configured for UDMA/133
> scsi 0:0:0:0: Direct-Access     ATA      ST3250820AS      3.AA PQ: 0 
> ANSI: 5
> scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6V100E0   VA11 PQ: 0 
> ANSI: 5
> 
> Signed-off-by: Eric D. Mudama <edmudama@gmail.com>

hmmmm.  While I agree that exposing the full firmware rev is a good 
thing to do, I'm a bit embarrassed as it is about libata's dmesg spam, 
and I try to resist increasing it.  As such, I think that firmware rev 
on a line all by itself is a bit "greedy" by those standards.

Additionally -- and this is not your fault since the previous line is 
the same -- the "ata2.00: ata2: [dev 0]" is redundant.  The "ata2.00" is 
all we really need to know which bus and device we're referring to.

I would rather revamp things to look something like

	...
	ata2.00: ATA-7, Maxtor 6V100E0, VA111910, max UDMA/133
	ata2.00: 195813072 sectors, multi 16, LBA48 NCQ (depth 0/32)
	...

I realize that's more work than just a simple addition, alas...

Regards,

	Jeff


