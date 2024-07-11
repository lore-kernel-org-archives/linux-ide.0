Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41523CE;
	Thu, 11 Jul 2024 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710961; cv=none; b=r/Fa/XZimzdGY99noNFc+pnqp1KCNyq5sDwnNq1PynXz/2AxIVEBYCbHvml+14kfu4DphKG8eTbeFK+lr1eF4LFadp+niAKGx3eeGmv7eSinkuOn7oBajahI1tzIUG7EFF+LeNSRJK8L0FdQFOImCa4JBE77te2RNuNhMREgCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710961; c=relaxed/simple;
	bh=69NxrdQtCaFvKPAK+3dmMpGuDWOfj7n4eKuXyLqH94A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iV3man6Fvy0crMy+4hdYp7taZZAVyhnFlp/UjydjKlwUr7YpqMLyR5mpNl5KvMSd57JGVvDIvalpjtjDkouzrm/Lyg+bGFA6GmJkseYOaTO3qpI8+ZdxiFtj+US7e/dDiSKaeRnmEk6DTzIEZBNfWh9PaAqCVQC3oa62LY/tWDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CF2vN7k7; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CF2vN7k7"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ee910d6a9dso10790891fa.1;
        Thu, 11 Jul 2024 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720710958; x=1721315758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGl/Q3t3H4Y6pcGYBNgquXA7C+pZSkZnm2XjFCslZZE=;
        b=CF2vN7k7xZW97cqK4YEksNKFmg3uJxP5qu6XGrcn5EurxDGl8LQYtTm3lkQcE7aYqP
         kf8PZEUGUtLdW36N/sZWB4njPIFSgekfg1DOG92EcutzVl1CG9T257cF67bStJKxhfNl
         TnWiK7vOfA9M1hWWmc8dcb3uuhUSHPjrySFQg0HKQ3JACrTn2vtVHtSnQXBZTWvaJWL8
         NN8hGaVGQDHrbpRahepnZRZhm5SLMaDizqf6n88dj9HN9vnEfZsz6i5BxvPe/LMJSxbO
         x1AGqE2IPpTy2Xi8YNjJJ2vN3j2UZOXoilJcX0Q5oFg74bDsIL6GiNBy712InmFfJE/y
         +utQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720710958; x=1721315758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGl/Q3t3H4Y6pcGYBNgquXA7C+pZSkZnm2XjFCslZZE=;
        b=WiBOwuQ8ooRQoSvNCha+p9EvGTxy0q+CNvUmZGXG0f+JOBUwRJ9GxdR3iutdeioSdM
         euEcPNfmy5/Ch44g2AuuDvlVUWMbDRkb5BYgMfHSVxMLlNf8vN5/LBFd4uDf4wa9T2jQ
         exhUmNi1Gk0GpNGm0pTwkc3DrLC6OZnyxd3w6gPp85O5i2F5xd5W2lGabZQbpr3HPvoz
         xAx4pQy7nE/Qh2H9+vIZwHEDgQ3U30Yd/5d25zXlXNJYxC3wI+5jUTEVTC85KBS6eFcl
         uTo43vHnoFjwnRCzN0LXVjfGYlT9/0z/T0Ob18A2/4/3hKMPSTH7Ze2dWl6pv9IS7Ezi
         KV6A==
X-Forwarded-Encrypted: i=1; AJvYcCXjlfFqlcDPsGoafNUJa8oGqFa74i5OFXURTJ1nfx7QzEZJpZG8jYuRoZJZfa0ZjZaVs73gtlRNjHHGluVx02ezBBM1vK4CVWE+T5wc5xaoKQu97zzp/eK2NiCjPglzrTMi2V0JUMfO
X-Gm-Message-State: AOJu0YxCC7/4x9MDjlvIT14z2rVSRgCDtR3wfQJAu0UJ0/YAiNbl3OWQ
	mAaxJES3folLUN8N9rWthKyl49Ohv/RMBo9vqdInjyKbnei9Svec
X-Google-Smtp-Source: AGHT+IEZK224wXxaBhlp/9qyNfJD3kPGiU4NCU8SJCg/+jcHd6LQYrEJcKw40dLSOpV78Wc1tOS+vw==
X-Received: by 2002:a2e:b059:0:b0:2ec:53fb:39cb with SMTP id 38308e7fff4ca-2eeb30ba0edmr58659121fa.6.1720710957454;
        Thu, 11 Jul 2024 08:15:57 -0700 (PDT)
Received: from localhost.localdomain ([178.69.224.101])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eeb3475174sm8700481fa.79.2024.07.11.08.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 08:15:57 -0700 (PDT)
From: Artem Sadovnikov <ancowi69@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Artem Sadovnikov <ancowi69@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v5 5.10/5.15] ata: libata-scsi: check cdb length for VARIABLE_LENGTH_CMD commands
Date: Thu, 11 Jul 2024 18:15:46 +0300
Message-Id: <20240711151546.341491-1-ancowi69@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fuzzing of 5.10 stable branch reports a slab-out-of-bounds error in
ata_scsi_pass_thru.

The error is fixed in 5.18 by commit ce70fd9a551a ("scsi: core: Remove the
cmd field from struct scsi_request") upstream.

The problem is that the length of the received SCSI command is not
validated if scsi_op == VARIABLE_LENGTH_CMD. It can lead to out-of-bounds
reading if the user sends a request with SCSI command of length less than
32.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
Signed-off-by: Mikhail Ivanov <iwanov-23@bk.ru>
Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
---
 drivers/ata/libata-scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 36f32fa052df..4397986db053 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3949,6 +3949,9 @@ static unsigned int ata_scsi_var_len_cdb_xlat(struct ata_queued_cmd *qc)
 	const u8 *cdb = scmd->cmnd;
 	const u16 sa = get_unaligned_be16(&cdb[8]);
 
+	if (scmd->cmd_len != 32)
+		return 1;
+
 	/*
 	 * if service action represents a ata pass-thru(32) command,
 	 * then pass it to ata_scsi_pass_thru handler.
-- 
2.34.1

