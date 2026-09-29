Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BDF36B934
	for <linux-ide@vger.kernel.org>; Tue, 29 Sep 2026 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700138; cv=none; b=Rtc1Lf4TzqeaV9Rxai6T/RPzPTxNfmnA+qyqvhRBAmHP9K4qna1dU4FmlU0bDssvZhXvy6Yz5w6RXKiGUxtZwch9aPZDK4PzfcJOh/qXu8vPpmNTiA5wRoRUzPbDNHQCryGe3fevEfRWSVdIsLFgeRKZzwzyu5fbbUGBZQ/fJCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700138; c=relaxed/simple;
	bh=4oNNBVrx7iWlKCs0k9aLCLQO+dCsFhb60Z7Vs+mKWdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDVw1uS1dkN4lQDslCtNxDjj72gP6RFv9ubGjc4EorWFURA2nPVMgLKkYkNHMSdJBeHywI+zlavCtNsJePfqdsFAVWJOmYG0/7njyn3tdPSt81D4lx1XIMP/novVEQsBm8sYYTN9MtvT6Py3bznAb/fBagpfwUiRJ607wUrjdQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=TIAigef5; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="TIAigef5"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-53320dc09f3so33617731cf.1
        for <linux-ide@vger.kernel.org>; Tue, 29 Sep 2026 09:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1790700135; x=1791304935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qkmc9HSMYXuGuOTX21xyysxiwNQV626wcdXoxNjH/r4=;
        b=TIAigef5/fRo3DQh1ApmGh8ZNqLC/2sdOW/k1yVBYRMU8FzToEKFWJBY7+Xk8DU8r0
         6ke/fHBgWWjPDPMyzGymFLnEKdVbzwSQKGbfpHf8r1mJKYDGCj60TZBOSwg7/qg7bxRW
         ZN4/h785w6evL1B6sqc4K1A7MdkZ6aEdQirN0J3QnU8EnWriS1DDWxKoUjApAL7Zmwxk
         JDD98ViSGpLHdC2z16UbA8jTdtFBQBl1RFTnWVdiaaqyPHbr2P2wFr2lU8jCBzCZw9hs
         FdqPDrHyqX3RQqSHIJYGajaFFzgsGS6rTNwsfh7r7D4a9u55d9Gdh7ng6u6SBpJUCiCg
         aQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790700135; x=1791304935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qkmc9HSMYXuGuOTX21xyysxiwNQV626wcdXoxNjH/r4=;
        b=hDYPRREqPWPW2rfYm2XtURynOLeCt2ew4y8O06RiT4juyxvw4hqBJnzsiRtQf23xts
         7dtz/0QgxnQe1aoOUVE2mMo8c6rKluQT1+9b459RsKTaJ10uEMqYP4xQyZMGMQH+7doQ
         nOYK4T5ZL2u0FfZLjqFu+iYXpJJIdIAjg5mnTG4cBTNg1xKPK7bOrZ8xIL+5ASEEdYwj
         FFbZsHQocctdCkTEho6FjPeaCUQaVqWITFxP60U4qf92UXPlNgznxZY8vQBc/RacxHLV
         qvbWoIilLD/A+yuNjJRfzi/UrNS2Q8djoTLj++GPP5DQnVv6kMTin2VGcflZwUKqjWKb
         a+tA==
X-Forwarded-Encrypted: i=1; AKwUvBzCfNPJ9VxjdvdUlz13rWZMrXQMTXV/GIKzJbltTP+ZLvAWnBGjzfu19bJHRcqt8v34KnFe/OIItyY=@vger.kernel.org
X-Gm-Message-State: AFuF++n2te7ynlE0szIJrhSqFCZQktPLIHntSjUQsyu4xvynSYTd5z5r
	E08Iw92X0XQeKUas1mVe42/Ti3wfpKd6CYFKW1aevBdoAdkI1VwxO5FMNgQ0ezDq8Su8qQVxw51
	Ttt9ghDvt
X-Gm-Gg: AYBFou3YVVGOaDVrT69rJH988dJldSSYHuJwn7xhm+Mhf2AIKd0F9s2/y9a+S1ZZ/5s
	ds6Ae8QJIeQ3cmJfeNtzRY10PeZScpv1uBVDnEWWLPFiyxjpUyXwb7dyC1bEtLr06Q+RR7FHgT9
	QGmXCb4/oaRUCx0SLn0LGrGrAa/+uc5yxVWWADIP7xAMe0udCxgFQTf4NKJEfoO7BNEjab5c1kO
	gG6l0PJcHHQT/p79yx1WtYDJFriyNVbO9lPitmbQW+viLYiBJ6+wzaTkHs7RNzyD6L2TaaG/x3E
	7nH8dW95eSVfDzCsygo29iG6/TgHhVrcCgya9a7dYUulAnLzKEdzb6USkFzCLq9uqO7pGAjYTgQ
	DFx/x0gmYKh9/5C5Z/ZaR3ixwnHRjuHudwdtbX4Cox1unPOazPTomuIiOLbHSJ1w9nJL5VqDtNA
	P1nFmGFg8l7eqXedZ7M3JTULx/EQfNl2clhfU9Wgm1GEBDRq58tr77MyH8YcAVsxKxWKTp422js
	vEmr/T5h1WRPdZuHXYyVA==
