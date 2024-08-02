Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E99A92D
	for <linux-ide@vger.kernel.org>; Fri,  2 Aug 2024 00:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558521; cv=none; b=QV7QvdVy+G2RpeNlLaxvQgpFApOgNzT3plgNNSElYYIcyt87cAAIWJzIrxa/VDB6Wh6lV6FpqHeLGSx5555YYQYb0XGdIzdJMFs2GO35/5/HkOrqsdRRR1XSa6H2UuLVO6uDdlvJlRfPvOgcTXBCMlH24T6csLklIQ6Fx3Kwtxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558521; c=relaxed/simple;
	bh=o3t6EB1AytW9VEY7G0NsjYse8oYHbmhdlxSWNBKwxXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MHxPz2njRd/yJn1XrW5v7yJCCZ4CRiew2VTO8VxBdC24dIDA6ZNUqs2DDhqIxCugYdm1FbaWE5JWSll90rvzRZJlvqjLrU/nw/v6xGjalYQ3fx4p5F+JqjIDu3+P5+re+Oc5bS61VJzP8gkDKm9lSpGD73CTqiEo7WNHMgvQ5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6Nx6UNc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6Nx6UNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89460C32786;
	Fri,  2 Aug 2024 00:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558521;
	bh=o3t6EB1AytW9VEY7G0NsjYse8oYHbmhdlxSWNBKwxXE=;
	h=From:To:Cc:Subject:Date:From;
	b=Q6Nx6UNcYiy/ZID1Q+XsMjNtjbTMyJVjiaiu69w4iyIWrelyAQph6nLRBUTUHZyKH
	 P6LUhkjIYLTWjg+M6uw0deR/DzotOpLd0PTo1l/exJGmxNfBDCIjsmpw8ajazoRpke
	 IOhiIeT4G0wIMf5ulvWsfsV5avzfVcGu0Ey3ARhdqr08bex3YJ7K235E+kgj122mAz
	 nRg3v1zQFkfax6d/zovtDg3aQUSDJCIDj6XLCQKKbacKhnZOgYz0PrKUhwGO6r7N4p
	 plCyor9TQ45ZH7eu8Fwf8wcPeDcqylOmpWdCHiJBdmVMwFnLBOiw2iZwHhgWEm3+iX
	 4cAGhSnOMRt4A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ata: libata: Print device quirks only once
Date: Fri,  2 Aug 2024 09:28:39 +0900
Message-ID: <20240802002839.17338-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ata_dev_print_quirks(), return early if ata_dev_print_info() returns
false or if we already printed quirk information. This is to avoid
printing a device quirks multiple times (that is, each time
ata_dev_revalidate() is called).

To remember if ata_dev_print_quirks() was already executed, define the
EH context flag ATA_EHI_DID_PRINT_QUIRKS and set this flag in
ata_dev_print_quirks().

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 58157d607aec ("ata: libata: Print quirks applied to devices")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/ata/libata-core.c | 8 +++++++-
 include/linux/libata.h    | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b4fdb78579c8..e4023fc288ac 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -160,7 +160,7 @@ MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
-static inline bool ata_dev_print_info(struct ata_device *dev)
+static inline bool ata_dev_print_info(const struct ata_device *dev)
 {
 	struct ata_eh_context *ehc = &dev->link->eh_context;
 
@@ -4025,10 +4025,16 @@ static void ata_dev_print_quirks(const struct ata_device *dev,
 				 const char *model, const char *rev,
 				 unsigned int quirks)
 {
+	struct ata_eh_context *ehc = &dev->link->eh_context;
 	int n = 0, i;
 	size_t sz;
 	char *str;
 
+	if (!ata_dev_print_info(dev) || ehc->i.flags & ATA_EHI_DID_PRINT_QUIRKS)
+		return;
+
+	ehc->i.flags |= ATA_EHI_DID_PRINT_QUIRKS;
+
 	if (!quirks)
 		return;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d5446e18d9df..0279c0a6302f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -378,6 +378,7 @@ enum {
 	ATA_EHI_PRINTINFO	= (1 << 18), /* print configuration info */
 	ATA_EHI_SETMODE		= (1 << 19), /* configure transfer mode */
 	ATA_EHI_POST_SETMODE	= (1 << 20), /* revalidating after setmode */
+	ATA_EHI_DID_PRINT_QUIRKS = (1 << 21), /* already printed quirks info */
 
 	ATA_EHI_DID_RESET	= ATA_EHI_DID_SOFTRESET | ATA_EHI_DID_HARDRESET,
 
-- 
2.45.2

