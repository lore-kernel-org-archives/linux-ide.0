Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96435524D7
	for <linux-ide@vger.kernel.org>; Mon, 25 Dec 2023 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 2730614F2DB; Mon, 25 Dec 2023 10:20:29 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Phillip Susi <phill@thesusis.net>
Subject: [PATCH 1/1] libata: only wake a drive once on system resume
Date: Mon, 25 Dec 2023 10:19:15 -0500
Message-Id: <20231225151915.258816-2-phill@thesusis.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231225151915.258816-1-phill@thesusis.net>
References: <20231225151915.258816-1-phill@thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the event that more than one pass of EH is needed during system resume,
only request the drive be started once.
---
 drivers/ata/libata-eh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 120f7d7fb450..97284b5b67d1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -713,7 +713,7 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 				ehc->saved_ncq_enabled |= 1 << devno;
 
 			/* If we are resuming, wake up the device */
-			if (ap->pflags & ATA_PFLAG_RESUMING)
+			if (ap->eh_tries == ATA_EH_MAX_TRIES && ap->pflags & ATA_PFLAG_RESUMING)
 				ehc->i.dev_action[devno] |= ATA_EH_SET_ACTIVE;
 		}
 	}
-- 
2.30.2

