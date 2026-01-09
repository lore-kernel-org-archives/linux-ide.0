Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E2A35E529
	for <linux-ide@vger.kernel.org>; Fri,  9 Jan 2026 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969604; cv=none; b=PGkEumFowy66FzpmuIdxeUyH4f991mTsNt5XxhHMVgGGhL1NxZPUZ0H9aQ+av6X/VWjFQ6jsx1lch34Q+73vk2zn9SZ9WqOUyjZj1o8g3HImwYZKSbrx/J5DjtNRxXW+ZxAvK6fkkXkAkovg0Tl63Fqr6jVZ0Gw7d1kHYpOGb8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969604; c=relaxed/simple;
	bh=y8xRIEdRGOeUuWF6E+nu9I3VUL+D2Burgo87Gstz668=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAl7KohlKw8/IGf2RGBEL8Kswtb2GG9nWy3QWUMxXmtA8bpxeRx0LyU/b/ao+DGsYo4SEvUMJl+GMb3Ev8C366eFQt6Ml4JC19FtHEvrp4+Pf15trJjfeJuW6e5Tu3Re7uEWAxIKhJGgvwyOIhixfXQ/SGIjzDL6BohvZvaIvJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAif7L/j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAif7L/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575B5C4CEF1;
	Fri,  9 Jan 2026 14:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767969604;
	bh=y8xRIEdRGOeUuWF6E+nu9I3VUL+D2Burgo87Gstz668=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kAif7L/jql1UKUj80jfj/uGwK9wo4d484HCsUhjiOes78gDv9Xl10R7ua5Eq0izo+
	 I/Vj6HzElqRmlaY0vhttOd3JQ8n6NdlVx5vVAfI2eus75+XySfsENmoO4gDpv1mK78
	 FOaR1mJJ69j9OAx0QiiiBxJUsI843r6J5HoTbjRDwHNiaB+thNCsRHj4TznUuJ65Ue
	 iffALaxKpdx5B2DcenNuD204EDwB4lRq6A7JR13Q6Nb4CmmVO+Cppq5eBbjEpcfHXS
	 /P8WTbCiekGB4tQxGzKs1T/DqYnckGu8zaNl1KTiPH9LBClO3WZbI0MC61X5PEu3qX
	 n6qaVQNDU1oEw==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	wolf@yoxt.cc,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 5/5] ata: ahci: Do not read per port area for unimplemented ports
Date: Fri,  9 Jan 2026 15:39:55 +0100
Message-ID: <20260109143949.331105-12-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109143949.331105-7-cassel@kernel.org>
References: <20260109143949.331105-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2124; i=cassel@kernel.org; h=from:subject; bh=y8xRIEdRGOeUuWF6E+nu9I3VUL+D2Burgo87Gstz668=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIThc08Lwj29LJejN0y+bP1nKlO/brVG9qfPE29tbP+W ODe5NxVHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjImiJGhrmLH0lOTJN6ss5J 7dvugmfs9ovnnBS5oK3jtfvRw88bXrgxMixnP5z/Py8z/GFm0u+F7mZmi/YzZrbazxRo3qcqNi9 FgxEA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

An AHCI HBA specifies the number of ports is supports using CAP.NP.
The HBA is free to only make a subset of the number of ports available
using the PI (Ports Implemented) register.

libata currently creates dummy ports for HBA ports that are provided by
the HBA, but which are marked as "unavailable" using the PI register.

Each port will have per port area of registers in the HBA, regardless if
the port is marked as "unavailable" or not using the PI register.

ahci_mark_external_port() currently reads this per port area or registers
using readl() to see if the port is marked as external/hotplug-capable.

However, AHCI 1.3.1, section "3.1.4 Offset 0Ch: PI – Ports Implemented"
states: "Software must not read or write to registers within unavailable
ports."

Thus, make sure that we only call ahci_mark_external_port() and
ahci_update_initial_lpm_policy() for ports that are implemented.

For a libata perspective, this should not change anything related to LPM,
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

