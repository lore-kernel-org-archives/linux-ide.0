From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: WRITE DMA EXT failures with JM20330 based sata2ide
Date: Mon, 06 Jun 2011 20:51:27 +0200
Message-ID: <isj7ql$4fh$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:34515 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757857Ab1FFTUG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Jun 2011 15:20:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1QTfLI-0003ic-Jl
	for linux-ide@vger.kernel.org; Mon, 06 Jun 2011 21:20:04 +0200
Received: from p4fd18e48.dip0.t-ipconnect.de ([79.209.142.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 06 Jun 2011 21:20:04 +0200
Received: from Manuel.Spam by p4fd18e48.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 06 Jun 2011 21:20:04 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I already posted this to the file-systems list, but as this might be the wrong 
list, I'm copying this request to here.

I've converted a 1,5TB SATA drive to IDE to run it on a UDMA100 IDE controller.

Low traffic applications work well. I'm able to create a xfs or ext4 filesystem 
and even a fsck runs without problems and without causing error messages on dmesg.

If I start to copy a file with some gigabytes in size to the new disc, then 
errors like the following keep coming on dmesg:

ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.00: failed command: WRITE DMA EXT
ata2.00: cmd 35/00:00:30:07:8a/00:04:57:00:00/e0 tag 0 dma 524288 out
          res 40/00:ff:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
ata2.00: status: { DRDY }
ata2: link is slow to respond, please be patient (ready=0)
ata2: device not ready (errno=-16), forcing hardreset
ata2: soft resetting link
ata2.00: configured for UDMA/25
ata2.00: device reported invalid CHS sector 0
ata2: EH complete

The error repeats many times.

Copying a big file from this disc to another location on the disc, then this 
also works without errors (maybe because of the slow down of the mixed 
read/write access). This copy from disc to same disc also failed before I 
switched the disc to SATA I mode. This is done now, but doesn't seem to fix copy 
from another disc to the new one.

Interesting thing is that always WRITE DMA EXT seems to fail. Is there any way 
to fix this? Maybe it would be a option to increase the timeout, that gets 
triggered here, so the driver waits longer for the result?

What I definetly need is some workaround to stop the kernel from speeding down 
until UDMA/25 is reached. This speed is totally unacceptable for such a big 
drive... :-(

Are there configuration parameters that change how the driver behaves in such 
situations and how to set them to get around this problem?

Thank you very much in advance for any help...

Yours

Manuel

