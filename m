Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7F2B9C5
	for <linux-ide@vger.kernel.org>; Tue,  2 Jul 2024 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888467; cv=none; b=OtX9Lvi+L+1CZYfnHcq/Onma9B4T8gEMc5r4K0SG0KfFv8NBtXd4ZA8kB1UUDbxw63F9Wkh6qMOEC/XzfQOxfkk706FnIZS7RM4b3TZ1CG5rQvKPpFhH000tPfzY8CmeYwhzyURpn5qvum3zJC3L2WptZX7WMdqzSt+nbV8mcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888467; c=relaxed/simple;
	bh=UQZTNgxuo/nQ4A40i4CKkg/R6rQqJGLMQemrM+QDYEI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=koWYU5OZ3i05ftXYcYU8Bqf06ymu5eio2o81rkZ5R7aGNcCAQbZ5wmfMvYF0Vp4WPQRNJhi3lM6kSmtdM+FBLEIE1DcbT8pN5xEh4FphDRRAWFSwFp6S+xvYYgUcysOU/epuDd/2SWP0ToYKDKbOVyukGNuU9rffd83VTxQyjYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/y/Zik2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/y/Zik2"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02b8c0c2c9so6700812276.1
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2024 19:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719888465; x=1720493265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w00QSz187T1KSvOH92zkWn3h1qrakV8FNdVfs8AN5w0=;
        b=E/y/Zik2Y4fQQm2Xc+17rXiBV52nI6BWL3bE2wodmL6A1SnHxUTMAnDhCsdta9/Z+0
         gtcF+zEmEe5DHYRcTR3iayRrwdTQLUm7sHYeCMFsOsYjUQ0qzLLpArqxJTzfFpBdPt0c
         VXryAc162Y1wmcsEg73UP48XQq8E40HkbYIZJm2qjEi8yXVvQb/jLvngKeCoxCHr19M/
         20mxqtxEX+6yogcMVoI0fbIYhky2v+6VltyJFTBNov5pxdXnK6F8H9oel6D4Be/zPtYt
         pRcVxppH63gMfpsf0STrMdG/mS/oG/fjXXErZ5+LAKwX0sX4fLFd7QGXRozrve17W7Kc
         IFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719888465; x=1720493265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w00QSz187T1KSvOH92zkWn3h1qrakV8FNdVfs8AN5w0=;
        b=Lq4BBwpcUbipq9bEBR4+wzAKHRBihNCdV32EJMRJIALag+pI3WuU+CtYZsnO6VmeVn
         nv+V7E8bcAOU4U5Sug57XJDOE7bsJV6SIhoWHsYtOIsrf2gOmDZuneKDm49vP5oqAuOz
         VhyWankpVmmSIk64BwyTnywESkPq6Y8MnUnQnSQ4xw//ascRDcTRntWs6L5yrmTRNsqZ
         /jFexYk9ZRuEMnxcUARHU7R3PfOdyVe0D0UhlZ3Bn3WjbHdne0HEHBcoPjliPxxhKBAd
         U2ExZueXG1Zy1cHkdlQM++LnivjpE+UEoRrAwVTuS3B+GVgGq7+ehi0FHqSWGAs82DY7
         Xi8w==
X-Forwarded-Encrypted: i=1; AJvYcCUUZD2nKd9I+sB3P0CUmfRxFevLlMsB7gbUno3lS65ZtoZOeUtbm9FGSAmcFlxljhaxkr7qdwPmpsQTlynBYHs1xXqh8GzSy563
X-Gm-Message-State: AOJu0YxZRWlTM9PTb4HH20N++c6THu8VNaikyalTh6OdlY+UOKbk+bLh
	RRSv0wPuuJBYPPIS9KFyYHdwvIjVbWi2l93K2EAQPTJJr68RHkCmm4PfbgswB75Jt5vUZR2BELP
	ltb1hNpgxwA==
X-Google-Smtp-Source: AGHT+IEvUTFIgKCzrTE5ovL08iBb/D3RskDQu4+yIlR5yKTtxFavno3Ikw8Oljg6ZVkQd+fpyujDnQ6yQRlZtg==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a25:9206:0:b0:e03:4d2d:b0df with SMTP id
 3f1490d57ef6-e036eb573b9mr201128276.6.1719888464966; Mon, 01 Jul 2024
 19:47:44 -0700 (PDT)
Date: Tue,  2 Jul 2024 02:47:31 +0000
In-Reply-To: <20240702024735.1152293-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702024735.1152293-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702024735.1152293-4-ipylypiv@google.com>
Subject: [PATCH v5 3/7] ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1
 and no error
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

SAT-5 revision 8 specification removed the text about the ANSI INCITS
431-2007 compliance which was requiring SCSI/ATA Translation (SAT) to
return descriptor format sense data for the ATA PASS-THROUGH commands
regardless of the setting of the D_SENSE bit.

Let's honor the D_SENSE bit for ATA PASS-THROUGH commands while
generating the "ATA PASS-THROUGH INFORMATION AVAILABLE" sense data.

SAT-5 revision 7
================

12.2.2.8 Fixed format sense data

Table 212 shows the fields returned in the fixed format sense data
(see SPC-5) for ATA PASS-THROUGH commands. SATLs compliant with ANSI
INCITS 431-2007, SCSI/ATA Translation (SAT) return descriptor format
sense data for the ATA PASS-THROUGH commands regardless of the setting
of the D_SENSE bit.

SAT-5 revision 8
================

12.2.2.8 Fixed format sense data

Table 211 shows the fields returned in the fixed format sense data
(see SPC-5) for ATA PASS-THROUGH commands.

Cc: stable@vger.kernel.org # 4.19+
Reported-by: Niklas Cassel <cassel@kernel.org>
Closes: https://lore.kernel.org/linux-ide/Zn1WUhmLglM4iais@ryzen.lan
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b59cbb5ce5a6..076fbeadce01 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -941,11 +941,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
-		/*
-		 * ATA PASS-THROUGH INFORMATION AVAILABLE
-		 * Always in descriptor format sense.
-		 */
-		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
+		/* ATA PASS-THROUGH INFORMATION AVAILABLE */
+		ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
 	}
 }
 
-- 
2.45.2.803.g4e1b14247a-goog

