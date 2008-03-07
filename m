From: LCID Fire <lcid-fire@gmx.net>
Subject: Frequent ATA errors
Date: Fri, 07 Mar 2008 20:49:22 +0100
Message-ID: <47D19C42.60301@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:60942 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757070AbYCGTtZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Mar 2008 14:49:25 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi.
I have a big problem. Since 2.6.22 I keep getting ata errors. Most of
the time my computer (Intel P965 Chipset) ran fine - but then suddenly
it began to stutter - the mouse was only moving very little and all
input was lagged like hell. The only chance to get rid of this is to
restart.
It has continued to my current 2.6.24. In between there were times
(kernel revisions) when it was better - meaning the error did only occur
every few days or so. With the current 2.6.24 I have it almost every
hour - I restarted my computer 10 times today alone. The errors look
like the following:

[27536.340215] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
[27536.340225] ata9.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[27536.340226]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
[27536.340228]          res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask
0x4 (timeout)
[27536.340231] ata9.00: status: { DRDY }
[27536.340250] ata9: soft resetting link
[27536.996008] ata9.00: configured for PIO0
[27537.159874] ata9.01: configured for UDMA/25
[27537.159885] ata9: EH complete

or

[ 1001.987309] ata9.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
[ 1001.987319] ata9.01: cmd a0/00:00:00:00:00/00:00:00:00:00/b0 tag 0
[ 1001.987320]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
[ 1001.987322]          res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask
0x4 (timeout)
[ 1001.987325] ata9.01: status: { DRDY }
[ 1001.987343] ata9: soft resetting link
[ 1002.643096] ata9.00: configured for UDMA/25
[ 1002.806958] ata9.01: configured for UDMA/33
[ 1002.806967] ata9: EH complete

Does anybody have a clue what is wrong here? It seems to me that it has
a problem with the ide channel since I cannot remember it ever saying
anything about any UDMA/100+ drives.

Regards
Andreas
