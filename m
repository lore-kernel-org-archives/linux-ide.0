From: =?ISO-8859-1?Q?Lars_Michael_Jogb=E4ck?= <lm@jogback.se>
Subject: Problem with size after growing a device on 3ware-9500
Date: Thu, 26 Jul 2007 23:36:44 +0200
Message-ID: <46A913EC.2070100@jogback.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.jogback.se ([192.165.82.16]:37188 "EHLO jogback.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934684AbXGZWJV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2007 18:09:21 -0400
Received: from [192.165.82.43] (account lm HELO [192.165.82.43])
  by mail1.jogback.se (CommuniGate Pro SMTP 5.1.9)
  with ESMTPSA id 4614797 for linux-ide@vger.kernel.org; Thu, 26 Jul 2007 23:36:49 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I don't know really which subsystem this, so I'm sending this to the 
linux-ide list.
Please direct me to a more appropriate place if this is not correct.

I'm using a 3ware 9500 with Linux 2.6.18.1. I've grown the HW 
raid5-array and here is where the problem begins. After the card had 
expanded the array, I used "blockdev --rereadpt /dev/sdn" to get the 
kernel to recognize the now larger device. The last step was to do a 
"pvresize /dev/sdn". The problem is that pvresize still thought that the 
device was at the original size.

 From the lvm mailinglist I found out that pvresize used the same 
mechanism as "blockdev" (ioctl BLKGETSIZE64) to get the size of the 
disks, so I tested this and found that blockdev also reported the device 
to have the wrong size.

So, if I do:
# cat /sys/block/sdn/size
5859250176

and

# blockdev --getsize64 /dev/sdn
2499946741760
# blockdev --getss /dev/sdn
512
# expr 2499946741760 / 512
4882708480

Apparently /sys/block/sdk/size is updated with the new size, but 
whatever "ioctl BLKGETSIZE64" is querying is not. If I reboot, 
everything works correctly.

Shouldn't it be possible to extend the size of a disk without rebooting?

Best Regards,
/LM
