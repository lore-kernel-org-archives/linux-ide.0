Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5041A2FDA
	for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2024 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267163; cv=none; b=fCVMm0iB3uDBgGnA9LfL7msOoL/+Jv6rxjAisQy9miB/TdlPPVtLkogqywaJgmKIFWOdGwwzfa8tL9I5Igj5DAIa8fqoKh1ZGiiV6suQwUzHrMZ5sEbNJVyo37CRnXiCL/lUydtw2afBIpfNuXd48jBdc88KH1e3hTbCRl/tFOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267163; c=relaxed/simple;
	bh=pfz7uu+jOOwMjwmY/w6sU4kNgauq6UsTyFTXS6nG/Ww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fvK4LHPKAjhEo5F+5YNCGtMM3QmYX5wFnMx5X+ldCGZDVcuXQCxzvbUppJD5n93VrrxagVM1NlVXsdDXLxEk52pwNHKn9PMGB8RwPul1H1nb5tdlUt1ed59t/74nA6ewRMuVfCmrjPLNPInjAqmtYnAhGubpdFPIubWHpUZip3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PCTXrJ4+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCTXrJ4+"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-643acc141cbso21745757b3.1
        for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2024 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719267161; x=1719871961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PD3uQGUFz5zxx7acHrfAbDYiKppPlFoCwrVRy3QI4Ug=;
        b=PCTXrJ4+c3s1wYTJ0jMJH4fTwET79Uc9+6+YyBtiSPJgLwGpHxF+0yhgh+Eah7FLKH
         KOisIfdMC82DaUkW0+v6+VVP50+xLmkmphu8+JZA8FueYtbnFZndRTAj0y26pzY/a59G
         Fy126dxHyAFHRU7DlAOgrY0A8kr/diZFlFDCwzXTbby4FRPHcJQzjtrg0K3hpuyEt/CU
         a9lwZ1APRIkREOw7+/gaEc26/SZghVK6Im+lW8ev0pKACC1mbif6/s04ALG/t+oyZgmP
         ZiWyjVbL9h0XY7rgU0rVs6VdRgtwfscv4gYrHazLDZ/A4Ef/nJEFQVqLj2YuxAvetdRU
         CHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267161; x=1719871961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PD3uQGUFz5zxx7acHrfAbDYiKppPlFoCwrVRy3QI4Ug=;
        b=YMnR/KRB4AaouNmyViwC6PkUk/YuXZuOJSH1dAbjHuIZOq4BJ2lD+TyU74Fn44OQvf
         6iMDaELHGeMyO0/81G5XL9TQ4IwgZFqpq0Qi9qLSalYoF2gVZEUJ3o5QnqP09tr5g9Wa
         5V0pywkVk11PeIwhuNwb7q12l+7HJjZ8/g/Kzu7DQN6I+zrWhKjgC/Mna3dkFqMZM4/W
         j0UlRwnOBjydifhQgRROWz02rtfKrqGeoxRdRrZiKXFPZqirJJzs/Zg6i7HJ4YqERehY
         g73hxz0/JcR9zcaOM3A+FM5FhwN2X9SrucjGysTghJ77UzFnNnqtzEAoCRy55+/QzFay
         C7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXyc6Zul80de8SZtWbvV1HJtviZ4j3GiYydShIxIiMWYtn4S6ynvRXODYwREYFndyTIe0Wi1NA4PnygEAP309faF3a53tCZrO07
X-Gm-Message-State: AOJu0YyLTG7w12jV7UU4plYGbI9IMr3zurcmxvNANacJ381M2c0HnCIs
	972oH+CMbU4W19kYpq/ukIFqdawDBwRnov/e79zbMPIS+o9LP0RrSC5uIjeFVPokvTJ8AwQSA7E
	81SHpD8m5Gw==
X-Google-Smtp-Source: AGHT+IG855a4XCLpwisoxKNjnI+nzvVm5c+AAl7kfh4POpZN1c2KNve/pvrtKYJHgwmNI/LedE7U9ADzvsbazw==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a81:9208:0:b0:631:4588:4acc with SMTP id
 00721157ae682-64242491f26mr370887b3.0.1719267160788; Mon, 24 Jun 2024
 15:12:40 -0700 (PDT)
Date: Mon, 24 Jun 2024 22:12:10 +0000
In-Reply-To: <20240624221211.2593736-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624221211.2593736-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624221211.2593736-7-ipylypiv@google.com>
Subject: [PATCH v2 6/6] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before
 using result_tf
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.

For ATA errors and ATA PASS-THROUGH commands the ATA_QCFLAG_RTF_FILLED
flag should be always set. Added WARN_ON_ONCE() checks to generate
a warning when ATA_QCFLAG_RTF_FILLED is not set and libata needs to
generate sense data.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e5669a296d81..7a8a08692ce9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -246,6 +246,9 @@ static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
 	struct ata_taskfile *tf = &qc->result_tf;
 	unsigned char *sb = cmd->sense_buffer;
 
+	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
+		return;
+
 	if ((sb[0] & 0x7f) >= 0x72) {
 		unsigned char *desc;
 		u8 len;
@@ -928,6 +931,9 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	unsigned char *sb = cmd->sense_buffer;
 	u8 sense_key, asc, ascq;
 
+	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
+		return;
+
 	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
@@ -971,6 +977,10 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
 		return;
 	}
+
+	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
+		return;
+
 	/* Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
-- 
2.45.2.741.gdbec12cfda-goog

