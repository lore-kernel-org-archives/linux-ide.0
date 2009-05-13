From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 0/2] Series short description
Date: Wed, 13 May 2009 15:01:56 +0100
Message-ID: <20090513135941.11247.13097.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38131 "EHLO
	t61.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759335AbZEMNDk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 09:03:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Couple more little ATA patches. The ALi one would be good to get upstream
ASAP, the other is a performance item.
---

Alan Cox (1):
      libata: Use IGN_SIMPLEX for ALi

Arjan van de Ven (1):
      ata_piix: Enable parallel scan


 drivers/ata/ata_piix.c |   29 ++++++++++++++++++++---------
 drivers/ata/pata_ali.c |   17 +++++++++++------
 2 files changed, 31 insertions(+), 15 deletions(-)

-- 
 "And the nice thing is you don't need to be able to type, because every
  possible keystroke does {something} for/to you. Anything from point out
  off-by-one errors to perform a sex change on your gerbil."
			-- Bill Davidsen describing emacs
