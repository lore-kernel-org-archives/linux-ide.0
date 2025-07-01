Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B412F1FE2
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751328981; cv=none; b=CXzIDgaznGA6ZDtlwH1M3+KtkjRmHH53pkoGCWC3vOrxqr7AbVHmNngmF/GtPvoDTzyJKOp8dVDotP12StOsYBioLR2l6dp3OqV6R0D1QBsOqe0ZmXwvfOMIUapg57ARnBjnh6fBMaI3Gibfyo8zW3qs9RaTy9QHt08C8ywP81s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751328981; c=relaxed/simple;
	bh=Yw+Odmp0K9LE6nnTmXGHpXPOm4digpuIxaJGOIf55JA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+hjiz1kiGE0q0b7cerrd7O55fu9lJYveybMZIcEnDqrY12wAD9yeMwOgPoe/VWGIFsLSL5oJqReXPaW8cvvJdM39pbwJx0RfOwx0gB9KmMVhG6HuYuTAhHsgx9Nk93icT6QhhLeS8YoSdCLyn1n4/geKvOXpU9I+C0c3MM3Co8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obY8PyQU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obY8PyQU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BF9C4CEF0;
	Tue,  1 Jul 2025 00:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751328981;
	bh=Yw+Odmp0K9LE6nnTmXGHpXPOm4digpuIxaJGOIf55JA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=obY8PyQUKddmJMW8UISHw9k4um7iiOpJJ4r9Iy9fz9dTUVQNWpS9xb9Y1x8VYgk5J
	 6kdIZLkFIfA3teBAgwlS2ATfijqamMfLglSbj/Pe8TyJW7cPmsPRwqcB7tFkfQGCAe
	 O7M25G9HWT5IzuPOgI+70eEVVBupv5M4molbuzxtONsmLP08RU1dFteiHFSSfWnbGH
	 qaF6XJimmmnhKWOM+WJp/7odoRMVntntY97/OtqIdb5g+Ij1V3YLW/16Y/xNulLWE+
	 MflU0OdjHqa2rIC9/oW5MOYqryfVAkVWtJy4AG+x+aIV2E+f74DhyFkUh3FHJphQis
	 AoqpoQex7g+bA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 05/10] ata: libata-sata: Disallow changing LPM state if not supported
Date: Tue,  1 Jul 2025 09:14:03 +0900
Message-ID: <20250701001408.330364-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701001408.330364-1-dlemoal@kernel.org>
References: <20250701001408.330364-1-dlemoal@kernel.org>
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
Reviewed-by: Niklas Cassel <cassel@kernel.org>
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

