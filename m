From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: rtc lost interrupts during ata errors
Date: Fri, 25 Nov 2005 00:25:15 +1100
Message-ID: <4385BF3B.80109@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ihug-mail.icp-qv1-irony3.iinet.net.au ([203.59.1.197]:8613 "EHLO
	mail-ihug.icp-qv1-irony3.iinet.net.au") by vger.kernel.org with ESMTP
	id S1750856AbVKXNZT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Nov 2005 08:25:19 -0500
Received: from [192.168.3.7] (e7.eyal.emu.id.au [192.168.3.7])
	by e4.eyal.emu.id.au (8.11.6/8.11.6) with ESMTP id jAODPFP11297
	for <linux-ide@vger.kernel.org>; Fri, 25 Nov 2005 00:25:15 +1100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: list linux-ide <linux-ide@vger.kernel.org>

Is something blocking interrupts for too long?

This is a sata sil3112 based card that produces these errors (seems
harmless at the moment) and for each error there is rtc interrupt
loss reported.

vanilla 2.6.14.2.

[4570544.453000] ata3: status=0x51 { DriveReady SeekComplete Error }
[4570544.453000] ata3: error=0x04 { DriveStatusError }
[4570544.489000] rtc: lost some interrupts at 1024Hz.


BTW, is there any progress with the sata_sil support? Should I
try 2.6.15-rc2?

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
