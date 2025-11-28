Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4172FD1B0
	for <linux-ide@vger.kernel.org>; Fri, 28 Nov 2025 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319724; cv=none; b=akbAKZcLc25HCi5WMc9ZZgMZe4eObqZIBa1GZNZ0gn+0Z9nfWcXB3akNJyYNaNOgQ2LyC/Q3qKh+It1vdcQcOBl2KVzLqcdztWRq99J0C61EN2y1/qBAgOI5xlB9oed7QZUI+MLMHOuH/8yfSnoTRyb4Rh4OPPMPYQV/wYV4WCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319724; c=relaxed/simple;
	bh=GYmEiCXQ0KjvFCswGHmwcRAxseICvS5Q2mRZzp7Ipxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY8+eUbTdRrcq5rbKb+Ugbeyfe9gQD4ph8f579nWLob4BYx4n24D7ZlOte031wkB0rzjqt4prYgQlnptfoBASA7b+/nIJd0lvW1p9tYTZC//uYpHp+V/dP82PJCCTQo71sQ72UxQB31T6LEM9PiuX2GTQkLCSeKZPbAEMDI+0kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXAyeEDa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXAyeEDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D624BC2BCB1;
	Fri, 28 Nov 2025 08:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764319723;
	bh=GYmEiCXQ0KjvFCswGHmwcRAxseICvS5Q2mRZzp7Ipxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mXAyeEDa3gLg+PT5HlFQs5jwQH9LY/qdFi/OOVJjhEzrOGnHDKWFMRz8IX9oDjy1/
	 1Ab4zZdiKNMmnfRu+t5XY2GlFLGeeBCj86jEDZEAlwsRtpcoyKRGRRICYVzi+VKg0a
	 MsiQTMPVn8BRU6pkncUM9xMz07+qna63X/nf51kvcKSYbY7rWTBc9IRafoPwkvTDzn
	 NGn/CBsEnyhYzKam5Nu2+lfs7aqe6jYZJQxaCz9roo6V+jJkmrsSFTT0c7dD3shLiv
	 oOMZ+mpTDDAs5rh5Eu7VVw3yR/RFldcllmLe/jSyZ3Of9PP/Bf88CVZBVk7CeHLGSh
	 2cimmnB86mHZQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 7/8] ata: libata: Add libata.force parameter max_sec
Date: Fri, 28 Nov 2025 09:48:22 +0100
Message-ID: <20251128084814.3798425-17-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128084814.3798425-10-cassel@kernel.org>
References: <20251128084814.3798425-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1882; i=cassel@kernel.org; h=from:subject; bh=GYmEiCXQ0KjvFCswGHmwcRAxseICvS5Q2mRZzp7Ipxo=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI1Ey8nXXj7i0nsknj9PW8bq5jItddjW+pb3WZaXNv8e Mflit8RHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjI5x2MDDsuHfq5NvJA4M0K /qXf55qmcyv/v9vXkB3amd0a4/Wq+wfD/5THF9IYf2RwpaRdO6Whqix5rCuUe/LX/PstCpPUXP4 l8wAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add a new libata.force parameter called max_sec.

The parameter can take an arbitrary value using the format:
libata.force=max_sec=<param_value>

e.g. libata.force=max_sec=8191
or
libata.force=max_sec=2048

This will allow the user to set an arbitrary max_sectors value using
libata.force.

We cannot remove the existing libata.force parameters "max_sec_128" and
"max_sec_1024", as these are a part of the exising user facing API.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 drivers/ata/libata-core.c                       | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6c42061ca20e5..c5464b11a2ad5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3294,6 +3294,10 @@
 			* [no]logdir: Enable or disable access to the general
 			  purpose log directory.
 
+			* max_sec=<sectors>: Set the transfer size limit, in
+			  sectors, to the value specified in <sectors>. The
+			  value specified in <sectors> has to be an integer.
+
 			* max_sec_128: Set transfer size limit to 128 sectors.
 
 			* max_sec_1024: Set or clear transfer size limit to
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 7f59eca2a65be..c122a8aa27688 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6540,6 +6540,7 @@ static const struct ata_force_param force_tbl[] __initconst = {
 
 	force_quirk_val(max_sec_128,	ATA_QUIRK_MAX_SEC,	128),
 	force_quirk_val(max_sec_1024,	ATA_QUIRK_MAX_SEC,	1024),
+	force_quirk_on(max_sec=,	ATA_QUIRK_MAX_SEC),
 	force_quirk_on(max_sec_lba48,	ATA_QUIRK_MAX_SEC_LBA48),
 
 	force_quirk_onoff(lpm,		ATA_QUIRK_NOLPM),
-- 
2.52.0

