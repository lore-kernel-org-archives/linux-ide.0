From: Tom Evans <tom@23palmer.net>
Subject: Port Multiplier Patch 2.6.22.1 on Alpha
Date: Wed, 29 Aug 2007 23:25:23 -0400
Message-ID: <46D638A3.2030704@23palmer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:6966 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172AbXH3DfJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Aug 2007 23:35:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hi Tejun and all -

I have applied the libata-tj-stable patch to the 2.6.22.1 kernel and am 
having some issues.
I'm not certain if it is the PMP patches, or my platform.

I have a Silicon Images 3124-2 based PCI-X card (Norco 4618) for my 
Alpha system .
I realize this is not the usual test platform and I understand if you 
decide to blame it on the platform.

I also have a "StorBox" which is a 5-bay eSATA box based with the Si4276 
port multiplier, which is noted to be "quirky" in the README.

The problem arises when I try to create/assemble a linux software raid 
using 4 disks (level 6).  At the time the system becomes very very slow 
- basically unresponsive - I can get an occasional keystroke in on the 
console, but the machine is essentially dead.

If I pull the eSATAcable out of the card, the sata_si24 driver does its 
thing and the machine comes back to life.
The unit is plugged into the port designated as the first - all drive 
bays contain a drive.

I am able to individually address and to format individual drives 
without performance issue, but the creation of a raid is deadly ....

Have you heard of such and issue with the 3124-2/4276 combination?
Is anyone else trying this driver on an Alpha?

I have similar such behavior before when using drivers that generate 
many unaligned accesses - I only have seen 2 places they occur in 
sata_sil24 and have fixed them myself, but that made no difference.

Are there any logs or output that might help?  Should I attempt to 
upgrade the firmware of the devices?

Thanks,
...tom
