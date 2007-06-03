From: Michel Lespinasse <walken@zoy.org>
Subject: SATA hotswap and write caches
Date: Sun, 3 Jun 2007 03:43:35 -0700
Message-ID: <20070603104334.GH18680@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 64-142-28-230.dsl.static.sonic.net ([64.142.28.230]:57724 "EHLO
	Angel.zoy.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753097AbXFCLNI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Jun 2007 07:13:08 -0400
Received: from Angel.zoy.org (localhost [127.0.0.1])
	by Angel.zoy.org (Postfix) with ESMTP id 5713D175E23
	for <linux-ide@vger.kernel.org>; Sun,  3 Jun 2007 03:43:35 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have a few questions about disk cache synchronization. I'm running a
setup with several SATA drives (seagate ST3500630AS), installed in
hot-swap bays. The host controller is an Intel ICH8 running in AHCI
mode, if that makes any difference. Also my kernel is from kernel.org,
version 2.6.20.12.

When hot-removing a drive, I get messages such as:
Jun  1 23:48:50 server kernel: ata3.00: detaching (SCSI 2:0:0:0)
Jun  1 23:48:50 server kernel: Synchronizing SCSI cache for disk sdb: 
Jun  1 23:48:50 server kernel: FAILED
Jun  1 23:48:50 server kernel:   status = 0, message = 00, host = 4, driver = 00
Jun  1 23:50:22 server kernel:   <3>ata3: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action 0x2 frozen

When the drive is plugged it mentions about caching:
Jun  1 23:50:32 server kernel: SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA.

I tried to google for more information about caching but could not come out
with much. Mainly I found http://linux-ata.org/shutdown.html but this only
talks about server poweron/down and suspend operations, not hotswap issues.

I'm a bit confused about this caching and have two questions:

* Is there anything one needs to know before hot-removing a drive ?
  Maybe a file under /sys that asks the drive to flush its cache ?

* Does the kernel issue such cache flushing commands when executing
  sync() or umount() operations ?

Please CC me in replies - I have subscribed to the list but did not get
the majordomo confirmation message yet so who knows if that worked :)

Thanks,

-- 
Michel "Walken" Lespinasse
"Bill Gates is a monocle and a Persian cat away from being the villain
in a James Bond movie." -- Dennis Miller
