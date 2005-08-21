From: Jeff Garzik <jgarzik@pobox.com>
Subject: a word about ATA interrupts, and SATA (was Re: [PATCH libata-dev-2.6:upstream
 00/02] libata: race fixes)
Date: Sun, 21 Aug 2005 16:08:21 -0400
Message-ID: <4308DF35.4070503@pobox.com>
References: <20050820141408.62050C34@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:60105 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751103AbVHUVMP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 17:12:15 -0400
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7LKBb4E006562
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 13:11:38 -0700
In-Reply-To: <20050820141408.62050C34@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>
Cc: albertcc@tw.ibm.com

BTW, here is food for thought:

In first generation SATA controllers, the host controller silicon 
emulates a set of PATA taskfile registers.  When you follow the ATA 
command protocols (host state machines), handling ATA commands in the 
specified manner, the host controller silicon is processing that stuff 
behind your back, silently converting your actions into other actions:

* storing data in a H2D Register FIS buffer, for eventually sending to 
the device
* storing data received from a D2H Register FIS or SDB FIS into the host 
controller taskfile registers.
* handling PIO Setup and Data FISes, for PIO data xfer and PACKET 
command protocol
* handling FIS's associated with DMA data transfer

I've never seen any documentation for any host controller, that 
describes how the emulation is implemented in silicon.  Probably nobody 
outside of the original VHDL designers for each chip know that.  All we 
know, we must figure out from inference:  we pretend a host chip is 
PATA, and the host chip turns our actions into a SATA FIS conversion.

Because of this, we can discern several unique SATA quirks:
(a) writing most ATA registers simply involves storing a data value into 
a buffer on the host controller
(b) writing to Device Control or Command registers causes a H2D Register 
FIS to be sent.
(c) [most important to this thread] the ATA INTRQ is signalled by 
setting the 'I' bit in certain FIS's.  It is no longer a pure indication 
of the INTRQ signal, as it was in PATA.

Due to the ramifications of (c), polling in general is possible but not 
the best idea.  libata currently uses polling for the IDENTIFY DEVICE 
command, and I have long been thinking about turning off polling for 
SATA controllers.  Some SATA controllers, such as Vitesse/Intel, simply 
do not support the ATA nIEN bit.  It is emulated in the driver.  Other 
controllers may not honor the nIEN bit correctly (due to bad emulation 
logic in silicon, probably).

Just factor this info into your decisions, when playing around with the 
interrupt delivery code.

	Jeff



