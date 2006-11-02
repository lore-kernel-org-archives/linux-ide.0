From: Jeff Garzik <jeff@garzik.org>
Subject: Promise 20319 chipset specs opened
Date: Thu, 02 Nov 2006 00:12:26 -0500
Message-ID: <45497E3A.6060103@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:31909 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750888AbWKBFMa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Nov 2006 00:12:30 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>


Promise has given me permission to post hardware programming info for 
one of their chips (Linux driver: sata_promise), PDC20319.  This also 
marks the first open chipset for Promise (AFAIK), so let's give them a 
round of applause.

The PDC20319 is a reasonably representative example of the hardware 
programming interface covered by sata_promise.  Kernel developers 
wishing to work on sata_promise can study this doc, and deduce how the 
two-port PDC2037x chips work.

In addition to describing the "packet" format for ATA and ATAPI 
commands, this doc also describes how to use the chip's XOR RAID-assist 
features.  I think it would be cool if someone so motivated found a way 
to use this efficiently under Linux.

The doc:
	http://gkernel.sourceforge.net/specs/promise/pdc20319.pdf.bz2

I have also updated the list open chipsets and developer resources on 
linux-ata.org:
	http://linux-ata.org/driver-status.html#open_chipsets
	http://linux-ata.org/devel.html

Have fun!

	Jeff


