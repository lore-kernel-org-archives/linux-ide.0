From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_sil: remove unaffected drives from m15w blacklist
Date: Wed, 1 Mar 2006 15:13:50 +0900
Message-ID: <20060301061350.GA26900@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:5590 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932440AbWCAGNz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 01:13:55 -0500
Received: by zproxy.gmail.com with SMTP id n29so61883nzf
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 22:13:55 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>

m15w blacklist overgrew by attributing unrelated problems to m15w
including R_ERR on DMA activate FIS errata.  This patch shrinks
sata_sil m15w blacklist such that it's as reported by Silicon Image.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Carlos Pardo <Carlos.Pardo@siliconimage.com>

---

As said earlier, I think this patch needs testing in -mm for some
time.  Maybe this should be merged only into #ALL.

diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 91ecf52..3d82b84 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -110,12 +110,8 @@ static const struct sil_drivelist {
 	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST360015AS",		SIL_QUIRK_MOD15WRITE },
-	{ "ST380013AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
-	{ "ST3160023AS",	SIL_QUIRK_MOD15WRITE },
-	{ "ST3120026AS",	SIL_QUIRK_MOD15WRITE },
-	{ "ST3200822AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
