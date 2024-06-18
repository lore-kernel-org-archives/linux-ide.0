Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269B33C099
	for <linux-ide@vger.kernel.org>; Tue, 18 Jun 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724964; cv=none; b=tsik5ozjMJBWHbZCc169Wxwp5L0+ihntIewJrLiiDQ2IOYR9tit5BMXdxos0gX37ahyX2OF9ObYKgkbUZKBnFnoLW0LP8NiAJxbunfbA2bQ1C7Hhdycwk1yoWxPgtahFu0/roJAcqvAEVrAd9v3TmDTiNVCNJwhZ4I7btYAEohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724964; c=relaxed/simple;
	bh=5YCiS624qkzmfHV+AlRdUGv3I7SSV2NEfGO2niHVDbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGN53p8QYB4DeiWTYVOqLr20WEMhvWb/xPwEA/9YGhs7VEOcEEkgIIpSuLuQTGAG+Jcrq8LNkOVQl/peQOBKmrohOwwGY5pBNVeY7rK36oGQM6Dnw8Ek8KMjA0lPt34BXpfgrfK+WkM8l4uNxyyxpXH6FcDIbBbttjnxLk0GS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDbRFxpK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDbRFxpK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0683EC3277B;
	Tue, 18 Jun 2024 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718724962;
	bh=5YCiS624qkzmfHV+AlRdUGv3I7SSV2NEfGO2niHVDbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZDbRFxpKqKo0sRncqq37FXQqrRBSXBCpSsNSlCzdWBBjEmqRPeP5YYXw8Sgb7rnb5
	 m5O49Ql7vnUuBiN+LJ2fRCGxKepjubh1Dk5Hf/7GUdwSj9m8aM6GHiU+25+oRLUjPe
	 jib99JoAg9I+Oj1KcY3RXMdJdGey8yc7VTBuZik74kMOira/wVR1burCO+W9alCPJR
	 I8EKlgGZ2d0zxervVl1kOeFFdWlPyR3tY3g/2vVH7MJ6qJ7hBEnKNSHbmQkyBiR8PG
	 BNbRL/2Hi0RCwy4+Ao1pL1rEL5xKEYwN2BSm9OoCJ5/Js6Npi5CJacIORZTcY+2EqS
	 5fES6rIxD4jzQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 4/5] ata: libata-scsi: Assign local_port_no at host allocation time
Date: Tue, 18 Jun 2024 17:35:42 +0200
Message-ID: <20240618153537.2687621-11-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618153537.2687621-7-cassel@kernel.org>
References: <20240618153537.2687621-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1465; i=cassel@kernel.org; h=from:subject; bh=5YCiS624qkzmfHV+AlRdUGv3I7SSV2NEfGO2niHVDbo=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIKV3rfCw5rEw2atPC+apixo5VZa44OawpzA/e6V2HHT XUVv37pKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwETSOxkZlk3YLF55xmRlq2uy UxnDkTeVW9+eYrqrt0zyodqD7Dr75Qz/NGO9fjouvWLlEOo3bUH1iR1hifs+dJmZlTZ+5U7jOBr DDgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Now when we have removed support for decreasing the number of ports,
the most logical thing is to assign local_port_no at the same location(s)
where we assign port_no.

Note that we cannot move the local_port_no assignment to ata_port_alloc(),
because not all users of ata_port_alloc() assigns local_port_no
(i.e. ata_sas_port_alloc()).

I have no idea what local_port_no is actually used for, but at least
there should be no functional changes caused by this commit.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fb4835c2ba2d..ee1a75bc0466 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5591,6 +5591,7 @@ struct ata_host *ata_host_alloc(struct device *dev, int n_ports)
 			goto err_out;
 
 		ap->port_no = i;
+		ap->local_port_no = i + 1;
 		host->ports[i] = ap;
 	}
 
@@ -5902,10 +5903,6 @@ int ata_host_register(struct ata_host *host, const struct scsi_host_template *sh
 	for (i = host->n_ports; host->ports[i]; i++)
 		WARN_ON(host->ports[i]);
 
-	/* give ports names and add SCSI hosts */
-	for (i = 0; i < host->n_ports; i++)
-		host->ports[i]->local_port_no = i + 1;
-
 	/* Create associated sysfs transport objects  */
 	for (i = 0; i < host->n_ports; i++) {
 		rc = ata_tport_add(host->dev,host->ports[i]);
-- 
2.45.2

