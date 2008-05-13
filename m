From: Mark Lord <liml@rtr.ca>
Subject: Port-Multiplier hotplug support: ATA_FLAG_AN
Date: Tue, 13 May 2008 18:50:41 -0400
Message-ID: <482A1B41.50507@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2420 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbYEMWun (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 May 2008 18:50:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun,

Apparently the newer (GenIIe) sata_mv chips *can* support asynchronous
notification without problems.  Some/all of the older ones cannot (errata).

So, I've done the one-liner change in sata_mv, to add ATA_FLAG_AN to
the 7042 and 6042 chips, and it all seems to work rather nicely.

Am I missing something?  Is there any other local code to sata_mv
that should be provided before setting ATA_FLAG_AN ?

Like I said, it works, but I just want to check whether any other
pieces are expected to be present? 

Cheers

Mark
