Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B7020B208;
	Wed, 16 Oct 2024 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084732; cv=none; b=So13ArxUyEmf7dgXzYU39WXNYhMrWO5E56E7n5+ClH8xjZ0ei2GQJwij4tSK2vfGL/ydRrmO21O8QS4v/OTIinYRyzv35+QRXWWNVxdnSAiFTzFlBWA1SoOIHZdtjtAEmZNn1vgZPTjukxQTyQQKHdkEI+uJHQV0+PK/z2d92+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084732; c=relaxed/simple;
	bh=P2cJ3FrKw3YLzdNPSkhG/vqF3ynZpX9KZsrBVG+D0ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uBUD4ApGXiOnuux+J3GV6uSMn6FfI3DXwq7AX3XwNtEXXDbbT1suZogIuorP/TgogcmCskTbxN8rswGji4N3+Qkok8MHBgNCqrSA80B4t1SkH0dxrK1tDERXE0StukQ0zD5aeIUJIfhyx623tal/VsHSb3HzK8wfGXvpdwLQkbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Or6Jb+Y+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Or6Jb+Y+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729084732; x=1760620732;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P2cJ3FrKw3YLzdNPSkhG/vqF3ynZpX9KZsrBVG+D0ZU=;
  b=Or6Jb+Y+V86P+LK3PyBJl4JD4+dxQVFKVG3Idm/Hp61VmC7ZTh3zQ4S7
   Ghj4QcbQbGIStKiF5R+SWRewPLuUusQpLC2vMKYvhkI+15WeRBqzKea0Q
   HOdbPMAWAGLyiZ3vqVHPEKYHTFPl1LDT53Pzwfklg02LWciHyiN6/YKUl
   T4yUXmiyJHOTa49NuXHUp52x3L8pB0dsJrTYy12exsCGvax90FZmhYwK3
   r0asVphspU57/M3z/egqFj71OXXnn4LKenMIovmU1yKgN6mDB1PIRTAok
   bw6GvNjMxPdd9JomUtBeT5TugCyEFN01dXtnQevlYxwImznONgdncmUf0
   Q==;
X-CSE-ConnectionGUID: BwFvVJRHQVyd2ef6c4e8ig==
X-CSE-MsgGUID: 7QP8N/MyRd+aEBONh/6A9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51069921"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51069921"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:18:51 -0700
X-CSE-ConnectionGUID: CMGgOgEdSBeLHWiax18p3g==
X-CSE-MsgGUID: Xy7uRwpFRjaXlCW1A9CL1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82188313"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 16 Oct 2024 06:18:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D5A5C165; Wed, 16 Oct 2024 16:18:47 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ata: libata-scsi: Refactor scsi_6_lba_len() with use of get_unaligned_be24()
Date: Wed, 16 Oct 2024 16:18:44 +0300
Message-ID: <20241016131845.898632-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor scsi_6_lba_len() with use of get_unaligned_be24() to make it
consistent with other similar helper implementations.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/libata-scsi.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f915e3df57a9..4cef824cbafa 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1334,17 +1334,8 @@ static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc)
  */
 static void scsi_6_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
-	u64 lba = 0;
-	u32 len;
-
-	lba |= ((u64)(cdb[1] & 0x1f)) << 16;
-	lba |= ((u64)cdb[2]) << 8;
-	lba |= ((u64)cdb[3]);
-
-	len = cdb[4];
-
-	*plba = lba;
-	*plen = len;
+	*plba = get_unaligned_be24(&cdb[1]) & 0x1fffff;
+	*plen = cdb[4];
 }
 
 /**
-- 
2.43.0.rc1.1336.g36b5255a03ac

