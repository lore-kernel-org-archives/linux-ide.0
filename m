From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: Suggestions for debugging ata_piix and ahci driver failures on Xen pv_ops dom0 kernel (2.6.29-rcX)
Date: Thu, 5 Feb 2009 10:28:43 +0200
Message-ID: <20090205082843.GD15052@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from edu.joroinen.fi ([194.89.68.130]:49123 "EHLO edu.joroinen.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148AbZBEI2q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Feb 2009 03:28:46 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Hello!

I'm trying to figure out what's wrong with the pv_ops dom0 kernel/patches [1]
causing at least ata_piix and ahci drivers to fail to work.

There was legacy IRQ enabling problem earlier with the pv_ops dom0 patches, 
which pretty much prevented the disks from being detected.. but that got fixed. 
It could still be something related to Xen/dom0 irq handling.. 

I'd be glad if someone could take a look at this 2.6.29-rc3-tip pv_ops dom0 kernel boot log
and comment about _possible_ causes for such behaviour of ata_piix and ahci:

http://pasik.reaktio.net/xen/pv_ops-dom0-debug/pv_ops-dom0-bootlog-11-xen331-linux-2.6.29-rc3-atadebug3.txt

In that testing box I have just one IDE hdd attached to ata_piix controller, the AHCI controller doesn't
have any disks attached.

The exact same kernel works OK without problems on baremetal without Xen
hypervisor. 

[1] http://xenbits.xen.org/paravirt_ops/patches.hg/ and
http://wiki.xensource.com/xenwiki/XenParavirtOps

-- Pasi
