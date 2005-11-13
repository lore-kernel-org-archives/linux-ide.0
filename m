From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sil24: add missing ata_pad_free()
Date: Mon, 14 Nov 2005 00:24:18 +0900
Message-ID: <20051113152418.GA14697@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:30340 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964920AbVKMPYj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Nov 2005 10:24:39 -0500
Received: by zproxy.gmail.com with SMTP id 14so1047695nzn
        for <linux-ide@vger.kernel.org>; Sun, 13 Nov 2005 07:24:39 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

sil24_port_stop() is missing call to ata_pad_free() thus leaking pad
buffer when a port is stopped.  This patch adds it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index d3198d9..55e744d 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -687,6 +687,7 @@ static void sil24_port_stop(struct ata_p
 	struct sil24_port_priv *pp = ap->private_data;
 
 	sil24_cblk_free(pp, dev);
+	ata_pad_free(ap, dev);
 	kfree(pp);
 }
 
