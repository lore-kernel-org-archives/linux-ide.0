From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/3] ide: Fix use of paired device
Date: Thu, 18 Oct 2007 10:56:18 +1000
Message-ID: <1192668978.21882.719539599813.qpush@grosgo>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:36519 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756248AbXJRA4V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 20:56:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

At least 2 drivers (siimage and cs5535) have a bug where they use
the construct:

	ide_drive_t *pair	= &hwif->drives[drive->dn ^ 1];

To access the other drive in a master/slave pair. This is bogus
because drive->dn is not the unit number, but the global drive
number, thus can be 2 & 3 for ide1, 4 & 5 for ide2 etc...

This causes the driver to access beyond the drive array into lalaland
for any other interface than ide0 and in some case, actually crash :-)

These 3 patches fix those by introducing a ide_get_paired_drive()
helper that does the right thing and then using it.

Please apply to 2.6.24 if no objection.

