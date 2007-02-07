From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [QUESTION] ATA: abnormal status 0x80 on port 0xCC07
Date: Tue, 06 Feb 2007 22:23:37 -0500
Message-ID: <45C94639.9020509@garzik.org>
References: <6bffcb0e0702031044v601e4fc3icf859544af292789@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57974 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965620AbXBGDXk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Feb 2007 22:23:40 -0500
In-Reply-To: <6bffcb0e0702031044v601e4fc3icf859544af292789@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Michal Piotrowski wrote:
> Hi Jeff,
> 
> What does this mean?
> 
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd c8/00:08:67:40:68/00:00:00:00:00/e3 tag 0 cdb 0x0 data 4096 in
>         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1: soft resetting port
> ata1.00: configured for UDMA/133
> ata1: EH complete
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd c8/00:00:c3:52:43/00:00:00:00:00/ea tag 0 cdb 0x0 data 
> 131072 in
>         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1: soft resetting port
> ata1.00: configured for UDMA/133
> ata1: EH complete
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd c8/00:00:c3:52:43/00:00:00:00:00/ea tag 0 cdb 0x0 data 
> 131072 in
>         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1: soft resetting port
> ata1.00: configured for UDMA/133
> ata1: EH complete
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
> support DPO
> or FUA
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't 

timeouts usually mean that an interrupt was not delivered, when the 
driver was expecting one.

All the usual suspects apply: this could be a system hardware problem 
(check cables and PSU), heat problem, BIOS or ACPI problem, hard drive 
failure, or ATA driver problem.

	Jeff



