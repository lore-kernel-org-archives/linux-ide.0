From: P@draigBrady.com
Subject: elusive BIOS workaround code
Date: Fri, 27 Feb 2004 12:19:39 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <403F35DB.4090302@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.corvil.net ([213.94.219.177]:32780 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261810AbUB0MTk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Feb 2004 07:19:40 -0500
Received: from draigBrady.com (pixelbeat.local.corvil.com [172.18.1.170])
	by corvil.com (8.12.9/8.12.5) with ESMTP id i1RCJdjD009203
	for <linux-ide@vger.kernel.org>; Fri, 27 Feb 2004 12:19:39 GMT
	(envelope-from P@draigBrady.com)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, I'm running 2.4.20 on an embedded system here, and have the
following annoying message at boot:

"PCI: Device 00:1f:1 not available because of resource collisions".

On this system that PCI device is a "82801CA IDE U100".

Googling a bit suggests that it's a BIOS problem and that
there are workarounds in ac kernels:

http://www.ussg.iu.edu/hypermail/linux/kernel/0211.3/0991.html
http://www.clustermatic.org/pipermail/linuxbios/2002-September/000228.h=
tml

Now I can't apply all of 2.4.20-ac2 as that would invalidate
the extensive testing, so I was wondering if anyone could
point to the pertinent code.

cheers,
P=C3=A1draig.

