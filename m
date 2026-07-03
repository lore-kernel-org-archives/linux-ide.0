Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDCB37D12D
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068729; cv=none; b=sXF6ad94qEDGtyBDEH55NGyMFASDY0c0y738n9sXu5pXqQQcD830ANRBZcVEd7aeYBB7BKPw7auAL1VVh/3uI+02d+gktoUeExJ9YxjC/UNUqg7LIC8LKNabvakUFKq3PScJiP5B7hWmE07P6YmXIG9/Pjloq0v+E1KsLdFsU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068729; c=relaxed/simple;
	bh=uWO/BwLpWhKjaVza2rO7gKHkyMUQ76C8kG8iMYCqzC8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMjSXoQvyy0TptpdJta11xW7xMRwzJVge8QnLqVfbrDjMcj+xloz8ag++WgDU3Pia77vnU92iuiAAZmRzGBzr4lvdAKgqNyuK6NykJ3T4nR9NFvQAl27BHjeSialKeG3ztb3BgKEWXi3KnYTtGIaMxoDhM/w2STMvHKpBipSqIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/jBf47X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/jBf47X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E3E1F000E9;
	Fri,  3 Jul 2026 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783068726;
	bh=17L6osc0BF3E6zLrY4rwrl8WdcaFMEyC0RK9w5WqAdE=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=h/jBf47XvtCNYiI+NZ6YcUOpZZtjlBFuXChj5mCmj5LQ1nPirWy/WvCKQs+ZKumuU
	 Lr7IeEGpfcCkU1cyi3y9oDp1fhz2FrnSMGYDsyIa7VB/rG2ovv2F9LYHMvOJp2+wBR
	 r9XrRswhpee9+H8Vl2ydh/0R07cS/Ra6Cdp2yNg3E205wb7vvsHmVZPhPSgCA7gdmn
	 ErUKoeHLuYmLIp97q4WtPU2gKnJ6dhsvY2cBwvJQWYQJTKq5IlecqIoQcgnp9pUrAe
	 +RrwuzzIp0v3+y6r2ynx3h2Etpi9ZVLB4nuHr7Hfl5oKqdGoz1r4Co8rVtX5cOg5/K
	 5btKwDOvAxhlg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 4/5] ata: libata-scsi: support reporting options 2 in REPORT SUPPORTED OPERATION CODES
Date: Fri,  3 Jul 2026 17:51:51 +0900
Message-ID: <20260703085152.2350034-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703085152.2350034-1-dlemoal@kernel.org>
References: <20260703085152.2350034-1-dlemoal@kernel.org>
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
index 39323d39fd75..265236b0493d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3777,6 +3777,13 @@ static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
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

