From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: HPT34x progress - and a DMA question
Date: Thu, 18 Dec 2008 22:51:52 +0000
Message-ID: <20081218225152.2ad356d1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44539 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752460AbYLRWvh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2008 17:51:37 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id mBIMpr8R029935
	for <linux-ide@vger.kernel.org>; Thu, 18 Dec 2008 22:51:53 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No I don't have DMA working (yet), but I've no intention of being beaten
by an ATA controller. I have however identified the freeze and lock of
the box that occurs after a DMA timeout.

The 343/363 crashes if you write ->ctl with a live DMA outstanding. Now
its easy enough to fix in the driver - just wrap ata_sff_freeze. It
raises an interesting question however - which is should ata_sff_freeze
stop any running DMA in the general case ?

Alan
