From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/15] libata: add ATA_QCFLAG_IO
Date: Sun, 2 Apr 2006 18:51:53 +0900
Message-ID: <1143971513867-git-send-email-htejun@gmail.com>
References: <11439715124131-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:5252 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932315AbWDBJwG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 05:52:06 -0400
Received: by zproxy.gmail.com with SMTP id o37so1447008nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 01:52:06 -0800 (PST)
In-Reply-To: <11439715124131-git-send-email-htejun@gmail.com>
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

c990a902336e539c91d6f030f67d294674065c83
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
index cbbc821..a6d829c 100644
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


