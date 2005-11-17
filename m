From: "James Rose" <james@stubbornroses.com>
Subject: Re: sata_sil24 test support
Date: Thu, 17 Nov 2005 16:58:43 -0600 (CST)
Message-ID: <63269.137.32.101.32.1132268323.squirrel@www.stubbornroses.com>
Reply-To: "James Rose" <james@stubbornroses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxsf22.cluster1.charter.net ([209.225.28.222]:10900 "EHLO
	mxsf22.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S964891AbVKQW6y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Nov 2005 17:58:54 -0500
Received: from mxip06a.cluster1.charter.net (mxip06a.cluster1.charter.net [209.225.28.136])
	by mxsf22.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id jAHMwi8K003354
	for <linux-ide@vger.kernel.org>; Thu, 17 Nov 2005 17:58:45 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Results for second test (one more badblock run still going):

/dev/sdd is 400GB Hitachi Deskstar in a SteelVine 2000
(Sil 3726), connected to external SATA connector on Sil 3124

------------------
debian:~# time badblocks -w -t random /dev/sdb > badblocks.sdb.txt

real    287m48.162s
user    11m49.856s
sys     4m14.692s
debian:~# cat badblocks.sdb.txt
debian:~# fdisk -l /dev/sdb

Disk /dev/sdb: 400.0 GB, 400088457216 bytes
255 heads, 63 sectors/track, 48641 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

Disk /dev/sdb doesn't contain a valid partition table
debian:~#
---------------
