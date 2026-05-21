Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670E13DD506
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384850; cv=none; b=l/g094oMw+1cPCACkPRyJU+cgwMX64Q/60s+hI46D2Q7Up6jvvIVbonmZ0qOEZLy2uBP7/q9QZW7dzvhaORR7R8b0TGjFkwRUtiiYwlhmVG+1moN1ID5Vsn8mBppa1LSMI4FBGUkyLxnVkTmsSBth46sjnZ9pFRr+2zYOQvSDVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384850; c=relaxed/simple;
	bh=xZ/20xRY9rkMfVfVWT9afrKjoJpX/S37hhAcMBRnuJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYT0nsavKtjWnpziZOXEd3RwlMnX6tcRJ/BGrIVuv2s1tXxhxgE60AvJhMUzB2qC7TIfn/YUZImyysdu6Jdir1OBg6WC7XCxgvHpnVdUEGM8kDWNjskZs5yg+BO0m+bjvXjyM/CDF8dJCn0uo1zjDbzmVHOzTfbB6FDE15xJbeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nmO8iVTy; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nmO8iVTy"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gLwWH0vpSz1XM0pN;
	Thu, 21 May 2026 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779384838; x=1781976839; bh=EQTig
	5WMUy1ezJ8buvOk1NgB2asANxw4gZ/WuVQgpCA=; b=nmO8iVTy28+1q4GgAnkgU
	/cbl5jICuAY+oV4flWT912pr5TjhAeo01oDFtpeOS1+rxPD7NUA7/RNe5VhL+QS8
	9bAEJ2XN/1KF5mzokB7rfu0aBC7sE2PC2dORjbgepA7OIuh3xJQDA3EoHgXCf7O8
	wZe51IKcZlyYI//BSHA3ti0sYOn0Xgivh3jzeRenoTpTISWSanV/OlKY4KPs031D
	JXyV1if8yMb+PgDCrTF82yDh1shRFu+SbeP6qq6HFtAaliubLEiPG8+X8e8VFV8r
	Pi+ZuA1QhiqIdkw4By437bD3WQIFzWeKiLUMZajtn1NYm4tx3X5D3ImmaJ/dddP1
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cbuaGrg2nPEJ; Thu, 21 May 2026 17:33:58 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gLwW90THmz1XM0p0;
	Thu, 21 May 2026 17:33:56 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Tejun Heo <htejun@gmail.com>
Subject: [PATCH v2 1/9] ata: libata: Fix ata_exec_internal()
Date: Thu, 21 May 2026 10:33:29 -0700
Message-ID: <20260521173347.2079560-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260521173347.2079560-1-bvanassche@acm.org>
References: <20260521173347.2079560-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some but not all ata_exec_internal() calls happen from the context of
the ATA error handler. Commit c0c362b60e25 ("libata: implement cross-port
EH exclusion") added ata_eh_release() and ata_eh_acquire() calls in
ata_exec_internal(). Calling these functions is necessary if the caller
holds the eh_mutex but is not allowed if the caller doesn't hold that
mutex. Fix this by only calling ata_eh_release() and ata_eh_acquire() if
the caller holds the eh_mutex. An example of an indirect caller of
ata_exec_internal() that does not hold the eh_mutex is
ata_host_register().

Fixes: c0c362b60e25 ("libata: implement cross-port EH exclusion")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ata/libata-core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e76d15411e2a..3d25dec6ac6c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1540,6 +1540,7 @@ unsigned int ata_exec_internal(struct ata_device *d=
ev, struct ata_taskfile *tf,
 {
 	struct ata_link *link =3D dev->link;
 	struct ata_port *ap =3D link->ap;
+	const bool owns_eh_mutex =3D ap->host->eh_owner =3D=3D current;
 	u8 command =3D tf->command;
 	struct ata_queued_cmd *qc;
 	struct scatterlist sgl;
@@ -1617,11 +1618,25 @@ unsigned int ata_exec_internal(struct ata_device =
*dev, struct ata_taskfile *tf,
 		}
 	}
=20
-	ata_eh_release(ap);
+	if (owns_eh_mutex) {
+		/*
+		 * To prevent that the compiler complains about the
+		 * ata_eh_release() call below.
+		 */
+		__acquire(&ap->host->eh_mutex);
+		ata_eh_release(ap);
+	}
=20
 	rc =3D wait_for_completion_timeout(&wait, msecs_to_jiffies(timeout));
=20
-	ata_eh_acquire(ap);
+	if (owns_eh_mutex) {
+		ata_eh_acquire(ap);
+		/*
+		 * To prevent that the compiler complains about the above
+		 * ata_eh_acquire() call.
+		 */
+		__release(&ap->host->eh_mutex);
+	}
=20
 	ata_sff_flush_pio_task(ap);
=20
