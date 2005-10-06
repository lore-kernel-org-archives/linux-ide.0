From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev-2.6:sil24] sil24: implement tf_read callback
Date: Fri, 7 Oct 2005 01:43:19 +0900
Message-ID: <20051006164319.GA8047@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.197]:64201 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751143AbVJFQnv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 12:43:51 -0400
Received: by xproxy.gmail.com with SMTP id i30so295441wxd
        for <linux-ide@vger.kernel.org>; Thu, 06 Oct 2005 09:43:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux@horizon.com, efalk@google.com
Cc: linux-ide@vger.kernel.org

 Hello, guys.

 This patch implements ->tf_read callback for sil24.  It didn't use to
be necessary but new ata_gen_fixed_sense now makes use of ->tf_read
callback.  This patch is taken from Edward Falk's driver.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -229,6 +229,7 @@ static u8 sil24_check_status(struct ata_
 static u8 sil24_check_err(struct ata_port *ap);
 static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg);
 static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
+static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void sil24_phy_reset(struct ata_port *ap);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static int sil24_qc_issue(struct ata_queued_cmd *qc);
@@ -280,6 +281,8 @@ static struct ata_port_operations sil24_
 	.check_err		= sil24_check_err,
 	.dev_select		= ata_noop_dev_select,
 
+	.tf_read		= sil24_tf_read,
+
 	.phy_reset		= sil24_phy_reset,
 
 	.qc_prep		= sil24_qc_prep,
@@ -372,6 +375,12 @@ static void sil24_scr_write(struct ata_p
 	}
 }
 
+static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	struct sil24_port_priv *pp = ap->private_data;
+	*tf = pp->tf;
+}
+
 static void sil24_phy_reset(struct ata_port *ap)
 {
 	__sata_phy_reset(ap);
