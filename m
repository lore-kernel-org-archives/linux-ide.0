Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE21A351C2E
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974068; cv=none; b=vGZtRBEoA3tvznEY0bNG5VEXSRxzdXwW79iAozacJpWXJMTejV3HIbUiif7PLxVdF2b1Kl+5Aoih69obU+PyF7CXsRorhn5eh0+9REiXUDd8eBvSE2lpRGUgmMrJSc3fDUjcNasDS3w/nKNc/6Q3nEACMM3MVtfTdYEcYQdGxcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974068; c=relaxed/simple;
	bh=fqmkSt0s7xrSjiHTIBjntnR+glabkOJCvsmssXuiP34=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPCYvQOhPiUmAOu82Fr1KtxjxpMlaOnCXZWFO0ZJ7cAvl1svJpPJBke4rxFwq4kcgPU8eLdxGLCsb/vQCl0edceoeU7KKN6g7KP40eYrnTEeH8OBNMPEz+qiOmh/X1IXn1WdWYIq/5/MOEZuk+EFXWZqXudndCx0JfAZEEKOW94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrMHQzDH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrMHQzDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBFA1F00A3A;
	Thu,  2 Jul 2026 06:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782974066;
	bh=DiVXf97SnWwKHLDUKO39bqLLi9Q9+lJUdcOmzqNkWH4=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=VrMHQzDHre0UBQsMQoauoYn37DxzmnZzO/Q5a5r4TU+vcrRjZOEjELP2km7ld3JZI
	 BpKAzn45VeX6D3xS0Mfa9WOuGY9an4i2den60ezQUFC05iJhdigL9y4ZSHNqO9ed6F
	 tLNbhQawQQoBlMF2lTry+FyGPhsi6F5nBYMS4Jcgsau95mjcHcUxqn73mFm5+Wb/oC
	 R8oxvfRO0j9U859w+OBsDhvBxeNFv8EzL7ja7tI8rYR0HaGRxfJukgd8vfimmfjdO+
	 sKRE5QFE/vZTLP6Xs3PbmdFc/L4VG8yvgJOVPu0HJ3248QO9OJDk2NGnx+oRfwPeze
	 RiHl3PjZtKsfQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 4/5] ata: libata-scsi: support reporting options 2 in REPORT SUPPORTED OPERATION CODES
Date: Thu,  2 Jul 2026 15:34:11 +0900
Message-ID: <20260702063412.1892584-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702063412.1892584-1-dlemoal@kernel.org>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the reporting options value 2 of the in REPORT SUPPORTED
OPERATION CODES command in ata_scsi_report_supported_opcodes(). With this
reporting option, the specified opcode to check must have a service
action. Use ata_scsi_supported_cmd_has_sa() to check for this and fill the
command reply buffer using the one command format based on the command
support.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 86ac41a7d81a..e75ed573e234 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3737,6 +3737,13 @@ static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
 			return 0;
 		}
 		break;
+	case 2:
+		/* One command format, must have sa. */
+		if (!ata_scsi_supported_cmd_use_sa(cdb[3])) {
+			ata_scsi_set_invalid_field(dev, cmd, 3, 0xff);
+			return 0;
+		}
+		fallthrough;
 	case 3:
 		/* One command format */
 		sa = get_unaligned_be16(&cdb[4]);
-- 
2.54.0

