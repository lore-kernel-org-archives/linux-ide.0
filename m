From: Doug Maxey <dwm@austin.ibm.com>
Subject: [RFC] IDE/ATA/SATA controller hotplug
Date: Mon, 19 Jul 2004 14:47:39 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200407191947.i6JJldK1024910@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pixpat.austin.ibm.com ([192.35.232.241]:51735 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S265212AbUGSTro (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jul 2004 15:47:44 -0400
List-Id: linux-ide@vger.kernel.org
To: Linux IDE Mailing List <linux-ide@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Howdy!

  This note went out originally to a semi-internal list, but after
  several comments, posting it here...

  As we chug along here in PPC64 land, we (meaning IBM internal) have
  been given a requirement to make all devices on our new DLPAR
  (POWER5 and later) systems be hotplug capable.  This includes ALL
  PCI devices on the system, even those that are soldered on the
  motherboard.

  This raises some interesting issues when dealing with IDE devices.

  I realize there is considerable work under way (hi Bart :) to clean
  up the 2.6 trees.  This hotplug work would be another delta on top
  of that work.

  The changes could also possibly affect the libata work, as that
  could also be touched by work on the attached devices themselves.

  What I would like is input on the general strategy that should be
  taken to modify the controller/adapter and device stack to:

  1) be first class modules, where all controllers/adapters are
     capable of being loaded and unloaded.  This is directed mostly at
     IDE/Southbridge controller/adapter devices.

  2) extend that support to all child devices; disk, optical,
     and tape.

  3) be part of mainline.

  The items I perceive at the top of the issue list are:

  - The primary platforms for IDE/ATA devices are x86 based, and
    certainly do not care about having this capability.

  - Assuming the capability is added, what rework would be acceptable
    for block devices?

  - Where should this capability go?  Fork a subset of IDE
    controllers, and put them under the arch specific dir?
    Or include all devices?

  - should we work to the goal of having the capability for all
    platforms, and all IDE devices?

++doug






