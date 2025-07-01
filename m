Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465DB2727E5
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374537; cv=none; b=Y360qXvWHsE3S9TIeyaXWvKu49v1CcYqVVTq4g8xdnUIAUTzAA0w1k/QjSvJ24o8gqmVPlGOde2M19wBqq/7I3eAyaY4XCnl1XJZDL5clhCYwKhjFO/HbmH+g/OWzxRdn3ziqockpHy2PxnYq4cLjxoSvW7DKcPUqquMIGSggsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374537; c=relaxed/simple;
	bh=8rB1QpqCLmriQiRba2LGEsUfc4ZNP7zc+iQVddlc81A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZ/9SVY/e4ja5ZQKlNds9m4CGc7nWsjeOnyvufsBDYWcJwzqrT1vyzt3rzceT5OQEVdaFdrPbIk11jOxsv5vB5EjQsdr6IyJyRtWO8MThaAt/G2TRbMhRlCLOa89VegXOlfT8UMU5Ow5z3UX8RK94TqYLNOyzRBx225NEXQaMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1kCG/nd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1kCG/nd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6981AC4CEED;
	Tue,  1 Jul 2025 12:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751374536;
	bh=8rB1QpqCLmriQiRba2LGEsUfc4ZNP7zc+iQVddlc81A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=N1kCG/ndhBuyIAO7rsp2gpKvDAIX9W6qE6jR9Snf4GvoYsZYFrR59I1fGOilfd+Fw
	 Mu3cKT+8190Y6jZ+PCbSXUUuonDelBIm0lz1wkJMyVhCBkfhxJczIXnszEOPirYOZU
	 Nh0lL+nV3Pp0SlxS7zM8lzOs+KkLgBV9TuLuQx6ezLqnqxaASPToLmX7+apWNBz9qT
	 jt6efQKQYRsj/plkK7UTNtdxfdlfEUpq/05fD4hMEgWYIsgPBJUMYFn0l0QqJZVNOS
	 6Y5dwFWd9hA5O0VKa1M2Ddei0u2tML2Vdq/3awLvjh97s9LFwfa3jLIf+D2XgVr7Tv
	 xExmUST4wV7ww==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 06/10] ata: ahci: Disable DIPM if host lacks support
Date: Tue,  1 Jul 2025 21:53:17 +0900
Message-ID: <20250701125321.69496-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701125321.69496-1-dlemoal@kernel.org>
References: <20250701125321.69496-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AHCI specification version 1.3.1 section 8.3.1.4 (Software
Requirements and Precedence) states that:

If CAP.SSC or CAP.PSC is cleared to ‘0’, software should disable
device-initiated power management by issuing the appropriate SET
FEATURES command to the device.

To satisfy this constraint and force ata_dev_configure to disable the
device DIPM feature, modify ahci_update_initial_lpm_policy() to set the
ATA_FLAG_NO_DIPM flag on ports that have a host with either the
ATA_HOST_NO_PART flag set or the ATA_HOST_NO_SSC flag set.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/ahci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1b4151d95888..0760fa47d90e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1780,6 +1780,13 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
 		return;
 	}
 
+	/* If no Partial or no Slumber, we cannot support DIPM. */
+	if ((ap->host->flags & ATA_HOST_NO_PART) ||
+	    (ap->host->flags & ATA_HOST_NO_SSC)) {
+		ata_port_dbg(ap, "Host does not support DIPM\n");
+		ap->flags |= ATA_FLAG_NO_DIPM;
+	}
+
 	/* If no LPM states are supported by the HBA, do not bother with LPM */
 	if ((ap->host->flags & ATA_HOST_NO_PART) &&
 	    (ap->host->flags & ATA_HOST_NO_SSC) &&
-- 
2.50.0

