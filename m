From: Yossi Down-Under <fcp@pop.co.za>
Subject: ide cdrom performance issue
Date: 05 Oct 2003 19:35:32 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1065375332.1355.9.camel@server>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ctb-mesg4.saix.net ([196.25.240.76]:40640 "EHLO
	ctb-mesg4.saix.net") by vger.kernel.org with ESMTP id S263222AbTJERff
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 5 Oct 2003 13:35:35 -0400
Received: from ckb-ip-nas-1-p233.telkom-ipnet.co.za (ckb-ip-nas-1-p233.telkom-ipnet.co.za [155.239.77.233])
	by ctb-mesg4.saix.net (Postfix) with ESMTP id 02463AAD3
	for <linux-ide@vger.kernel.org>; Sun,  5 Oct 2003 19:35:32 +0200 (SAST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Running RH9 with xcdroast and three recorders each on its own ide
channel configured for ide-scsi. Having trouble with buffer underruns.
Am told by xcdroast author that it is a kernel ide driver issue,
specifically not using dma for transfers and recommended I try a newer
kernel.

My question is whether the 2.5.75 kernel is going to improve this
situation before going to the trouble to install it?

Thanks,

L. Baker

