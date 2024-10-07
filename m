Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB51622086
	for <linux-ide@vger.kernel.org>; Mon,  7 Oct 2024 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321350; cv=none; b=X0kZtaMX0oobh9OkkQrMXVS3PDJD39FF6vZkDTZXXWB/Zh/mNjYR0ugdmuSYdv9N2k0F+7rR3WEqjVYzexVBjAxgVdRMRiz49Cnc3WiVpYQEhP4PjUbbPp5scUq5dRMXRlgu34hfTUEVLpo77Zup7wN6LYNDh2976C6wj9lSnPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321350; c=relaxed/simple;
	bh=O3M36Sq2PQmr7PLFuiTaeN9cZTRF6ey4q/h+iXr9dg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NB/OC6tUVKXBIyrPcgj5IqmQdN648hL9e5frgbDfykxiNs9cnxjIvWJYIF7SgNhEJLMFUXMdkIadmkPY7tC1qsxYiQaOyw3yZtWspAJIwV3ns9dfkuQsEuaVRxu8Tdl+9QYnOkZNy6/DxhihaG0z9zZ8S2bS8WDKo+LWbEvUmU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XifUkPrH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XifUkPrH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95CEC4CEC6;
	Mon,  7 Oct 2024 17:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728321350;
	bh=O3M36Sq2PQmr7PLFuiTaeN9cZTRF6ey4q/h+iXr9dg8=;
	h=From:To:Cc:Subject:Date:From;
	b=XifUkPrHH+LbYRDHjYYEHQWHIKR+jSnrAWUmg0nr/cicWzcOFrsLJU9AKwhEKki7b
	 3r1YU94xs0Lo/bBXrX0R9t9BdNDujZDKoXaex40H5r4JkYWsxbGYRKNP4beGnBMYnM
	 9s0qvENcymWonDcj98bm4Q0XzsyHoVilcO8rCoP8h7QhKgqk0ccp6tj2DiKkJudtV9
	 Sk9tsuacfoMpaGhA2pctqKdi5J5rX339Cce397FcUuR2nI6syx6X4dwDfQvl7ca36S
	 JvsvbsfA0nJ3rqDsvp37PI08Jux31kKdb6mTWN9I+nWtVv5vnwme1kXoGZb6OORdCO
	 xr9WVB1PJ6bXA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Cc: W <linuxcdeveloper@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata: avoid superfluous disk spin down + spin up during hibernation
Date: Mon,  7 Oct 2024 19:15:44 +0200
Message-ID: <20241007171544.1222925-2-cassel@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2849; i=cassel@kernel.org; h=from:subject; bh=O3M36Sq2PQmr7PLFuiTaeN9cZTRF6ey4q/h+iXr9dg8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJZxB0mcZ30CsjYwf3mhX1S1E+exyKfmKUVrbys797a6 qh7SbC6o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABO5lsnI0LNu+omVK2ZwCX7i q1rHpNFwy6Lziq3rH13dn7wXlX1ORDMyNLAsuKSbsdLsrf9U9aBvbbLmDgtrq/JOs38q27tdaGU VFwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

A user reported that commit aa3998dbeb3a ("ata: libata-scsi: Disable scsi
device manage_system_start_stop") introduced a spin down + immediate spin
up of the disk both when entering and when resuming from hibernation.
This behavior was not there before, and causes an increased latency both
when when entering and when resuming from hibernation.

Hibernation is done by three consecutive PM events, in the following order:
1) PM_EVENT_FREEZE
2) PM_EVENT_THAW
3) PM_EVENT_HIBERNATE

Commit aa3998dbeb3a ("ata: libata-scsi: Disable scsi device
manage_system_start_stop") modified ata_eh_handle_port_suspend() to call
ata_dev_power_set_standby() (which spins down the disk), for both event
PM_EVENT_FREEZE and event PM_EVENT_HIBERNATE.

Documentation/driver-api/pm/devices.rst, section "Entering Hibernation",
explicitly mentions that PM_EVENT_FREEZE does not have to be put the device
in a low-power state, and actually recommends not doing so. Thus, let's not
spin down the disk on PM_EVENT_FREEZE. (The disk will instead be spun down
during the subsequent PM_EVENT_HIBERNATE event.)

This way, PM_EVENT_FREEZE will behave as it did before commit aa3998dbeb3a
("ata: libata-scsi: Disable scsi device manage_system_start_stop"), while
PM_EVENT_HIBERNATE will continue to spin down the disk.

This will avoid the superfluous spin down + spin up when entering and
resuming from hibernation, while still making sure that the disk is spun
down before actually entering hibernation.

Fixes: aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3f0144e7dc80..fa41ea57a978 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -4099,10 +4099,20 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 
 	WARN_ON(ap->pflags & ATA_PFLAG_SUSPENDED);
 
-	/* Set all devices attached to the port in standby mode */
-	ata_for_each_link(link, ap, HOST_FIRST) {
-		ata_for_each_dev(dev, link, ENABLED)
-			ata_dev_power_set_standby(dev);
+	/*
+	 * We will reach this point for all of the PM events:
+	 * PM_EVENT_SUSPEND (if runtime pm, PM_EVENT_AUTO will also be set)
+	 * PM_EVENT_FREEZE, and PM_EVENT_HIBERNATE.
+	 *
+	 * We do not want to perform disk spin down for PM_EVENT_FREEZE.
+	 * (Spin down will be performed by the subsequent PM_EVENT_HIBERNATE.)
+	 */
+	if (!(ap->pm_mesg.event & PM_EVENT_FREEZE)) {
+		/* Set all devices attached to the port in standby mode */
+		ata_for_each_link(link, ap, HOST_FIRST) {
+			ata_for_each_dev(dev, link, ENABLED)
+				ata_dev_power_set_standby(dev);
+		}
 	}
 
 	/*
-- 
2.46.2

