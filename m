From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: check Word 88 validity in ata_id_xfer_mask()
Date: Sun, 12 Mar 2006 12:34:35 +0900
Message-ID: <20060312033435.GC29870@htj.dyndns.org>
References: <11415871161635-git-send-email-htejun@gmail.com> <441364C1.1000007@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:55983 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750868AbWCLDel (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2006 22:34:41 -0500
Received: by pproxy.gmail.com with SMTP id d42so662399pyd
        for <linux-ide@vger.kernel.org>; Sat, 11 Mar 2006 19:34:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <441364C1.1000007@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Check bit 2 of Word 53 for Word 88 validity before using Word 88 to
determine UDMA mask.  Note that the original xfer mask implementation
using ata_get_mode_mask() didn't consider bit 2 of Word 53.  This
patch introduces different (correct) behavior.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 libata-core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 42d43b5..e2529e9 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -819,7 +819,10 @@ static unsigned int ata_id_xfermask(cons
 	}
 
 	mwdma_mask = id[ATA_ID_MWDMA_MODES] & 0x07;
-	udma_mask = id[ATA_ID_UDMA_MODES] & 0xff;
+
+	udma_mask = 0;
+	if (id[ATA_ID_FIELD_VALID] & (1 << 2))
+		udma_mask = id[ATA_ID_UDMA_MODES] & 0xff;
 
 	return ata_pack_xfermask(pio_mask, mwdma_mask, udma_mask);
 }