X-Received: by 2002:a05:622a:2d6:b0:533:360f:e753 with SMTP id d75a77b69052e-533360ff66cmr172909001cf.35.1790700134841;
        Tue, 29 Sep 2026 09:42:14 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-533223efcc4sm90377781cf.25.2026.09.29.09.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 09:42:14 -0700 (PDT)
From: hengyul@cs.unc.edu
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: mkp@kernel.org,
	ipylypiv@google.com,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hengyu Liang <hengyul@cs.unc.edu>,
	stable@vger.kernel.org
Subject: [PATCH v2] ata: libata-scsi: do not lose CHECK CONDITION for failed ATAPI commands
Date: Tue, 29 Sep 2026 12:41:35 -0400
Message-ID: <20260929164135.266708-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hengyu Liang <hengyul@cs.unc.edu>

Since commit 2e1d2e65e773 ("ata: libata-scsi: terminate deferred commands
on time out"), atapi_qc_complete() sets SAM_STAT_CHECK_CONDITION for a
failed command only if cmd->result is zero, so that the DID_TIME_OUT or
DID_REQUEUE host byte of a terminated command is preserved.

However, cmd->result can also be non-zero for a regular failed ATAPI
command completed through libata EH: ata_eh_analyze_tf() calls
ata_eh_decide_disposition(), that is, scsi_check_sense(), on the sense
data obtained with REQUEST SENSE, and scsi_check_sense() sets the SCSI
midlayer internal byte of the result for some sense codes, e.g.
SCSIML_STAT_TGT_FAILURE for ILLEGAL REQUEST with ASC 0x20 (INVALID
COMMAND OPERATION CODE) or 0x24 (INVALID FIELD IN CDB), or
SCSIML_STAT_MED_ERROR for MEDIUM ERROR with ASC 0x11 (UNRECOVERED READ
ERROR). For such commands, atapi_qc_complete() keeps the result as is and
the command completes with a GOOD status byte, even though it failed and
valid sense data is available.

As a result, passthrough users see these failed ATAPI commands as
successful. For example, with the emulated IDE CD-ROM drive of QEMU and
no medium loaded, a PLAY AUDIO MSF command issued with SG_IO completes
with status 0x00 (and no DRIVER_SENSE) instead of 0x02 (CHECK CONDITION)
with sense key ILLEGAL REQUEST, ASC/ASCQ 0x20/0x00, and the CDROM ioctls
CDROMPLAYTRKIND, CDROMSUBCHNL, CDROMPAUSE, CDROMRESUME, CDROMPLAYMSF and
CDROM_GET_MCN return 0 instead of -ENOMEDIUM or -EOPNOTSUPP.

Fix this by setting the status byte to SAM_STAT_CHECK_CONDITION whenever
the host byte is not set. Use set_status_byte() rather than overwriting
the whole result, so that the SCSI midlayer internal byte set by
scsi_check_sense() is preserved, as ata_scsi_qc_complete() already does
for ATA commands.

Fixes: 2e1d2e65e773 ("ata: libata-scsi: terminate deferred commands on time out")
Cc: stable@vger.kernel.org
Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Changes in v2:
- Only set the status byte with set_status_byte() instead of overwriting
  cmd->result, so that the SCSI midlayer internal byte set by
  scsi_check_sense() is preserved (suggested by Niklas).
- Link to v1: https://lore.kernel.org/r/20260924180414.2102946-1-hengyul@cs.unc.edu

 drivers/ata/libata-scsi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 8f9aa97a519d..fb5517d51095 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3059,10 +3059,15 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 		if (qc->cdb[0] == ALLOW_MEDIUM_REMOVAL && qc->dev->sdev)
 			qc->dev->sdev->locked = 0;
 
-		if (cmd->result)
-			ata_scsi_qc_done(qc, false, 0);
-		else
-			ata_scsi_qc_done(qc, true, SAM_STAT_CHECK_CONDITION);
+		/*
+		 * Report CHECK CONDITION unless the command was terminated
+		 * with a host byte set. Only set the status byte, so that the
+		 * SCSI midlayer internal byte, which scsi_check_sense() may
+		 * have set from the sense data, is preserved.
+		 */
+		if (get_host_byte(cmd) == DID_OK)
+			set_status_byte(cmd, SAM_STAT_CHECK_CONDITION);
+		ata_scsi_qc_done(qc, false, 0);
 		goto schedule_deferred;
 	}
 
-- 
2.53.0

