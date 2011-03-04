From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Should minimum_io_size be adjustable (fake 512/4KB drives)?
Date: Fri, 4 Mar 2011 14:43:15 +0100
Message-ID: <20110304134315.GA7044@gentoo.trippels.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ud10.udmedia.de ([194.117.254.50]:40207 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab1CDNnS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2011 08:43:18 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

My new hard-drive (Seagate ST1500DL003) is a 4KB sector drive that
unfortunately reports a "physical sector size" of 512 byte.

cat /sys/block/sda/queue/physical_block_size
512
cat /sys/block/sda/queue/logical_block_size
512
cat /sys/block/sda/queue/minimum_io_size
512

I have created my filesystems on it with "mkfs.xfs -s size=4096".
Would there be any (performance) benefit if minimum_io_size could be
adjusted to 4096 (by the administrator) in this case?
-- 
Markus
