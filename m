From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ide: fix drive side 80c cable check, take 2
Date: Mon, 5 Feb 2007 21:47:13 +0900
Message-ID: <20070205124713.GL1625@htj.dyndns.org>
References: <20070205074713.GF1625@htj.dyndns.org> <20070205111837.1981bda2@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:9361 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932300AbXBEMrU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 07:47:20 -0500
Received: by an-out-0708.google.com with SMTP id b33so1008757ana
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 04:47:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070205111837.1981bda2@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, stable@kernel.org, linux-ide@vger.kernel.org

eighty_ninty_three() had word 93 validitity check but not the 80c bit
test itself (bit 12).  This increases the chance of incorrect wire
detection especially because host side cable detection is often
unreliable and we sometimes soley depend on drive side cable
detection.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Ah... thanks.  That explains the code much better.  Fixed accordingly.

diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index badde63..6558055 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -607,6 +607,8 @@ u8 eighty_ninty_three (ide_drive_t *drive)
 	if(!(drive->id->hw_config & 0x4000))
 		return 0;
 #endif /* CONFIG_IDEDMA_IVB */
+	if (!(drive->id->hw_config & 0x2000))
+		return 0;
 	return 1;
 }
 
