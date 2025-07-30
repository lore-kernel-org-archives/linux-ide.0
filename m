Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4928E2110E;
	Wed, 30 Jul 2025 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873239; cv=none; b=ROfqWGbQw4Fb1nHKbntpnrCalUOBtgGfisJtm+hElHLC96Pr1isWR3Cnmg4EJ2UM8UzGykGpO/VCSx2B98jtdc/W4J167m0ijOmZHW2Jk8EedaBrW29vOXZNLOkXjyJxx2oMwk4hUKbQdTL8bxb9FBT+L/KQaON4THnKOP5P8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873239; c=relaxed/simple;
	bh=HaZMMuKZQZcg6lQ9hU9TY59/UTNMhl0PQFmNQNiY2yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ir3dzEO33qmwJXUGvGqs1oU45488DYbQm9O0WIoZf8kFR+h9Q+Q9DbQ4rdWJ+RH/PXDrEmndmZkf8g6gjdKBe/TBJMz/r4QJMaX4CXmKnvMEcMGkRZJKeKO8JQGBMzLOzBnX3B25CKhrZ3bPicE4A2y7O0vvnhP57nnwc2wwExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSxtUr+z; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSxtUr+z"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45611a6a706so30950435e9.1;
        Wed, 30 Jul 2025 04:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753873234; x=1754478034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SbLm+cLzm8h/ctscYb3BMVYRqSGLoFptIrggVe0rnsU=;
        b=RSxtUr+zok94JKSJQp7VoE3lEVVyGI7bI9fPU5tYUbvHVLNS5SKeYo02vX1zSOGhVv
         +Fob7OacWa5a1EWB+C65FjnzksV5vtrh4qPjU9GdYQ+08lNcwAzyU3KXXmKGf7It76OG
         6b3G/aqrsWm87UDTmAuIO/aqedrBqvg0/4FxVnsjfQr7y58++gCZgekX7Fdh0t4AOBOU
         qgV4VXAyL55aZ3+Xq1rX7uQAk3nlpZTeKJKHuWaPTmIB9fUstxB4/Y1h9/2m0VNDW4ex
         rIIKrKvVrYr6uAFInqCSAXHHrX6eJ/NaQVuojSJ3UlN/Ub7GqRIBxbUQE/s9nK6mmYRf
         90yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753873234; x=1754478034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbLm+cLzm8h/ctscYb3BMVYRqSGLoFptIrggVe0rnsU=;
        b=qSVeqwMCfRRPazaUduHDXOrYAnOWLzT5Gf5VKZ5gFqlausUfz3QFiclQELcFpX9TFP
         erTG2XNWsKMW47xKFTiZcwQq/P2lBS62apsq+kP6HFRafWDe0xj9eggAYENDyKg7fN0h
         Gzzv8ixLpLAYGudzyx2FbD0uE8dH4xQw+shrvmxmKBahsqO2gHNkKEzISReeukhnQc2N
         0RQZLCKFP7Yh9LTRPNLn2GSGsP/5Dc7comKd9/ba+wpVGVMRIsSCtrqQPBSqWrJIfuzn
         X/IrNUZHLslNTQ/yvLtjXbTFYrpqACqDaDCaP120is6/ouCRqGtqgeN9tdufYIFBVeoL
         +vvw==
X-Forwarded-Encrypted: i=1; AJvYcCUBjibCvgqgL5IdBJGxtzusjQI1OIMFUcSquUzSYJ8Dy6DCX7pzHPgQ1lVG2B+f90D3pSbhlUz9XSPg6epd@vger.kernel.org, AJvYcCWog98TqzHr7cJQHkFt5u35Q/hFUBtpszJiPWPPxOImS+ZhgY8gDUsDT8bYUOOlb15NkZcJMJ/pmNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIK2PjiKoVxUxFMN0fgmt7i4KHyAbb862ZzqoCLVI4+p3BoGT3
	X8rTgf9UDmnAJV20zfgyZIEAjZDD77RW/KoVNSrnxfSh14kGx6IwXT2t
X-Gm-Gg: ASbGncsr1+R+0RPI24lv/uObKPP20pRJmPoafRcprQNhkmaZ6yO9ML74dLMYgRk3KSJ
	YlBO8jsi31tCuHjbKQN6gOZnyB0ONaFTrPOZoAKo85OCsH+f63L2aVAeoudVJyoudOfbWZM1vY5
	KOrUyhVSPu0y3rKIGspWAHDrEfAscbGzWp9ilOxEHa6mgmUbS1ZI0/Ysx7zy2SlEEY/UpHPIFt+
	G1OUfN6lqrLpZzvrM2azDKPgcS4ZThrLEQChwsV3gzKoDVihiiVTN6a9FU7L/gT2XzXt3VNTBND
	mX/TcWhv9NJA91cdgKDevADThysE1LljIY5JRqsaPpMad1X9OpHHkQ3vc3ZrDXwTG+YNrMq0L/W
	t6p5iGp+2esi5Bad+YUY+
X-Google-Smtp-Source: AGHT+IHL6le99e4dQvuL6ZyO5dMlJdlnJwbY2lLiTZCb+XxxAi5luS5/iEhxQDi0lFJnLlF8pRBcbw==
X-Received: by 2002:a05:600c:358b:b0:450:d4a6:79ad with SMTP id 5b1f17b1804b1-45892bcc5f2mr19847925e9.23.1753873234274;
        Wed, 30 Jul 2025 04:00:34 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458953865dfsm22547585e9.18.2025.07.30.04.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 04:00:33 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ata: libata-core: Remove space before newline
Date: Wed, 30 Jul 2025 11:59:59 +0100
Message-ID: <20250730105959.2058765-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a extraneous space before a newline in a ata_dev_dbg message.
Remove the space.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 97d9f0488cc1..ff53f5f029b4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4602,7 +4602,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 		return AC_ERR_INVALID;
 
 	/* set up init dev params taskfile */
-	ata_dev_dbg(dev, "init dev params \n");
+	ata_dev_dbg(dev, "init dev params\n");
 
 	ata_tf_init(dev, &tf);
 	tf.command = ATA_CMD_INIT_DEV_PARAMS;
-- 
2.50.0

