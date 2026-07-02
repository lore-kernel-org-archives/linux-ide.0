Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4029CE9
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 01:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957422; cv=none; b=FL7+kuVCqWMkbuy9y3f4ZKoU8CUUAhEexiL66WwU+LwjMR67+qxLioF1ukjI55dpfevE0+cquwuXt+s8Na0F7R9cuXBFUqWo3AYZpLf91FGXHvHkkQH+ajOf9ixBtSTUiojw5QiFH+Upqdj7ihZNQHOYiUTisqBGaKACowYcqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957422; c=relaxed/simple;
	bh=4/Cv3sSN7NlV+HN3AU+m3uf9AOhX5+rxwHTFo7oKnfs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8dNRI6ZOJKLE18Qf55NnrtLg2mrzoeGo281zkEOrBYDCh7hQ89PifQ9RZ6Gi+CEJH2dqBCtn19AUlZgtp+A/Qr+NOoqfdHCuxbf7DRW5QAaWxaiIjMNWT9XiKNRJLIcNopt60adSkjAL50zkkeHu8sV+ZdK1/z/0ijrQdeH4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouI1KuxB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouI1KuxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF3C1F00A3D;
	Thu,  2 Jul 2026 01:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782957421;
	bh=9KUBATwqusaztKM+4Ysn/TQJuMtW1AQGD1y3c8pXkp0=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=ouI1KuxBo004EqWlQrztUw/eKYnwfQd42YkJXEOtY84RaFFyJH+Sno1zTufDeXvCd
	 1+8eSWhafHnV/T721aOWKB8sB5LwbiKiKYN93/5IVIXmYlGuI9nF8+g1REzkAWytIm
	 23DtWSGy0+VayZCFwo0CfmG49gekMx8ox7/aFXo6peGRq2LrxaBHy4nDF2J4qoGGoq
	 8r3eiXGCfABZJRFEu1Tgw0gKNHBD7XKBrfWLmahSCI22iVb6DrIVGFCPWDebjEhH9u
	 09HXsM5dm7Y6hWNlr1dYxNfBxKAZ4vTupJ2vkG3AA129lUKDGEaS5oY2AcQJPkZyY/
	 uX7j2WvDpsXVQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v1 5/6] ata: libata-scsi: support reporting options 2 in REPORT SUPPORTED OPERATION CODES
Date: Thu,  2 Jul 2026 10:56:45 +0900
Message-ID: <20260702015646.1702539-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702015646.1702539-1-dlemoal@kernel.org>
References: <20260702015646.1702539-1-dlemoal@kernel.org>
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
index f9e6bda6833e..3f313050c63f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3747,6 +3747,13 @@ static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
 			return 0;
 		}
 		break;
+	case 2:
+		/* One command format, must have sa. */
+		if (!ata_scsi_supported_cmd_has_sa(cdb[3])) {
+			ata_scsi_set_invalid_field(dev, cmd, 3, 0xff);
+			return 0;
+		}
+		fallthrough;
 	case 3:
 		/* One command format */
 		sa = get_unaligned_be16(&cdb[4]);
-- 
2.54.0

