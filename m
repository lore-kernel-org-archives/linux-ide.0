From: Mark Lord <liml@rtr.ca>
Subject: Per ATA host sysfs attributes?
Date: Tue, 10 Mar 2009 16:12:11 -0400
Message-ID: <49B6C99B.9030507@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:49203 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754255AbZCJUMP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Mar 2009 16:12:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Guys,

I have added IRQ coalescing to sata_mv, but need a way to activate/tune it.
There are two simple parameters:  an IRQ count threshold, and a time threshold.

Whenever either the count or the time threshold is exceeded,
the chip will generate an interrupt (assuming at least one completed event).

These two parameters are per-chip (actually, per group of four ports within the chip).
How can I export these for setting/query withing sysfs ?

It is all rather easy to create per-SCSI-host attrs in sysfs,
but I don't see any obvious way to do it per-chip. 

Suggestions?

For now, I'm doing it with a module parameter,
but that's really rather stone-age in the sysfs era.

Thanks.
