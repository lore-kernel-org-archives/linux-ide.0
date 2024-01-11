Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4D1154BD;
	Thu, 11 Jan 2024 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5Bo+gb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92572C43390;
	Thu, 11 Jan 2024 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704973887;
	bh=nihRM/HmW/B5OecPS2/9PBbqtPYOl0WjidOQkoL64Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S5Bo+gb2WeogGpxMcXOQViTeGO1IgCvHsOil9CQiXXQKyE0Ybiussho0NMmgQ6xbO
	 WcQB3BSs2DjBKEUXYpnr1RSx/98Y0bLkMLZdrt8FKPUQPQKXke0hqAjd/MRi2ajP3J
	 g6n+OsiW/fUx4pRt9/oQItzf1hHvl6jc//5quF5zkVVHTNmQ72XcqkOENjl08bFwBE
	 IMYNvZk7G47uVsxMxSA+wDvH3FAaLGr5o8Vyr7tkRJ1fMC3JSbGmDEp0l8nX/kO6V/
	 bZ+Gp7xa/SBSG/DT5yWys/FpYFLFOGNz+WBo13MYJwBfKHMzcodGyltEwK0kw3RGbx
	 XivM39JPbZLqg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Dieter Mummenschanz <dmummenschanz@web.de>,
	Wang Zhihao <wangzhihao9@hotmail.com>,
	linux-regressions <regressions@lists.linux.dev>
Subject: [PATCH 1/2] ata: libata-core: Do not try to set sleeping devices to standby
Date: Thu, 11 Jan 2024 20:51:22 +0900
Message-ID: <20240111115123.1258422-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111115123.1258422-1-dlemoal@kernel.org>
References: <20240111115123.1258422-1-dlemoal@kernel.org>
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
Cc: stable@vger.kernel.org
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

