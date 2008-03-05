From: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>
Subject: Re: SATA HDD password problem
Date: Wed, 5 Mar 2008 14:49:42 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0803051443500.28213@Soyuz-KT.TeNet.Odessa.UA>
References: <Pine.LNX.4.64.0803051143450.27209@Soyuz-KT.TeNet.Odessa.UA>
 <47CE9264.1010600@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Te.NeT.UA ([195.138.80.34]:53364 "EHLO te.net.ua"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934090AbYCEMts (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Mar 2008 07:49:48 -0500
In-Reply-To: <47CE9264.1010600@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Wed, 5 Mar 2008, Jeff Garzik wrote:

:> kernel, kernel send RESET to SATA drive and password need to be entered 
:again > - so the kernel panics because it cant mount rootfs. How this 
:problem can be solved ?

:This is definitely an under-tested area, as most people do not enable this
:feature.
:
:Make sure libata module option 'noacpi' is disabled (0).

..........
[Hors]:root:~ # cat /sys/module/libata/parameters/noacpi
0
.........

:It sounds like a software bug, not HDD manufacturer bug, to me.

 Seems like something like "do_not_hard_reset" parameter for libata shoud 
exists, or may be different kind of resets exits in standart, for which 
password do not clear. My previous laptop was with IDE WD drive - no such 
problem existed for it. Seems like only SATA drives hits this.

:
:

		Rus
