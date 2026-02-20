Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D7923A99E
	for <linux-ide@vger.kernel.org>; Fri, 20 Feb 2026 05:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771563972; cv=none; b=cJNwfLmSZmRnp8ZcVT26KR5wB61Pu3DZ43R1S/XSFzt/9nGz72ejMUHhxCdjeiA4ZNW8F1qN/88JwG8Qw6+sUAECKn6WRz2nkzlhNatJu3EVNXbcrw0aqAnXKfu0QM81aOL5xZNQ8dXPOlZ0rjtR0/ydQXLE9A0bITA2Xpq1hHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771563972; c=relaxed/simple;
	bh=t99LW8lym2NGN3MKG6UZlD3bsRMUZ2RQcMKzIFlWYxg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQ26LYO2f1aY+BaTL/KpQGWWH3iuCVvDXENVPJle7KzsiKyVJUd/75ENR9blHCtlaZINtIYdfORzad9x2r5IGK4I1J/GaUOxZX1iHgIEHyKRuDRkkzrEY+0i1133SX+XEvYtu3h6lYyfLDk0D1qyoN2MKo8ypPh+IG/GFTpecP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TysRNkp5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TysRNkp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B65C116D0;
	Fri, 20 Feb 2026 05:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771563971;
	bh=t99LW8lym2NGN3MKG6UZlD3bsRMUZ2RQcMKzIFlWYxg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TysRNkp52LkmTgXF9nqWWVPylYLKXCxkPAhRriSyblAcSUeOBItlN4YoKIzcL5SLD
	 U2kfaR0MuZuVvJ/HTZ8veZdL8rPqoXTwzWOpDMXEy7+erDGJt8BNfkBWuGcrHrg6Z5
	 oyu2flq3mzbTpdFQMspPueSXvew4oXk4VKBZbvSM8ahA1oZtiBpjHlp5+ByGCvkFhE
	 5Z02BDvQp4XIeiySFGXJAcpIqbGvatqX39SqR6XjVo5ArO17Mkuyyr15FKm4MBrkX5
	 Zzw/co098j6jHTW1uJ3I5aRgBhBiLjI2WHD3qknGWFgWyD8A9Dxv/2P3/kYL90M4AT
	 Zhpw543Vy+Kgw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/2] ata: libata-core: fix cancellation of a port deferred qc work
Date: Fri, 20 Feb 2026 14:00:53 +0900
Message-ID: <20260220050053.390135-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220050053.390135-1-dlemoal@kernel.org>
References: <20260220050053.390135-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cancel_work_sync() is a sleeping function so it cannot be called with
the spin lock of a port being held. Move the call to this function in
ata_port_detach() before locking the port and add a call to
ata_scsi_requeue_deferred_qc() to make sure there are no remaining
deferred qc.

Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index beb6984b379a..54afa4df987e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6254,9 +6254,18 @@ static void ata_port_detach(struct ata_port *ap)
 	/* Wait for any ongoing EH */
 	ata_port_wait_eh(ap);
 
+	/* Requeue any remaining deferred qc. */
+	ata_scsi_requeue_deferred_qc(ap);
+
 	mutex_lock(&ap->scsi_scan_mutex);
+
+	/* Make sure the deferred qc work finished. */
+	cancel_work_sync(&ap->deferred_qc_work);
+
 	spin_lock_irqsave(ap->lock, flags);
 
+	WARN_ON(ap->deferred_qc);
+
 	/* Remove scsi devices */
 	ata_for_each_link(link, ap, HOST_FIRST) {
 		ata_for_each_dev(dev, link, ALL) {
@@ -6269,10 +6278,6 @@ static void ata_port_detach(struct ata_port *ap)
 		}
 	}
 
-	/* Make sure the deferred qc work finished. */
-	cancel_work_sync(&ap->deferred_qc_work);
-	WARN_ON(ap->deferred_qc);
-
 	/* Tell EH to disable all devices */
 	ap->pflags |= ATA_PFLAG_UNLOADING;
 	ata_port_schedule_eh(ap);
-- 
2.53.0

