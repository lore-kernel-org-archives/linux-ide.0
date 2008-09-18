From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: NCQ on Promise SATA300 TX4
Date: Thu, 18 Sep 2008 09:45:33 +0200
Message-ID: <18642.1821.517076.200761@harpo.it.uu.se>
References: <1221687728.12558.12.camel@tim-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:55211 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468AbYIRHpn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Sep 2008 03:45:43 -0400
In-Reply-To: <1221687728.12558.12.camel@tim-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Besard <tim.besard@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tim Besard writes:
 > Hi,
 > 
 > I recently bough a Promise SATA300 TX4 controller, which I am using in
 > combination with an NCQ-capable harddrive. As the controller supports
 > NCQ [1], and the libata webpages seems to indicate [2] that the
 > sata_promise driver does as well, I am currently trying to enable NCQ
 > (kernel 2.6.27).
 > 
 > Without any luck however, my dmesg log indicates the following:
 > [    4.244047] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
 > [    4.253636] ata1.00: ATA-7: ST3500320AS, SD04, max UDMA/133
 > [    4.253639] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth
 > 0/32)
 > [    4.268850] ata1.00: configured for UDMA/133
 > 
 > And the NCQ queue depth flag seems read-only:
 > tim@tim-desktop:~$ sudo echo 31 > /sys/block/sdb/device/queue_depth
 > bash: /sys/block/sdb/device/queue_depth: Permission denied
 > 
 > The read-only nature of the queue_depth field seems to indicate that the
 > SATA module doesn't have NCQ support, but this contradicts with what I
 > read on the libata page.
 > 
 > Could you shed some light on this issue?

sata_promise does not support NCQ.

I've tried to make it support NCQ, but failed. It works for a
little while but then appears to lose completion interrupts,
and it doesn't recover from this state.

I hope to find some time to debug this further later this year.

/Mikael
