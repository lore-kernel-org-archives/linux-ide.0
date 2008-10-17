From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 0/4] Small set of further libata patches
Date: Fri, 17 Oct 2008 19:08:20 +0100
Message-ID: <20081017180655.7781.15021.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38478 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754621AbYJQSIZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Oct 2008 14:08:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Sort out ninja32 suspend/resume
Do data draining to fix stuck DRQ errors
First cut at lost IRQ recovery

---
Alan Cox (4):
      libata: clean up the SFF code for coding style
      libata: Improve timeout handling
      libata: Drain data on errors
      pata_ninja32: suspend/resume support

 drivers/ata/libata-eh.c    |   19 +++-
 drivers/ata/libata-sff.c   |  222 +++++++++++++++++++++++++++++++-------------
 drivers/ata/pata_isapnp.c  |   12 ++
 drivers/ata/pata_ninja32.c |   43 +++++++--
 drivers/ata/pata_pcmcia.c  |   34 +++++++
 include/linux/libata.h     |    5 +
 6 files changed, 254 insertions(+), 81 deletions(-)

-- 
"I don't think we should kill you because you are right this time around."
			- Cristian Gafton
