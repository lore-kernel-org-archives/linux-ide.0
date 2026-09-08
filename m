Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E28E5293F7
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 21:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903940; cv=none; b=L+stlk3KXvLgFjwVahvGRVp3aJG0U4APqaXtryVvLMgugw79y2bThh8ALniJhq+uPnf94rn5qnwV+O4KIXYjllYL9R1rQiKcJsJAm75IxcvQkSOSLWYMxDJaM2o8EQKv8MAeYYeG05yxk+VUIqgVuWQ/VdoUM3suIK56zqagIOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903940; c=relaxed/simple;
	bh=R8g1dZY/ggKCMjit7jScrhBDCd+gAII9ItpPUFnKBRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3OkU0/BBuAan3veWnbRacQVkToyIkpZJwiSqAPc9S6X8lc6BhN61g58LWw+q8LTbaxFfn5TNXCBEEl8KfwIi3WdSq/M9mCt3ndqBw/r5J/ZvIIT0an6pAEAfIMmg14JM6CEq1YbIF+jLNfHFc39murllxV0Tq4w53pv3WgTOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJM9GFAz; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJM9GFAz"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ceb47d53so378514a12.0
        for <linux-ide@vger.kernel.org>; Tue, 08 Sep 2026 14:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788903938; x=1789508738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SaN6XVxvP97I/EahdycgHKF+2oKgGUfbpldf6OV9k48=;
        b=rJM9GFAzf44zx+kdVzPY5aUUn4KtZByV1BZOWlLdjY+t1wHWUW9dI96KOdzZJQf3vM
         d0aP2XyvcR43oVIkN1N9lFmjJKxcuq3BCVnWPdXKS30F/74DI7Gkr71MjdfVQxBo3F2n
         devWsTo2NiE+eH5Y4WPkgZcrhuNPJG8qAIdbUWuemBj4dpmXYNE0uzTLDF/nAxj1hRcc
         V/FfzLqqIhyIWkzhlcxSKShIrT82iZZfM7zrtyN8l0WILZ8CEk4PhiiWCWIdwz+VrFd2
         4GX3yN/KY/+NPoZ9RjzHwjundWhMxGqb4Lm2VzLIISkpbUtPUptEQ0d9BVNdfv9vfk0m
         v+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788903938; x=1789508738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SaN6XVxvP97I/EahdycgHKF+2oKgGUfbpldf6OV9k48=;
        b=XILyBFBj2ol58V0Glc6beCWZ5stLWWSKI850Ihk9vc9oFkJAXI2rzib+f72isYbGVa
         +dDCTOnK6lvPBZ/jdCpNeo47T/PofvStoQzdbkkYKQEBpc2STYMR+leA6nVOaNy22ceI
         8+o2wQyPh39HVefOn4HbqImfpagUy6Y0AI9rZKRzpNZ2ib7VxCW/YYmLFcBpR2s1EY2f
         0BHVQTP+6axpqmdtJNVhfJjg1ffahxqiwY5jZz9iOmUdk7wAx2xNIMrEWpQq/uNnknhQ
         GOiFenrBWD1VAK0VOLmWIN+NurDnJLXQV7jCrJYhTaBLWy+Yy0bSMIKVUBxghnmGR4Mw
         q2kw==
X-Gm-Message-State: AFuF++ktX/+RP87eeCTkeeO2uRhrf+dSOVyufFRhwf7xqf6fN0Ydl8Az
	gtCLTWXBtG6aJx/nTdORmH0hPMXbNwlnCI5R7jKOKtJmCfdZjgkTCk3a0HgJEQ==
X-Gm-Gg: AYBFou2MtBhPqUuAJq4zgG/bDA8u1zPcf7t4VN8MBxvHm8EokbM98iYCxYkY/+Budzs
	f9dsNxEm5F8ZyTdKhzNWPsPyNu14sE58esLZUh6GjkrBcCL5VJwYGkUuQ8u3rR8OPdmpEr+co2j
	VeBwij4R8qsJZxo9Kahrcj6cdr6ZrEtNeZn9HP1UXvFj7aHT8J5jlf550zjyyhPVgIiX+SsYm6l
	0ik2XhMlgsGn/qLCLX40BCoE3qiw8/s+XCjoIpYmN10CRSww8kmtggF6tu+uHh5FE1eCceBrVPb
	u+0XhxgpTj5nx+flM1tGEg/uYpKZNFvDuzH1I12vk/On3ZnwS9dY5vUddIEOFoyon5PpbtGtHoA
	biqr1NSk/3l5V/Mbq+oASBNxJ7lmNTnL5Gl4F21Oq7P/A8nCcGgOjqumHq+CXY+OjoGwbui7O1z
	YUNLGTLjuz8nJOAGWqf2iIX791uJvWiI5fLnnOF3XZomi9aaKIQlf1YBjy54lg6qgcQq9gBs5su
	3Jay9zLtg6CRg3Mr+1pnTKsMHyFvgVqgNHaC0G2YN29E8NOKGjzO2EL338d20sX3rkxPB+NgALG
	5eqhUZdHMWhxddNHyvUieM6D1MxmEP7eAFB/qw==
