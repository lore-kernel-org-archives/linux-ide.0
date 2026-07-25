Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A587F2F39B5;
	Sat, 25 Jul 2026 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784944335; cv=none; b=ed4Z+Pq5GT9xjDHhqZVuqKL5dqow4yXKB+HQBV/Mm8+bexfxEvjpSx2qcin8kOWM0C7DysoICY1lNJEYGEACsbQng1nchK/2JdPlI+bek9WNOgNQFYpv2+EUioyXq2iaLBQ+AwQ4LNDvGXebIE8RLgqvzj62ifcsF8bhV2RFMf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784944335; c=relaxed/simple;
	bh=xiUGfNPHC8xCT+PmfYFhfCv8cShkaeIE3IQ0Fw9oC2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLvSWOeh8sfXwydImhlz2iP/6TASk4dnzM3DeJDGz4pBXnFP4QonVR6fmaYKFV6arypw6bzZzq/2+n6Myx0DCFsqyqQxauCEBH6sCvoe1+5R07LDcVnxqVFBGmBayYS/5eilYMzWcKzL8luIAE3bNnPqVD3jpS43aDE/w0Va//o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aWkQpoAc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aWkQpoAc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=gJo8//kKxEVud2uvFK0K9PByClrLKCOVAT+FgOlSBhM=; b=aWkQpoAcIx3vq3qwJ02PePW0kb
	n1K1MOURs1SS/g7+LhBCKW2JUmAR1b1WWfz7W39PgtrK3H7VqmKllM27PmVhTmYUKDJOHJGZfRGb7
	Sj+I741MybJuEXbtzVhJdEbTFZhwnC16qara4hSsWO53VFEJ/ZX3ms+7uL0oL5M8VWVervpp7POWW
	ve5IjDu7iEvZohiuS/u/3rEBusUECQt/e+L/YVY4Vaz2Wf7DBs/r2ffS0Zeo+GKflcJnzFtfnUdSB
	y4YUbZuDz528+b/MjU0W7YWOU7P8Zn9pkk9QlU6sZqM2z0769fHh+LSjzhFnxkByW+36f63GVBaiY
	EnMKwn8w==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnRYg-0000000HT8p-2m65;
	Sat, 25 Jul 2026 01:52:10 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata: avoid kernel-doc warnings
Date: Fri, 24 Jul 2026 18:52:09 -0700
Message-ID: <20260725015209.1207666-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify comments to prevent kernel-doc warnings:
- use "/*" for a non-kernel-doc comment
- add a Returns: section for ata_id_major_version()

Warning: include/linux/ata.h:770 Cannot find identifier on line:
 *
Warning: include/linux/ata.h:782 function parameter 'id' not described in 'ata_id_sct_data_tables'
Warning: include/linux/ata.h:782 expecting prototype for Word(). Prototype was for ata_id_sct_data_tables() instead
Warning: include/linux/ata.h:820 No description found for return value of 'ata_id_major_version'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org

 include/linux/ata.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-next-20260722.orig/include/linux/ata.h
+++ linux-next-20260722/include/linux/ata.h
@@ -767,8 +767,7 @@ static inline bool ata_id_sense_reportin
 	return id[ATA_ID_COMMAND_SET_4] & BIT(6);
 }
 
-/**
- *
+/*
  * Word: 206 - SCT Command Transport
  *    15:12 - Vendor Specific
  *     11:6 - Reserved
@@ -815,6 +814,8 @@ static inline bool ata_id_sct_supported(
  *
  *	The practical impact of this is that ata_id_major_version cannot
  *	reliably report on drives below ATA3.
+ *
+ *	Returns: major version of ATA drive level or %0 if unknown
  */
 
 static inline unsigned int ata_id_major_version(const u16 *id)
