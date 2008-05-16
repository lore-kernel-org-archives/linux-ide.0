From: Mark Lord <liml@rtr.ca>
Subject: Port Multiplier drives not always all found on cold plug
Date: Fri, 16 May 2008 12:34:39 -0400
Message-ID: <482DB79F.2030204@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2274 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758741AbYEPQek (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 May 2008 12:34:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun,

Since enabling PMP support in sata_mv, there have been some recent
reports of not all drives being found on a PM.

I can reproduce this here myself, too:

(1) silicon image PM with four drives attached.
(2) power-down the PM.
(3) rmmod sata_mv ; modprobe sata_mv (latest upstream).
(4) plug (power off) PM into sata_mv card (7042 chipset).
(5) power on the PM.
(6) watch only 2-3 of the four drives get found.

If the PM was already powered on in advance, then all drives are found.
sata_mv relies entirely on libata-*.c for PMP resets/enumerations,
so I'm not sure that the problem is in sata_mv.

Any ideas?
