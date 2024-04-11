Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB42817756
	for <linux-ide@vger.kernel.org>; Thu, 11 Apr 2024 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712866353; cv=none; b=K7A+Dzf7ZHfguDfsUtw+MwSCsX9ZW0glIhHtQWzPcrrDEvAdCwAKZJwUT9rujMgIHQls5cvduplADXdRfKE8vlKjyJpeLgES1ICyei284rJb/44CdNkz5RuzNKQnnmumTQ/QhwkwywvfIENKAPfMQPdnJJGdodX/wbM1FPa/Mpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712866353; c=relaxed/simple;
	bh=IOzWZkywOwA2ndhPjHmzQHWJ3c7dhd0+FGx+Rn/xt1s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FzvVUJ5DXp1/y3CWDqUqc0h9U96WlEzQUs6oBXHB13RJIy4X516KFNM9Va/gNT19Z8ScYMzON1yhSN2R8jYZYVc9EGHHwwpJKJczE/YdNrxrbmGlYxeA/XPL8VA9aHxjPnjUvbECFAHLuBh3H2FEBhFwo6FOo8F5eHbDYOE9HWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LSunOtQC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LSunOtQC"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf216080f5so327749276.1
        for <linux-ide@vger.kernel.org>; Thu, 11 Apr 2024 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712866351; x=1713471151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z2BoP91YkDa6Qt/uP+LjX8R6BByP1pkp+j1WZvkyP9c=;
        b=LSunOtQCeDJXWRMpWM0I9BZDPudqJhateHSTyy5LiNMp5LRgOi2UsqoZ7Rs0dg4QFP
         IQou8hmjncJR+3z1NMq31bFDRND0/+rDL72LZeBopzHnVOoYJvwi31u7V2idB1cyd9Bx
         e7hctJf6RcMTc8IEKlGV3shp1DKN9ic1Ii6YDq7id05dgRZdkrTzTdA5TlQfQ0+LO6jd
         r1LCUTit1XPtwJn6vmLhKmuleRtK5+3NaJH1AFbCrHOvXIJoGERVSLrFPYMILmM0uHH8
         r60VUq4+vgePfQCoKU0TEQkSXJPd74K9ITA9jcKKQkB4vUnKW4lj9bDpQO36WIPMhoX2
         JREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712866351; x=1713471151;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2BoP91YkDa6Qt/uP+LjX8R6BByP1pkp+j1WZvkyP9c=;
        b=squ3ziAZ7dV1FRncoREuwb9A+HhRSTYfMH3AMnjjmB4Bw2CfUxeQL6y/ssNPmRAAWP
         +O4zHTjsLMO1uc+J1J1qHUdtZETyNdAxZ6QFDch2cIX5lHRJgcWoael3ZD6BFIt9Gdqg
         6uibZ/Q8bVB2fz43OG9nKAtBN1zof9r+YXLh77Z8r2FOgWGnkTeUKnr9+Wt+ZEo6Or2E
         sE7H9v07msJ49gCdb4nqQQ4m+PUy8M1lW23S8a78pmVcIbv67YxGdi7iBGIEqTnooq16
         cNKdxJmbSECbWOwMHOV3o48VLKE1viXUmcFqXbEAHiYvVq5kr61LMqSkvf2XBhWlYixH
         +tpA==
X-Gm-Message-State: AOJu0Yz1zAMToSoWvMoaa4nzMYgOALScDOzKH/yoBjP1KBvJQFiEByS/
	EzbvsfVA1bIVUe6w1lUhYvcnVPTds1h/eecQRfOTG4uiEy6PeZ+hvqd2uMIhf9VU+Ugeujp8fwp
	r7Sa1Wo4ckA==
X-Google-Smtp-Source: AGHT+IHP35EiL8Z/ThcjwbVilIgOWIx7kty8BvrtYfdYdh6PolWqYRFhau0jCfMJznCy7ffkzl2wn12Va+2G0A==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:100b:b0:dcc:f01f:65e1 with SMTP
 id w11-20020a056902100b00b00dccf01f65e1mr157365ybt.8.1712866350713; Thu, 11
 Apr 2024 13:12:30 -0700 (PDT)
Date: Thu, 11 Apr 2024 20:12:24 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240411201224.1311198-1-ipylypiv@google.com>
Subject: [PATCH] ata: libata-core: Allow command duration limits detection for
 ACS-4 drives
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

Even though the command duration limits (CDL) feature was first added
in ACS-5 (major version 12), there are some ACS-4 (major version 11)
drives that implement CDL as well.

IDENTIFY_DEVICE, SUPPORTED_CAPABILITIES, and CURRENT_SETTINGS log pages
are mandatory in the ACS-4 standard so it should be safe to read these
log pages on older drives implementing the ACS-4 standard.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index be3412cdb22e..c449d60d9bb9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2539,7 +2539,7 @@ static void ata_dev_config_cdl(struct ata_device *dev)
 	bool cdl_enabled;
 	u64 val;
 
-	if (ata_id_major_version(dev->id) < 12)
+	if (ata_id_major_version(dev->id) < 11)
 		goto not_supported;
 
 	if (!ata_log_supported(dev, ATA_LOG_IDENTIFY_DEVICE) ||
-- 
2.44.0.683.g7961c838ac-goog

