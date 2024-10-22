Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795DBC2C8
	for <linux-ide@vger.kernel.org>; Tue, 22 Oct 2024 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729565142; cv=none; b=pctsTuJR/tFeSJzw2xtnX7UKfEjw/a7kM8rTPq4LoJzyiI49KrM+LBlKoS79MvxHM2Ey2ZpRByQ/IW8o/RrD7Jw4KyNYSqoKtznPknymkVWyNPCIa+ipO64H4T/YukWmMgmq6b/92Wl1EORI67feuELjlpIe3f3jCfi7JCe+mAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729565142; c=relaxed/simple;
	bh=lGdLx9HN2fw26ihne+DEBQsLhtVryKhWdf3zBrHVJHw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbV0V7khGANBzp7/T+tTX5IOsf6wOwBi2t/ShdiC84Cut2Byy0ShXzwrytlBBLc68Js1L1/DZlxoicZbdYry1KkQk4l7dBniXtnjVwoQG9V0JAWfXeU8gClvq4MmHXssLAk3CDd1ZXLRQANJrmuyrH44BWsZJlGDyuMK4RniiKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGbd6CrP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGbd6CrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C3DC4CEC3;
	Tue, 22 Oct 2024 02:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729565142;
	bh=lGdLx9HN2fw26ihne+DEBQsLhtVryKhWdf3zBrHVJHw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sGbd6CrPa4OHlEm165Z2sXVnEd0cXP8FxNd96ERoXxHazQq6vQabALt2MhYZZ4Jqm
	 vYwI02Ev2x6deUcxZ1V/VbFgvnKrRT/wdDwZXTZTa/Lq56xgoj3SbK5OKdFn9DyV+m
	 XNmszPJHNOAKbD1uQ+jyE3cbmRmcXXh7ZShivlV5pM1Cd17sDZ6Y0FR1/bAqhsFxOt
	 jCydUrHy6mPYJb04gaM9A8WcMZ10qvp3Db/1Sm8POhk+3HaIkIPoigPS5aq+otXCzT
	 +DwSM6ymUnOCovOmu8pcSIeo/hU/Hetov4BGzmfScWokMbCYRZxziC2rX3Z10qddRT
	 qN69bbvz6XlGQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 4/6] ata: libata-scsi: Document all VPD page inquiry actors
Date: Tue, 22 Oct 2024 11:45:35 +0900
Message-ID: <20241022024537.251905-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022024537.251905-1-dlemoal@kernel.org>
References: <20241022024537.251905-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing kdoc comments for the ata_scsiop_inq_XX functions used
to emulate access to VPD pages.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 54 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f9c70f650cfc..880a1e20a8dd 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2052,6 +2052,16 @@ static unsigned int ata_scsiop_inq_89(struct ata_scsi_args *args, u8 *rbuf)
 	return 0;
 }
 
+/**
+ *	ata_scsiop_inq_b0 - Simulate INQUIRY VPD page B0, Block Limits
+ *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
+ *
+ *	Return data for the VPD page B0h (Block Limits).
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
 static unsigned int ata_scsiop_inq_b0(struct ata_scsi_args *args, u8 *rbuf)
 {
 	struct ata_device *dev = args->dev;
@@ -2092,6 +2102,17 @@ static unsigned int ata_scsiop_inq_b0(struct ata_scsi_args *args, u8 *rbuf)
 	return 0;
 }
 
+/**
+ *	ata_scsiop_inq_b1 - Simulate INQUIRY VPD page B1, Block Device
+ *			    Characteristics
+ *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
+ *
+ *	Return data for the VPD page B1h (Block Device Characteristics).
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
 static unsigned int ata_scsiop_inq_b1(struct ata_scsi_args *args, u8 *rbuf)
 {
 	int form_factor = ata_id_form_factor(args->id);
@@ -2109,6 +2130,17 @@ static unsigned int ata_scsiop_inq_b1(struct ata_scsi_args *args, u8 *rbuf)
 	return 0;
 }
 
+/**
+ *	ata_scsiop_inq_b2 - Simulate INQUIRY VPD page B2, Logical Block
+ *			    Provisioning
+ *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
+ *
+ *	Return data for the VPD page B2h (Logical Block Provisioning).
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
 static unsigned int ata_scsiop_inq_b2(struct ata_scsi_args *args, u8 *rbuf)
 {
 	/* SCSI Thin Provisioning VPD page: SBC-3 rev 22 or later */
@@ -2119,6 +2151,17 @@ static unsigned int ata_scsiop_inq_b2(struct ata_scsi_args *args, u8 *rbuf)
 	return 0;
 }
 
+/**
+ *	ata_scsiop_inq_b6 - Simulate INQUIRY VPD page B6, Zoned Block Device
+ *			    Characteristics
+ *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
+ *
+ *	Return data for the VPD page B2h (Zoned Block Device Characteristics).
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
 static unsigned int ata_scsiop_inq_b6(struct ata_scsi_args *args, u8 *rbuf)
 {
 	if (!(args->dev->flags & ATA_DFLAG_ZAC)) {
@@ -2144,6 +2187,17 @@ static unsigned int ata_scsiop_inq_b6(struct ata_scsi_args *args, u8 *rbuf)
 	return 0;
 }
 
+/**
+ *	ata_scsiop_inq_b9 - Simulate INQUIRY VPD page B9, Concurrent Positioning
+ *			    Ranges
+ *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
+ *
+ *	Return data for the VPD page B9h (Concurrent Positioning Ranges).
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
 static unsigned int ata_scsiop_inq_b9(struct ata_scsi_args *args, u8 *rbuf)
 {
 	struct ata_cpr_log *cpr_log = args->dev->cpr_log;
-- 
2.47.0

