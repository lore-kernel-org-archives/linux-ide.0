From: "Brian & Chamaigne Scamman" <scammanbc@earthlink.net>
Subject: RE: [PATCHSET #upstream-fixes] git tree available
Date: Tue, 20 May 2008 08:08:35 -0400
Message-ID: <006f01c8ba72$3ac5d1a0$6917a8c0@parents>
References: <12111273141039-git-send-email-htejun@gmail.com> <48305961.2050509@gmail.com> <006501c8ba19$c1f53340$6917a8c0@parents> <48323E4F.3050806@rtr.ca> <4832535B.1080505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-scoter.atl.sa.earthlink.net ([209.86.89.67]:49445 "EHLO
	elasmtp-scoter.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753851AbYETMIo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 May 2008 08:08:44 -0400
In-Reply-To: <4832535B.1080505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>, 'Mark Lord' <liml@rtr.ca>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
>Can you please describe what you did exactly?  sil3726/4726 has some 
>problems when its first fan out port goes online and offline while it's 
>powered up.  You want to keep it occupied at all times.
>
Here's the current setup:
- PMP powered via computer's power supply; on with computer
- SSD and bridges powered via computer's power supply; on with computer
- FC9 with new 2.6.26-rc2-hotplug-patches installed and booted
- Once computer is booted, login, open a terminal and dmesg -c
For the case which fails:
- plug SSD drive/bridge into PMP port 0
- plug eSata cable into PMP
- plug eSata cable into eSata port on controller
- watch the softreset timeout
For the case which works:
- plug eSata cable into PMP
- plug eSata cable into eSata port on controller
- watch the PMP become recognized
- plug SSD drive/bridge into PMP port 0
- watch the SSD drive become recognized

Steps above are repeatable. Previously I was applying power to the PMP while
the drives were attached (PMP, bridges and drives all receiving power at the
same time) and then plugging in the eSata cable, but this case always failed
as well.

>Also, does putting sslep(5) right before followup-SRST help?
>
I'll look at adding the sslep line and the new patch (independently).

-Brian

