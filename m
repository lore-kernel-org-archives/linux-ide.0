From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 0/4] Series short description
Date: Wed, 06 May 2009 17:08:32 +0100
Message-ID: <20090506160612.24191.90737.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58413 "EHLO
	t61.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759518AbZEFPKJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 May 2009 11:10:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org

A quick batch of PIIX updates
---

Alan Cox (4):
      ata_piix: Remove stale comment
      ata_piix: Turn on hotplugging support for older chips
      ata_piix: The Sony TZ90 needs the cable type hardcoding
      ata_piix: ICH7 does not support correct MWDMA timings


 drivers/ata/ata_piix.c |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

