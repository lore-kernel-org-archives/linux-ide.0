From: David Dasenbrook <david@daviddasenbrook.de>
Subject: Kernel hangs trying to speak to DVD-ROM
Date: Wed, 21 Dec 2005 22:24:23 +0100
Message-ID: <43A9C807.7010306@daviddasenbrook.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s176.evanzo-server.de ([62.67.235.176]:37968 "EHLO
	mx12.evanzo-server.de") by vger.kernel.org with ESMTP
	id S932159AbVLUVQR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Dec 2005 16:16:17 -0500
Received: from [192.168.178.21] (Iad4f.i.pppool.de [85.73.173.79])
	by mx12.evanzo-server.de (Postfix) with ESMTP id 1E047CA297
	for <linux-ide@vger.kernel.org>; Wed, 21 Dec 2005 22:16:04 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,
I have this weird problem, and I would appreciate if someone could give
me a hint on how to solve it:
Whenever I connect a DVD-ROM drive (ANY DVD-Drive, not just a specific
one) to my computer via the onboard IDE-connector, I cannot boot any
more. The last message the kernel prints (actually, I think it's the
ide-cd module) after getting hung up is this:

hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x04
hdc: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdc: request sense failure: error=0x04Aborted Command

I tried using the first and the second IDE channel, using the drive as
master and slave. The strange thing is that CD-drives work perfectly
fine, this happens just with DVD-Drives. Those DVD-Drives work fine in
another computer with the exact same kernel.
My mainboard is a AK70 by DFI, I think the onboard IDE-controller is the
AMD7409 (that's what the kernel says.) I use Linux 2.6.8-2.
2.4.x kernels don't work either, real old distributions with kernel 2.2
or lower do.
After playing around a bit, I found the DVD works when I type
"hdc=noprobe hdc=cdrom" on the kernel command line. But still, I cannot
do that when trying to run the debian installer or installers of debian
derivatives. When detecting the DVD-ROM drive, the installer just hangs
and I can't do anything any more but reboot.
I find this really strange, maybe someone has a clue. If not, thanks
anyway for taking the time to read this message.
If you reply to this, please send me a CC.
Thank you,
David Dasenbrook

