Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881F484246
	for <linux-ide@vger.kernel.org>; Thu, 10 Sep 2026 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042760; cv=none; b=OUKMkHJcTj7fqeSc4gg7TjCvaAMPt58dE+LK7iqhBJT1PH5GVYpzNBlO9fJGC7r1V+IQc51JcAd85Nx5RPVIYF1wjZZ9sPeXe/cTSVV4kRAfASfOk5jYbLIBCKc8gTAmoFj9VXigqyZcI0yzZ3cl74NR7OzinWp2WgryXnqfreM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042760; c=relaxed/simple;
	bh=+b3+SKTWH0g/ra8zP4BJnBMASjM9SdLNVoETS3aDNio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yel7ju+10L/IH+in6o+J59wvLHYHTLxqYU/Cr0szEogOde9tfTj23YB89ithANAiq9/vnks/+fcDzTqmPS6Cs29fSE7FprHyI1SMoQR6l+xwQ93EH+29TVCkIMAmvTWZHXbM5gUphQOVIoTjlFe/Tgs1n73qwSJoVEMa6hPG7+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMdIcFpO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMdIcFpO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2781D1F00899;
	Thu, 10 Sep 2026 12:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789042759;
	bh=mOdkGLAI+f/3cRYTelfN0qRNv5U3LBARnEeu+Zo5fyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bMdIcFpOF57JaCXbxqk+8NLZHT8BR05SI3eN9dwr11x8QeFi1Bo1MYuKK+jngcxEs
	 os7BfALQBg81t2oz1T8t0zZCmBvZcewMKD/Pm1/aFSW66HLNMetYw+FoMNQ4VmScD5
	 cmBRfs198DTaCUTcQbyKlFo40Hm6djloGvZ9/oFp8km7maQqcE01418uwrOR9+3yv0
	 lqx5aFxLvnjPc1A89TkZ2N1826ttHN0w0RC+FBupiAStkvpkRlD7UboLrAL7ujFaDT
	 kk5/bbvqfjmlk/j5kXDmFlnpCowPZ5uIeDaBd53zd5kbGGUtAgjGNjqcG5Fc/zM+PJ
	 JpkQqYp6wkKwg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v3 3/3] ata: libata-core: Fix the ata_host_register() kdoc
Date: Thu, 10 Sep 2026 14:19:03 +0200
Message-ID: <20260910121900.97676-8-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910121900.97676-5-cassel@kernel.org>
References: <20260910121900.97676-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1402; i=cassel@kernel.org; h=from:subject; bh=+b3+SKTWH0g/ra8zP4BJnBMASjM9SdLNVoETS3aDNio=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIWLTBj5+3I22bybMvRnV+3rfnfaVQj/Lrx75KL1gtPf DXVPOP3saOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATeVTI8E+Nt2PB8sgPykZM cgzZ7xjyDScyi6jMSNghMuX+Xa1JnUsZ/ns8fqHLECgdz7EjL0/PVFeItSGu9rrRebPEw6k6TC+ 9eAA=
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

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5b8dc89ed131..eeb7a33c2c51 100644
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

