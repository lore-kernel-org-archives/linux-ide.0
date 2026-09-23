Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF442122E
	for <linux-ide@vger.kernel.org>; Wed, 23 Sep 2026 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185932; cv=none; b=NaKMfHXjr0305e3wQyK7tpndjc5NclWrYBYC/GFf5SPxhx/hF7ImhOsraeP91rGH3YAcnb/R6RAliceex5SeOcYjVva+OWGRK/wP3yp5TH3Qlhj2iqvtxoxA9eEoh3pb/FeOx6fPKen+TA60dLti6bXdvZK/vlodtbDVDKHPD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185932; c=relaxed/simple;
	bh=QFb8iVySwyLfgXL7jDS8KaEsZGAjMl/5sUCUCwPAoxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMroelOM7n3o/sNGdRmhETf4XT8MOq97hIC1/UJMKC8Iic7FgSmkSTgg/qqJZHkHjUcKd+kd4v7mQdJeyDZs3VnS7BloXi9kQFAWLixsE5dmJJeFVqBa0ONOoubRvljj6vcTFcw/hjrGdVhwAC/bUY37rbSnOYUvqJiVpvIRRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KF5ZBuj9; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF5ZBuj9"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso921130a91.1
        for <linux-ide@vger.kernel.org>; Wed, 23 Sep 2026 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790185928; x=1790790728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Clx5xb7m9CpojaBgnGTvFUUi96mrh39iGvs9B9m14SA=;
        b=KF5ZBuj9T11cCy2zNNN7Wt4wYfK8che2xWx0gjrDmkcpBWsDgDCVcE2P+9fC+FOUDT
         Y0BYAmWLvjatoxkM2nQR5qptC56N8hxbnzMrbMHzN3aFDN96yy7s2OYfJVNRk0cSnX/H
         sx3TVSrHFsDD9dKziaRyuuC9pOMhrUYyedLpcngUcBD6DZ4eoN9jERuiMthRjDTeDn8m
         +dGet01OM80724rpSKeGkOepXmPNSv8ameyq660bKOw+0+WuRGG2ptEI/yk5+YoHlX4F
         SsQ8wZ0AX9sLDfUMg44dAcaiCcsSgG6tSfpO7UQ9hvoQwbNyCSB4qM+6woboRZndKd5R
         EbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185928; x=1790790728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Clx5xb7m9CpojaBgnGTvFUUi96mrh39iGvs9B9m14SA=;
        b=QohDUD2LaiPUHL6FLfotW5HBLEvU4y927FMID4llL8PGgzOj0typJfRrYUkZMfLFsD
         Kjkjv/v1HiHOpw76EeO7mETZ5KXIwaRaVlwEb0z6CcpU5Kr2zjilwlvytduuGUVmjVdB
         IeNMDm3HdqIzTc956Cm+YYKHOs89hWNr+wOtqstlLarl93V5U8Vq6L+6fWkz+OgoLwTa
         z4beOGHBTci8FAHEoH7LONJOL2R4ua3lQHL0yANzMPS6FfTphVgDq0c43ohuBCBtTzml
         M0vb72CfPa81esvwJnbaGdXm3hvdekcGeJkVzTiBGsZAWJ5vG2CmUnwBpB8D7VtU0juw
         fYqQ==
X-Gm-Message-State: AFuF++miM2NUDr67604Hdsyag1ggOrU6PQhlczwxkyicSZ/nFGj5A7bu
	O+g9a48JkkZNXud7EzSZ1jQekPryaHusOf4fvczEs2/8WIcBY1T7uqLW
