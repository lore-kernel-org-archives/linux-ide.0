From: robert@robos.org (Robert)
Subject: Improper disk shutdown with 2.6.22.6?
Date: Wed, 19 Sep 2007 11:33:06 +0200
Message-ID: <20070919093306.GA2359@robos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from proxy3.bredband.net ([195.54.101.73]:49975 "EHLO
	proxy3.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235AbXISJeN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Sep 2007 05:34:13 -0400
Received: from peru.robos.org (83.227.163.7) by proxy3.bredband.net (7.3.127)
        id 46F02EF100097024 for linux-ide@vger.kernel.org; Wed, 19 Sep 2007 11:33:07 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

When shutting down this system running Linux 2.6.22.6, I get a warning =
about
the possibility that the disks are not properly shut down. When the pow=
er is
turned off, it sounds like the disks aren't spun down (but I may be mis=
taken
on that point).

http://linux-ata.org/shutdown.html claims that kernels newer than 2.6.2=
1 will
always spin down the disks, but is this really the case?
The manage_start_stop files exist.

Tell me if you'd like more detailed information about configuration and
hardware.


Robert =C3=96stling

