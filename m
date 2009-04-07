From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata errors
Date: Tue, 07 Apr 2009 17:41:29 -0400
Message-ID: <49DBC889.3080304@pobox.com>
References: <4b215b9d0904071340w16a65b5bs64f6161b6042b4f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44428 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761682AbZDGVle (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Apr 2009 17:41:34 -0400
In-Reply-To: <4b215b9d0904071340w16a65b5bs64f6161b6042b4f1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Grice <mcjgrice@gmail.com>
Cc: linux-ide@vger.kernel.org

Matt Grice wrote:
> Dear Mr Garzik,
> 
> I am currently having trouble with the new libata kernel subsystem (My
> system broke after 2.6.21 I believe). After much fruitless googling
> and trawling through the libata code (I am *no* kernel programmer!) I
> took the serious, final step of bugging you.
> 
> Ten or so minutes after boot (long enough for my two IDE Sony DW-G120A
> DVD writers to spin down) I start getting these error messages in my
> kernel logs:
> 
> [ 6317.817041] ata4.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> [ 6317.817057] ata4.01: cmd a0/00:00:00:08:00/00:00:00:00:00/b0 tag 0
> pio 16392 in
> [ 6317.817058]          cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
> [ 6317.817059]          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask
> 0x4 (timeout)
> [ 6317.817064] ata4.01: status: { DRDY }
> [ 6317.817087] ata4: soft resetting link
> [ 6318.221356] ata4.00: configured for PIO0
> [ 6318.253533] ata4.01: configured for PIO0
> [ 6318.253567] ata4: EH complete
> [ 6335.817039] ata4.00: qc timeout (cmd 0xa0)
> [ 6335.817059] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> [ 6335.817069] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
> [ 6335.817070]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> [ 6335.817071]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask
> 0x5 (timeout)
> 
> ad nauseam.
> 
> (I am running kernel 2.6.27-11, amd64. I have also tried 2.6.29, and
> the messages are the same)

What type of system hardware?  What libata driver?

If its ahci, try using ata_piix.  I am beginning to think that ATAPI on 
AHCI is broken.

Otherwise, "timeout" generally means your hardware stopped sending 
interrupts, which could indicate a non-libata problem.  Timeouts are 
often symptoms of broken PCI MSI interrupts, for examples.

	Jeff