X-Gm-Gg: AYBFou0e3v9OBck77nQw5IYFjvPYy1TTf2ZiQfpYuUNU9it4v4kL2dZ4DmzkMNk4HT/
	rhKg8wUW2LPcxnKagfMkUfJSgD5mCJldxelpKSVvihr0FifjEM02HEKUruEYRa7FtnnQljJn9eO
	qAIw6I58IbosoeZhhruiEbEhpkQkyfBf9tnBOssiooNMqhCJkQq8y8WVkjAhKW9IXxRvBfPCBrK
	MB9BEOViJI/Q8oJeuB3YdOiX3+qZOjHNwVLEgkTYs7AJ78GqVQpecOSXRBvi2gVJnCdIiOJTriW
	e9MgTplW+4hdvoulYXhVARTAYUTZ4M7Q+fxwN+LKWqodkj90ZpZM31GrCzMZtw/q7xPE91/ae1U
	YMtupUK8VeW87d7YlgfLVDYRlQFBDN//S5vd/dqWpJ3iXDxUIg0OaXd25RJRpaW0+B+KePDp/77
	PGllx7LlTP+GLAiNiOiFVb2crxtwd/aySpYNWkN+G3+fbddOvzQSw1rddZbdgOKHvJvo5B/DPkG
	77j5abBcnJLuhszSXpoPX0/P6WtnZXFnHwY2mivW+9ukyt53t1VdPLP2mdILm68gl679YmkIPoP
	DHf/xlbl1Fj6I2qeBtrChq41gWMoYj/uFG1trrmXL+iony/REPl6zhPvD0V46w==
X-Received: by 2002:a17:90b:578f:b0:39e:4c80:44b7 with SMTP id 98e67ed59e1d1-3a07e513903mr3003339a91.26.1790185927616;
        Wed, 23 Sep 2026 10:52:07 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09738f98asm208110a91.15.2026.09.23.10.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:52:07 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ata: libata-scsi: bound the ATA passthru sense descriptor writes
Date: Thu, 24 Sep 2026 01:52:03 +0800
Message-ID: <20260923175203.1576825-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an ATA PASS-THROUGH command to an ATAPI device fails, the sense
buffer holds the device's REQUEST SENSE reply, and
ata_scsi_set_passthru_sense_fields() trusts its additional length
byte, sb[7], when adding the ATA Status Return descriptor.  A faulty
or malicious device can use that to make the kernel read and write
past the 96-byte buffer in three ways:

- scsi_sense_desc_find() is passed sb[7] + 8 as the buffer length, so
  its clamp against sb[7] does nothing and the walk runs off the end.
- A type-9 descriptor found near the end is filled in unchecked.
- A new descriptor at sb[8 + len] needs len + 22 bytes, not len + 14,
  so len 75..82 writes up to 8 bytes past the end.

Reproduced with KASAN under qemu, with the emulated ATAPI REQUEST SENSE
reply patched:

  BUG: KASAN: slab-out-of-bounds in scsi_sense_desc_find+0x1a5/0x210
  BUG: KASAN: slab-out-of-bounds in ata_scsi_qc_complete+0x1a15/0x1a50

Both are gone with this patch, and a valid descriptor is still filled
in.

Fixes: 97981926224a ("ata: libata-scsi: Do not overwrite valid sense data when CK_COND=1")
Cc: stable@vger.kernel.org
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
v2: check the found descriptor's offset instead of forming desc + 14,
which could point past the end of the buffer, as Niklas suggested.  The
two conditions are equivalent, so I kept Damien's Reviewed-by.

v1: https://lore.kernel.org/all/20260922182655.2423663-1-matthias.goergens@gmail.com/

 drivers/ata/libata-scsi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7e22bbc382384..8f9aa97a519d1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -261,12 +261,18 @@ static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
 
 		/* descriptor format */
 		len = sb[7];
-		desc = (char *)scsi_sense_desc_find(sb, len + 8, 9);
+		desc = (char *)scsi_sense_desc_find(sb, SCSI_SENSE_BUFFERSIZE, 9);
 		if (!desc) {
-			if (SCSI_SENSE_BUFFERSIZE < len + 14)
+			/*
+			 * The descriptor is written at sb[8 + len] and is 14
+			 * bytes long, so it needs len + 22 bytes of buffer.
+			 */
+			if (len + 22 > SCSI_SENSE_BUFFERSIZE)
 				return;
 			sb[7] = len + 14;
 			desc = sb + 8 + len;
+		} else if (desc - sb > SCSI_SENSE_BUFFERSIZE - 14) {
+			return;
 		}
 		desc[0] = 9;
 		desc[1] = 12;

base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
-- 
2.55.0

