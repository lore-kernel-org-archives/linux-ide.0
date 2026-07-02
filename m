Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAC72D7D59
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 01:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957422; cv=none; b=qbW7IvdxnvBYDPi080zIk0F4scxgIwCMMC4PX1XFNs+G5oXRa5m99IhbYbzLDc8XMVkdA0AMDyWhyfuxxTM+AmOvxDMN+KT2dfSufNMK1H/wWB693ho4cyGcFL33BoGvbo8Xe1cB3geZLVI5hLa6gxFbqtkWwtwQVXUn2tUb8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957422; c=relaxed/simple;
	bh=Oe8oFGCVUYQOI/h6pq+IBzlIgErc+4bzZeAacuuYtYU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvqoM+hc3E3Z83ngEEYQLB1tgjbdged5OMYYl5O/QSPjHWFte87v3obS4IwYIg0TW92aknlb30zEVj0481XDyLu8D72Y3mGUVFpK7q4Fh4cJvAU7ixLQr2mZC+0Iv7JLEgQMgxhWXHsDT4tY9Y5VPNKnnW5LUcy911BVx20Oe5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ8VaOeJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ8VaOeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73551F00A3A;
	Thu,  2 Jul 2026 01:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782957421;
	bh=JHxkoa5DaD+/BtZFLb7659KPM7r2UoAXHnM73aOoLe4=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=FZ8VaOeJQiO+/60IIt+WsUK6lXRjt8tntd4+xZCL2unbo82xoUY+zxCBAIIMzx7Zq
	 9CNvizA03i4ASQnlczTb1Sc2yqCNMnMoS4upHBzMMVVZ5rohPOaq6yL0APItP706+v
	 eilpm/wsWNirvUSpEzMBF70R8bzm+Mpu/Z3qhNWtZrQYTXIfY26YgpLRWwE9vINnUO
	 cYLk8gzQTTn4X9rLcIUim89rrX/w9vc3vb4Id8uBqicq1sk1ouC6KFpYGyCg3HZdGa
	 EX6X1HfJ4vfTffmKTn2IPaocErh42aIywK12WR6M3IF1cY0Pu4E50uDCLSJMa1agG/
	 sEsGgbA5IMWvw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v1 4/6] ata: libata-scsi: improves checks for ZBC_IN and ZBC_OUT commands support
Date: Thu,  2 Jul 2026 10:56:44 +0900
Message-ID: <20260702015646.1702539-5-dlemoal@kernel.org>
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

Improve ata_scsi_cmd_is_supported() to check the service action for the
ZBC_IN and ZBC_OUT opcodes, to correctly report supported zone management
commands for zoned disks.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e432e521ad31..f9e6bda6833e 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3708,8 +3708,17 @@ static bool ata_scsi_cmd_is_supported(struct ata_device *dev, u8 op, u16 sa,
 		}
 		return true;
 	case ZBC_IN:
+		return sa == ZI_REPORT_ZONES && ata_dev_is_zoned(dev);
 	case ZBC_OUT:
-		return ata_id_zoned_cap(dev->id) || dev->class == ATA_DEV_ZAC;
+		switch (sa) {
+		case ZO_CLOSE_ZONE:
+		case ZO_FINISH_ZONE:
+		case ZO_OPEN_ZONE:
+		case ZO_RESET_WRITE_POINTER:
+			return ata_dev_is_zoned(dev);
+		default:
+			return false;
+		}
 	case SERVICE_ACTION_IN_16:
 		return sa == SAI_READ_CAPACITY_16;
 	case SECURITY_PROTOCOL_IN:
-- 
2.54.0

