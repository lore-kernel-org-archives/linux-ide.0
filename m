From: Marco Wertejuk <wertejuk@mwcis.com>
Subject: Support for Promise S150 TX2 plus
Date: Thu, 30 Dec 2004 23:30:55 +0100
Message-ID: <20041230223055.GA28570@maeko.hayai.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from maeko.hayai.de ([217.172.178.38]:8635 "EHLO maeko.hayai.de")
	by vger.kernel.org with ESMTP id S261576AbUL3Wa6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Dec 2004 17:30:58 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,

I'm using a newly bought Promise Fasttrak S150 TX2 plus
sata controller which works fine with promise drivers
in 2.4 but when using redhat enterprise beta 4 with 2.6.9
kernel, it won't, although sata_promise.c looks as if
that card should work.

The kernel uses sata_promise version 1.0 but driver
version 1.01 doesn't seem to improve support for this
card, the diff with sata_promise.c from 2.6.10 with
the same file from redhat supplied 2.6.9 shows only
structural changes.

The lspci -v output from that card is:
02:0b.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 3d75 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 3d75
        Flags: bus master, 66Mhz, medium devsel, latency 72, IRQ 193
        I/O ports at d480 [size=128]
        I/O ports at d000 [size=256]
        Memory at feace000 (32-bit, non-prefetchable) [size=4K]
        Memory at feaa0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at fea90000 [disabled] [size=32K]
        Capabilities: [60] Power Management version 2

So this is probably a newer revision of this card than
those that are already supported and the pci id is not
present in the source.

Perhaps you can give me some hints how to get this
card running and if neccessary include proper support
for this card to sata_promise.c so that it will
incorporated into later kernels.

Regards,
Marco

-- 
Mit freundlichen Gruessen,
Marco Wertejuk - mwcis.com
Consulting & Internet Solutions
