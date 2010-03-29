From: Joe Ceklosky <jfceklosky@gmail.com>
Subject: Failed Flush Cache on Intel SS4200-e
Date: Sun, 28 Mar 2010 20:29:21 -0400
Message-ID: <4BAFF461.9070909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55885 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423Ab0C2A3Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Mar 2010 20:29:25 -0400
Received: by vws8 with SMTP id 8so2259073vws.19
        for <linux-ide@vger.kernel.org>; Sun, 28 Mar 2010 17:29:24 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have been working with an Intel SS4200-e using the libata SATA drivers 
in a Fedora 12
kernel.  I have 4 Samsung 250's in a software Raid 5 config.

While running an rsync I sometimes get the following on two different 
drives:
The drives are fine as far as I know.
The first time was drive 3, this was from drive 4.

Anyone with any thoughts on this?


kernel messages:
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata4.00: failed command: FLUSH CACHE EXT
ata4.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
          res 40/00:0c:ba:2d:40/00:00:19:00:00/40 Emask 0x4 (timeout)
ata4.00: status: { DRDY }
ata4: hard resetting link
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: configured for UDMA/133
end_request: I/O error, dev sdd, sector 488391834
md: super_written gets error=-5, uptodate=0
raid5: Disk failure on sdd2, disabling device.
raid5: Operation continuing on 3 devices.
ata4: EH complete
RAID5 conf printout:
  --- rd:4 wd:3
  disk 0, o:1, dev:sda2
  disk 1, o:1, dev:sdb2
  disk 2, o:1, dev:sdc2
  disk 3, o:0, dev:sdd2
RAID5 conf printout:
  --- rd:4 wd:3
  disk 0, o:1, dev:sda2
  disk 1, o:1, dev:sdb2
  disk 2, o:1, dev:sdc2
md: data-check of RAID array md0
md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
md: using maximum available idle IO bandwidth (but not more than 200000 
KB/sec) for data-check.
md: using 128k window, over a total of 233705472 blocks.
md: md0: data-check done.


