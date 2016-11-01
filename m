From: Bram Matthys <syzop@vulnscan.org>
Subject: Write performance 50% compared to Windows
Date: Tue, 01 Nov 2016 11:37:42 +0100
Message-ID: <adf65b5b8edfe0c1c99bc55a2827a68d@mail.vulnscan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.vulnscan.org ([149.210.174.15]:48230 "EHLO
        mail.vulnscan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168776AbcKALUg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Nov 2016 07:20:36 -0400
Received: from mail.vulnscan.org ([149.210.174.15])
        by mail.vulnscan.org with esmtp (Exim 4.84_2)
        (envelope-from <syzop@vulnscan.org>)
        id 1c1WRq-00037p-5T
        for linux-ide@vger.kernel.org; Tue, 01 Nov 2016 11:37:42 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have a Samsung SSD 850 EVO 4TB and under Linux I'm only getting 
~240MB/s write speed. On Windows it's 490MB/s (yes, without cache).
The read speed is the same on both Linux and Windows, though. Both are 
512MB/s.

Any ideas what this could be? It can't be a slow SATA link as read 
speed are fine. And since write performance is fine on Windows so I'm 
kinda stunned. Not sure how to proceed / debug this any further.

I'm testing with dd if=/dev/zero of=/dev/sdX bs=1M count=65536 
conv=fdatasync. Results are similar without the conv=fdatasync. On 
Windows I test with AS SSD.
Prior to testing I do a ATA security erase to make sure the SSD isn't 
clearing any cells during the benchmark. (Previously I used blkdiscard 
but then realized this would only 'mark' the cells as unused so it might 
do the actual erasing in the background)
I tested this both with a 4.4.0 and 4.8.4 Linux kernel. Another 
machines (different hardware) has the same results. All have a SATA III 
interface.

Dmesg:
[    4.741663] ata2.00: ATA-9: Samsung SSD 850 EVO 4TB, EMT02B6Q, max 
UDMA/133
[    4.752974] ata1.00: ATA-9: Samsung SSD 850 EVO 4TB, EMT02B6Q, max 
UDMA/133

# cat /sys/block/sda/device/queue_depth
31

If you need anything else let me know. Any help is welcomed.

Regards,

Bram
