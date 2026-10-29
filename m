Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299498;
	b=zYamWFQoK2Ua7CrTKFlAG2NiMWoP6RVY28FnWgxv64H8dhvtPuB0qWtP7rVTT0gkkCdy
	 WK5ceSDrWTu+M65PRAf1QiqK2QtGsbRrFKcbRSn4WOvTDxnDWvCW6ka0cr0/5BIR3voxz
	 JmIifK1Dpk0/sPsgWf48pWYUNDKPluEBual3BLuBWXYsP9BmR++Uy6heIrC2n4LLKf0Yd
	 c+wJ8tUZEOdkdiKQ79R62NmY2orYHpMr7xSYNcd1gbu3NtZKOgMfR8SmmcCzGZFZru1ab
	 FoXpWlX0rtEHCrR+o7QLcUm+3ns4Hq9EEaJjLgYcYHW+XCOa3+3hHofMR0bQlZI1JuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=YHoHpQQmvqEwVhuQBwmFySvFAaKw6EmVrc8LkjO8rvQ=;
	b=YkGdii+OAq0pWF2I+0Tbjt/y2XA8zJ9MgoBDu+fKC6kP3y9WFoA7HoGQt+z7sA6CtYL1
	 9iXbRyIK7ykbXfgffK+tCMzRoajjAVciYBDpQuB5FZTM/31fkwEAMXTDE98+WTNu1bUyR
	 gCLHVUob9dvfgcPbOSN28lbAh3jICtxmrbyc87Vl03VwTiRIvYo2773GbyfPfT1LJWRI4
	 FeYA9Ls0i6m/6QLkeJtHaZz2Htdih1VPi0HBPqdwWn00osqaaM/qcXPD0eLd7uWtFvc5V
	 IM9BeU4N1WfKAPj6Mdrk8Leszh8XtLy4Ja4hKxf9SolwE8H2DB3nzZn2tCyDm7POM2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YfDKR6ps;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9D606A31C
	for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 18:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6D9D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YfDKR6ps
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ac6795617aso2108474a91.1
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 11:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793299497; x=1793904297; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YHoHpQQmvqEwVhuQBwmFySvFAaKw6EmVrc8LkjO8rvQ=;
        b=YfDKR6psdc8HAjZnim3EbcPyjiF/5cVACVZjpi4H1FYCLn43l0E9qlY4z3A2e2xJN9
         SrkY9BE1stdliuEr9/V0cb4wDQaJ/FfAuNJ8gPO/1w9WXDLJgnlS+HZIoTO+9frt0T9M
         ytC8wXccFSYIrDjnKNcaBw6P4aTHTUx+rVsCmX3rcpEHaAX9Gu4477GD/R0txdJtn3xJ
         4+LPL5enXkdwAi+aehSt99cpBpKZkCSzG8zuJ9Ff46OKbVHMp6QtbAsGSJCEerUxm7HJ
         DzDgURcBPAz33/7ak2JA+RT6QxmEqG6XieLUdP4KjszTkOOWIEZ87YB4Noqp++DrT7lS
         XtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793299497; x=1793904297;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YHoHpQQmvqEwVhuQBwmFySvFAaKw6EmVrc8LkjO8rvQ=;
        b=QJYR6f1dAh7xxkX0PS4OHBhoHPJhnCX6ad0MMtpGSzKwg5N880ryDoOSMGy1Aa8+5+
         fgVbru5NUQ3TJ3Z6VBCxu24JjlHhDPODWFveE6mZezmr8mhvLwbtw4snymcFV6DEyV0d
         HSpmyfWrfNoXE09bzbjDxbdLJD5l3lcaXRzsxJPz02LdUXT/XHJOgjdpZckkJFiETQqh
         OgyDYI2ca3imAAjTngTdYeaqA9hyf5vmf8MCAFId9dnZ5FhYfkTGEz/ofQzASTQ8KLtw
         Rxlts0ly+IXmd4N2OPFmG1WP+lhm6Z6p4YpB1awpOFq3Mc1lB7gMtlDI9w23qVgmK3ja
         dtoA==
X-Forwarded-Encrypted: i=1; AKwUvBzOuXKOtuEoxDjT80ElUgtwLlnLfZJTxXSC2s4GSby4KkKM4QJeqjvKhBioni+G2EnwAl/ZXGC7N+8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0tuRCezfLbWhxiHOn/2Xmpiafn9rnmBdMaq++tFSAq5GWRHpZ
	Qe2zb5Nh5LKQnmmsjnsyp36a8Y3LHlXA4ajihtkZHlBeILEGHMZaUqJvoPjmKf2D+tUzh71T9N3
	QYo4DzhTsU+qqaA==
X-Received: from pjah8.prod.google.com ([2002:a17:90b:5908:b0:3ad:850b:6f1c])
 (user=ipylypiv job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2641:b0:3ad:370f:46be with SMTP id 98e67ed59e1d1-3ae5822b436mr5249932a91.36.1793299496950;
 Thu, 29 Oct 2026 11:44:56 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:44:45 -0700
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029184445.1615717-1-ipylypiv@google.com>
Subject: [PATCH] ata: libata-sata: allow re-enabling NCQ with the same queue_depth
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: John Garry <john.garry@linux.dev>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

When ata_eh_speed_down() disables NCQ due to excessive errors, it sets
ATA_DFLAG_NCQ_OFF without changing sdev->queue_depth. Userspace can
re-enable NCQ by writing a queue depth > 1 to the sysfs queue_depth
attribute, which invokes ata_change_queue_depth() to clear
ATA_DFLAG_NCQ_OFF.

However, ata_change_queue_depth() returns early if the requested
queue_depth is equal to sdev->queue_depth before clearing
ATA_DFLAG_NCQ_OFF. As a result, writing a different queue depth > 1
re-enables NCQ, whereas writing the current sdev->queue_depth value
leaves ATA_DFLAG_NCQ_OFF set.

Since ata_change_queue_depth() already checks whether queue_depth equals
sdev->queue_depth before calling scsi_change_queue_depth(), remove the
early check so that writing the current queue_depth > 1 clears
ATA_DFLAG_NCQ_OFF and re-enables NCQ.

Fixes: 45623d33bfc0 ("ata: libata-sata: Improve ata_change_queue_depth()")
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
Commit 45623d33bfc0 ("ata: libata-sata: Improve ata_change_queue_depth()")
didn't add the first queue depth check, but it changed the return value
of the second check from -EINVAL to sdev->queue_depth so it seemed like
a better candidate for the Fixes tag.

 drivers/ata/libata-sata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 32fd0e804654..d917242ac136 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1287,7 +1287,7 @@ int ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
 	spin_lock_irqsave(ap->lock, flags);
 
 	dev = ata_scsi_find_dev(ap, sdev);
-	if (!dev || queue_depth < 1 || queue_depth == sdev->queue_depth) {
+	if (!dev || queue_depth < 1) {
 		spin_unlock_irqrestore(ap->lock, flags);
 		return sdev->queue_depth;
 	}
-- 
2.56.0.317.g454f8302e1-goog

