From: Mark Lord <liml@rtr.ca>
Subject: Anyone else out there have an ExpressCard to try?
Date: Wed, 17 Oct 2007 12:04:14 -0400
Message-ID: <4716327E.40903@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2539 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935071AbXJQQER (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 12:04:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

I have a Dell Inspiron 9400 with an external ExpressCard slot.
I've also got a "Bytecc" 2-port eSATA ExpressCard-34 that identifies as:

 Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)

To get it to work with Linux on my Dell notebook,
the pcihp_force=1 parameter is necessary for the pciehp module.

After that, it works great with libata and NCQ, of course,
with R/W performance in the 40-60 Mbyte/sec range (depends upon the drive).
Much better than with USB2 (28-30 Mbyte/sec).

The problems are with PCIe hotplug.

If the card is inserted prior to loading pci_hotplug + pciehp modules,
then it is not detected upon modprobe of those modules.
Removing and reinserting the card cures that.

After a suspend/resume (RAM) cycle, card insertion/removal is no longer
detected by pciehp, until doing:   rmmod pciehp; modprobe pciehp

Apparently many (all?) Dell notebooks have this problem,
because the ACPI BIOS lacks info/whatever for the ExpressCard slot.
I'm wondering if other brands (or other Dells, even) have similar issues.

So.. if you have one and ExpressCard slot and an ExpressCard,
could you please try testing the above scenarios, and post a reply?

In the reply, describe what works, what doesn't,
and whether or not the pciehp=force parameter was required.

On LKML, there is a patchset to fix the above issues,
and if you have those problems then please try the patches
and report back on that as well.

   http://lkml.org/lkml/2007/10/16/465

Thanks.
