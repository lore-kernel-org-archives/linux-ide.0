From: Jeff Garzik <jgarzik@pobox.com>
Subject: libata maintainership change
Date: Fri, 03 May 2013 16:01:33 -0400
Message-ID: <5184179D.5050407@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:41920 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab3ECUBi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 May 2013 16:01:38 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE mailing list <linux-ide@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Tejun Heo <tj@kernel.org>


Linux has really found its groove.

When I first got involved in Linux, there was no PCI API (now called the 
hotplug or device API), and patch submission was a moderately painful 
process of throwing spaghetti at a wall: sending and resending, with 
both Linus and maintainers having to manually resolve merge conflicts. 
<shiver>

It was a real fight to get any Linux hardware support at all.  The vast 
amount of hardware documentation was locked away or simply unavailable.

Working on memory management or filesystems or scheduling was always the 
Sexy Rock Star PhD work that attracted engineers.  OTOH, I felt, device 
drivers were ignored as boring, unsexy grunt work.  Which, ok, maybe it 
was.  Each new device driver, though, spread Linux to more and greater 
locales.  Alan Cox and Don Becker did enormous heavy lifting back then. 
  Now Linux is where it is today, with most hardware vendors actively 
seeking open source driver support (except NVIDIA, natch).  The kernel 
has come a long way.

Time for new open source pastures outside the kernel, for me.  SATA is 
slowly getting unexciting to the world.  Which, really, just means the 
brand new technology has reached a usable plateau.  :)  And maybe in a 
few years, with directly attached PCI-NextGenSuperFastExpress storage, 
ATA and SCSI will be distant memories.

Until such time as block-based storage disappears from this earth, the 
brave Sir Tejun, basically the libata co-author at this point, has 
agreed to be a target for slings and arrows known as libata patches.

All the best,

	Jeff


