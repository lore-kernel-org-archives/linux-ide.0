Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3742E35E52F
	for <linux-ide@vger.kernel.org>; Fri,  9 Jan 2026 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969603; cv=none; b=pCXRpifSdtJSU55eE3uAVfxSXRCezcQShlIe075DIRVKn/q4zOrg6RnCqM7ZffS9jxCqTui60O29gZ++el78HRCHsi5WxqBWJQWOS4NSApLla7TOjcc9H+TB3rFYKvU6L7v/CaX8AObbAXjCKsqmp2oGg0b6zA7YspXCTz25jWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969603; c=relaxed/simple;
	bh=SW1S0wQDf7mPg3VxzJ1YDckoyI7DNHRoVegcNv7P0jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQ+m1kn/uLRAghkxLPtv0PI5LN2HLCTegGr+0FGEb3kaOIFZ/AEln4HWjjxHU7U6DnaaDkwU80XBmvDqK0C+Srl9Pjr0+VoIc2MmXXZtTU062y1aXLiu1nBvrNcS+CJ+hmN4jEEsilIRaOMsFeiTWIhUIA4XJw5bKnmgJ196Qno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyA/vPQg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyA/vPQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D650FC4CEF1;
	Fri,  9 Jan 2026 14:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767969602;
	bh=SW1S0wQDf7mPg3VxzJ1YDckoyI7DNHRoVegcNv7P0jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KyA/vPQgmpVJ21wkcA+klU7Es3l8B6QnYeXJAZH6Q+7ASf285w4tWDJTBWelR8hXI
	 TFNAQWlBQqNxYbk3u1ocdTL2uvw4W+sbJ0Pcv/Mvgy/uW41ypwaqvUEXN7lsy8cdZp
	 lD26EUo2smTh1BcA/6GmEaphAmM8yIDdB8OxNk8jFb3zt0DxmSvOUvNrp9kPRVcOaZ
	 aG7Veu5wPSGaOrjNG9wimJPQbYNtr5YUlecIm1UPHTV6T15gg8E4ON7OVUveNnIM9c
	 gPujSFngsJ13bHZqMvH50O2ud8+sOBlVzK4ids6smnCPTRw0V8fZhCiaGj0ioAclqW
	 nRlH0gybRiB2w==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	wolf@yoxt.cc,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 4/5] ata: libata-sata: Improve link_power_management_supported sysfs attribute
Date: Fri,  9 Jan 2026 15:39:54 +0100
Message-ID: <20260109143949.331105-11-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109143949.331105-7-cassel@kernel.org>
References: <20260109143949.331105-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=cassel@kernel.org; h=from:subject; bh=SW1S0wQDf7mPg3VxzJ1YDckoyI7DNHRoVegcNv7P0jk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIThU1LH8frbtjZVr5MgvNqSovvIf2eyY+T+T+wZzEff P8qwX5rRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACYS5snI0BTtvuqHSvUeI5WU D0kLtx03rVeLL8o58up/9lq1OZ1xmxkZOpnuGlwTOizBzX+v3nGBsq39F4e7m2//P1249Y/Uh33 ZDAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The link_power_management_supported sysfs attribute is currently set as
true even for ata ports that lack a .set_lpm() callback, e.g. dummy ports.

This is a bit silly, because while writing to the
link_power_management_policy sysfs attribute will make ata_scsi_lpm_store()
update ap->target_lpm_policy (thus sysfs will reflect the new value) and
call ata_port_schedule_eh() for the port, it is essentially a no-op.

This is because for a port without a .set_lpm() callback, once EH gets to
run, the ata_eh_link_set_lpm() will simply return, since the port does not
provide a .set_lpm() callback.

Thus, make sure that the link_power_management_supported sysfs attribute
is set to false for ports that lack a .set_lpm() callback. This way the
link_power_management_policy sysfs attribute will no longer be writable,
so we will no longer be misleading users to think that their sysfs write
actually does something.

Fixes: 0060beec0bfa ("ata: libata-sata: Add link_power_management_supported sysfs attribute")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-sata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index b2817a2995d6..04e1e774645e 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -909,7 +909,7 @@ static bool ata_scsi_lpm_supported(struct ata_port *ap)
 	struct ata_link *link;
 	struct ata_device *dev;
 
-	if (ap->flags & ATA_FLAG_NO_LPM)
+	if ((ap->flags & ATA_FLAG_NO_LPM) || !ap->ops->set_lpm)
 		return false;
 
 	ata_for_each_link(link, ap, EDGE) {
-- 
2.52.0

