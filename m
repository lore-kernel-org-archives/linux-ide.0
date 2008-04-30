From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] sata_inic162x: make it work
Date: Wed, 30 Apr 2008 16:35:07 +0900
Message-ID: <12095409172824-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:39296 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145AbYD3HfY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 03:35:24 -0400
Received: by py-out-1112.google.com with SMTP id u52so616515pyb.10
        for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2008 00:35:24 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Hello, Jeff, Alan.

Initio took the sata_inic162x driver, implemented ATA_PROT_DMA using
IDMA, renamed it to sata_initio162x and posted on their website.  It
didn't work very well for me but contained enough hint on how to use
IDMA mode.

So, this is the patchset to make sata_inic162x to use IDMA for
everything including ATAPIs.  There are still some issues - result TF
is not accessible, !read ATAPI commands should be issued using
ATAPI_PROT_PIO, but overall, everything including suspend/resume,
hotplug and burning cd/dvds works nicely.

Thanks.

--
tejun
