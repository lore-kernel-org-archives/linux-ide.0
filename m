From: Daniel Brahneborg <daniel.com@wtnord.net>
Subject: siimage and drive order problem
Date: Fri, 26 Dec 2003 08:54:50 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031226085450.A4045@nettis.grimsta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 212-214-141-193.v-by.wtnord.net ([212.214.141.193]:60296 "EHLO
	ricercar.mine.nu") by vger.kernel.org with ESMTP id S264971AbTLZHzA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Dec 2003 02:55:00 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: alan@redhat.com
Cc: linux-ide@vger.kernel.org

Greetings,

I have an Abit KV7 motherboard with an Serial-ATA PCI
card with a si3112 chipset.  The motherboard has two
additional serial-ata slots on a VIA chip, and a normal
IDE disk on ide0.

My problem is that when I boot with siimage.c enabled
or try to insert it as a module after booting, it forces
the drives on that card to become hda and hdb, messing
things up pretty badly.  How can I force that driver to
use hde/hdf/... instead?  Without it the drives aren't
usable at all.

I want a setup where hda-hdd lives on the old ATA bus
and the two Serial-ATA cards comes afterwards.  Is that
possible?

I've searched through all documentation I can find, but
everybody seems to want to have the S-ATA drives as hda,
hdb etc.

Many thanks,

/Basic

