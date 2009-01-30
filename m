From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: DMA breakage in 2.6.29-rc*
Date: Fri, 30 Jan 2009 16:46:11 +1100
Message-ID: <1233294371.18767.23.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60269 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111AbZA3FqR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2009 00:46:17 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: list linux-ide <linux-ide@vger.kernel.org>

Hi Bart !

On a bunch of pmac's, I'm getting lost interrupts when trying to do DMA
with ide hard disks (first time at boot when reading the partition
table). It then times out, reverts to PIO and boots fine.

Haven't had time to fully bisect yet, but it seem to be somewhere in the
pile of IDE patches (surprise :-) that went in around that time.

I'll dig more next week, but in the meantime, I though you may have a
possible candidate in mind.

Cheers,
Ben.

