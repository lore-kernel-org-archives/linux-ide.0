From: "Laurent CORBES {Caf'} <caf@glot.net> (by way of Laurent CORBES {Caf'}"
	<caf@glot.net>
Subject: PROBLEM: ata_piix disk detection 2.6.18-rc5
Date: Mon, 28 Aug 2006 15:08:25 +0200
Message-ID: <20060828150825.7e32a8d2@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from republique.smartjog.net ([83.243.17.194]:29198 "EHLO
	mx.republique.smartjog.net") by vger.kernel.org with ESMTP
	id S1750793AbWH1NIu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Aug 2006 09:08:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx.republique.smartjog.net (Postfix) with ESMTP id 95B5DC02F
	for <linux-ide@vger.kernel.org>; Mon, 28 Aug 2006 15:08:25 +0200 (CEST)
Received: from mx.republique.smartjog.net ([127.0.0.1])
	by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 08358-02-8 for <linux-ide@vger.kernel.org>;
	Mon, 28 Aug 2006 15:08:25 +0200 (CEST)
Received: from localhost (lcorbes.republique.smartjog.lan [192.168.0.72])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx.republique.smartjog.net (Postfix) with ESMTP id 7D7E1C02D
	for <linux-ide@vger.kernel.org>; Mon, 28 Aug 2006 15:08:25 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, 

Not really a severe bug but it can hide other problems. I have a Dell
optiplex with a ICH5 chipset. When I load the ata_piix module and there
is no drive plugged in, the driver try to contact the Hdd and fail.

This was not a problem with 2.6.17.


Linux laurent 2.6.18-rc5 #1 SMP PREEMPT Mon Aug 28 14:19:16
CEST 2006 i686 GNU/Linux

libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 17
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 17
scsi1 : ata_piix
ata1: port is slow to respond, please be patient
ata1: port failed to respond (30 secs)
ata1: SRST failed (status 0xFF)
ata1: SRST failed (err_mask=0x100)
ata1: softreset failed, retrying in 5 secs
ata1: SRST failed (status 0xFF)
ata1: SRST failed (err_mask=0x100)
ata1: softreset failed, retrying in 5 secs
ata1: SRST failed (status 0xFF)
ata1: SRST failed (err_mask=0x100)
ata1: reset failed, giving up
scsi2 : ata_piix
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: reset failed, giving up

Thanks,
regards.
-- 
  http://glot.net/, caf@glot.net
  Cycom http://www.rezal.net/, Epidemic http://epidemic.glot.net/
