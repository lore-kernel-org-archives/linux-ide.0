From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: clear TF before IDENTIFYing
Date: Wed, 07 Feb 2007 12:37:41 -0800
Message-ID: <45CA3895.5010108@gmail.com>
References: <20070202151856.GD1625@htj.dyndns.org> <20070202211441.GA2933@artsapartment.org> <45C3EECF.2080100@gmail.com> <45C4E6BB.6020307@pobox.com> <45C84650.3030703@gmail.com> <20070206163303.GA2185@artsapartment.org> <45C93F1D.8090504@gmail.com> <20070207193513.GA1929@artsapartment.org> <45CA2DBF.9040403@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:22544 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423200AbXBHKhq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Feb 2007 05:37:46 -0500
Received: by ug-out-1314.google.com with SMTP id 44so422834uga
        for <linux-ide@vger.kernel.org>; Thu, 08 Feb 2007 02:37:45 -0800 (PST)
In-Reply-To: <45CA2DBF.9040403@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>, Jeff Garzik <jeff@garzik.org>
Cc: Art Haas <ahaas@airmail.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, stable@kernel.org

Some devices chock if Feature is not clear when IDENTIFY is issued.
Set ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE for IDENTIFY such that whole
TF is cleared when reading ID data.

Kudos to Art Haas for testing various futile patches over several
months and Mark Lord for pointing out the fix.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Art Haas <ahaas@airmail.net>
Cc: Mark Lord <mlord@pobox.com>
---
I think this should go into -stable but a little bit hesitant because
the code hasn't been tested widely.  This patch should really be
harmless but who knows.  Jeff, Mark, what do you think?

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 667acd2..d6fcf0a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1478,7 +1478,16 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	}
 
 	tf.protocol = ATA_PROT_PIO;
-	tf.flags |= ATA_TFLAG_POLLING; /* for polling presence detection */
+
+	/* Some devices choke if TF registers contain garbage.  Make
+	 * sure those are properly initialized.
+	 */
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+
+	/* Device presence detection is unreliable on some
+	 * controllers.  Always poll IDENTIFY if available.
+	 */
+	tf.flags |= ATA_TFLAG_POLLING;
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS);
