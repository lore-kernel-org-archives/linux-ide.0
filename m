From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 0/4] pata: imx: set timings for PIO modes up to PIO4
Date: Wed,  9 Nov 2016 02:56:34 +0200
Message-ID: <20161109005638.17691-1-vz@mleia.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:50568 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754016AbcKIA4l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 8 Nov 2016 19:56:41 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org

The changeset adds support of PIO modes up to PIO4 by setting
necessary timings in the driver, before the change it is assumed
that the timings are always set by a bootloader once and thus
only one possible PIO mode has been supported (PIO0). With
this change the driver can be used on boards without ATA controller
configuration done by a bootloader.

The change is tested on a legacy i.MX31 board with an HDD connected
by a 40-pin flat cable.

Vladimir Zapolskiy (4):
  pata: imx: sort headers out
  pata: imx: set controller PIO mode with .set_piomode callback
  pata: imx: add support of setting timings for PIO modes
  pata: imx: support controller modes up to PIO4

 drivers/ata/pata_imx.c | 82 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 25 deletions(-)

-- 
2.10.2

