From: Carolin Latze <carolin.latze@gmail.com>
Subject: kernel crash with lite-on sata controller Dell XPS 13 9343
Date: Thu, 25 Feb 2016 22:45:10 +0100
Message-ID: <56CF75E6.5070803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37443 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbcBYVpN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Feb 2016 16:45:13 -0500
Received: by mail-wm0-f44.google.com with SMTP id g62so46376503wme.0
        for <linux-ide@vger.kernel.org>; Thu, 25 Feb 2016 13:45:12 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hdegoede@redhat.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org

Hi all

I have been asked to post here based on the bug I filed at Ubuntu:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1516215

I have the newest kernel running:

cat /proc/version
Linux version 4.5.0-040500rc5-generic (kernel@tangerine) (gcc version 
5.2.1 20151010 (Ubuntu 5.2.1-22ubuntu2) ) #201602201730 SMP Sat Feb 20 
22:32:16 UTC 2016


Since the beginning (started with 3.19.x kernels on this notebook) I had 
problems with this sata controller:

03:00.0 SATA controller: Lite-On Technology Corporation Device 0224 (rev 10)

Very often during boot, the boot just failed with error messages like

ata1.00: exception... (I was only able to capture them by taking a 
picture: https://launchpadlibrarian.net/227876135/IMG_20151128_230313.jpg)

Then I keep trying, sometimes I boot into Windows inbetween, and 
eventually, the kernel comes up.

Then, when running and putting a lot of load on the disk (e.g. running 
dump or a simple update via apt-get upgrade), the system looses its disk 
and I have to hard reset.

The machine runs perfectly fine under Windows, so I don't believe it is 
a hardware issue.

I hope there is a solution to this issue.

best regards
Carolin
