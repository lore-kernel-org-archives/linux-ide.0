From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] pata_legacy: fix no device fail path
Date: Tue, 14 Apr 2009 12:59:03 +0900
Message-ID: <49E40A07.6010905@gmail.com>
References: <19f34abd0804200329j3308b081vc0732c3ec5c0b721@mail.gmail.com> <1208782090.7115.179.camel@twins> <480FF821.9050208@gmail.com> <49E0C102.4020705@pobox.com> <49E22ED9.40100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:25785 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbZDND6T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Apr 2009 23:58:19 -0400
In-Reply-To: <49E22ED9.40100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Vegard Nossum <vegard.nossum@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

When pata_legacy can't detect any device, it unregisters the
platform_device and fails detection.  However, it forgets to detach
ata host triggering weird failures as the host later gets freed by
devres while still attached.  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Peter Zijlstra <peterz@infradead.org>
---
Well, with or without test verification, this patch is correct.  Thanks.

 drivers/ata/pata_legacy.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 3f830f0..0c6dde8 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -1032,6 +1032,7 @@ static __init int legacy_init_one(struct legacy_probe *probe)
 			return 0;
 		}
 	}
+	ata_host_detach(host);
 fail:
 	platform_device_unregister(pdev);
 	return ret;
