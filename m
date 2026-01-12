Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DC1E4AF
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2026 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220460; cv=none; b=ibec+s1k97Wki0AjaaDSbSwZZ1Li9O33DT7eQLk7I/LEUEOvngSGejqEwbnQcDBysByuA3HSagrfwyH/By7nobOHHvZrvltcx69E0CMYp6knjsPAEABOMcEKgwjFBKO4M5hN5lddH2grkkz/8ZmQ5hDNYSjZVqjRLOmUISiMWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220460; c=relaxed/simple;
	bh=5VG4wYsSaNwS03NN891Vw2iuRCjxnLaOXTSDeCqpYis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyuFeiRAX6YStAy6U3mA90qIv3HT5KkI4w1YZ787+P030rt177OgIXSNfnTTfZVTWYofyvsG9TSdI84ECfZM3IOGaGj+XgD/PkUein9dtpa/PExBbKOf4FdfKKg6oz+vqTYmV0nwMaGpK+kpuQ2ZyUTGlf6XrLZolxwkQR/m6XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjSndIV1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjSndIV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97943C19421;
	Mon, 12 Jan 2026 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768220459;
	bh=5VG4wYsSaNwS03NN891Vw2iuRCjxnLaOXTSDeCqpYis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XjSndIV1qhPnCrp2T0hqjebLs8enBkta8a3Ul6sX7rg1gkVv4Gm1Bi8I40qbfy2uY
	 JHnIkTZmZQK5yvCj5jN/Rqg0/e8X2qrF9CXfMhTNsWPnIgKFr3cexJFlxJrJkjZ2Jw
	 zQ1tqlfYaSn/QmvDgre0IhasWST0zspOTCRC7RiAZ/Y2qB6FgbduRj/fseUKYZLYnQ
	 7A4CfsuB1GkD4dDosOumV1qofsBt4kENxzXYt8CAj4LtEi6TL9VyPEo9PUAuxFMssg
	 ScRa1cbn8Fvxv7CyUNLE+4ZdeEupTg0NDz8kDez2Gd9vGT0Z1xy5U6NB/PP1n1ToqQ
	 K27wK6enloPsA==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	wolf@yoxt.cc,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 1/6] ata: ahci: Do not read the per port area for unimplemented ports
Date: Mon, 12 Jan 2026 13:20:46 +0100
Message-ID: <20260112122044.143637-9-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112122044.143637-8-cassel@kernel.org>
References: <20260112122044.143637-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105; i=cassel@kernel.org; h=from:subject; bh=5VG4wYsSaNwS03NN891Vw2iuRCjxnLaOXTSDeCqpYis=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJTnitKcepaPT62zu7ttLQz+ufTAlI3b9p9ymHnzSf3H l8yvdzZ0lHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJrJnDyHDmhtiNklnLQxJM tkhsdV5Y+/98xSbjHZXhduui5L4bnJrO8D9W+N3fm6uUJi/oLot2txJc67W3ZkKAs/afCazn4kM rtrICAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

An AHCI HBA specifies the number of ports it supports using CAP.NP.
The HBA is free to only make a subset of the number of ports available
using the PI (Ports Implemented) register.

libata currently creates dummy ports for HBA ports that are provided by
the HBA, but which are marked as "unavailable" using the PI register.

Each port will have a per port area of registers in the HBA, regardless
if the port is marked as "unavailable" or not.

ahci_mark_external_port() currently reads this per port area of registers
using readl() to see if the port is marked as external/hotplug-capable.

However, AHCI 1.3.1, section "3.1.4 Offset 0Ch: PI – Ports Implemented"
states: "Software must not read or write to registers within unavailable
ports."

Thus, make sure that we only call ahci_mark_external_port() and
ahci_update_initial_lpm_policy() for ports that are implemented.

From a libata perspective, this should not change anything related to LPM,
as dummy ports do not provide any ap->ops (they do not have a .set_lpm()
callback), so even if EH were to call .set_lpm() on a dummy port, it was
already a no-op.

Fixes: f7131935238d ("ata: ahci: move marking of external port earlier")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7a7f88b3fa2b..931d0081169b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2094,13 +2094,13 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (ap->flags & ATA_FLAG_EM)
 			ap->em_message_type = hpriv->em_msg_type;
 
-		ahci_mark_external_port(ap);
-
-		ahci_update_initial_lpm_policy(ap);
-
 		/* disabled/not-implemented port */
-		if (!(hpriv->port_map & (1 << i)))
+		if (!(hpriv->port_map & (1 << i))) {
 			ap->ops = &ata_dummy_port_ops;
+		} else {
+			ahci_mark_external_port(ap);
+			ahci_update_initial_lpm_policy(ap);
+		}
 	}
 
 	/* apply workaround for ASUS P5W DH Deluxe mainboard */
-- 
2.52.0

