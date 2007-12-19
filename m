From: Harri <harald.dunkel@t-online.de>
Subject: question about SATA vs (SATA via USB)
Date: Wed, 19 Dec 2007 09:57:55 +0100
Message-ID: <fkamek$gqs$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:56928 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340AbXLSTx5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Dec 2007 14:53:57 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1J54lu-0001Si-AP
	for linux-ide@vger.kernel.org; Wed, 19 Dec 2007 19:40:02 +0000
Received: from p57bd3c55.dip.t-dialin.net ([87.189.60.85])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 19:40:02 +0000
Received: from harald.dunkel by p57bd3c55.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 19:40:02 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi folks,

I have seen a file system corruption when I conected a
previously written SATA disk to my PC using a SATA-via-USB
connector. Probably this wasn't supposed to happen, was it?

I had bought a new 500 GB SATA disk to be built into my
PC. To copy the boot partition I attached it to the PC
using a cheap SATA-via-USB connector. Probably you have
seen these devices on Ebay before. Its a strange socket
to be plugged into the back side of the disk, providing
both IDE and SATA. It also includes an external power
supply.

Creating a partition table and copying the boot disk went
fine. After that I replaced the internal disk with the new
one, fixed the mbr and tried to boot. It worked.

Next I mounted (rw, shame on me) the old SATA disk via USB
to the PC, and tried to copy the data. But during the copy
there were some syslog messages about file system corruptions
on the old disk. I stopped rsync, unmounted the disk,
and ran fsck, but it was damaged beyond repair. No chance
to recover any data.


The question is what has happened here? I checked the old
disk on a real SATA connector; it seems to be OK.


???


Regards

Harri

