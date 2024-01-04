Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCBE2CCB8
	for <linux-ide@vger.kernel.org>; Thu,  4 Jan 2024 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 1C76F151D5C; Thu,  4 Jan 2024 17:40:13 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Phillip Susi <phill@thesusis.net>
Subject: [PATCH 2/4] libata: don't wake sleeping disk during system suspend
Date: Thu,  4 Jan 2024 17:39:38 -0500
Message-Id: <20240104223940.339290-2-phill@thesusis.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104223940.339290-1-phill@thesusis.net>
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When suspending the system, libata puts the drive in standby mode to
prepare it to lose power.  If the drive is in SLEEP mode, this spins it up
only to spin it back down again.  Don't do that.
---
 drivers/ata/libata-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a2d8cc0097a8..1244da8f77e2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2030,6 +2030,10 @@ void ata_dev_power_set_standby(struct ata_device *dev)
 	    system_entering_hibernation())
 		return;
 
+	/* no need to standby if it is alreqady sleeping */
+	if (dev->flags & ATA_DFLAG_SLEEPING)
+		return;
+
 	/* Issue STANDBY IMMEDIATE command only if supported by the device */
 	if (!ata_dev_power_init_tf(dev, &tf, false))
 		return;
-- 
2.30.2

