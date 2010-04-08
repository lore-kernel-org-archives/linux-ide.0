From: Alexander Clausen <alex@gc-web.de>
Subject: 4k sector size and WD20EARS
Date: Thu, 08 Apr 2010 16:20:16 +0200
Message-ID: <4BBDE620.3040601@gc-web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server3.gc-web.de ([188.40.57.209]:56974 "EHLO mail.gc-web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757413Ab0DHO3F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Apr 2010 10:29:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.gc-web.de (Postfix) with ESMTP id 831B926D27A1
	for <linux-ide@vger.kernel.org>; Thu,  8 Apr 2010 16:20:17 +0200 (CEST)
Received: from mail.gc-web.de ([127.0.0.1])
	by localhost (server3.gc-web.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BsRjoOHIhRXK for <linux-ide@vger.kernel.org>;
	Thu,  8 Apr 2010 16:20:17 +0200 (CEST)
Received: from [192.168.0.162] (p3E9D4050.dip.t-dialin.net [62.157.64.80])
	by mail.gc-web.de (Postfix) with ESMTPSA id 5155226D2798
	for <linux-ide@vger.kernel.org>; Thu,  8 Apr 2010 16:20:17 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,
i just bought some WD20EARS harddisk. They are supposed to have 4k physical sector size, right?
My system seems to think they are not:

alex@hal:/sys/block/sdb/queue$ cat logical_block_size physical_block_size
512
512
alex@hal:/sys/block/sdb/queue$


alex@hal:~$ uname -a
Linux hal 2.6.33.2 #1 SMP PREEMPT Sun Apr 4 20:52:14 CEST 2010 x86_64 GNU/Linux
alex@hal:~$

from dmesg:

scsi 1:0:0:0: Direct-Access     ATA      WDC WD20EARS-00S 80.0 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)

so, who is right?

The current partition table looks like:

alex@hal:~$ sudo cfdisk -P s /dev/sdb
Partition Table for /dev/sdb

                First       Last
  # Type       Sector      Sector   Offset    Length   Filesystem Type (ID) Flag
-- ------- ----------- ----------- ------ ----------- -------------------- ----
  1 Primary           0  3907024064     63  3907024065 Linux (83)           None
alex@hal:~$

is that okay for 4k sector size?

Alexander
