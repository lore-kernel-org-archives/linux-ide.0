From: Mark Lord <liml@rtr.ca>
Subject: Correct use of  ap->lock  versus  ap->host->lock ?
Date: Thu, 06 Mar 2008 10:48:02 -0500
Message-ID: <47D01232.1000106@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4220 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758656AbYCFPsE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Mar 2008 10:48:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff / Tejun / Alan,

I'm trying to sort out the spinlocks in sata_mv.

In some places, the existing code uses ap->lock.
But in others, notably the interrupt handling, it uses ap->host->lock.

This looks buggy to me, and I'm wondering how to make it bulletproof.

The interrupt handler for each port should really be using ap->lock, right?
But accesses to the host-level (shared among ports) interrupt registers
probably requires ap->host->lock.  Right again?

>From a libata core point of view, what does ap->host->lock protect?

???

Thanks
