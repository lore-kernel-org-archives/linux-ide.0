Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107FC146D7F
	for <linux-ide@vger.kernel.org>; Wed,  4 Sep 2024 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725489466; cv=none; b=NZRAEAVPFC5qBM7l1ZDTRBr7hyIgFe4r7OOs+ZIPHrTSFZA0hjUdml6af6r1E7kID3rp3nU8+Z9emQvuTU91cJ+WPQ3tM6YWeC96mbp1DHNs8tUYsJvtcnU2qv9Lw5MTGYuyVBru7asVI+LMKgWxDpu/kUUunuS3MVzCfJ8lbOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725489466; c=relaxed/simple;
	bh=55A94q2uIAcfHQgoZ/TQhxg4Fzdi8TDEazEFMyc1W5A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ghtnYUHk4LLYQAqIGn89UAcZKHh44EVeymGEdB9nnIBvU4jmKTvbf7o8otsl9Hg57NJ+RhnMZCCsEm0WdiETblzQ1ssyX933h4rKMO8QN1kOK8wKXeIPyW3szNE36APUrfPN8fbjQxvgGcho/wMor0peZp7XY7bt7SLeqLbzG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MuZHFgBC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuZHFgBC"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7d505d457c2so117077a12.3
        for <linux-ide@vger.kernel.org>; Wed, 04 Sep 2024 15:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725489464; x=1726094264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RJz5BwpSqcmwVPAPNTz8F/kb5jxfiYrhQSyjUval4vU=;
        b=MuZHFgBCW5tiOMSm55oIfDMAKpFY1G04PuM6Z0A2F2BmFWLUzlR1S5Upag+bAXSnxN
         LAOxiyOV/8klXE9h3w+hR+w1kLmr4qjannobKetV3CElzSuwY2b5pKJYaHHGQfNsAlEp
         AQDYeENRUquUtZeqCD1Sf5gKqj6pzVG62q3bi0z2oNvzavSZUrJ4eyT6PaMX2xnB88S3
         sHofkEGQFQC3LBr/5yNCwugZ9ORWEh8Wod72bQtNU8Po8pp36lfvXQr9K1S1BZY53v61
         /0VCj+XW++m+bsU7CB4Tr9UiUnmm6Jini+idXnwBXZcJC0HQCrsjbdDxyMSA11tqvnWS
         SInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725489464; x=1726094264;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJz5BwpSqcmwVPAPNTz8F/kb5jxfiYrhQSyjUval4vU=;
        b=k+CK1icKsZ0A0k/LjfszlmM9mwar/NyBNgKzMMyyq8jdIj+olFdFSu42H+Rcrm682e
         LqLirDEk8KU9sILxpuLjG8Acf0PWyhEIM3hNRs+3imB327zOqCVwUrekNRPZ9Qr7VRM6
         eY/xNjkBPHswAyOo4UIWerP3PkBv6fwfIjMlsb3qyvPWaSuIsKBzlpIC+dEHGkbYnKAD
         cB5+ry98ikRPJ0L1Du1J7z88C33KERIXRmmO2PbrnLfwCZBwpSnAhRfdqZlsfghzJ9BD
         77xjf0as7AiQXIfeDKLT0n4kVjzV6SOgsTDpPVbPFhiaGuJRvFibx1uVgVdz57/4v995
         ncPw==
X-Forwarded-Encrypted: i=1; AJvYcCUX2YW8gMIKbdfcYfZtVe5zv1U2ru75TRebpbGaFkEakOGbyojOoeOhjT2sql85XwIzXuNXiBvGGCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmHH1kJgh9u6KDenQkwFOwgL+39Th3P4T6kgrkox3b5HzycGIp
	/QJ6/CIe8fltD0FsmyItsZJJ+egEYvrBEsOjfYxtm8EhiuXxDzvmYvW8IS3KuVFwHgy+NQ5RbgB
	oW+KRsbPAiQ==
X-Google-Smtp-Source: AGHT+IEbQZx8pfGo0dd1GOt1EE/7QtgONM5C6dGvw9uuv3rMZhCVuCHQAKlzk+8/yDYc8HAhZ4IJhcArEBy9QQ==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:ef:85c8:ac13:4138])
 (user=ipylypiv job=sendgmr) by 2002:a63:6302:0:b0:75b:fd10:a196 with SMTP id
 41be03b00d2f7-7d4c10182e2mr45024a12.1.1725489463168; Wed, 04 Sep 2024
 15:37:43 -0700 (PDT)
Date: Wed,  4 Sep 2024 22:37:27 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240904223727.1149294-1-ipylypiv@google.com>
Subject: [PATCH] ata: libata-eh: Clear scsicmd->result when setting SAM_STAT_CHECK_CONDITION
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

commit 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to
not set CHECK_CONDITION") changed the way how SAM_STAT_CHECK_CONDITION is
set. Assignment "scmd->result = SAM_STAT_CHECK_CONDITION;" was replaced by
set_status_byte() which does not clear the scsicmd->result.

By not clearing the scsicmd->result we end up in a state where both
the DID_TIME_OUT host byte and the SAM_STAT_CHECK_CONDITION status
bytes are set.

The DID_TIME_OUT host byte is getting set a part of error handling:

ata_qc_complete()
    ata_qc_schedule_eh()
        blk_abort_request()
            WRITE_ONCE(req->deadline, jiffies);

blk_mq_timeout_work()
    blk_mq_check_expired()
        blk_mq_rq_timed_out()
	    req->q->mq_ops->timeout() / scsi_timeout()
                set_host_byte(scmd, DID_TIME_OUT);

Having the host byte set to DID_TIME_OUT for a command that didn't timeout
is confusing. Let's bring the old behavior back by setting scmd->result to
SAM_STAT_CHECK_CONDITION.

Fixes: 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to not set CHECK_CONDITION")
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-eh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 214b935c2ced..4927b40e782f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1605,7 +1605,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc)
 		 */
 		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID) &&
 		    (stat & ATA_SENSE) && ata_eh_request_sense(qc))
-			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
+			qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;
 		if (err & ATA_ICRC)
 			qc->err_mask |= AC_ERR_ATA_BUS;
 		if (err & (ATA_UNC | ATA_AMNF))
-- 
2.46.0.469.g59c65b2a67-goog

