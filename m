Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193421;
	b=ulq4kabM5UT+xB48M0weDRA5xwF5NZFCK4qqw5DiHhhrNImfH4lDgNR9XLH7RxrLGykW
	 9rzCkg6hjN1uhLCJNN0cYMxR1rp2GUGNxkXrLkrsZOGeG3SvRdpPXZJSnWYsV5EUWaOdg
	 eSAP7W9ZIAJgMJB6AnlJZlwOn9lKQ9tK2EhR+BZtNfxl+EymGekpxM98ZiLfGD8jrFLB7
	 ro+mNAdyLCPOfuLvo29bzyEqd6UAsi+yUQrvF95w9mLE9Y0zb0lkY0/7kYIgCx0VDotBl
	 OaHsCMcZBnPopnoAWdFaqFy+rlH6q6WgsengSiWtocVQcQDbHkJsVlWBd0VezOxKSEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193421;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tuXhXvMR/EuLnHDeDHBNbKaycVla3heQ5caE3x0CNtE=;
	b=HCem2G3EBe70cwW/BLOc4wG4SxMCGkFArNzkzmdy6qjWfLEoSm63IYSxxLDOmo4QX09r
	 qRnq/W5kI/k+5hnIgMAzj9j32tvVeN0kqS2abyhc1ki4LkzOZ76eMb607TPJyViUlH/bX
	 uaZe7rtcg0q3L7Od5ivkATiWP7hnyBXyFY8oANEiHkjiI+V9F8SjeQVDtNn4R3vXeGnzZ
	 2UyFvqVQh3cFw/ivriTi3UNjmAPVa3FKNCKdUKDab1ZjxC9CTvy7VC6pv5paRh/2iGxtc
	 vtBMb7ocHWxLrafcYYuUATqsn7KDfmSOfPkR/i+gPiZeqwivYcX8gg8Pv771asFUeyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8JM7odd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5CC606A31A;
	Wed, 28 Oct 2026 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8JM7odd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829E61F01828;
	Wed, 28 Oct 2026 13:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793193420;
	bh=tuXhXvMR/EuLnHDeDHBNbKaycVla3heQ5caE3x0CNtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V8JM7oddIpuj6TKW71faQcMUESUA3NnGJBZJx1J58ZUpSd1pFzdMNEPkhkL8Ttkxh
	 JLVHYMrMiCVV/U9CoF202ZEwjNNnuRtepfZOkbdT9c4etePZ4mUqDMyM4DVceF/ZjM
	 7TJ/273n9tHTMEjjaQAGkhEY6oMbLANwTqBtrTHFaKR7JlF9QUI16c6A8aePqQXoEH
	 ULmnDbyD9MeAWiJFy0geuZiHsHTZAecpXBfnWbWTweTdte/k13V/aSgdKbbHqHIWvH
	 bR6vtAUBhCptG5qSYuoTJNbFqKPR4xb2M5gRfyLYXVY4iVkjMTOj04Wj7WWfJJLDmP
	 SWQQv7Ww34XLQ==
Date: Wed, 28 Oct 2026 14:16:56 +0100
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Zhao Gongyi <zhaogongyi@bytedance.com>, linux-ide@vger.kernel.org,
	dlemoal@kernel.org
Subject: Re: [PATCH v2] ata: libata-scsi: reject data-in commands with a
 data-out buffer
Message-ID: <auH1yAtfRUmf3OJq@ryzen>
References: <20261027090809.94126-1-zhaogongyi@bytedance.com>
 <20261028113903.19569-1-zhaogongyi@bytedance.com>
 <sashiko-outbox-187849@kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-187849@kernel.org>

Hello Zhao,

When sending a V2 (or V3), please do not use In-Reply-To:
https://docs.kernel.org/process/submitting-patches.html#explicit-in-reply-to-headers

It creates an unmanageable forest of references in email clients.


On Wed, Oct 28, 2026 at 11:53:37AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] ata: libata-scsi: ata_scsi_translate() direction check misses atapi_xlat()

This looks like a valid comment, we probably need something like:

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3193,6 +3193,13 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 
 	qc->complete_fn = atapi_qc_complete;
 
+	if (scmd->sc_data_direction == DMA_TO_DEVICE &&
+	    scmd->cmnd[0] == INQUIRY) {
+		ata_scsi_set_sense(dev, scmd, ILLEGAL_REQUEST,
+				   INVALID_FIELD_IN_CDB);
+		return 1;
+	}
+
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	if (scmd->sc_data_direction == DMA_TO_DEVICE) {
 		qc->tf.flags |= ATA_TFLAG_WRITE;



> - [Medium] ata: libata-scsi: missing ascq argument in ata_scsi_set_sense() calls

This Sashiko comment is a false positive.

Because Sashiko first tries to apply a patch to libata/for-next before
mainline, Sashiko did not realize that ata_scsi_set_sense() has changed in
mainline by the recent SCSI pull request.

Since Linus has pulled the both the SCSI and the libata pull request, I
updated libata for-next to point to mainline, so Sashiko should not give
this false positive comment should not happen again.


Kind regards,
Niklas
