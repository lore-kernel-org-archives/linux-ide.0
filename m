Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291AB283FCE
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 04:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051557; cv=none; b=P3Uhk52q1j0shD6v7kYjuGOwZu7YGz9PzVZSnduK1EViPMLZjp7DXLkB/v3CiYxUERDUvpXLk2Gqppoltglqp/gmS2AEjtwdLdwrphYHJdc0S3XwCHPRIp7DGx66Wb1ejm40a+vY29y5SvtAHBh0n0UFGLjjeejUbqG+Mx5BOmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051557; c=relaxed/simple;
	bh=EfG4ec2ZLBcFe+/0t2F9bFndwyZQGWJQWi7yfXNmPQ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLSp2WQBzd8Im+9raGSYfsjTF0b0xUtn++tnOCd/6xmLwpKyAYzgSvBgSkuzQVojc9dSrvzR/iunLqVci321BPUx1+11lVajuDeM90iYge69lixRWoM+hkC0cwbyw0cb3xPVsVjvOD0///ggKzQW9TQtATqMc9tSilY+PX/4Y9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ4gOAA/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ4gOAA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB001F00AC4;
	Fri,  3 Jul 2026 04:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051546;
	bh=/vOzXGBcuiSGg5V8Fhov/6H0VYbmkYGirw+hcfBCj1E=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=MZ4gOAA/wkFyEjrm3Nh+5qWYh52N99fDYAay63q1yqx3MhbAkmOLt1XMrrE9ViRdh
	 dNHnUKJEXCLs2pGzu+9/7NCfqIF7M/R5B0r4hS6Qye+QMVkFAK2TM6vEvphkJd/lik
	 lzopmtt0sGJx/WbkJG031E3ULCwF66hi6Hj/gboEWIpwoeR/tJQHmEP2Wj0zRc7WsJ
	 ptPUfoQBEYJBsTbgtLe6AjuZxWdV8DatMHWG7YarTjG+4rarpliBlLXXVCady3aL2C
	 xBGP9idZIp4krNbg+2XmTgEh+nNwbd+IxCYmmgHF+3Dca4DGVM3CNm7z2nE/JR4COp
	 2jMm78pqN55Ww==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 4/5] ata: libata-scsi: support reporting options 2 in REPORT SUPPORTED OPERATION CODES
Date: Fri,  3 Jul 2026 13:05:31 +0900
Message-ID: <20260703040532.2152614-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703040532.2152614-1-dlemoal@kernel.org>
References: <20260703040532.2152614-1-dlemoal@kernel.org>
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
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/ata/libata-scsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 4d4cdf304740..5dd76579327e 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3774,6 +3774,13 @@ static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
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

