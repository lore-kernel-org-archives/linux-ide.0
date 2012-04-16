From: "=?gb2312?B?zO/WvtbZ?=" <tzz@bstar.com.cn>
Subject: Seagate SATA disk flush cache timeout issue
Date: Mon, 16 Apr 2012 10:31:45 +0800
Message-ID: <201204161031454684853@bstar.com.cn>
References: <201204131039173121876@rd.bstar.com.cn>,
 <201204131039534213981@rd.bstar.com.cn>,
 <201204131053446718483@bstar.com.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpcom.263xmail.com ([211.150.64.24]:46734 "EHLO
	smtpcom.263xmail.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752748Ab2DPCbC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Apr 2012 22:31:02 -0400
Received: from smtpcom.263xmail.com (localhost.localdomain [127.0.0.1])
	by smtpcom.263xmail.com (Postfix) with ESMTP id D9AAFC9F6D
	for <linux-ide@vger.kernel.org>; Mon, 16 Apr 2012 10:30:54 +0800 (CST)
Received: from TIANZHIZHONG (localhost.localdomain [127.0.0.1])
	by smtpcom.263xmail.com (Postfix) with ESMTP id A7B514BF2
	for <linux-ide@vger.kernel.org>; Mon, 16 Apr 2012 10:30:53 +0800 (CST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>

Hi,

I'm working on an embedded linux DVR product and its kernel is based on 2.6.24. During recent testing I found several SATA disk IO errors while read/write disks for long time, e.g. about 24 hours. 

I find three kinds of Seagate SATA disk have such problem. They are 
ST2000DL003 (Barracuda Green / 2TB   / 5900rpm / 64M cache  / 4KB per sector)
ST500DM002  (Barracuda Green / 500G / 7200rpm / 16M cache  / 4KB per sector)
ST1000526SV (SV35 series       / 1TB   / 7200rpm / 32M cache  / 512B per sector).

The kernel output is alike below.
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         res 40/00:01:09:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata4.00: status: { DRDY }
ata4: port is slow to respond, please be patient (Status 0xd0)
ata4: device not ready (errno=-16), forcing hardreset
ata4: hard resetting link
ata4: port is slow to respond, please be patient (Status 0xff)
ata4: COMRESET failed (errno=-16)
ata4: hard resetting link
ata4: port is slow to respond, please be patient (Status 0xff)
ata4: COMRESET failed (errno=-16)
ata4: hard resetting link
ata4: port is slow to respond, please be patient (Status 0xff)
ata4: COMRESET failed (errno=-16)
ata4: hard resetting link
ata4: COMRESET failed (errno=-16)
ata4: reset failed, giving up
ata4.00: disabled
ata4: EH complete

I analyzed the kernel output and got its reason is ATA_CMD_FLUSH_EXT command timeout.
I tried adding SCSI flush cache command timeout to 120 seconds and retrying 5 times when the command is timed out, the symptom was still happened.
I tried adding ATA_CMD_FLUSH_EXT timeout to 120 seconds becuase of the specification of ATA8, the symptom was still happened. 

There is a very strange symptom that is before the failed ATA_CMD_FLUSH_EXT(cmd ea) command, the last command must be ATA_CMD_VERIFY(cmd 40).
In most kernel outputs, the sector LBAs that ATA_CMD_VERIFY accessed are in a very narrow range (from 0xC24F00 to 0xC24F09), even for different disk modles, such as ST2000DL003 and ST1000526SV.

I also found same symptom in debian buglist http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=625922

Can you give me some suggestion on this issue?

Thanks.

Tony Tian

2012-04-16 


tzz@bstar.com.cn

