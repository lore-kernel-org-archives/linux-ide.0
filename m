From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: libata hotplug question
Date: Mon, 30 Nov 2009 17:04:12 +1100
Message-ID: <1259561052.2076.73.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38137 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbZK3GEH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Nov 2009 01:04:07 -0500
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nAU64CKS029519
	for <linux-ide@vger.kernel.org>; Mon, 30 Nov 2009 00:04:13 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

So pata_macio is starting to look good, it even suspends and resumes on
a couple of test laptops, now is time to sort out the last piece of the
puzzle, which is the hotplug media-bay.

The old code use to call directly into drivers/ide ide_port_scan()
etc... from within the mediabay driver. Pretty filthy.

I'm changing that to something that's even simpler: the macio_driver
gets a new callback for plug/unplug events from the bay, so it will be
easy to keep the old driver do whatever drivers/ide cruft it wants
locally and do something different in libata.

Now, for libata, I haven't totally figured out what to do though.

It seems like when the state "changes", I can do something like ahci and
call ata_ehi_hotplugged() followed by something like ata_port_freeze()
to kick the EH... at least that's my rough understanding.

But I don't quite get how to inform libata that the part has or has not
something plugged in it. I thought about playing with the probe_mask but
it looks like ata_eh_link_autopsy() will reset that since I'm PATA, not
SATA and thus have no sata_scr_read()...

Any suggestion here ?

Cheers,
Ben.



