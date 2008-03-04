From: Jeremy Jackson <jerj@coplanar.net>
Subject: hdparm -W 0 2.6.24.3 causing XFS shutdown on IO Error
Date: Tue, 04 Mar 2008 17:22:14 -0500
Message-ID: <1204669334.7633.42.camel@ragnarok>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from titan.coplanar.net ([70.47.139.2]:40934 "EHLO
	titan.coplanar.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbYCDWgX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Mar 2008 17:36:23 -0500
Received: from [70.47.139.174] ([70.47.139.174])
	(authenticated bits=0)
	by titan.coplanar.net (8.14.1/8.14.1/Debian-8ubuntu1) with ESMTP id m24MMEpo029583
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-ide@vger.kernel.org>; Tue, 4 Mar 2008 17:22:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

using sata_nv ADMA mode, on CK804 Ultra, motherboard Tyan S2865, I am
trying to disable the write cache for data integrity.

Drives are Seagate ST3500830AS FwRev=3.AAC
or Seagate ST35000630AS 

Using md-raid1 + LVM2

Kernel is Ubuntu/Hardy 2.6.24-11.17

To reproduce,

# hdparm -W 0 /dev/sda ; hdparm -W 0 /dev/sdb
# touch /tmp/foo
# sync

sometimes XFS shutsdown, sometimes machine hard reboots, no serial
console msgs.

I'm not sure where to begin, so anyone who has an idea let me know what
info is needed.

-- 
Jeremy Jackson
Coplanar Networks
(519)489-4903
http://www.coplanar.net
jerj@coplanar.net

