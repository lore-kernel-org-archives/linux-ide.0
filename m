From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA ATAPI work in progress
Date: Thu, 13 May 2004 16:56:25 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A3E0F9.7030507@pobox.com>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>	<1084403654.3196.31.camel@patibmrh9> <1084460833.5303.45.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26301 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264737AbUEMU4j
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 May 2004 16:56:39 -0400
In-Reply-To: <1084460833.5303.45.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> I'll first try keeping only the ata_exec_command_pio of
> ata_bmdma_start_pio.

A bit busy today, I'll ponder a bit and respond to your previous mail.


> I'm thinking we want the bus mastering DMA set up to reliably catch the
> rising edge of a potentially rapid device INTRQ before we write the last
> "word" of Command Out.

Your basic statement is correct, but remember in the new world of SATA 
FIS's, you must concentrate on when the HBA transmits the H2D Register 
FIS (command FIS) to the device, and when the device responds in some 
manner (either with DMA setup and Data FIS conversations, for which the 
DMA engine must be armed, or with an error via D2H Register FIS)

An interrupt will not be asserted until the command FIS has been sent, 
and some sort of response is received from the device.

Further, and perhaps more importantly, everything is inside 
spin_lock_irqsave(), so interrupts will be handled after the lock is 
released.

	Jeff



