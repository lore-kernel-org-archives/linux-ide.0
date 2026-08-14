Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C135E944;
	Fri, 14 Aug 2026 03:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786679935; cv=none; b=UjDLgPXlf81pQxzrwlR4ZWkOMKdY5hqdLANKBBYpW1HKFGcN26Wg4Mpvxk/ApA9K0JNaAhtb0e9UG7fTKy76mXwxkYUBaoKfdo6IPlCiU07KZXlVO9xsUstP4AWQ4X+f7ER9apv1hwPc5E9pHbtcrBTJMjSrcKsnz2KlR329318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786679935; c=relaxed/simple;
	bh=jz/VjQS+BZSB3xSkq5/eA+CnwR3x+p1oocl1jKiMwr0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LaaDFU1dJ4hyygtK5s8+uimNOzTq43MKXiNc467y92H7iyEYuDhAfA5Zu5DWePtuP47iNt2jU1XhLhx+03rfF9x/s5LS2t23W7Ah1ywskuYPkGc6QOIrNcyAc3gK1fzDK/TbYEL1kOtC1TltcgYpgj0kcazdPkUmltgWubChYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=OMIz36cg; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="OMIz36cg"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xaapQHUFciKCd0XqxK3Nap3/y6DNgcfIgTD0X5newI4=;
	b=OMIz36cgQYNMlZmHiRaEqT0CDz22zurIS0ZV5sNgPTa53pdrO5RBic4xqvd220i+yQw3rqANL
	ZYQiIO/coyssjszZ3812JBlyR7m/3uU1O9AwaqHSniHsUwdMti04vlw/F0hche5QP/2R1cx6PEp
	NfMLs6f3G4EtaBED3ZfKp40=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hLp9M4N9Lz12LDV;
	Fri, 14 Aug 2026 11:48:23 +0800 (CST)
Received: from kwepemp100003.china.huawei.com (unknown [7.202.195.218])
	by mail.maildlp.com (Postfix) with ESMTPS id B446340538;
	Fri, 14 Aug 2026 11:58:47 +0800 (CST)
Received: from kwepemp500015.china.huawei.com (7.202.195.9) by
 kwepemp100003.china.huawei.com (7.202.195.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 11:58:47 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemp500015.china.huawei.com (7.202.195.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 11:58:47 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: [PATCH v1] ata: libata-eh: Add timeout table entry for STANDBY IMMEDIATE
Date: Fri, 14 Aug 2026 11:58:46 +0800
Message-ID: <20260814035846.2032778-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemp500015.china.huawei.com (7.202.195.9)

ATA_CMD_STANDBYNOW1 is not in the ata_eh_cmd_timeout_table and falls
back to the 5s default (ATA_EH_CMD_DFL_TIMEOUT), which is too short
for some drives to complete a STANDBY IMMEDIATE command issued from
ata_dev_power_set_standby() via ata_exec_internal():

  ata1.00: qc timeout after 5000 msecs (cmd 0xe0)
  ata1.00: STANDBY IMMEDIATE failed (err_mask=0x4)

Reuse the existing ata_eh_flush_timeouts for this command, as a drive
entering standby may need to flush its internal cache, making the flush
timeout a natural fit.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/ata/libata-eh.c | 2 ++
 include/linux/libata.h  | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 05df7ea6954a..8f9e12f460c3 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -149,6 +149,8 @@ ata_eh_cmd_timeout_table[ATA_EH_CMD_TIMEOUT_TABLE_SIZE] = {
 	  .timeouts = ata_eh_flush_timeouts },
 	{ .commands = CMDS(ATA_CMD_VERIFY),
 	  .timeouts = ata_eh_reset_timeouts },
+	{ .commands = CMDS(ATA_CMD_STANDBYNOW1),
+	  .timeouts = ata_eh_flush_timeouts },
 };
 #undef CMDS
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 96e626d6a7ca..6c0d385b2cde 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -425,7 +425,7 @@ enum {
 	/* This should match the actual table size of
 	 * ata_eh_cmd_timeout_table in libata-eh.c.
 	 */
-	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 8,
+	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 9,
 
 	/* User visible DMA mask for DMA control. DO NOT renumber. */
 	ATA_DMA_MASK_ATA	= (1 << 0),	/* DMA on ATA Disk */
-- 
2.43.0

