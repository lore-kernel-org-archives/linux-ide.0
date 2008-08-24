From: "Jeffrey W. Baker" <jwbaker@gmail.com>
Subject: SATA ALPM min_power causes > 10s delay on resume
Date: Sun, 24 Aug 2008 10:27:50 -0700
Message-ID: <1219598870.11057.2.camel@stinkpad>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:28485 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbYHXR2B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Aug 2008 13:28:01 -0400
Received: by wa-out-1112.google.com with SMTP id j37so601773waf.23
        for <linux-ide@vger.kernel.org>; Sun, 24 Aug 2008 10:28:01 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I started using the min_power ALPM setting on my ThinkPad to save power
(which works great, thanks!) but it causes a small problem.  When the
machine resumes from suspend-to-ram it hangs for about 10s and then
prints this on the console:

ata1: COMRESET failed (errno=-16)

It then proceeds normally.  The full messages are:

ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/100
ata1: failed to recover some devices, retrying in 5 secs
ata1: soft resetting link
ata1: SATA link down (SStatus 611 SControl 300)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting link
ata1: port is slow to respond, please be patient (Status 0x80)
ata1: COMRESET failed (errno=-16)
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

After which point the machine works normally.  The SATA controller is an
Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) SATA AHCI Controller (rev
03) and the SATA target is a SAMSUNG MCBQE32G Rev: PS10.  The kernel is
2.6.24.  I haven't tried anything newer.

If the ALPM setting is left at its default of max_performance then
resume from suspend is instant.  Is there any way to work around this?
ALPM is worth a solid 30 minutes of extra battery life, so obviously I'd
like to use it.  If nothing else, it might be helpful to have a module
parameter to shorten the timeout on known-working hardware.

-jwb

