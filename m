From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: attempting task abort with block: remove artifical max_hw_sectors
 cap
Date: Tue, 06 Jan 2015 12:16:35 +0100
Message-ID: <54ABC413.6090000@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:55353 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003AbbAFLQh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2015 06:16:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Dear list,

while testing 595b8ecd47e4dde64f704bf78d8c9b97e070ac67 ([PATCH] block:
remove artifical max_hw_sectors cap), i came around a problem with some
crucial m500 ssds direct attached.

With the patch applied, i see the following max_sectors_kb value:
# cat /sys/block/sdi/queue/max_sectors_kb
16383

But this results in the following error messages (at random time - most
probably at high load):

Write(10): 2a 00 04 f9 db f0 00 0c d8 00
scsi target0:0:7: handle(0x000a), sas_address(0x4433221107000000), phy(7)
scsi target0:0:7: enclosure_logical_id(0x5003048016aee700), slot(5)
sd 0:0:7:0: task abort: SUCCESS scmd(ffff88018c6b4700)
sd 0:0:7:0: attempting task abort! scmd(ffff8807a12e6800)
sd 0:0:7:0: [sdh] CDB: Read(10): 28 00 15 d4 f9 60 00 00 10 00
scsi target0:0:7: handle(0x000a), sas_address(0x4433221107000000), phy(7)
scsi target0:0:7: enclosure_logical_id(0x5003048016aee700), slot(5)
sd 0:0:7:0: task abort: SUCCESS scmd(ffff8807a12e6800)
sd 0:0:7:0: attempting task abort! scmd(ffff88078d989800)
sd 0:0:7:0: [sdh] CDB: Read(10): 28 00 15 aa d2 f9 00 00 20 00

Stefan
