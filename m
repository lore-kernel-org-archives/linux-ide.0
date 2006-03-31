From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/15] libata: preserve SATA SPD setting over hard resets
Date: Sat, 1 Apr 2006 01:38:18 +0900
Message-ID: <11438230983250-git-send-email-htejun@gmail.com>
References: <1143823097579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:42854 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751418AbWCaQie (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 11:38:34 -0500
Received: by zproxy.gmail.com with SMTP id o37so955013nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 08:38:33 -0800 (PST)
In-Reply-To: <1143823097579-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Don't overwrite SPD setting during hard reset.  This change has the
(intended) side effect of honoring the BIOS configuration.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

5f8ccbb89585c3d80973c49e086b5f6fd0732d56
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 283994d..16095d8 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2310,9 +2310,11 @@ err_out:
 static int sata_phy_resume(struct ata_port *ap)
 {
 	unsigned long timeout = jiffies + (HZ * 5);
-	u32 sstatus;
+	u32 scontrol, sstatus;
 
-	scr_write_flush(ap, SCR_CONTROL, 0x300);
+	scontrol = scr_read(ap, SCR_CONTROL);
+	scontrol = (scontrol & 0x0f0) | 0x300;
+	scr_write_flush(ap, SCR_CONTROL, scontrol);
 
 	/* Wait for phy to become ready, if necessary. */
 	do {
@@ -2432,10 +2434,14 @@ int ata_std_softreset(struct ata_port *a
  */
 int sata_std_hardreset(struct ata_port *ap, int verbose, unsigned int *class)
 {
+	u32 scontrol;
+
 	DPRINTK("ENTER\n");
 
 	/* Issue phy wake/reset */
-	scr_write_flush(ap, SCR_CONTROL, 0x301);
+	scontrol = scr_read(ap, SCR_CONTROL);
+	scontrol = (scontrol & 0x0f0) | 0x301;
+	scr_write_flush(ap, SCR_CONTROL, scontrol);
 
 	/*
 	 * Couldn't find anything in SATA I/II specs, but AHCI-1.1
-- 
1.2.4


