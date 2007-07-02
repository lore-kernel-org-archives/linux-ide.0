From: Jeff Garzik <jeff@garzik.org>
Subject: [info] What's in Jeff's libata-dev inbox?
Date: Mon, 02 Jul 2007 12:42:23 -0400
Message-ID: <46892AEF.8@garzik.org>
References: <20070702151639.GA10948@havoc.gtf.org> <20070702165327.2646a761@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52968 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754828AbXGBQm2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 12:42:28 -0400
In-Reply-To: <20070702165327.2646a761@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>, Albert Lee <albertcc@tw.ibm.com>, Tejun Heo <htejun@gmail.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mikael Pettersson <mikpe@it.uu.se>

>> I have patches from Alan (pata_sis FIFO whack, pata_dma option), Tejun,
>> Albert and Kristen still to be reviewed.  Will get to those on Friday,
>> after the July 4th US holiday.tions(-)

Just to be more specific, my to-review inbox contains:

Alan: pata_sis FIFO whack, pata_dma option

Tejun: PMP patchbomb

Albert: irq_on/off restructure, irq-driven PIO to wq, minor PIO fixes

Kristen: ALPM

Mikael: sata_promise cleanup and hotplug

via akpm: HPA cleanup, cancel-rearming-wq cleanup

A few one-liner patches from Florian A, Boaz H, Christian L, Sonic Z, 
Jose A R.


NOTE to Kristen:  I am OK with your SATA async notification patches, as 
stated a while ago, but I think Andrew Morton had a better plan for 
merging that, so it's not in my queue.


Anything not on this list should be resent, I don't have it.

	Jeff


