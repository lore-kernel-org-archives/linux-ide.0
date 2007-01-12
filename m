From: "Dailey, Nate" <Nate.Dailey@stratus.com>
Subject: sata_vsc.c cache line size question
Date: Fri, 12 Jan 2007 14:45:23 -0500
Message-ID: <92952AEF1F064042B6EF2522E0EEF43703EE316A@EXNA.corp.stratus.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub4.stratus.com ([134.111.1.17]:38366 "EHLO
	mailhub4.stratus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030179AbXALTwn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 14:52:43 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeremy@sgi.com

Hoping someone on this list might shed some light on this...

I was investigating a problem of poor sequential write performance
(IOmeter, various size sequential writes) with an embedded Vitesse 7174,
maxing out (with disk write cache on) at around 10 MB/s...

After noticing that Windows on the same hardware was using 0x10 for the
cache line size, but Linux was using 0x80, I tried removing the
following from sata_vsc.c:

381         /*
382          * Due to a bug in the chip, the default cache line size
can't be used
383          */
384         pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);

Now, with cache line size the same as Windows, Linux is doing more like
43 MB/s.

Just wondering what the deal with this "bug in the chip" might be, since
for me it seems that the default cache line size is better? If there's a
real bug, I don't want to do anything dangerous by removing this code
(though I've heard--haven't seen the code--that the Windows driver
doesn't touch the cache line size, nor does the Linux non-libata
reference driver from Vitesse).

Thanks!
Nate
