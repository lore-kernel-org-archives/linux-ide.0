From: Tejun Heo <tj@kernel.org>
Subject: [PATCH libata/for-3.14-fixes] sata_sil: apply MOD15WRITE quirk to
 TOSHIBA MK2561GSYN
Date: Mon, 3 Feb 2014 10:55:18 -0500
Message-ID: <20140203155518.GA30250@htj.dyndns.org>
References: <201401300324.s0U3OFFs006205@rs101.luxsci.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:64122 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbaBCPzX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Feb 2014 10:55:23 -0500
Received: by mail-qc0-f180.google.com with SMTP id i17so11304445qcy.39
        for <linux-ide@vger.kernel.org>; Mon, 03 Feb 2014 07:55:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201401300324.s0U3OFFs006205@rs101.luxsci.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: matson <lists-matsonpa@luxsci.me>
Cc: linux-ide@vger.kernel.org

>From 9f9c47f00ce99329b1a82e2ac4f70f0fe3db549c Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 3 Feb 2014 10:42:07 -0500

It's a bit odd to see a newer device showing mod15write; however, the
reported behavior is highly consistent and other factors which could
contribute seem to have been verified well enough.  Also, both
sata_sil itself and the drive are fairly outdated at this point making
the risk of this change fairly low.  It is possible, probably likely,
that other drive models in the same family have the same problem;
however, for now, let's just add the specific model which was tested.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: matson <lists-matsonpa@luxsci.me>
References: http://lkml.kernel.org/g/201401211912.s0LJCk7F015058@rs103.luxsci.com
Cc: stable@vger.kernel.org
---
Applied to libata/for-3.14-fixes.

Thanks!

 drivers/ata/sata_sil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index d67fc35..b7695e8 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -157,6 +157,7 @@ static const struct sil_drivelist {
 	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3120022ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3160021ASL",	SIL_QUIRK_MOD15WRITE },
+	{ "TOSHIBA MK2561GSYN",	SIL_QUIRK_MOD15WRITE },
 	{ "Maxtor 4D060H3",	SIL_QUIRK_UDMA5MAX },
 	{ }
 };
-- 
1.8.5.3

