From: "Anssi Hannula" <anssi.hannula@iki.fi>
Subject: FLUSH CACHE EXT timeouts with ST31500341AS
Date: Tue, 13 Apr 2010 09:09:58 +0300
Message-ID: <1a212f77bc5e0507a0d7186ccf389dc6.squirrel@mail.onse.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sypressi.dnainternet.net ([83.102.40.135]:43189 "EHLO
	sypressi.dnainternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab0DMGTG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Apr 2010 02:19:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by sypressi.dnainternet.net (Postfix) with ESMTP id 115E2A4885
	for <linux-ide@vger.kernel.org>; Tue, 13 Apr 2010 09:09:59 +0300 (EEST)
Received: from sypressi.dnainternet.net ([83.102.40.135])
	by localhost (sypressi.dnainternet.net [127.0.0.1]) (amavisd-new, port 10041)
	with ESMTP id GLao-ey-eShO for <linux-ide@vger.kernel.org>;
	Tue, 13 Apr 2010 09:09:58 +0300 (EEST)
Received: from oliivipuu.dnainternet.net (oliivipuu.dnainternet.net [83.102.40.215])
	by sypressi.dnainternet.net (Postfix) with ESMTP id E5B85A48BE
	for <linux-ide@vger.kernel.org>; Tue, 13 Apr 2010 09:09:58 +0300 (EEST)
Received: from mail.onse.fi (unknown [109.204.162.131])
	by oliivipuu.dnainternet.net (Postfix) with ESMTP id DD94D7F33A
	for <linux-ide@vger.kernel.org>; Tue, 13 Apr 2010 09:09:58 +0300 (EEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm continously getting the following error with a Seagate ST31500341AS
when under load:

ata17.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata17.00: failed command: FLUSH CACHE EXT
ata17.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata17.00: status: { DRDY }
ata17: hard resetting link
ata17: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata17.00: configured for UDMA/100
ata17.00: retrying FLUSH 0xea Emask 0x4
ata17.00: device reported invalid CHS sector 0
ata17: EH complete

Reading [1] it seems that this is a known issue with this firmware when
NCQ is enabled, and kernel disables NCQ automatically due to this.
However, I'm experiencing the issue despite this. This is on kernel
2.6.33.1.

NCQ seems to be correctly disabled:
# cat /sys/block/sdo/device/queue_depth
1

It seems likely to me that the firmware issue is therefore not limited to
NCQ. Or do you think this might be caused by something else? Do you need
any more information?

In the meantime, I'll try to contact Seagate support to see if they have a
firmware update for my drive.

[1]
https://ata.wiki.kernel.org/index.php/Known_issues#Seagate_harddrives_which_time_out_FLUSH_CACHE_when_NCQ_is_being_used

-- 
Anssi Hannula
