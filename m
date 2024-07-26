Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1316620B35
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 03:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721963997; cv=none; b=gJjyZkC+Z22fjYOW1IyaXOiHcMXL9j/6pO+byVFoXmXQFCFZ2WVAK+KxPnbbWrsgUx3PpQkaKJ4sgGEX2fMoGkiOewhULcE0tTdTNA668/DrO50h+PlkDGf+OKaepryw8Sc1/2MY2cNojo3n8b1vfwjraFweEvQvJVkIZxbSRBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721963997; c=relaxed/simple;
	bh=VqAFJrZDz7cC1y+vS6bx2qq7f1IitxH0kDlOoQITrt4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r98X0LSYrHcsfRxp/h6ShHKgdD4Mdg++THq+udyvXAaERKsPM42PqbDfDZQ12l02b2bdhZn1lOgMA26eJRVkLT2p3nN16yWPq0smuhOabplAyJ9CdcJOikz9MD7MnSDNVu3TFFNXzE0VbuC3o8LpAHzOXuo6xb5L2fLuSIkt8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2HVJIDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2HVJIDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74880C4AF09;
	Fri, 26 Jul 2024 03:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721963996;
	bh=VqAFJrZDz7cC1y+vS6bx2qq7f1IitxH0kDlOoQITrt4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f2HVJIDXWn6hsbZkXVEtK6+ZfXSo+ps3u0GtSyy/mE8ZR0uPOsZWjw7h+RMECluau
	 MUeww1rNvZyU9YIi+KSnvQ2xiofTEk2w3gwmWYFaRfqvRSkxAJhTTg+RZ1FfDx7+Vy
	 QzHuIKhYCCd/2S6hVRLzO0QP5PLPrqq3EfIFPGLoHT5GFlgQDkWoAep9njTDnKi27w
	 Xml346AY+uW7PYtbY6yH/QuygMGAGlOB3tKj4FKGnAtnyvEFhNO26Z96jMJe6JGSMy
	 NQFEvQ/GiPoa2Lt4WOBKUDA5vtHu9AsmGofw4mxjUEHv7BxbqOq0k10SlEoE0lxpFb
	 XtC4wu994/iUQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 01/11] ata: libata: Change ata_dev_knobble() to return a bool
Date: Fri, 26 Jul 2024 12:19:44 +0900
Message-ID: <20240726031954.566882-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726031954.566882-1-dlemoal@kernel.org>
References: <20240726031954.566882-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the function ata_dev_knobble() to return a boolean instead of a
u8.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c7752dc80028..c49334e13c0b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2219,12 +2219,12 @@ static int ata_do_link_spd_horkage(struct ata_device *dev)
 	return 0;
 }
 
-static inline u8 ata_dev_knobble(struct ata_device *dev)
+static inline bool ata_dev_knobble(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
 
 	if (ata_dev_blacklisted(dev) & ATA_HORKAGE_BRIDGE_OK)
-		return 0;
+		return false;
 
 	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
 }
-- 
2.45.2

