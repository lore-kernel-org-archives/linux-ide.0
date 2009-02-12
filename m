From: Mark Lord <liml@rtr.ca>
Subject: EXPORT_SYMBOL_GPL(ata_pio_sectors) ?
Date: Thu, 12 Feb 2009 16:31:27 -0500
Message-ID: <4994952F.9080006@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:47392 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbZBLVba (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Feb 2009 16:31:30 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun / Jeff,

Any objections if I EXPORT ata_pio_sectors() for use from sata_mv.c ?
The code there is complex enough that I'd rather not duplicate it.

It will be needed for an errata workaround that's being worked on,
and I'll post a patch for it along with the errata patch once it
is ready.

Thanks
