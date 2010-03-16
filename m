From: Tino Keitel <tino.keitel@tikei.de>
Subject: Intel X25-M and device-initiated interface power management
Date: Tue, 16 Mar 2010 23:05:22 +0100
Message-ID: <20100316220522.GA14120@x61.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eazy.amigager.de ([213.239.192.238]:40501 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab0CPWOL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Mar 2010 18:14:11 -0400
Received: from x61.home (port-92-206-33-132.dynamic.qsc.de [92.206.33.132])
	by eazy.amigager.de (Postfix) with ESMTPA id 49D1CFA8008
	for <linux-ide@vger.kernel.org>; Tue, 16 Mar 2010 23:05:29 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I read that the Intel X25-M SSD consumes less than 0,3W during typical
usage if DIPM is enabled.  This would give noticable power saving even
compared to a spinned down hard disk.  I checked the hdparm -I output
on my notebook with the current hard disk, and it shows this:

*	Device-initiated interface power management

When searching for the corresponding hdparm output with X25-M in
google, I found only hdparm output with this feature unset.

What can I expect with a X25-M on my hardware regarding DIPM? It is a
ThinkPad X61s, lspci shows this:

00:1f.2 SATA controller [0106]: Intel Corporation 82801HBM/HEM
(ICH8M/ICH8M-E) SATA AHCI Controller [8086:2829] (rev 03)

Please CC: me in replies, as I'm not subscribed.

Regards,
Tino
