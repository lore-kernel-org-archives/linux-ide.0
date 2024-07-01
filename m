Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AFF17108B
	for <linux-ide@vger.kernel.org>; Mon,  1 Jul 2024 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863891; cv=none; b=a7DoFCGJljffcY0MRAfLaIpdYZaOZrxs10xkhgnrarhURGLD0wmhJE1KRwdrPKastcXWO9YdkHyTqg5PJmRPntRXBaggtPuob3ntUggUUu1eS4cUSHNKoG9I++FFVueBWOYiHuDTGXw4AFFe+aZ9ND8afXlHB+ed1q6h/lLkXGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863891; c=relaxed/simple;
	bh=i1WM4kmIfmDHPI5dw7j2QdeDu+pN70xb5vkqTT4Klio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IZ3wUxwd55tPnbjH/BAz5oDB7IREed496ngcRjbahUPnuMCzsTQRh+6OA6o1jeME4IX6gsCL8HZGzwysWtHLBLCIbOcCviBLqwFiBepNNTfqcbAqMZ98DxPqOLTIXhQHF6kgh2FenqRzTigaXwu1H55p35eSiS6LXaNhJEZx1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k7w3CaWh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7w3CaWh"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-706698fe5b4so3164325b3a.2
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2024 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863889; x=1720468689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MMO2KKUa8/8PW1hug4/vwJix22ScHjcmOPyPA73iWX4=;
        b=k7w3CaWhvv+L8yZDE5/eQgrqkbG/rwjjPeOzvT6xVjTVUwXMqrCfT8wo6zMePw1RGK
         Fou0imwoYIoZgTH0jE2PwkOozeWPuPp5Nf7DDqphbtirONKGA65Qmbe5tfgXVvHjIcuR
         nfmtO+G8cw3z/dZMpRtMnjkJSwDnn7m7HFwMTix6LQ+vjbXj8MNcjYy9yvVyDqj3Hcn4
         GYAbiZOu8fW2dA3eCOWusNlqKyl/a79kBeh9a09KJcEiAAnc1+rOL/fefWgLMIPauyiB
         RX7V4jbcY9VJZwGov+I+k1XQPt7w5LHERBr3mBh/Sv1gnrB/aXOGextKURzu2n+laarX
         WnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863889; x=1720468689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMO2KKUa8/8PW1hug4/vwJix22ScHjcmOPyPA73iWX4=;
        b=EsrZHsqTXI+s00naW2iIzuQJ/hrRSrqfBcRKvV9ABnq/+fb9uCDyoj+jhAxdxHtrWX
         Uz1P0QamOsD5nhs2WVIdF/YJS21GUzVGdmtZFPb+Gfc/d+cbhzFWqdicztRMgXwUF4Qa
         R+JQRu8cCG07oav5fGV2ydTxKAChond69ABfoQ4qNdbRSDOy1IuTp8SNkTH+nnBa9tYK
         YB2/5fTcrxXFFXLNr3w64niS5ehgKoTCwlQMEMiSFVyK3HY88UN9mI48ek/06OwdHNQb
         mNSqoIKhQJO8NTOxfXpJnErE7WcBEEx95NDYndD88rgQHROKVhbxYjanIl21hiZBpFt6
         cEcw==
X-Forwarded-Encrypted: i=1; AJvYcCWgZ/jeFleWQQBjLilYDsHzG4qIO2o6SMLp92dqH7juvytyzH6NmbW7XKOwVJvkb5Q4prcv37sukcotyZNfcJOXPSa36xysnY7/
X-Gm-Message-State: AOJu0YzqEOucYgru1XoSkIwh8Lk8Ew44m9eZZf6vzQMifYYApJ+AQ5lI
	QXw7QSufRgfEIUza5niv0u9y9lnzDXGonp/EQtNog/vb5bnxisBTaAbQdxX9d43pFwaohpNTlGZ
	W60oFcZP7wQ==
X-Google-Smtp-Source: AGHT+IHReH8MOWTtus6bvZ9IiV9dzMjmSS3I/s0f4LPu18gpADTm0fop6yxvqbOXiivfQbvbcjpBGN3Z6yyMCQ==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6a00:1889:b0:706:2a35:66e3 with SMTP
 id d2e1a72fcca58-70aaaf9d74emr528990b3a.6.1719863889424; Mon, 01 Jul 2024
 12:58:09 -0700 (PDT)
Date: Mon,  1 Jul 2024 19:57:53 +0000
In-Reply-To: <20240701195758.1045917-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701195758.1045917-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701195758.1045917-4-ipylypiv@google.com>
Subject: [PATCH v4 3/8] ata: libata-scsi: Honour the D_SENSE bit for CK_COND=1
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

Let's honour the D_SENSE bit for CK_COND=1 commands that had no error.
Kernel already honours the D_SENSE bit when creating the sense buffer
for commands that had an error.

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
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 26b1263f5c7c..ace6b009e7ff 100644
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

