From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 0/7] ata: Updates and improvements
Date: Mon, 05 Jan 2009 14:12:14 +0000
Message-ID: <20090105141102.28189.44312.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56415 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752011AbZAEOMD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 09:12:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Resynched against the current git head

---

Alan Cox (7):
      libata: Add 32bit PIO support
      libata: clean up the SFF code for coding style
      libata: Improve timeout handling
      libata: Drain data on errors
      pata_ali: Fix and workaround for FIFO DMA bug
      pata_ali: force initialise a few bits
      pata_hpt3x3: Workarounds for chipset


 drivers/ata/ata_piix.c    |    2 
 drivers/ata/libata-eh.c   |   19 +++
 drivers/ata/libata-sff.c  |  275 ++++++++++++++++++++++++++++++++++-----------
 drivers/ata/pata_ali.c    |  107 +++++++++++-------
 drivers/ata/pata_amd.c    |    4 -
 drivers/ata/pata_hpt3x3.c |   51 +++++++-
 drivers/ata/pata_isapnp.c |   12 ++
 drivers/ata/pata_mpiix.c  |    3 
 drivers/ata/pata_pcmcia.c |   34 +++++-
 drivers/ata/pata_sil680.c |    4 -
 include/linux/libata.h    |    8 +
 11 files changed, 398 insertions(+), 121 deletions(-)

-- 
	"Policy is a poor man's substitute for common sense."
			-- David Woodhouse
