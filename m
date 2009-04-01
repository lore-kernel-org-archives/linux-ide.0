From: Mikael Abrahamsson <swmike@swm.pp.se>
Subject: PMPs
Date: Wed, 1 Apr 2009 21:18:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.10.0904012109180.28814@uplift.swm.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from swm.pp.se ([212.247.200.143]:54296 "EHLO uplift.swm.pp.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757838AbZDATSr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Apr 2009 15:18:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by uplift.swm.pp.se (Postfix) with ESMTP id 80F179E
	for <linux-ide@vger.kernel.org>; Wed,  1 Apr 2009 21:18:44 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hello.

I have a SiL based PCI-E card and a PMP:

02:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)

ata8.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9

I'm using Ubuntu 8.10 kernel 2.6.27-11-generic #1 SMP Thu Jan 29 19:24:39 
UTC 2009 i686 GNU/Linux

I'm running into all kinds of weird behaviour, like only P1 (port 1 out of 
5) on the PMP working with single drive. Also, it seems to differ whether 
I have a WD or Samsung drive, the WD drive works alone in P1 and P2 of the 
PMP, with the Samsung drive only working alone in P1. If I put the Samsung 
drive in P1 and put the WD drive in P3, the P3 drive isn't recognised upon 
hotplug. If I unplug Samsung P1 drive and re-insert it in the same P1 
hotswat bay again, drives in both P1 and P3 are recognised upon P1 
spinning up and being recognised.

Is this a known problem?

This is perfectly reproducible, I can provide logs if that would help. I'm 
also willing to try 2.6.29.x if there has been work done after 2.6.27.

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
