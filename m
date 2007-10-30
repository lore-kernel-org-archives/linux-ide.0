From: Jeff Garzik <jeff@garzik.org>
Subject: Re: "Fix ATAPI transfer lengths" causes CD writing regression
Date: Tue, 30 Oct 2007 12:02:41 -0400
Message-ID: <472755A1.5080703@garzik.org>
References: <47274A5F.6070409@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34106 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958AbXJ3QCs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 12:02:48 -0400
In-Reply-To: <47274A5F.6070409@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Daniel Drake wrote:
> Hi Alan,
> 
> In 2.6.23 and previous, CD writing works fine on my system. I'm using 
> ata_piix on:
> 
> 00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) SATA 
> IDE Controller (rev 01)
> 
> When I'm running CD writing utilities, I sometimes see this message in 
> the kernel logs:
>     ata2.00: 66 bytes trailing data
> Things do work fine though.
> 
> With 2.6.24-rc1, I can't write CDs. Instead of the above message, I get:
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: cmd a0/00:00:00:0a:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 10 in
>          res 58/00:02:00:0a:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
> ata2.00: status: { DRDY DRQ }
> ata2: soft resetting link
> ata2.00: configured for UDMA/33
> ata2: EH complete
> 
> and the software acts oddly - for example Brasero tells me that the 
> blank CD I have inserted has a capacity of 17,179,869,184gb and it 
> doesn't let me write CDs as it says the medium is not writable.
> 
> git bisect lead me to commit 2db78dd302d26d242d3e8e5c4c5024b6c3ea93c2 as 
> the culprit.
> 
> Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Date:   Tue Oct 2 13:53:04 2007 -0700
> 
>     libata_scsi: Fix ATAPI transfer lengths
> 
>     Some controller variants snoop the ATAPI length value for Packet
>     transfers to do state machine and FIFO management. Thus we want to
>     set it properly, even for cases where it is otherwise meaningless.
> 
> Any ideas?

hrm

we may need to make that controller-specific, given that the code prior 
to 2db78dd302d26d242d3e8e5c4c5024b6c3ea93c2 was working for most...

	Jeff



