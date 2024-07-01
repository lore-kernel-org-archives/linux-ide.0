Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CD116FF45
	for <linux-ide@vger.kernel.org>; Mon,  1 Jul 2024 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863893; cv=none; b=eqL/szkA2K14giRxlSYB6L27NvS0xw8L4/W115BucdqotxKcmk8HPBCHpC1TTdCsekStVc5XKOhRnjG7PY5k2238fLH/M8ZaTLtjPoucma5K44ZtPDtaK7qjPcwcQM/aKtCdr9zfMBK7w1n3YCAO5zBilH9MAjP3dTyG9A+Nqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863893; c=relaxed/simple;
	bh=eNn85Fcj7KCcSuMYSdoEr0B/RTvkczi9hHJCBqhaPCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eBf50a1DyemIzRrVGFlVCMbt/1DQ2T4onXTCqCeZUIjkNZ4fq9u+48KdCOaPf6BD8aCCPc4sf9m7ekPmRBtppsPJr6C3mjZt+B1x8323LxnIXh/3sOz7p2ndbEX70s6/E/KGOXu3datr3askA4+zC+mH4na6Nr1bFrSwhmZZwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ksaHk4R2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ksaHk4R2"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64bacf9a659so51631297b3.2
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2024 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863891; x=1720468691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBOTiXxGTl6GNLs3EaV9yCivuLqQXgDZHBD5L6v/nwg=;
        b=ksaHk4R2hDVkHs4kuLAngw7JwLvOM8v6LqbFd0ZYRRAoMC5CzjyyRjlgG5QgJSI8n/
         eIxfgSh4vs344QomzRyv0wgnRtyaIfL7ndVk2bpVf2qgKHmhe3CLvXtSvJFqhKBdFj/6
         ucbVPxUostz3i2YZdowxhRmwN0Zz8+RTChm+Z8yUa8TqOXZiXMx+FjAu9yoX8ngJnEp0
         oi/aLxypOTPq8ycetHkZqZ16/1f8rRmDDH6z+OB7mHLH/kAhi93tsAWVyA2EVOtgMI2M
         QUqMub9s4D0a6M6RQkvmPgjdBH/cb6CGbJ3ULTwyiyYNRBO3YNVd32kC6t4z+KEFxVYq
         NJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863891; x=1720468691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBOTiXxGTl6GNLs3EaV9yCivuLqQXgDZHBD5L6v/nwg=;
        b=WcK4ZpCRF4YUfROH7Gl4B2iDgRx8MWPNQjJWIGRvkIeuESR6vy1473JEI6Wo8aXOam
         wKBnOuwFxkyf+5xjDOog5SxtiOGi2j0BtvINL/Hh/TsfGTJIRKb/MuVPtjPBMIes72Is
         ZHBKhZOHkmZIItW/l12l5lIqG5PQVX4R7gryc12Yckxte650CPzZpFh5DQA2lKDOM/ML
         mr+U40E9Txl1SvQNndsT6BcJCyxY9tj4n1l2VRnzMo1Gxf2+e+14iqppsDgK3ZPmNbDK
         x3r3CmhuNSKxXgN3vS+/r7W5vvZTqifqjwTnNuY8JeKIYmqeOOJ3DWr6rrrN48jaEA4Y
         q9Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWnKjXMaiur2kpOrnoFlDpcuFS0KjIIdNqWxYDhVRnjuPjFjTnWaFRRS/hEOK3Q5OhP7meOPqbTVzQBChIdApP4AdXcmEtL9zoI
X-Gm-Message-State: AOJu0YwgJjJZdKtPfnuJeSnUl7Zr12ZH1KurTVOSeJSoZFhkasPCbEKg
	wbXGPnr0hc9yhI2AiFN1li9q0ZdE4DISVh9Gz1enCYdcIzl0XPtqC4zCYlFokMLO+jC+KLtYg21
	uS9i3br+6Hg==
X-Google-Smtp-Source: AGHT+IGGuHrEYXjyiMSFh+UBkKB6xRBF3G+mpXgTXcpxTLMS8PdCo5X5+gFF9R+5CNIc/yOizJi+4yBEmjtMng==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1889:b0:e03:39fb:5729 with SMTP
 id 3f1490d57ef6-e036ec41ca6mr672429276.10.1719863890874; Mon, 01 Jul 2024
 12:58:10 -0700 (PDT)
Date: Mon,  1 Jul 2024 19:57:54 +0000
In-Reply-To: <20240701195758.1045917-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701195758.1045917-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701195758.1045917-5-ipylypiv@google.com>
Subject: [PATCH v4 4/8] ata: libata-scsi: Remove redundant sense_buffer memsets
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

SCSI layer clears sense_buffer in scsi_queue_rq() so there is no need for
libata to clear it again.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index ace6b009e7ff..c11ae77d3ca6 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -926,11 +926,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
-	unsigned char *sb = cmd->sense_buffer;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
@@ -965,8 +962,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	u64 block;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	if (ata_dev_disabled(dev)) {
 		/* Device disabled after error recovery */
 		/* LOGICAL UNIT NOT READY, HARD RESET REQUIRED */
-- 
2.45.2.803.g4e1b14247a-goog