X-Received: by 2002:a17:90b:4b06:b0:398:9bd3:d6d6 with SMTP id 98e67ed59e1d1-39b8bf67006mr7365462a91.16.1788903938460;
        Tue, 08 Sep 2026 14:45:38 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b84cce64fsm10245204a91.3.2026.09.08.14.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:45:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Mans Rullgard <mans@mansr.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] ata: sata_dwc_460ex: preserve sactive_issued state across ISR invocations
Date: Tue,  8 Sep 2026 14:45:36 -0700
Message-ID: <20260908214536.598823-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zeroing hsdev->sactive_issued on every ISR entry destroys the NCQ tag
tracking that must persist across interrupts.  This field is populated
in the NEWFP (DMA Setup FIS) handler and used in subsequent DMAT (DMA
Transfer Complete) interrupts to determine which tags have completed
via the formula tag_mask = (sactive_issued | sactive) ^ sactive.

With the zeroing in place, sactive_issued is always cleared before a
DMAT interrupt can read it, so the NCQ completion path never identifies
completed tags correctly.  The command completion then falls back to
the non-NCQ path using ap->link.active_tag, which works for a single
outstanding command but produces wrong results when multiple NCQ tags
are in flight.

Remove the spurious zeroing and fix the NCQ/non-NCQ discrimination:
when tag_mask is zero but the active command is NCQ, all tracked tags
are still in SCR_ACTIVE and no completion processing is needed.

Fixes: 2d20da00c324b ("ata: sata_dwc_460ex: get rid of global data")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: resend as standalone patch
 drivers/ata/sata_dwc_460ex.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 8a1d80ac906a..6cce790516cc 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -465,7 +465,6 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	int handled, port = 0;
 	uint intpr, sactive, sactive2, tag_mask;
 	struct sata_dwc_device_port *hsdevp;
-	hsdev->sactive_issued = 0;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -517,8 +516,11 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	sata_dwc_scr_read(&ap->link, SCR_ACTIVE, &sactive);
 	tag_mask = (hsdev->sactive_issued | sactive) ^ sactive;
 
-	/* If no sactive issued and tag_mask is zero then this is not NCQ */
-	if (hsdev->sactive_issued == 0 && tag_mask == 0) {
+	/*
+	 * If tag_mask is zero and the active command is not NCQ this is a
+	 * non-NCQ completion.
+	 */
+	if (tag_mask == 0) {
 		if (ap->link.active_tag == ATA_TAG_POISON)
 			tag = 0;
 		else
@@ -534,6 +536,12 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 			handled = 1;
 			goto DONE;
 		}
+		if (ata_is_ncq(qc->tf.protocol)) {
+			/* NCQ commands still in flight; no tag completed. */
+			ap->ops->sff_check_status(ap);
+			handled = 1;
+			goto DONE;
+		}
 		status = ap->ops->sff_check_status(ap);
 
 		qc->ap->link.active_tag = tag;
@@ -612,9 +620,9 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		tag_mask &= ~(1U << tag);
 		qc = ata_qc_from_tag(ap, tag);
 		if (unlikely(!qc)) {
-			dev_err(ap->dev, "failed to get qc");
-			handled = 1;
-			goto DONE;
+			dev_err(ap->dev, "stale tag %d in NCQ completion",
+				tag);
+			continue;
 		}
 
 		/* To be picked up by completion functions */
@@ -1051,6 +1059,8 @@ static int sata_dwc_hardreset(struct ata_link *link, unsigned int *class,
 
 	ret = sata_sff_hardreset(link, class, deadline);
 
+	hsdev->sactive_issued = 0;
+
 	sata_dwc_enable_interrupts(hsdev);
 
 	/* Reconfigure the DMA control register */
-- 
2.55.0

