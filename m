From: Jeff Garzik <jgarzik@pobox.com>
Subject: new tool:  blktool
Date: Sun, 15 Aug 2004 17:36:04 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <411FD744.2090308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16266 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266910AbUHOVgX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Aug 2004 17:36:23 -0400
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


I just posted "blktool" on my SF page,
	http://sourceforge.net/projects/gkernel/
and in BitKeeper at
	bk://gkernel.bkbits.net/blktool


blktool aims to be an easier to use, and more generic version of the 
existing utility 'hdparm'.  For example,

	$ hdparm -c1 /dev/hda
		becomes
	$ blktool /dev/hda pio-data 32-bit

	and

	$ hdparm -L0 /dev/hda
		becomes
	$ blktool /dev/hda media unlock

The utility is currently still fairly specific to IDE devices (as hdparm 
is), but that will change in the coming weeks as SCSI, I2O, and possibly 
some bits of hardware RAID control are added.

The audience for this application, like hdparm, is fairly narrow, 
specific to people who tweak their storage devices and _know what they 
are doing_.  Improper use of this tool, like hdparm, can turn your disk 
into a doorstop.

	Jeff



