From: Mark Lord <liml@rtr.ca>
Subject: hdparm-8.7 is released
Date: Mon, 02 Jun 2008 17:56:58 -0400
Message-ID: <48446CAA.3050008@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4451 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357AbYFBV5A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jun 2008 17:57:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Version 8.7 of hdparm is now available from Sourceforge.net.

This version includes a number of small fixes and the like,
plus these new features:

 -- Uses sysfs to get device offset / size values,
    so it will continue to work with 2TB (and larger) drives.
    It falls back to the ioctl() interfaces when sysfs is unavailable.

 -- The -Q (queue_depth) flag now works with sysfs.
    This can be useful for easy tuning of SATA NCQ queue_depths, among others.

 -- New --fibmap flag, to dump out the extent list for a specified file.
    New --fibmap-sector flag, to dump out the absolute LBA of a specific sector of a file.
    These can be quite useful for determining suitable LBA values for fault-injection.

Cheers
    
