Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C654A5A0F4
	for <linux-ide@vger.kernel.org>; Tue,  2 Jul 2024 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888472; cv=none; b=lSwC3Z5CliamRNJ95gAh93MvfiiagQZDLajbujCgNLjcY+hMer5hsvEb5QBVZsq8upqbJnhE/sE6tAYoz9EHTfz0ftSa39sBJwFPQMAKv1NB05EC3693z//B1MXNJefRLOTBExe/7cICEqCQLHOBSzqN5O63u+Iq/XvtBm02CFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888472; c=relaxed/simple;
	bh=armYVp6bALgwlq3EStO19rEjX4MhF4wYcg/Vy9Y+1tk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dmayWTjwNH+o82S3mJ4VR15KLCwf+j+vY5m6Vx4qQrHbyvqjHwiOxeTh2ynunuLc/IMiGfd41JeFonhPouG+CEtPRvYe2/3qGWUeBE/GArSlTXaaSDtgnCRZMz1tQJAzserOJUSvP73RrOiaak6c8SOhDp4fme5gTVhou/lKnBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRg7OFZm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRg7OFZm"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-706a87c62a4so2528843b3a.1
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2024 19:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719888470; x=1720493270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuQ8E2r4ig1tVpjaudUDpj4znPX45jR9JD1FPJMHy0c=;
        b=bRg7OFZmffSqCswrGWe0AU1LRYEKjnQQGM9hIYF+L6zlczUS1b8QTENjMbyySA2mzu
         /+OGySHjhOFbPNmR1DHFxH+WPaN2zxWarwS7PjTuxKhHiyVTRFvkjOQYR4o9tOzH3/fG
         tC0oi146ZOL4YvR9XUJmmgUtRUMY2Ciq7TaSHH8yzH3GYCPHgZts99E7DJVOCj9fQT1f
         KZ8ZMRrGNXoUzv5CoK598TL0e/EVmHfp3tWxtg/TGl1gd4LjVnm80QNgg9152yV+3bb5
         HnjrhfFUEHJHgNUx1P9/Tm6vkmHHMdOYPuNciztMKlFwRwKkZ/GvY+gqqcZ5OM1KmguQ
         1UqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719888470; x=1720493270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FuQ8E2r4ig1tVpjaudUDpj4znPX45jR9JD1FPJMHy0c=;
        b=EbOvMYqHkxMlvozQD3QoKXpT/VXHjxaLpcQVm36Dm4r9w7TK+k1YNSMpTBW73IFVAC
         Jno4T2cxfHSGHab9aJ4y1rDPHUk28S+Qmix4h5TPzdu4dlbsFagQazHp7LhqgHZfn41j
         WY3IvCbFHxdT6sW69Gy81tVrhw55sefyzjnN4fcMU3MAK7nWLJV/BSXyRNTpQksDVo7I
         FGvLXtUZkmt3y3WvSNL5jRSHqBmHY64OczgQ4HNj7IzxFjm820OgwhAJ6VYh4UT+k3U1
         yAb5Kye9hBuIlcizc36+jlkEIkyi9UC05pGDLLcJy11+PUiWx7X8IpE3siNj/r/9U9V2
         Bxqw==
X-Forwarded-Encrypted: i=1; AJvYcCV3z1WAFadqwuNNRDZ0H6eOEok7wxl24AzcNksTRO/Dy/dd+6MEcOBF1DTsXEfgC8Qrvf4pFVlHzdqzgYV6TgQQfbltiOUiD6LX
X-Gm-Message-State: AOJu0YwTWV4EowKy6UUPCcA+SYjN1u9nXU00D9YEywA6GJb+PmX9JU09
	+KRg3iQ79A8TBt1Hn6MhR1cSPjRiGubDGVFLYCZoRyV2dYronn6YYEEkDuLA1sFNC99VW2gPNh+
	rivR7uK7ZDA==
X-Google-Smtp-Source: AGHT+IH+lL6r5VzGA0HxS1DdbBK4xw6ZsH2Sc+qAySIDyF6GkpVg26LKJoL3DppsDXBiRCJiVxykE5vl471l4w==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6a00:1255:b0:706:6b52:43a7 with SMTP
 id d2e1a72fcca58-70aaaf0e3c0mr296701b3a.3.1719888470043; Mon, 01 Jul 2024
 19:47:50 -0700 (PDT)
Date: Tue,  2 Jul 2024 02:47:34 +0000
In-Reply-To: <20240702024735.1152293-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702024735.1152293-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702024735.1152293-7-ipylypiv@google.com>
Subject: [PATCH v5 6/7] ata: libata-core: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

ATA_QCFLAG_RTF_FILLED is not specific to ahci and can be used generally
to check if qc->result_tf contains valid data.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libahci.c     | 12 ++----------
 drivers/ata/libata-core.c |  8 ++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 83431aae74d8..fdfa7b266218 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2075,13 +2075,6 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
 	struct ahci_port_priv *pp = qc->ap->private_data;
 	u8 *rx_fis = pp->rx_fis;
 
-	/*
-	 * rtf may already be filled (e.g. for successful NCQ commands).
-	 * If that is the case, we have nothing to do.
-	 */
-	if (qc->flags & ATA_QCFLAG_RTF_FILLED)
-		return;
-
 	if (pp->fbs_enabled)
 		rx_fis += qc->dev->link->pmp * AHCI_RX_FIS_SZ;
 
@@ -2095,7 +2088,6 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
 	    !(qc->flags & ATA_QCFLAG_EH)) {
 		ata_tf_from_fis(rx_fis + RX_FIS_PIO_SETUP, &qc->result_tf);
 		qc->result_tf.status = (rx_fis + RX_FIS_PIO_SETUP)[15];
-		qc->flags |= ATA_QCFLAG_RTF_FILLED;
 		return;
 	}
 
@@ -2118,12 +2110,10 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
 		 */
 		qc->result_tf.status = fis[2];
 		qc->result_tf.error = fis[3];
-		qc->flags |= ATA_QCFLAG_RTF_FILLED;
 		return;
 	}
 
 	ata_tf_from_fis(rx_fis + RX_FIS_D2H_REG, &qc->result_tf);
-	qc->flags |= ATA_QCFLAG_RTF_FILLED;
 }
 
 static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
@@ -2158,6 +2148,7 @@ static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
 			if (qc && ata_is_ncq(qc->tf.protocol)) {
 				qc->result_tf.status = status;
 				qc->result_tf.error = error;
+				qc->result_tf.flags = qc->tf.flags;
 				qc->flags |= ATA_QCFLAG_RTF_FILLED;
 			}
 			done_mask &= ~(1ULL << tag);
@@ -2182,6 +2173,7 @@ static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
 			fis += RX_FIS_SDB;
 			qc->result_tf.status = fis[2];
 			qc->result_tf.error = fis[3];
+			qc->result_tf.flags = qc->tf.flags;
 			qc->flags |= ATA_QCFLAG_RTF_FILLED;
 		}
 		done_mask &= ~(1ULL << tag);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 74b59b78d278..949662bc50e4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4800,8 +4800,16 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
+	/*
+	 * rtf may already be filled (e.g. for successful NCQ commands).
+	 * If that is the case, we have nothing to do.
+	 */
+	if (qc->flags & ATA_QCFLAG_RTF_FILLED)
+		return;
+
 	qc->result_tf.flags = qc->tf.flags;
 	ap->ops->qc_fill_rtf(qc);
+	qc->flags |= ATA_QCFLAG_RTF_FILLED;
 }
 
 static void ata_verify_xfer(struct ata_queued_cmd *qc)
-- 
2.45.2.803.g4e1b14247a-goog

