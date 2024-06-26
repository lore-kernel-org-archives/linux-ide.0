Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D81946D5
	for <linux-ide@vger.kernel.org>; Wed, 26 Jun 2024 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443074; cv=none; b=I3UkNTN25T0nMqu/lGwvuvwgnUBQMDb73ajFl1LLQSZfXpEvT9xvLGtvDc2pSq488UQyHUq0fYvgGPvljjKK2HRuFcuY6dA+be1I4OFgJjTlAyd4je9ACRWCTx5J3kh2yj3feGDyHY3Vk5uiuLR8zh+vRqz01vtD1f/1RV3aqzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443074; c=relaxed/simple;
	bh=rrgk4/GN+4afQi82RWjkVdACN68Mce2bh09M2M+kIiE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UuIw7WGy0+OSiJbYQguggWCnKzFf70HvPbJzTUZ/B4nsHMOmlcHyyNOtHonvf/nq/rjTKyYDwv8YXGw5H2d9BXsDTFguD9EV14hSeOO+bCJmkg0ScL4rnsuRaGdNJIUxOVrbMlXy09mS/T79mH/oqq9cMfheanWpY0eGyOuEo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wLm0kUne; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLm0kUne"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64399573fd3so123435427b3.0
        for <linux-ide@vger.kernel.org>; Wed, 26 Jun 2024 16:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719443071; x=1720047871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/AvM/q6eju1FsW+yZoXAdsmFslERaWnMqALTvRepcM=;
        b=wLm0kUne+f06wja8x6z0zsOrKV5ScP28P/L/bdTpFOyUM1ZIhDhGDy+hboncNldeZ0
         AfABcmWmhvwIgCXoC7bbeowqvcGTd7ZyzQnbRYJY2NMYxNWqjkDB93iy2r1IohQGzAZG
         OK+JQU/wc23B+zbdhc2zSie+k3ag9/MuTFahFwLVtLCuiEZBGnwWbOdYomTZ3ozx3hYK
         lo7w0X1j7z9hNkmijOWRPqsW4QnwtOv7XiQ77HOEHy9/5JAcnhpLia6dstp9LOkkZwqL
         BZIEXaWNfn9aYXwKtet/ZZpWHruVCDycYdTzgGCzXqKL9K6uMqDlrP0TomkZzKeg0MUM
         lV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719443071; x=1720047871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/AvM/q6eju1FsW+yZoXAdsmFslERaWnMqALTvRepcM=;
        b=TBO0eZ17uy2MnEKBPfP6NH1o1+CXLsU3VgcvNwqKbHEYVcV20vobZKFWnfxbh8WX0I
         GzSpq4G9iAnAKDIgreOAKuCQYMVOxFS2bO4kjomzx+CNmmve9o4BHBvhM2zx3+TfCoA6
         2MgFXb/s12IfKjiSf3B/oqpBwVGiYCvd1kvsTyh9jUJYkSKYEvkZQ6AgmGGj/W5SwsWp
         AqXuk0YCQwEs3/b4uVjVkJpkQjZSoT0dIFJgt/O60ehhqyqM2nRipOsU3VM1uaQFxahw
         YZr2CdxEOzR6f7sGFrIXruUWCQgv8j8tLWYHV3F0S51dZXN28f4HEqqVbcE+iVI2/ZF+
         TyMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8nuHxxoLadSSyfA21Q7XL+amwJb3HaBl1M8tMD+WDpu+Wg7E64VJj8ckTwcZ08vcaNg6NaJKAIOCqmHuNxmQkox2AM+kPlPur
X-Gm-Message-State: AOJu0YxbEdotKZ6aKjpW+ZZ4Vw2Qu3Cd4o4t2dDyM4euydMQUQKHaT13
	g28TbYnkXTtWKg/FO9VHJIpSicGpH4Dl4QrLdDzeCZ6QUKonk1u7kEX+009CJ/+OPz5EZc6q+R9
	dWcUlP0AU+A==
X-Google-Smtp-Source: AGHT+IGHbW9wWs9Mfi0inpboOmSQg9uCUPvebnEdxpQuJ2+zXLOG/ST6R9W4mdAq7jmPeHiFUa3LGqjhiLvsAw==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:f85:b0:e03:33c7:5678 with SMTP
 id 3f1490d57ef6-e0333c75779mr304400276.13.1719443070943; Wed, 26 Jun 2024
 16:04:30 -0700 (PDT)
Date: Wed, 26 Jun 2024 23:04:09 +0000
In-Reply-To: <20240626230411.3471543-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626230411.3471543-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240626230411.3471543-5-ipylypiv@google.com>
Subject: [PATCH v3 4/6] ata: libata-scsi: Do not pass ATA device id to ata_to_sense_error()
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

ATA device id is not used in ata_to_sense_error().

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 6b6e35292620..02af4d5d5799 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -785,7 +785,6 @@ static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
 
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
- *	@id: ATA device number
  *	@drv_stat: value contained in ATA status register
  *	@drv_err: value contained in ATA error register
  *	@sk: the sense key we'll fill out
@@ -799,8 +798,8 @@ static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
-			       u8 *asc, u8 *ascq)
+static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
+			       u8 *ascq)
 {
 	int i;
 
@@ -934,7 +933,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	 */
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
+		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
@@ -976,7 +975,7 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	 */
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
+		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(dev, cmd, sense_key, asc, ascq);
 	} else {
-- 
2.45.2.803.g4e1b14247a-goog

