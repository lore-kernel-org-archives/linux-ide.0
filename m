Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515A186E2D
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264932; cv=none; b=sd3bxyyJu4zfDL1fkaBHq4xD6EBxfVb3ww8aqISQ1zqFWmNKpBpheUUKLRGyl19PwJkhfluE/8XdkqueLzNB8wtnEC3XBoxKzRx0w+Sf1IRCsxzkSDtEzXMJPkWWVKpMuVU9m+lIIwGeYCHvLZ/1qhSDhx63tkJur0ud4A1kUSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264932; c=relaxed/simple;
	bh=pA3kWopx1ho6vqICVNJtOfcdICtVpb5kGsDq7BI/x54=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pz3GzahGSNdDUpFkQrc/dnULozHXruFxDtIeRJFN05BP8oJsfO2rIHhfFN76SJ15YFOWZXmCfq7V67y+2X4il1FE8JsUWRGE65vAq2SM+1HAssxvdmWR6Mk4RW0W1xu+jvaXXNNs6lMYvSnqiwrvn+xDXDqqHhaINm6uziZJta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh0iO2DQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh0iO2DQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E93EC4CEEB;
	Mon, 30 Jun 2025 06:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751264931;
	bh=pA3kWopx1ho6vqICVNJtOfcdICtVpb5kGsDq7BI/x54=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Jh0iO2DQ4afK3Ac1Pv5t0XfqRxV9RtsCRtouoxdICwPGfrN0/GQSE5NGc9UodkhkU
	 JObzgHtjldcBS1t32kxSEY3gdzoKNjUCmbyq+6z23aHfa6V3f+uvflWv1fnwCBrLa6
	 9ifSqPhvTKLuh8PYH65GzuQAV0gKEQWRRs+hih1kICJjKUsJWlRxaz5TIVf1qE67jK
	 vyUUc670WNAc5UOeaJ2QhCS3Y4vvbghIMNipigLXauE7qlo1VEN7tPzmJbAKxtlfJQ
	 z/20c0kYcnhrss6lehcWxxw8O8NRXLTqmP4yi+mKdy0RSZdsyPYYTYDjDIjUGtZ2v1
	 4Gf+liO8w6toA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 05/10] ata: libata-sata: Disallow changing LPM state if not supported
Date: Mon, 30 Jun 2025 15:26:32 +0900
Message-ID: <20250630062637.258329-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630062637.258329-1-dlemoal@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify ata_scsi_lpm_store() to return an error if a user attempts to set
a link power management policy for a port that does not support LPM,
that is, ports flagged with ATA_FLAG_NO_LPM.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-sata.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index cb46ce276bb1..47169c469f43 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -924,6 +924,11 @@ static ssize_t ata_scsi_lpm_store(struct device *device,
 
 	spin_lock_irqsave(ap->lock, flags);
 
+	if (ap->flags & ATA_FLAG_NO_LPM) {
+		count = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	ata_for_each_link(link, ap, EDGE) {
 		ata_for_each_dev(dev, &ap->link, ENABLED) {
 			if (dev->quirks & ATA_QUIRK_NOLPM) {
-- 
2.50.0

