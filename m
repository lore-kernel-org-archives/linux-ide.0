From: Jeff Garzik <jgarzik@pobox.com>
Subject: [sata] libata update
Date: Sat, 24 Apr 2004 22:48:28 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <408B26FC.30101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:131 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262106AbUDYCsm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Apr 2004 22:48:42 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>


I'm slowly and (somewhat) quietly cleaning up the libata internals. 
This is allow several interesting features to appear in rapid 
succession: hotplug, random taskfile submission (SMART!), and ATAPI.

This is the first step in cleaning up the internals.  Nothing terribly 
interesting for existing users, except for one key change:

Promise SATA driver has been split.  Promise TX2/TX4 SATA remains in 
"sata_promise".  The very-different Promise SX4 support is now found in 
a new driver "sata_sx4".  Promise users, please test and make sure I 
didn't break anything.  It seems to work on my Promise SATA h/w.


Linux 2.6.x patch and changelog:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.6-rc2-bk3-libata1.patch.bz2
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.6-rc2-bk3-libata1.log

Linux 2.4.x patch and changelog:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.27-pre1-libata1.patch.bz2
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.27-pre1-libata1.log

BitKeeper repositories:
	http://gkernel.bkbits.net/libata-2.[46]



