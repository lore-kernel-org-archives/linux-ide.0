From: Jean Delvare <khali@linux-fr.org>
Subject: ATA standard vs. speed
Date: Sun, 4 Mar 2012 14:48:06 +0100
Message-ID: <20120304144806.4bef0256@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:33877 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398Ab2CDOIn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Mar 2012 09:08:43 -0500
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=endymion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1S4BnH-0001oX-Kl
	(TLSv1:AES128-SHA:128)
	(envelope-from <khali@linux-fr.org>)
	for linux-ide@vger.kernel.org; Sun, 04 Mar 2012 14:48:11 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

After reading
http://en.wikipedia.org/wiki/Parallel_ATA#Features_introduced_with_each_ATA_revision
it seemed clear to me that there was a direct relation between the
operating speed of a (P)ATA hard disk drive and the version of the ATA
standard it implemented. However I see the following in my kernel logs
on an old machine (kernel 2.6.34, Intel ICH5 controller):

ata1: PATA max UDMA/100 cmd 0xeff0 ctl 0xefe4 bmdma 0xef90 irq 18
ata2: PATA max UDMA/100 cmd 0xefa8 ctl 0xefe0 bmdma 0xef98 irq 18
ata2.00: HPA unlocked: 40018511 -> 40020624, native 40020624
ata2.00: ATA-6: Maxtor 52049H4, DAC10SC0, max UDMA/100
ata2.00: 40020624 sectors, multi 16: LBA 
ata1.00: HPA unlocked: 78175679 -> 78177792, native 78177792
ata1.00: ATA-5: MAXTOR 6L040J2, A93.0300, max UDMA/133
ata1.00: 78177792 sectors, multi 16: LBA 

While the second disk matches the wikipedia table (ATA-6 introduced
UDMA/100), the first one doesn't: UDMA/133 wasn't supposed to exist in
standard ATA-5.

Digging old logs, I also found this (same machine, same kernel,
different drive):

ata2.00: ATA-4: WDC WD102AA, 05.05B05, max UDMA/66

Here again, UDMA/66 wasn't supposed to exist in standard ATA-4.

Can anyone explain this mystery to me?

Thanks,
-- 
Jean Delvare
