From: "James Rose" <james.o.rose@gmail.com>
Subject: Re: sata_sil24 test support
Date: Thu, 17 Nov 2005 18:35:59 -0600 (CST)
Message-ID: <55361.137.32.101.32.1132274159.squirrel@www.stubbornroses.com>
References: <63269.137.32.101.32.1132268323.squirrel@www.stubbornroses.com>
Reply-To: "James Rose" <james.o.rose@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxsf40.cluster1.charter.net ([209.225.28.172]:17627 "EHLO
	mxsf40.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750729AbVKRAgE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Nov 2005 19:36:04 -0500
Received: from mxip29a.cluster1.charter.net (mxip29a.cluster1.charter.net [209.225.28.188])
	by mxsf40.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id jAI0a1D2008940
	for <linux-ide@vger.kernel.org>; Thu, 17 Nov 2005 19:36:01 -0500
In-Reply-To: <63269.137.32.101.32.1132268323.squirrel@www.stubbornroses.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


Last one of the badblocks scans for Tejun:

dev/sdd is external 500GB SATA2 Hitachi Deskstar connected to Sil 3124

----------------------------------
debian:~# time badblocks -w -t random /dev/sdc > badblocks.sdc.txt

real    338m50.894s
user    14m41.059s
sys     5m15.016s
debian:~# cat badblocks.sdc.txt
debian:~# fdisk -l /dev/sdc

Disk /dev/sdc: 500.1 GB, 500107862016 bytes
255 heads, 63 sectors/track, 60801 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

Disk /dev/sdc doesn't contain a valid partition table
debian:~#
----------------------------------

Hopefully tomorrow I can write a script for the write testing, so it can
run over the weekend.

Regards,

James
