From: Mark Lord <liml@rtr.ca>
Subject: libata+SGIO:  is .dma_boundary respected?
Date: Sun, 19 Mar 2006 15:48:23 -0500
Message-ID: <441DC397.9040504@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:53395 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750921AbWCSUs2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Mar 2006 15:48:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jens / Jeff,

Each libata driver registers a .dma_boundary field with SCSI.
This field is used to prevent merging of bio segments across
a hardware limitation boundary, usually 0xffff.

This looks like it works for regular block I/O,
but I'm not so sure about SGIO originated requests.

Any thoughts, or code you can point me to?

Thanks

Mark
