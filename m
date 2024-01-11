Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF4914F8A
	for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5FZ582u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015DCC433F1;
	Thu, 11 Jan 2024 11:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704971714;
	bh=LzU66jklggjG8F/Xc26nAq75dFH4siY/esxjhKlLSkw=;
	h=From:To:Subject:Date:From;
	b=k5FZ582uwZN6z2jSCnj05BQwZYxrtlFAAtABuIE9TBqCAQrRHVoOm1UMH9FyXzvZH
	 owrsNNQjUoJ2wwYT/l3NNpOQ6/CAYco2r0ACbDJ9Ww+9HxqwxLlRu7pjpXOuLt/2+J
	 rMEmgQUe85c3gVkWm4mK6nsCfrNt2BKgQf3oW1bH/oSfz7E1IvG8uo2Hs+6QwBEi9T
	 /q8GUnKySQ5vN3t6M4/BFUebneuNia9njsyulcW06Vz2IRZ3gwuB+EXknTGHW7Z+Nm
	 754e6bZrmFvHzprk5wqHT/f3rndciIO3Bx5lbJlvn5cYJM9XgM1fk3F0TckVkaM0Bj
	 VZK71Lkf7vIsg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libata-core: Do not try to set sleeping devices to standby
Date: Thu, 11 Jan 2024 20:15:12 +0900
Message-ID: <20240111111512.1255875-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ata ata_dev_power_set_standby(), check that the target device is not
sleeping. If it is, there is no need to do anything.

Fixes: aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 09ed67772fae..d9f80f4f70f5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2017,6 +2017,10 @@ void ata_dev_power_set_standby(struct ata_device *dev)
 	struct ata_taskfile tf;
 	unsigned int err_mask;
 
+	/* If the device is already sleeping, do nothing. */
+	if (dev->flags & ATA_DFLAG_SLEEPING)
+		return;
+
 	/*
 	 * Some odd clown BIOSes issue spindown on power off (ACPI S4 or S5)
 	 * causing some drives to spin up and down again. For these, do nothing
-- 
2.43.0

