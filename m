Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA63F75809
	for <linux-ide@vger.kernel.org>; Fri, 20 Mar 2026 03:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773978830; cv=none; b=ffK2xdDrEUvS7MpeRRZjC3vg6Af+xi/OBG6vymc4yeGicbtohMsZheCN4gFFJNSuHXR86wHfbO7czuJUUc8NDJg3oJpezSiCawUhk8qJaCGO01iFS7lqshvxyTiz1vpvNDjzx0vcA4Xef3fTRT/P9d57t0zEUZ1lrdrXM9hxLsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773978830; c=relaxed/simple;
	bh=izLSp1tl/zz7fHW21BjMsfCjT1KlS+8aUYxG7t6nQlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqNn1EeH0k0R17zzjH8wclmrVp9c5214ZS/WJZr9LT2eza/ktRgCKRbsW/9mIEWpfDRWvXDC1Lrd0NXXttFJN+vAJ6ncs63AX90NLsOsScX5wKfZ3ma2qMZZMrAH0P4g3aAiFUHZwnZzIvZ9gJmdbOkxWPGlDz0DjkSdy00sUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMCumbok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMCumbok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5703C4CEF7;
	Fri, 20 Mar 2026 03:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773978830;
	bh=izLSp1tl/zz7fHW21BjMsfCjT1KlS+8aUYxG7t6nQlo=;
	h=From:To:Cc:Subject:Date:From;
	b=iMCumbokAh8J9MYB44lH397fQF693+55/+jw/Lv1x+NmkhbzoxuBS3JINEKvBl3gc
	 T6ECNHHzaO/JcTNyKaBN3VkaBecWDGFRPF7L10QS1iPL6aOrZDM6QPvFKUnXyBFI79
	 k43iQLCjF+7KksxXt8/gYtUiH3fCGKBWyFHrwolR7t/DxgaKP+YDwaPFhQq6oNqv6a
	 5mo8B0y/UZEgH4ljYrU0xt1JIIfyJqVXCdlfClTcF6/C3cvxJTQMpIhUoi7nmFTuXn
	 gqFYjvYPBruzm/f4PGie8S1a6E9QWQt7Jek4nIsfL4PdCaJ21Wk7E8GBfHRlSaDQDz
	 LH2yuVx0bLJwA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] ata: libata-scsi: report correct sense field pointer in ata_scsiop_maint_in()
Date: Fri, 20 Mar 2026 12:48:01 +0900
Message-ID: <20260320034801.529964-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4ab7bb976343 ("ata: libata-scsi: Refactor ata_scsiop_maint_in()")
modified ata_scsiop_maint_in() to directly call
ata_scsi_set_invalid_field() to set the field pointer of the sense data
of a failed MAINTENANCE IN command. However, in the case of an invalid
command format, the sense data field incorrectly indicates byte 1 of
the CDB. Fix this to indicate byte 2 of the command.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 4ab7bb976343 ("ata: libata-scsi: Refactor ata_scsiop_maint_in()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index ad798e5246b4..3b65df914ebb 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3600,7 +3600,7 @@ static unsigned int ata_scsiop_maint_in(struct ata_device *dev,
 
 	if (cdb[2] != 1 && cdb[2] != 3) {
 		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
-		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
+		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
 		return 0;
 	}
 
-- 
2.53.0

