Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08336120
	for <linux-ide@vger.kernel.org>; Tue,  2 Jul 2024 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888468; cv=none; b=VPZdCFYmAMqYcxWRHJ3KMYXTTSTDyQFedomKb6UYQpwamrZEF9qNZx67NYy8wbj+SY0nmjZWSKkV3fDgzX1UuC3LdirHenz0+a6EdmUpl07t3USugIE0Agg/I2chf7GcJo3C6jMYLi1y9JWeS9ZuAOYdFwAr8pMkueqKFq+WqFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888468; c=relaxed/simple;
	bh=doFIBDqtTa5Mu/2uxDG8Al0PrGigMDt7dbzK5fiISpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dUyWNz4JbfazNhu1EzsmQHQJWjYQHY1iiDrGcfMgh+AyeZgQwKEk6/y5JKkBiUzHLBn5Dqc/NSytfxu4Tc5JUsgBGdz0WQjUZVe1B30oJ1QiCJGtkXqdja1AjoUHGpTZT5uqcwWfkpQgPZSjkRHC3rXZGc4r2SjoBRUiVvrDzOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HWDOynoi; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HWDOynoi"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7065df788f6so3369739b3a.3
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2024 19:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719888467; x=1720493267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWYD3CFi0xqKyZt66+JpR9ECkv5q52fY5lPhimPSxvE=;
        b=HWDOynoiXExHm+o81NswJuT6jt4dLHJkGrzmV1J/1fgAlSlpzd1sJqH7A4I7ad4p2a
         XMpdTZGHTKo5/LENxLUsMgUvcByS1uLIt7ppT14U3+0b5LanWuF0CxVdc/3GSJz07iP4
         psxGwklnYhrRrfSNG/Dp0AGEvPgjXjNrJT7tvy/cDAjXx7xGlVmP3yB6IVfuayrh5o3M
         I9ZneRMpTICHUozu/qV/URgyBkRM7YPSn6XEZNb8bXlgxyjAX+gclQ2oIdio7TBU8+hP
         dd+Cvq84YidQbU6+90c+5sSmnLOJxXL37vDErB2EyZCsL2lM5gk31/qykiFi+vro3MV1
         8BQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719888467; x=1720493267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWYD3CFi0xqKyZt66+JpR9ECkv5q52fY5lPhimPSxvE=;
        b=MpuTRFsbC3TCoDdrwLIJrwYcXJmQfyytRhgQ8B0CNKY6ZNHU6vqzojfNmwlASOgmID
         muVin2afnNVYiFVpcCkSUQCu+wX0otClGe/PsR1oyr8Se47cEmSTBZ5YZ99l5M2x9Mwd
         Ygl2FwdbNLhfqbe4VvrqPjP0hT4E7NQ4F+9LmvpghC7eiTv0veJZdkNDGXPPe5bOR0Ib
         TLbMu6fJ3oq2y5qSdmggpm6I9agJmRQ/8E6RkYKGAq1qx+KmkqHPpUMW1gKSY49NZziK
         fvN/x0pIHl6rc8lxw7RqVgxmErLlxAA7AF0XwmAGss/pTC8DrxO5bDCxnIpPtVXEPuzM
         WLUw==
X-Forwarded-Encrypted: i=1; AJvYcCXiSNWl2IFo7TnEELshpXXM06Mr9JGLmw8GnxWZVgTlgpnF7RpMWT8OMaj1p++ecUy0PC4qW2cHthAW79h+AsSscyzugtJjtZzy
X-Gm-Message-State: AOJu0YzkRrJky6yf8ilGBHlx8guHxuK0zX36owzql8os7kLPkwKseBcG
	PWMMMZnDmQPY2YictASWVzOIg42JUGDjrv/v9CjlVK1y9WqItcN67zwW3ou83HUmcHHtPPSyO8T
	RfR7jQ81MlQ==
X-Google-Smtp-Source: AGHT+IEnUZWAIySfE2wBFSt1tDNvCahMYriM4Y6yt/rtcfr0+yUwTcq1HyF/y24/NusyTaAevhRKjh5UEFw5Yw==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6a00:1304:b0:708:2033:63e with SMTP
 id d2e1a72fcca58-70aaaf6e482mr474635b3a.5.1719888466711; Mon, 01 Jul 2024
 19:47:46 -0700 (PDT)
Date: Tue,  2 Jul 2024 02:47:32 +0000
In-Reply-To: <20240702024735.1152293-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702024735.1152293-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702024735.1152293-5-ipylypiv@google.com>
Subject: [PATCH v5 4/7] ata: libata-scsi: Remove redundant sense_buffer memsets
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

SCSI layer clears sense_buffer in scsi_queue_rq() so there is no need for
libata to clear it again.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 076fbeadce01..145319874c1a 100644
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

