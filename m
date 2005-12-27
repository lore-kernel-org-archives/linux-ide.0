From: Peter Smith <peter.smith@utsouthwestern.edu>
Subject: Re: Promise SATA oops
Date: Tue, 27 Dec 2005 17:51:16 -0600
Message-ID: <43B1D374.5070307@utsouthwestern.edu>
References: <20051202045853.GD3677@vitelus.com> <438FDB9D.2030201@pobox.com> <20051202195109.GE3677@vitelus.com> <20051220201719.GC15466@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from swlx166.swmed.edu ([199.165.152.166]:7045 "EHLO
	swlx166.swmed.edu") by vger.kernel.org with ESMTP id S932403AbVL0XvS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Dec 2005 18:51:18 -0500
Received: from peters.swmed.org ([129.112.118.137])
	by swlx166.swmed.edu with esmtp (Exim 4.44)
	id 1ErOb6-0005n2-Ry
	for linux-ide@vger.kernel.org; Tue, 27 Dec 2005 17:51:18 -0600
In-Reply-To: <20051220201719.GC15466@vitelus.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Aaron Lehmann wrote:

>Argh, died again!! It had been stable for over 12 days. Same error
>message, and the root md is degraded and dirty just like last time.
>This is a very severe state with high risk of data loss. When things
>went sour, terminals and most applications still kept working, but
>anything that touched the filesystem froze up. I had a shell open in a
>chroot on a ramdisk, but dmesg just hung for a few minutes and then
>exited with a "Bus error". I had no other way of examining the kernel
>log since the machine runs X.
>
>This was running 2.6.15-rc4. Crashes seem to happen less frequently
>with it than with 2.6.14.x, but when they happen they leave the RAID
>in a severe state. I also don't think 2.6.14.2 said anything about
>disabling the IRQ.
>
>I'm very desperate now. About every week I experience a crash that
>damages my RAID array to the point where it can't boot, as if the
>instability wasn't bad enough. Do I need to buy a hardware RAID card?
>
>  
>
I personally wouldn't recommend a hardware RAID card.. Are you still 
experiencing difficulties? Have you *tried* an i386 build? Can you work 
on getting more data out of the Ooops'es--this would involve setting up 
a serial console connection to another box and receiving dumps that way, 
there are How-tos out there on this setup.. Another possibility is the 
Kernel Crash Dump project [1]... Btw, I have (fairly simple) setup here 
at my office, using Fedora Core 3, 2.6.12-1.1381_FC3smp kernel, dual 
P3-500mz, 512MB ram, two Promise Sata2-150 TX4s, and five Seagate 200GB 
drives.. I haven't had any problems with it since it was installed. 
Granted the hardware and software are a bit behind the curve, it has 
been sailling along quietly and steadily, so it is possible.

Peter

[1] http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.11google.com
