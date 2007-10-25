From: "Andrew" <andrew@nelless.net>
Subject: 2.6.24-rc1, sata_nv: MCP51 is boned with SWNCQ too
Date: Thu, 25 Oct 2007 10:54:12 +0100 (BST)
Message-ID: <34545.86.7.220.119.1193306052.squirrel@wmbeta.mxes.net>
Reply-To: "Andrew" <andrew@nelless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from turtle-out.mxes.net ([216.86.168.191]:3013 "EHLO
	turtle-out.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbXJYK3P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 06:29:15 -0400
Received: from mxout-04.mxes.net (mxout-04.mxes.net [216.86.168.179])
	by turtle-in.mxes.net (Postfix) with ESMTP id 19264163F6B
	for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 05:58:13 -0400 (EDT)
Received: from w16.irbs.net (w16.irbs.net [205.237.194.58])
	by smtp.mxes.net (Postfix) with ESMTP id CF66FD051F
	for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 05:54:12 -0400 (EDT)
Received: from wmbeta.mxes.net (w16.irbs.net [205.237.194.58])
	by w16.irbs.net (Postfix) with ESMTP id A7DAE172645
	for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 05:54:12 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I've noticed a thread reporting that SWNCQ can't be disabled
on the sata_nv.

Gerhard Dirschl
*	BUG: sata_nv swncq cannot be disabled

and another with a patch switching MCP61 to GENERIC instead
of SWNCQ

Kuan Luo
*	[PATCH] ata: sata_nv MCP61 using GENERIC instead of SWNCQ


I would like to to report that the MCP51 on my Asus A8NVM CSM
mainboard is dead due to timeouts with SWNCQ. Reverting sata_nv.c
to the version prior to git commit
f140f0f12fc8dc7264d2f97cbe663564e7d24f6d works around the problem.

My drives are all Seagate drives, ST3320620AS, ST3500630AS,
ST3300831AS.

Not subscribed, please CC.

Andrew

