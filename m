From: Matt Sealey <matt@genesi-usa.com>
Subject: how to handle pata_via when controller not in fully-pci-native mode
 (two irqs?)
Date: Sat, 23 Jun 2007 01:26:06 +0100
Message-ID: <467C689E.3050800@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:2827 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbXFWAZ3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jun 2007 20:25:29 -0400
Received: from 82-46-178-156.cable.ubr06.king.blueyonder.co.uk ([82.46.178.156] helo=[192.168.2.228])
	by mail.genesi-usa.com with esmtpa (Exim 4.66 (FreeBSD))
	(envelope-from <matt@genesi-usa.com>)
	id 1I1tC7-000PMT-4p
	for linux-ide@vger.kernel.org; Sat, 23 Jun 2007 00:09:39 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Just bringing this up again as it's about that time of year.

There's an issue with some Via southbridges (the only notable and confirmed
example I have being the VT8231 on the PegasosPPC) which can be configured
such that they report that they are in "PCI Native Mode", but in fact handle
(and report) legacy ATA interrupts through the ISA Bridge configuration.

There are several different ways you can set it up from having a single
IRQ (true PCI native), to using PCI register access but with IRQ routing
through a certain pair of interrupts (14/15 or 10/11) or by having real
legacy ISA access (ports in the low memory ranges and the old 14/15 pair
we all remember from the first ATA controllers).

My problem with the driver is twofold; first, the old IDE block driver had a
hack applied which singles out the Pegasos as a quirk and maps two
interrupts into the "hwif" depending on the channel being set up. I
wrote a simple heuristic test which checks the IDE controller and
ISA bridge configuration and works out the correct IDE interrupts to
use. I can submit this patch but since the IDE block layer is going the
way of the dodo I see no point in it.

The second and REAL problem is that I see no real way in libata to
place detection of this quirk for the updated (and better) driver. I
noticed a strange patch on the linuxppc-dev mailing list by a Freescale
employee which changed the PCI class code of a ULI controller which
somehow made the libata driver for that controller consider it a
not-quite-native driver; I am not sure how that was meant to work but
it was obviously a platform-specific solution.

Does anyone have an idea how we can integrate this 'quirk' of the
non-native native PCI mode and support two IRQs properly so we can
have pata_via work on Pegasos (distros are dropping the old drivers
as we speak..)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
