From: Tejun Heo <htejun@gmail.com>
Subject: [libata-dev #upstream-fixes] pata_legacy: don't call ata_host_detach()
 after initialization failure
Date: Wed, 13 Feb 2008 18:20:19 +0900
Message-ID: <47B2B653.7020408@gmail.com>
References: <alpine.LFD.1.00.0802101603240.2920@woody.linux-foundation.org> <20080212081816.GA17820@elte.hu> <20080212071452.5c58ae6d@laptopd505.fenrus.org> <20080213090159.GA21614@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:60517 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbYBMJU2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 04:20:28 -0500
Received: by el-out-1112.google.com with SMTP id v27so2213774ele.23
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 01:20:27 -0800 (PST)
In-Reply-To: <20080213090159.GA21614@elte.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Mark Lord <mlord@pobox.com>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

ata_host_detach() detaches an attached port and shouldn't be called on
a port which hasn't been attached yet.  pata_legacy incorrectly calls
ata_host_detach() on unattached port after initialization failure
causing oops.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>
---
 drivers/ata/pata_legacy.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 333dc15..7383f19 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -1278,8 +1278,6 @@ static __init int legacy_init_one(struct legacy_probe *probe)
 		}
 	}
 fail:
-	if (host)
-		ata_host_detach(host);
 	platform_device_unregister(pdev);
 	return ret;
 }
