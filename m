From: Jeff Garzik <jeff@garzik.org>
Subject: Re: patch "libata-sff: Fix oops for pnp devices with no ctl" causes
 regression
Date: Thu, 05 Jun 2008 06:05:51 -0400
Message-ID: <4847BA7F.8070502@garzik.org>
References: <20080605050923.GD11811@wotan.suse.de> <20080605102424.0cf56c37@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40644 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065AbYFEKGB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jun 2008 06:06:01 -0400
In-Reply-To: <20080605102424.0cf56c37@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nick Piggin <npiggin@suse.de>, jgarzik@redhat.com, linux-ide@vger.kernel.org

Alan Cox wrote:
>> And when booting with the commit applied, I instead get a whole lot of
>> messages like this (this is the first one, copied by hand):
>>
>> ata2.00: exception Emask 0x0 SAct 0x0 Serr 0x10000000 action 0x6 frozen
>> ata2: SError: { }
>> ata2.00: cmd c8/00:02:42:08:20/00:00:00:00:00/e0 tag 0 dma 1024 in
>>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>> ata2.00: status: { DRDY }
>> ata2: hard resetting link
>> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata2.00: configured for UDMA/133
>> ata2: EH complete
> 
> Well I've been over the patch twice now and I cannot see a single point
> at which the sequence of code that *should* be executed is any different.
> 
> Stick wmb();rmb(); (or similar barriers to compiler optimisation and I/O
> fencing) at the start and end of your ata_sff_altstatus() and see what
> happens, if it suddenly decides to behave or forcing it no inline makes
> it behave then that would be useful info.

If he's getting a timeout, I wonder if that points to
ata_sff_irq_status() ...

