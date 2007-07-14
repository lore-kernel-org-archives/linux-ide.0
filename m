From: jm_928 <jm_928@jmtechnology.com>
Subject: sata_inic162x issue - PCMCIA card
Date: Sat, 14 Jul 2007 06:41:14 -0700 (PDT)
Message-ID: <11593734.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kuber.nabble.com ([216.139.236.158]:57841 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbXGNNlP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jul 2007 09:41:15 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1I9hs2-00026P-En
	for linux-ide@vger.kernel.org; Sat, 14 Jul 2007 06:41:14 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi,

I have an esata PCMCIA card based on the Initio 1620 chipset. When inserting
this into my Dell D600 laptop (running Ubuntu 7.04 with the 2.6.20-16
kernel) I get the following error messages:

[   27.660000] sata_inic162x 0000:03:00.0: version 0.1
[   27.660000] PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
[   27.660000] ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKD] -> GSI 11
(level, low) -> IRQ 11
[   27.660000] ACPI: PCI interrupt for device 0000:03:00.0 disabled
[   27.660000] sata_inic162x: probe of 0000:03:00.0 failed with error -22

Does anyone have any hints on what this message (particularly error -22)
means?

Thanks.
JM
-- 
View this message in context: http://www.nabble.com/sata_inic162x-issue---PCMCIA-card-tf4079060.html#a11593734
Sent from the linux-ide mailing list archive at Nabble.com.

