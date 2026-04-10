Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF78536215B
	for <linux-ide@vger.kernel.org>; Fri, 10 Apr 2026 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862926; cv=none; b=eNSe/u8RnJ1sRxDfwGB0onwWH6eXp3OVYPei27ZRlffdlF7YStqXWCv56QZ/EbAi4J70WzPSPCJ8kMYDCyATWCYk1b40lg5PljmyZnU8Z2DyZNAy7uCqzZzIUywgWSMBR1SLF9+k4jsWbVD+oyqLTWwTv2iNXHM7pK576rfFaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862926; c=relaxed/simple;
	bh=eYuxISrv/X3k5TUxzKbWNdINLoBc4naew/tA8xDUQto=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t6QSjMKQN3pVbPmzYJ5+Am8cW9JHEInXBkqnEO6TbRIt1sx6CdlGlFRr02AeYmx8R0pycpYCig7W/7zhtEApb4U4QuaQRNof4KWFVBhYcDax9V2U8RNqIhai4yyN3kKfTU+dVS4O6+6VenlsJhA4Z+E7QGVDmK7wZ3UxheGda5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=svKvEKWS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svKvEKWS"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bce224720d8so1543736a12.1
        for <linux-ide@vger.kernel.org>; Fri, 10 Apr 2026 16:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775862924; x=1776467724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fNacGDc773uS+o0Qj3GHlGLX7hbC2zRPARQZrbsF57c=;
        b=svKvEKWSV2MGh/gVwFLVBnidSuGazeiuC7bEwx1mCIsG8+Pe7tyiJb1UyIgm+kSIDp
         etq4PnFYJRH/hwZO5UdBeFvc1hp5dD9nc3wkbrlgDVPH5Cb60W5N6IGvDzHDzC+QFzvr
         CP/kuw2gD3ovnL02grnV9VOA+wA/b/j7Pxh9qkwoXUaVJrLOfiPhF1KsH2C1C2MvdIWK
         7sJjt54vl5bMIH5VgnWBnSW7rK8xPbHszQtIembD4sqt2jg437b3ic7Q1+aHhlE+3j8R
         Wq0LhkWWxm4UvPUck8l+XjuIPbyiLjGHN7tHyNL1gRANBowg0Y5K9GSVxziCRDDjwCNY
         qD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775862924; x=1776467724;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNacGDc773uS+o0Qj3GHlGLX7hbC2zRPARQZrbsF57c=;
        b=ebFNw5j/UF3r4hlOo8jygPpfj1P51+I3NGW8LDrrlffXUsQU2TXQAZlFtCA52edsMh
         C8Ha+XQpr+FoV85EQGTXSEot73WHLHLrZxMHNIKy1EO+0U9q1AlfEglP6AdxqGCG4ET2
         O/KNyf0YvGpsSWmX5vafYIyfu+uA4mdHtwDqNdiWraGpqiU3xiosFbcakCsY/Nkquvv6
         AEI10KkkDVmI+lvTQJxPsz+FoeAQ8nfj5NlMO1HiG43HI9nNRkTdgx4VvlrAoMybnE6F
         vKh2mSZ8OuUVeLdV8nmEHP9Iq6RX40MC2L/gEx0ob8gr4jh45kHZzF15rxHXeI0isUHh
         HTVA==
X-Forwarded-Encrypted: i=1; AJvYcCV/hyjbYdZDq9OowmzWI4yb1QZA3v7MQOaV8+BMEETTLtn5p42Ml5B8iSDDyCIu/s9lptYud0gYB/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxBRdINTX/G7EZvrunIKSFnPDWNQ/x9g7Jt5miMzl3RjdpMbef
	6EHxx90B47PCI2jGPeujUijIUPNvsXNS0gbfAVKyn7zvvc+nnAzBEVRVZCsvMDTUIP6M6AG3Wiq
	l0SinzIAMyaF8zA==
X-Received: from pfbgm23.prod.google.com ([2002:a05:6a00:6417:b0:82f:e13:111])
 (user=ipylypiv job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9987:b0:39b:87f0:758e with SMTP id adf61e73a8af0-39fe3c98388mr5711085637.8.1775862924120;
 Fri, 10 Apr 2026 16:15:24 -0700 (PDT)
Date: Fri, 10 Apr 2026 16:15:19 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410231519.951971-1-ipylypiv@google.com>
Subject: [PATCH] ata: libata-scsi: fix requeue of deferred ATA PASS-THROUGH commands
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, John Garry <john.g.garry@oracle.com>, 
	Xingui Yang <yangxingui@huawei.com>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
introduced ata_scsi_requeue_deferred_qc() to handle commands deferred
during resets or NCQ failures. This deferral logic completed commands
with DID_SOFT_ERROR to trigger a retry in the SCSI mid-layer.

However, DID_SOFT_ERROR is subject to scsi_cmd_retry_allowed() checks.
ATA PASS-THROUGH commands sent via SG_IO ioctl have scmd->allowed set
to zero. This causes the mid-layer to fail the command immediately
instead of retrying, even though the command was never actually issued
to the hardware.

Switch to DID_REQUEUE to ensure these commands are inserted back into
the request queue regardless of retry limits.

Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3b65df914ebb..0236394900cc 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1692,7 +1692,7 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
 	/*
 	 * If we have a deferred qc when a reset occurs or NCQ commands fail,
 	 * do not try to be smart about what to do with this deferred command
-	 * and simply retry it by completing it with DID_SOFT_ERROR.
+	 * and simply requeue it by completing it with DID_REQUEUE.
 	 */
 	if (!qc)
 		return;
@@ -1701,7 +1701,7 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
 	ap->deferred_qc = NULL;
 	cancel_work(&ap->deferred_qc_work);
 	ata_qc_free(qc);
-	scmd->result = (DID_SOFT_ERROR << 16);
+	set_host_byte(scmd, DID_REQUEUE);
 	scsi_done(scmd);
 }
 
-- 
2.53.0.1213.gd9a14994de-goog

