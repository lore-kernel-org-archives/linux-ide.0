Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED47A481B6
	for <linux-ide@vger.kernel.org>; Sun,  5 Jan 2025 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736112996; cv=none; b=tFZcSWqdLHX1SmnnTIbCAUQE0TuIf8yHEmA9SAJbmhVMgIDuLMsAqzwqMBMjRqK5jR+KuaAXNnetqyG2FoBBXTRD4FGk2ijZgLCCxBkAsaI2wLjMUMPcp9jIpCYjD3LW70OxpURgYm9lLFSdygN6FJvDx23a8iuHCqnDFQYATNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736112996; c=relaxed/simple;
	bh=klvB4Gl8/WkFj/7ofot6ObIeJ+P3iDd7gUOsORTV0Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOSSMQFoBgDPZTxFU5nMah733AQUm8rYYvlmAneL2DXRLPUa6SgQWRrL2JL55LtDlj7D8nLsXTZYtTpYwQqmwKu/X12sf04aT+nCAdaXFFg2fVEtlZsSqxOMA5Be4FZe+pgXonGXZ48035btRoKCHBWKbm7GRkCKev20QVJPmG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=T4lsfNlt; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="T4lsfNlt"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id CB111240027
	for <linux-ide@vger.kernel.org>; Sun,  5 Jan 2025 22:36:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1736112985; bh=klvB4Gl8/WkFj/7ofot6ObIeJ+P3iDd7gUOsORTV0Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=T4lsfNltzEzYoATrLpZcFaIx7ahFb35GskLsuSzfYSiceLV4uMclxafYltbk2SvrC
	 DOJD/7M8gem0UY0aO2Oe4DdsDCI9oz0blsXCrI+n5eN9/mwNFbxSDSzWELebH8auIu
	 q+XQHZ6ZJFsBQn/I8HDN+dRLWTw3lliQYkJX+6+QU3vOJ7zXKITy0vPKsUOgdNYaQ7
	 lR/irfEZeZR5kgsQTI5+rN5n0T+W07qMd4dZHwoEoBgOKhZ66cYoHNHgPPl4CdQDam
	 Yfzqbywg8TJFfhUhcueIk0X1yKQdyuot0MhRhvyTCgKQC5n2zmlxhI2mUDAcVGC9Qk
	 8s0u/D359roTw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YR9c75pbpz6tyl;
	Sun,  5 Jan 2025 22:36:23 +0100 (CET)
From: Daniil Stas <daniil.stas@posteo.net>
To: linux-hwmon@vger.kernel.org
Cc: Daniil Stas <daniil.stas@posteo.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Chris Healy <cphealy@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH] hwmon: drivetemp: Fix driver producing garbage data when SCSI errors occur
Date: Sun,  5 Jan 2025 21:36:18 +0000
Message-ID: <20250105213618.531691-1-daniil.stas@posteo.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scsi_execute_cmd() function can return both negative (linux codes) and
positive (scsi_cmnd result field) error codes.

Currently the driver just passes error codes of scsi_execute_cmd() to
hwmon core, which is incorrect because hwmon only checks for negative
error codes. This leads to hwmon reporting uninitialized data to
userspace in case of SCSI errors (for example if the disk drive was
disconnected).

This patch checks scsi_execute_cmd() output and returns -EIO if it's
error code is positive.

Signed-off-by: Daniil Stas <daniil.stas@posteo.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
---

Although I see there is scsi_status_is_good() function, which probably
means that not all scsi result codes are errors? I don't know scsi
protocol much, so maybe someone else can check it.
The error code that i see when the drive is physically disconnected: 0x00030000.

 drivers/hwmon/drivetemp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
index 6bdd21aa005a..fdf1d3b3b5a5 100644
--- a/drivers/hwmon/drivetemp.c
+++ b/drivers/hwmon/drivetemp.c
@@ -192,8 +192,11 @@ static int drivetemp_scsi_command(struct drivetemp_data *st,
 	scsi_cmd[12] = lba_high;
 	scsi_cmd[14] = ata_command;
 
-	return scsi_execute_cmd(st->sdev, scsi_cmd, op, st->smartdata,
-				ATA_SECT_SIZE, HZ, 5, NULL);
+	int err = scsi_execute_cmd(st->sdev, scsi_cmd, op, st->smartdata,
+				   ATA_SECT_SIZE, HZ, 5, NULL);
+	if (err > 0)
+		err = -EIO;
+	return err;
 }
 
 static int drivetemp_ata_command(struct drivetemp_data *st, u8 feature,
-- 
2.47.1

