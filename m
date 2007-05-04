From: Simon Kirby <sim@netnation.com>
Subject: Data corruption with sata_sil (Sil 3112)
Date: Fri, 4 May 2007 01:59:55 -0700
Message-ID: <20070504085955.GA5937@hostway.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from newpeace.netnation.com ([204.174.223.7]:50748 "EHLO
	peace.netnation.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1767772AbXEDJkM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 05:40:12 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello,

I've been having problems with Sil 3112 cards I purchased for additional
SATA ports resulting in read data corruption, about 3-5 instances over
2 GB of data, 100% reproducible.

I tried fiddling with PCI latency timer, underclocking, all sorts of
stuff, all no help.

I just rebuilt the entire box with the remains of another (went from
A7V8X (VIA) to A7N8X (NVidia), new CPU, new RAM, new power supply),
thinking the problem was related to the motherboard.  The issue followed
to the new box.

This new motherboard has an onboard Sil 3112 as well.  The old onboard
was VIA SATA, which did not corrupt anything.  The Sil 3112 onboard now
does too.

I noticed the driver has a request-limit quirk.  I tried forcing this on
-- same results.  I noticed there is a DMA-limiting quirk -- forced on,
same result.

I can't seem to find a way to make this chipset not corrupt reads.

Am I alone?

Scipt used to md5sum to find corruption:

	find $* -type f -print0 | sort -z | xargs -0 md5sum

Reproduced on any recent 2.6 kernel version (2.6.18 - 2.6.21).

Simon-
