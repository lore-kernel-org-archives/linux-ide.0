Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F11BDE6
	for <linux-ide@vger.kernel.org>; Fri,  6 Sep 2024 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725587931; cv=none; b=Zp6KcnJaU130b0FQh+lfjxR8Z9s83pQgyY1dDnjKGucDJUOFWr/J2w5CuAm9Dt5PuY6isTFOc1KvbLSkRokWfNtNIvYSTRylfJvdcVFiDadKlKnSbuy2yLFerKFy2o4kCg2qd7SB3t1B6DVGlcNP4KPt/E2InqF1+i024MtYaWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725587931; c=relaxed/simple;
	bh=4Cn4skyenAWw5QQjWOnCB7HhxndXxSfCBb7811lk65U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gm5CNZlli9AuZoqNaqQ7x2l8DisU13NyuP1QhxFafKxRS9Sb+mU6u8Vi0g9x/laR3RekiOCVioiQviqGdbSyDB/KMGFN5p5Fru5FnJtV+NUSuLlghmJCp0RnM1Yp7HT3G/WshAu87yFPZqRRKBsEQ1bIMLqntOO768t1OeBmBw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGrCSVWx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGrCSVWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EE1C4CEC3;
	Fri,  6 Sep 2024 01:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725587930;
	bh=4Cn4skyenAWw5QQjWOnCB7HhxndXxSfCBb7811lk65U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AGrCSVWxC426syH6h140A51Df4SqUze0vZPDQbt43uUms2EHa+O6N0Zsq3iGgxxkd
	 OF9gXU+AsN4cs/rd5aK39ng2ggg5NyzeUJh1NwjSshEMu2TZjETcEhHDW/BoSdie50
	 A1VIYPEmwxdgRukqZWHY+jXrJTI9q//Vv2PTm3BMHKEsfmgO9jikvu7LD/oFCgnJeU
	 8wIa9hQuRqzdmDxTFQy8W89NhrTpxxo4sRAFYIM5h00Z6gWJynxetgt2CbuDLD9s2v
	 akzPViPnVHAOThQsk00TdAbNPe4WlY6FcJBu6Y7Oir3ZI3epNeGMnth/F/jSQTt4wW
	 U/hHDKZbi6rZw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 2/9] ata: libata-scsi: Improve ata_scsi_handle_link_detach()
Date: Fri,  6 Sep 2024 10:58:40 +0900
Message-ID: <20240906015847.229539-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906015847.229539-1-dlemoal@kernel.org>
References: <20240906015847.229539-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A struct ata_device flags are always set iand cleared with the device
port locked.  Testing for a flag should thus also be done while holding
the device port lock. In accordance to this, modify
ata_scsi_handle_link_detach() to both test and clear the
ATA_DFLAG_DETACHED flag while holding the device port lock.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a3ffce4b218d..1a135d44286c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4616,10 +4616,12 @@ static void ata_scsi_handle_link_detach(struct ata_link *link)
 	ata_for_each_dev(dev, link, ALL) {
 		unsigned long flags;
 
-		if (!(dev->flags & ATA_DFLAG_DETACHED))
+		spin_lock_irqsave(ap->lock, flags);
+		if (!(dev->flags & ATA_DFLAG_DETACHED)) {
+			spin_unlock_irqrestore(ap->lock, flags);
 			continue;
+		}
 
-		spin_lock_irqsave(ap->lock, flags);
 		dev->flags &= ~ATA_DFLAG_DETACHED;
 		spin_unlock_irqrestore(ap->lock, flags);
 
-- 
2.46.0

