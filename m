Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A6534450
	for <linux-ide@vger.kernel.org>; Thu, 10 Sep 2026 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060520; cv=none; b=pgXPIjLd30q/9Z54I1AbKFQBj97DuhvQA73c4UFr2Ffxke0Hz4jr0WcrHD7JSOoJZISwN/+4R4tZ4p6ZtEQ6LQRbRp/A08t70469tqFLV83yhDCiVmIWqNGc163tgYfyUpTLF1HMPxHA5yZ2rF8nbrE7OHWXvXxSymShdbQzKqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060520; c=relaxed/simple;
	bh=8d2R+HmGls68wNljzGx++qxH/fOD0Jiwk256M5CZPfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQHWdVYb7o+JD6ezUd8xs85T20bIPe1YWRbJLSSZTIrRTu0gV4ai2y4DacCR64ie8wxkv096UCnRkY2VEgKW3L9iptGLszmFu4QHoJYX8HNjfrTzazaKi9piIfCB3hVsaoQ7iukG4CFyGWNIZ+mCMhLscPYkQLkoxaSuAW2ciPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVuKGDiS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVuKGDiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE8C1F0089A;
	Thu, 10 Sep 2026 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789060499;
	bh=X9XFdnbuwCdh62D3CD8DMUYjiXVGmJrFcbjdlZxs/84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lVuKGDiSaDnXTm/py1IKAs6QbWviWsh9mlNazsPC31iNmOhvdcsF3R5lVmHvkMY7S
	 aoiX5dwASgQr3ZomlD0rG5zhKl/pvICCV/v1W5Qha4G5u+lk1P5W6fUA7+XPo5qnGr
	 oSTVUJ7gr9So6150+/RDbu1wNIZC0E6VAo5bLmNfbqLu+3OO/dZdn014hXah1g3JJL
	 +3J89HVGvOm4tdWj/M+ereF2IAyTXyJxegIkBcoEsa4IvBVdvtdrjRfvAZaiJd7Oc5
	 Scdg0XbSYBjopNGmeAOgKZrhhC1ue6HP7fBoxbHQNLrT86p+ZxYTXKUAhaiJ+JKFLg
	 N2RkvLeeeSD7Q==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v4 5/5] ata: libata-core: Fix the ata_host_register() kdoc
Date: Thu, 10 Sep 2026 19:14:11 +0200
Message-ID: <20260910171406.131211-12-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910171406.131211-7-cassel@kernel.org>
References: <20260910171406.131211-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1402; i=cassel@kernel.org; h=from:subject; bh=8d2R+HmGls68wNljzGx++qxH/fOD0Jiwk256M5CZPfM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIWPc1yD6pYekaUXePORI+nyRJqknfNU77x7vr15rrPg +kVYW/7OkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRDcwM/ytDHFYmMTCEHd4s uc2KWe79j80WfttuH38pU2f67/T6pvcM/6MYyv9NFI//evZ23KlZNuobH+aYVMlJZbtsn7iC4Y2 6EycA
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

