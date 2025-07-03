Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431E233712
	for <linux-ide@vger.kernel.org>; Thu,  3 Jul 2025 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751527072; cv=none; b=i7ZcfQjf7xJeIVdGdorYxFzo9Ro7CfQPrJUw05gfDTj4yXZ60yRtdKSwlaxnBgo9WjWs+MI360nyx6DAjjlvdYMRLuJaMBhEt91I+x2obhKrMQcKeomPiZ3O7istR4blxXtmM77rvZMvt43tZxWTB6OIIxvCfPsbbFahDJBh9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751527072; c=relaxed/simple;
	bh=fLYxXxR4d39yzRKQzRVslyItefIpVLq/KCHMNfUSUzI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTst9yVeizOZb/Tg6SfwHaybpAUz7LB+Kda0o4JEhWKldia9S/uLltDxVSN51NxZGwsTUJeNuMFLFJAjXJS88YVZpojbG5E6wt6iyu3xeY/l3IOOs/X9IiBQn6TUdgXqgOf7ZPzDpwXh11rSJ4qYbSIbLZTXi26juH0SztC9dZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqJOD9Ee; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqJOD9Ee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFF6C4CEE3;
	Thu,  3 Jul 2025 07:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751527072;
	bh=fLYxXxR4d39yzRKQzRVslyItefIpVLq/KCHMNfUSUzI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sqJOD9EepytrpbJ1xt0PaxTgv0Bf8ajYg7LIpi4BVNBuy982B16tVrPtwqm3UUJe7
	 7HogP4gJosYBkw1E1PVdTeDkISOfktVjC2PoQ0eR5KvnTABZW0JxfMeJdxBgVPUDpH
	 HuSwALvVrpwhXtOMeoe6LRokhJsI/t9dKZnytyKTmzASh1glvUqNBDUJU4VB99ovFQ
	 AEkLbdPcDS+BypHr+TcHnFyPGDM/sp5AZV5H7kUanaigfuWih7xztIebA3Mmv2NDcl
	 2G/Y9wu1xtMnhE9y7OMs/Q4/3t7BUuZmXNj9xbTk16YsJRyRQUbuUdSyhGkleLDaN2
	 uc7nVMCnYwFVQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/3] ata: libata-core: Make ata_dev_cleanup_cdl_resources() static
Date: Thu,  3 Jul 2025 16:15:40 +0900
Message-ID: <20250703071541.278243-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703071541.278243-1-dlemoal@kernel.org>
References: <20250703071541.278243-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function ata_dev_cleanup_cdl_resources() is called only from
ata_dev_init_cdl_resources() and ata_dev_free_resources() which are
both defined in drivers/ata/libata-core.c. So there is no need for
ata_dev_cleanup_cdl_resources() to be visible from outside of this
file. Change this function definition to be a static function.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 2 +-
 drivers/ata/libata.h      | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 806ff5cee2b4..fb06aef8e0f6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2514,7 +2514,7 @@ static void ata_dev_config_trusted(struct ata_device *dev)
 		dev->flags |= ATA_DFLAG_TRUSTED;
 }
 
-void ata_dev_cleanup_cdl_resources(struct ata_device *dev)
+static void ata_dev_cleanup_cdl_resources(struct ata_device *dev)
 {
 	kfree(dev->cdl);
 	dev->cdl = NULL;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 8e68f4556962..767a61f8ff89 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -97,7 +97,6 @@ extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern const char *sata_spd_string(unsigned int spd);
 extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 				      u8 page, void *buf, unsigned int sectors);
-void ata_dev_cleanup_cdl_resources(struct ata_device *dev);
 
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
-- 
2.50.0

