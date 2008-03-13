From: Christian Spindler <csp@inode.at>
Subject: Re: nVidia MCP55 SATA hotplug support?
Date: Thu, 13 Mar 2008 21:23:01 +0000 (UTC)
Message-ID: <loom.20080313T211921-877@post.gmane.org>
References: <47D698C8.2020206@aquazul.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:44117 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757430AbYCMVaG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Mar 2008 17:30:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JZuzz-0006wS-3x
	for linux-ide@vger.kernel.org; Thu, 13 Mar 2008 21:30:03 +0000
Received: from 85-127-1-135.dynamic.xdsl-line.inode.at ([85.127.1.135])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 21:30:03 +0000
Received: from csp by 85-127-1-135.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 21:30:03 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


My hardware is:

00:0e.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
00:0e.1 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
00:0e.2 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)

And hotplug does not work, too.


chrisi@mars:~$ lsmod | grep sata
sata_sil24             15236  0 
sata_nv                20612  2 
libata                125168  3 sata_sil24,sata_nv,ata_generic


There are no info in dmesg wenn plug or un-plug a drive.
On Windows hotplug works.

Does anybody knows hot to activate hotplug?

thank you!

Chris

