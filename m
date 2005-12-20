From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: Kernel or patch suggestions for DMA enables Marvell Driver
Date: Tue, 20 Dec 2005 13:53:33 -0700
Message-ID: <E1EooUH-0008VA-Vj@highlab.com>
References: <43A86AF2.2080508@physics.ucsd.edu>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ecae158-153-dhcp.colorado.edu ([128.138.158.153]:46762 "EHLO
	highlab.com") by vger.kernel.org with ESMTP id S932104AbVLTUxK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Dec 2005 15:53:10 -0500
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1EooUH-0008VA-Vj
	for linux-ide@vger.kernel.org; Tue, 20 Dec 2005 13:53:34 -0700
In-reply-to: <43A86AF2.2080508@physics.ucsd.edu> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Terrence Martin <tmartin@physics.ucsd.edu> wrote:
> I have tried several development kernels to try to get the DMA version 
> of the  Marvell  SATA driver to work. The problem is that other problems 
> with the kernels have made them unsuitable for use. For example I used 
> the latest 2.6.14git kernel as well as the most recent patch for 
> 2.6.15-rc6. Both of which had problems.
> 
> Could someone suggest a version of the kernel that might work, or 
> alternatively is it possible to extract the DMA supported driver itself 
> for compilation in another version? For example 2.6.14.4.
> 
> The official kernel driver is the closest I have gotten to getting this 
> controller supported on my system. The source code from Marvell and 
> other sources seems to not want to compile at all.
> 
> Here is the card I have from lspci
> 
> 03:04.0 RAID bus controller: Marvell Technology Group Ltd. MV88SX6041 
> 4-port SATA II PCI-X Controller (rev 03)

I have a 6081 (Marvell Technology Group Ltd. MV88SX6081 8-port SATA II
PCI-X Controller (rev 09)), it works fine under 2.6.15-rc5.  No hotplug,
and a few wierd problems here and there.

I'm getting ~55 MB/s/disk off each of 4 disks.  220 MB/s total read.
It slows way down when you start writing to them too, of course.


-- 
Sebastian Kuzminsky
