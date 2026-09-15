Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655FC485515
	for <linux-ide@vger.kernel.org>; Tue, 15 Sep 2026 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461748; cv=none; b=R03sftKc0R0Ec+kO1oRZxMIFwztf1JmmP36VxFveXcINmAF8zWrjOfLWSqZYbj5DFbJ3uDxdLymAUTjxesHCaQ9XM2mUCJJyWGHqNX8a5S3D0mDYiEIk14JX7Ns6CX6+kure9p0N/Mx/VZ/DZwlKxQ2cLQy22xx6EMBNPDWhj4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461748; c=relaxed/simple;
	bh=FJO/0Gty111wiW6tRasHJarPuhPzY/HN7ZLOlO24tDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjaUKW6fNhFi9bq1MUHxlr7cB+rOUyDKD+3o+aumw6K397B33s1evsDtQivRrv8zbLF/lYtcqrr6Va2qj5szExRjSGCeTlqsaeUlV0ygY3J2xLHai9FsXT3vugxCK8q290vG9cbP5qrA9j2NznUqCYo9mHI7cV1PA+KgcR1/aaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4Jq/lwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4Jq/lwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A682C1F00899;
	Tue, 15 Sep 2026 08:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789461745;
	bh=WhLfI79poL18iT8Yrrl+aRr5IbeJgg+CLrkmCemoWkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q4Jq/lwGSzkE/YRDUAc/68qFds9beYeaeY9gtkliKXpG62oX5MRKxcFKsfx4yxvho
	 e4jivJKE5XtQJOFHdU+dbIN8v6aJQ2yDVKsruZoGMa33JC5wK/qqNHYDKycPBLFGRa
	 Sd/crNPt10+2OaQpVgPYE1dtRhYt/7BG5SXbrqr9syzdFBXUhpXp5KthPEYigrgmC4
	 LNZ4YYG3iQnm3yITuqbjUKQdOMeP+sM5mc5V+/b5lauBX9PDsgBQvKPRmXm8tPfVsx
	 rDd1RavCKV/I9k/4RFqg5FkVHrZjebqsrXzU7OU02BOLW6vm5XK447Wo8ggl89snc0
	 ynBpNTACA5TaA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v5 6/6] ata: libata-core: Fix the ata_host_register() kdoc
Date: Tue, 15 Sep 2026 10:41:32 +0200
Message-ID: <20260915084127.692494-14-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915084127.692494-8-cassel@kernel.org>
References: <20260915084127.692494-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1452; i=cassel@kernel.org; h=from:subject; bh=FJO/0Gty111wiW6tRasHJarPuhPzY/HN7ZLOlO24tDY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJWsux/vXN+WN2KsIj5XNZnFkseKAt667HwYvolX3arC J988Sq7jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExk4RmGf/pbK65NWM23dtoe B4UJap1bpfW83nDVWC/a2yRZ6Pg3hJmRocvx84mwnkgm10M/KhX7L8Tcibxmo/Hw2sPZQqtbV7+ RYQIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_host_register() does not start the ports of the host, it requires
them to have been started already:

	/* host must have been started */
	if (!(host->flags & ATA_HOST_STARTED)) {
		dev_err(host->dev, "BUG: trying to register unstarted host\n");
		WARN_ON(1);
		return -EINVAL;
	}

Fix the kdoc accordingly, and fix the grammar of the last sentence while
at it.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 197f5d6e93ce..682c58889715 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6237,9 +6237,9 @@ static void async_port_probe(void *data, async_cookie_t cookie)
  *	@sht: template for SCSI host
  *
  *	Register initialized ATA host.  @host is allocated using
- *	ata_host_alloc() and fully initialized by LLD.  This function
- *	starts ports, registers @host with ATA and SCSI layers and
- *	probe registered devices.
+ *	ata_host_alloc(), fully initialized by the LLD and started using
+ *	ata_host_start().  This function registers @host with the ATA and
+ *	SCSI layers and probes the registered devices.
  *
  *	On failure, the host remains started, i.e. the devres action
  *	registered by ata_host_start() is kept, so ->host_stop() is called by
-- 
2.55.0

