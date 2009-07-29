From: Mark Lord <liml@rtr.ca>
Subject: hdparm-9.17 released, with experimental trim/wiper scripts for SSDs
Date: Wed, 29 Jul 2009 19:35:20 -0400
Message-ID: <4A70DCB8.9000909@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:44842 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbZG2XfV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Jul 2009 19:35:21 -0400
Received: from [10.0.0.6] (corey.localnet [10.0.0.6])
	by mail.rtr.ca (Postfix) with ESMTP id A797A31DDA
	for <linux-ide@vger.kernel.org>; Wed, 29 Jul 2009 19:35:20 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

hdparm-9.17 is now available from sourceforge.net.

New in this release:
        - added wiper/ subdirectory with preliminary SSD-wiper (TRIM) scripts
        - nuked kernel_patches/ subdirectory
        - Capitalize first word of each line of help output
        - added --fallocate flag
        - added --trim-sector-ranges flag
        - removed --trim-sectors flag
        - removed --fibmap-sector flag
        - embed VERSION string for easier digging out with strings(1)

This release is mostly in support of enabling user-initiated DSM/TRIM operations
for solid-state drives (SSDs).  The in-kernel support for automatic-TRIM seems
a ways off yet, so I'm providing scripts to do it auto/manually instead.  :)

These basically scan for free blocks in a filesystem, and batch them together
into huge DSM/TRIM commands to the drive, letting it know about them all for
garbage-collection and wear-leveling purposes.

These scripts are similar (but being Linux, superior) to an existing wiper.exe
utility that MS Win users have been enjoying for some brands of SSD.

But they won't actually do anything until drives ship with TRIM-enabled firmware.

Cheers 
