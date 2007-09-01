From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: ATA_PIIX - soft resetting port, port is slow to respond, machine
 "freezes" for a few seconds
Date: Sat, 01 Sep 2007 13:23:39 +0200
Message-ID: <46D94BBB.9080403@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:45612 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbXIALXt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Sep 2007 07:23:49 -0400
Received: from postfix1.syneticon.net (postfix1.syneticon.net [192.168.112.6])
	by mail2.syneticon.net (Postfix) with ESMTP id 5FD9B5C7F3
	for <linux-ide@vger.kernel.org>; Sat,  1 Sep 2007 13:23:44 +0200 (CEST)
Received: from localhost (filter1.syneticon.net [192.168.113.3])
	by postfix1.syneticon.net (Postfix) with ESMTP id 9562394E3
	for <linux-ide@vger.kernel.org>; Sat,  1 Sep 2007 13:23:43 +0200 (CEST)
Received: from postfix1.syneticon.net ([192.168.113.4])
	by localhost (mx03.syneticon.net [192.168.113.3]) (amavisd-new, port 10025)
	with ESMTP id tVJ5W6FkDJ7M for <linux-ide@vger.kernel.org>;
	Sat,  1 Sep 2007 13:23:41 +0200 (CEST)
Received: from [192.168.10.145] (xdsl-87-78-207-62.netcologne.de [87.78.207.62])
	by postfix1.syneticon.net (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Sat,  1 Sep 2007 13:23:40 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>

I just upgraded from 2.6.18 distributed with Debian to 2.6.22.6.

I compiled ATA_PIIX directly in the kernel.

 From time to time, the machine "freezes" for a couple of seconds, and 
I'm getting the following logs (pasted below).

I didn't have anything like that with the old IDE.

The machine runs a 2 GB Transcend IDE flash disk.

Any ideas what it might be?


ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd ca/00:10:47:64:1d/00:00:00:00:00/e0 tag 0 cdb 0x0 data 8192 out
res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: device not ready (errno=-16), forcing hardreset
ata1: soft resetting port
ata1.00: configured for MWDMA2
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd ca/00:10:47:64:1d/00:00:00:00:00/e0 tag 0 cdb 0x0 data 8192 out
res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: device not ready (errno=-16), forcing hardreset
ata1: soft resetting port
ata1.00: configured for MWDMA2
ata1: EH complete
ata1.00: limiting speed to MWDMA1:PIO4
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd ca/00:10:47:64:1d/00:00:00:00:00/e0 tag 0 cdb 0x0 data 8192 out
res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: device not ready (errno=-16), forcing hardreset
ata1: soft resetting port
ata1.00: configured for MWDMA1
ata1: EH complete
sd 0:0:0:0: [sda] 3985632 512-byte hardware sectors (2041 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 3985632 512-byte hardware sectors (2041 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't 
support DPO or FUA


-- 
Tomasz Chmielewski
http://wpkg.org
