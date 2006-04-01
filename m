From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/14] libata: add ATA_QCFLAG_IO
Date: Sat, 1 Apr 2006 19:48:36 +0900
Message-ID: <11438885163030-git-send-email-htejun@gmail.com>
References: <11438885151530-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:54728 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751395AbWDAKsq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 05:48:46 -0500
Received: by zproxy.gmail.com with SMTP id o37so1210246nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 02:48:46 -0800 (PST)
In-Reply-To: <11438885151530-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add a new qc flag ATA_QCFLAG_IO.  This flag gets set for normal IO
commands originating from SCSI midlayer.  This information will be
used by EH to determine transfer speed reconfiguration.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |    1 +
 include/linux/libata.h     |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

15c24fd9b6d0f94db93b29f21b9d96efadc6220a
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 096bdff..234e1ca 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1188,6 +1188,7 @@ static unsigned int ata_scsi_rw_xlat(str
 	u64 block;
 	u32 n_block;
 
+	qc->flags |= ATA_QCFLAG_IO;
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 
 	if (scsicmd[0] == WRITE_10 || scsicmd[0] == WRITE_6 ||
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9f942d4..1f9e6ea 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -161,7 +161,8 @@ enum {
 	ATA_QCFLAG_SG		= (1 << 1), /* have s/g table? */
 	ATA_QCFLAG_SINGLE	= (1 << 2), /* no s/g, just a single buffer */
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
-	ATA_QCFLAG_EH_SCHEDULED = (1 << 3), /* EH scheduled */
+	ATA_QCFLAG_IO		= (1 << 3), /* standard IO command */
+	ATA_QCFLAG_EH_SCHEDULED = (1 << 4), /* EH scheduled */
 
 	/* host set flags */
 	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host_set only */
-- 
1.2.4


