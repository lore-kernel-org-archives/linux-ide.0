Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB1F34CDD
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851061; cv=none; b=PbOmM1LzdjcDbRQ7WcGvn90u9C8sAtDVykK80VeJL3VhaZPbKKItkiLoNb6/KXUQmW5VAsWJiYdSbxl99KNWZvMfRj7ggtkILLU38vjTVb8nt6iuSFUZ6z1pT1UDz3Vu86eTVY+W4RnF2wmdDpFMcGmjfdN/1OEeG6o0sl6jFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851061; c=relaxed/simple;
	bh=nUI5TbDWTweGekNOjKAYQGyyTp7oUDvk6+QBMM+0b+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYcPniUKdFRRbW3TWX+zL79tVECaDodjEq/dKLFn95a3RxVVOtmr3UpET2jyI1UKzTlkolMt2FxeTyI+z720i+nFfz+ofiuwFrUd69Hq0+YQuZFrm9+izf/0OsPTjJ2aitxkhfDrtrsMOu6iIsBathxE8w9QAqJu1vesjYHcwUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF6PQL+4; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF6PQL+4"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c964d52321bso1212092a12.0
        for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 13:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782851058; x=1783455858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhuCqNnq3rKv0ga2RMxQC7IRM/PJTZC3NOqkYu05+Fc=;
        b=IF6PQL+4VKXrVMOq5IWgl/7hml9w7olAhiPjAK4IWSyyFWrFFGwX6I1ZygSMXcCNW4
         2cC7u2OhNqYUWAUC0o1MCf2UlWC+0t9+5zHWQiYMjKLCjFPd/bQoWM/fGMjX2jWmARYD
         m4TewwV4K756NBvTkNzyBW6TkPf57YnEWERPIxkegTHdQeaZKI7tvnJ5jwiWwgeyUseD
         Mycrlx4Cb9Gn/cIaKml/3ZvHZR6UeTcrYpWT7P3f1Gy12mMSQO8kofvv8dDf6PCmJpBv
         aomxyhqNfT70jrTVcBYYhUKgC5v1I9/rML6QlPpXIC06aoT0tL+VWcKeL+cS/JIKFkQA
         Z6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782851058; x=1783455858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zhuCqNnq3rKv0ga2RMxQC7IRM/PJTZC3NOqkYu05+Fc=;
        b=PRImM2vE3iz4oTaTeNYq96y7zvKt4cV8HbquJF7XPDCL6tzvlcGdW+QD5oQ9vS4Pup
         OR0EfM9ipfuIMslPiJzX0uZrOA3C0TzCynHgjb7kkWDbg2DHJDG3YAd2kWm+vF89uMKt
         2MRQgc3bCqyXfpNJRNQsiQTUQU33ZEiQaiskZ7HTjin9x9S1rdy3577XvcgYtmHL2khX
         3UFyl8Hg/aIUkBxOfOH6ow/ort/dm15ZUDx5HpCudOShcxMZw07LDzomj8bNh8OVYMWN
         kc11q15qD36L1aLaR6D30haAf6azj+CMo8qqAzUSDaZWrxqYWP7YA76e5xDXG07xZyi7
         YtMQ==
X-Gm-Message-State: AOJu0Yz65+gm+0eU6u4kw0sImvb5r2iTXmnj2nuMjws1grE6bmFmzsce
	ulqWDpmcY8Ak0tGiTUxuxkoBFUudSLdpT8J/9PKGunYmZ2ys8gzA4my1gxaadlVD
X-Gm-Gg: AfdE7cmqlNqN//OpHPoMEDdPRx0UUi8DF6TTfbE+EOPXGzkKbgafBBkIg39X0Eaiv0r
	FHxB8iXKoZrQ43HXkTGh+6BBqPzVn431iAMKgkIZziS1ZxMgAFrMXnBVMCtvMshJbAOiUQwz+UN
	AwXXv8xMacV2RLJBIpegxEJVFjHVtegZNvgxucacMlgG31OwDh931AoommmvsfL32qGcR2ksJES
	EieXHd+k9if0N7f8YY2B7RIwi9GYuduYz8quDqhjE5ZzkjuV+SZTOgwYkJGUlxe4UlEK7LrAmsm
	R31Gh3U88v1ZnMpHY29m+Y3/Frhh1JRqHjHoWL84vBNnZ9Ekv9tuJTciNk6IY6qpg9G7puKULqS
	FFGYNNcn9Jamu7cmNF8YGA2ykz5NYkf1hUhBegO4i9JDjR8CP7aa8tSCc2g69Px617xM7AFcSuW
	7wkXuoJ0O5Npms0lBAc2USmV4R6zbLigAmNUTpOJuAvejnPl5to8SW12+ZKfNpLasLfRyGD4rw8
	HxmiiZV/IZRS2M3mNrC
X-Received: by 2002:a05:6a00:18a1:b0:845:c373:6525 with SMTP id d2e1a72fcca58-847adee7407mr1936902b3a.41.1782851058247;
        Tue, 30 Jun 2026 13:24:18 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a0337121sm2688854b3a.44.2026.06.30.13.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:24:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] ata: sata_dwc_460ex: use device_property_present()
Date: Tue, 30 Jun 2026 13:24:11 -0700
Message-ID: <20260630202415.234463-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260630202415.234463-1-rosenp@gmail.com>
References: <20260630202415.234463-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to use np here when dev is enough. Follows the similar
pattern elsewhere where of APIs are replaced with device ones,
especially when using platform_device.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 4fc22ce4bd9a..2bcb3ac5ae21 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1180,7 +1180,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	}
 
 #ifdef CONFIG_SATA_DWC_OLD_DMA
-	if (!of_property_present(np, "dmas")) {
+	if (!device_property_present(dev, "dmas")) {
 		err = sata_dwc_dma_init_old(ofdev, hsdev);
 		if (err)
 			return err;
-- 
2.55.0

