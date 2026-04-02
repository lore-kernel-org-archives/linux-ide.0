Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A832BF3F3
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136653; cv=none; b=UD47zlFvNMHDNUb3GppB8nxlMTJ5mUPR0JUm9mtmsjdwLXxeIPMRoLBkoveQdFItXcDKvfu8BMRfHBOyUJ2zPYs5asS9Mtnzd/rLkyrBTV11XA32sFSjvCpENXwPB+cvkLF4EuwBEz1oGSQeANKljbZtdCUAUGvyXYJeuFTvxI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136653; c=relaxed/simple;
	bh=oeQfoSM+oSuOWrNP1refR0lQ1BTs8wy0S3lbTh5owWc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Lu06VHZf6iNhKb3MyBSuqDAeIAo/0CpNFdLj5qyyKM/ACIf9/SXpMh8jxT/wZbDpPEwD2nTnGl5vZ7on2daUgiwtjjJsmjq1QdzVyeQ1tYmIIszxjr37DeBJQDiBcSG5eAUhBrElqn/EKqEgXTgJcyGtQmyUJ7GD3neErZo6diI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imT2v12z; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imT2v12z"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b949bf4easo1407638f8f.0
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2026 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775136650; x=1775741450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6dTns50KEXcCjmIgDZ6H3vL8B1rqJ1369P+2wfbLKhs=;
        b=imT2v12ztnBg3eKRPjcLhRXPIfhCb+K49RekX/ydNw1n54x1fllG8p/u71/Cyj8nXq
         kJhWEZnh1hY06Y2/S1wm/sBEVpsdl1MQDrj8CxhsBTwg/wCwSXFyJvrGPI9J9wp8c9pC
         3UvqeFIPiqJCeWwUF1DySEelAnhU9p3Rg/s96h+4phAI2NOByQVS83r0o5mQKmyihm/I
         nJqXYZtk3ecgGIY8RWEmLNUbUHq6vMoG/iCI+PoJzTrQ5f8TsUfXhehgO4MKqWmKLjY7
         EZqGjTNY8On1VYKPDp3rq/zzXKMi54WA05GqsbqWhyZFLshAa3GO6G4KuYvyq7wbcx3n
         hH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775136650; x=1775741450;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dTns50KEXcCjmIgDZ6H3vL8B1rqJ1369P+2wfbLKhs=;
        b=tFiWw+bK4wWYZf2kZs6UBpIluoH3fQEuB+h0S/nKpZpujeCoGWRucd3HKG8dduUvjP
         vxEMVyWbBSCFXTSH+cIel0KvdQaQ73JBRXJuhWtksL1ex7DmnM41m8t170M6O642OyF/
         BECk3eSCT6QdTdhWR9UsABjoV6DIlSN+yU5cKRvT6mJaI97sMYpInGIumFAwiWZgNurI
         STNSkAGiITpzow+FtBwPaSUjAzW+i0w69SbA0YKURDC4gb/kwHb0CMZ/aAgHz/3HEzoF
         7oFNBqZZ9P14Vdk9zEWc884iFzv4PBqnuhF3xZsFQT+mEZVXNSd8uka4agQApYy8QE4c
         eyCg==
X-Gm-Message-State: AOJu0YwUGjROmCanFW1Arvna0ikxQO5TviGQfdnPL6OLq+7Bmb3Sge0f
	+utpwF/vJlziYHvpLpzt+lrJBx+x8GmnMABUGqRKzHthVzxxKTLb7t73
X-Gm-Gg: AeBDiesxfvSfER6ZymdMGp0gYfzMerG5Mp5u9aRrRPbIVJlNv18Z2iFJBsqIUyCjIKZ
	/S45Wmc2V8UEQrOaS+sOVDSb42laBAOrWLpiQcwVJMXTHVSAX7shc2oa6GJHZDR2u9grpk4Vf64
	bDf8uEcp9NkHbCfi49QUQ+6uO6pUZZHAqXhN4GzWF1FtrEMp29bXievtlhsDmZsYfgJwn0jsbKy
	orVm9pb2hZjfp8QwwgC6UIA4f4En/hjIt0f5O7/pElYqvxRR6VpEv54/L8CHxmfpUdGFlmNqQ7I
	hkrhohjJBzWxyUxkwRM2TSbn7lXXfPYOa84LVyzPytnjBzHQ5roju/iYg2QwomgC3jj1n9mlnHt
	AmXchMGuxFiFNPU7m0+IOwYHPmLEufnOyJ1UmfJzr5Ra83Zr4bZaMefMSaVvtz6ZWQTL1M3ZxcP
	KMPV2xtYQ6xr0JhhzyPRJIQRVXEZMe2ZmT6sAKYS48BkCwLgDRnItKakzA+6/95wo0kHZxQe2V2
	cSCADfazxRfzGp/9nCAkd4YmlYd2pbcRjNJH2dCmMPYExaECvV4mGnEv4ppx+iXnA==
X-Received: by 2002:a05:6000:420a:b0:43d:167a:b5a with SMTP id ffacd0b85a97d-43d210ca81dmr4569643f8f.0.1775136650276;
        Thu, 02 Apr 2026 06:30:50 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:9500:c168:ad27:2fdd:9334? (p200300ea8f199500c168ad272fdd9334.dip0.t-ipconnect.de. [2003:ea:8f19:9500:c168:ad27:2fdd:9334])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f5bsm7579923f8f.7.2026.04.02.06.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 06:30:49 -0700 (PDT)
Message-ID: <5b4521e3-eb6b-4fca-aab8-caeb3e24a691@gmail.com>
Date: Thu, 2 Apr 2026 15:30:48 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/5] ata: libata-transport: use static struct
 ata_transport_internal to simplify match functions
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <93fc6c62-ed8c-4953-ad7b-522031bb7ed9@gmail.com>
Content-Language: en-US
In-Reply-To: <93fc6c62-ed8c-4953-ad7b-522031bb7ed9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Both matching functions can make use of static struct
ata_transport_internal. This eliminates the dependency on static
variable ata_scsi_transport_template, and it allows to remove helper
to_ata_internal(). Small drawback is that a forward declaration of
both functions is needed.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/ata/libata-transport.c | 44 ++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 9d594562c..68ae57a89 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -46,7 +46,11 @@ struct ata_internal {
 	struct transport_container link_attr_cont;
 	struct transport_container dev_attr_cont;
 };
-#define to_ata_internal(tmpl)	container_of(tmpl, struct ata_internal, t)
+
+static int ata_tlink_match(struct attribute_container *cont,
+			   struct device *dev);
+static int ata_tdev_match(struct attribute_container *cont,
+			  struct device *dev);
 
 #define tdev_to_device(d)					\
 	container_of((d), struct ata_device, tdev)
@@ -519,16 +523,6 @@ static bool ata_is_ata_dev(const struct device *dev)
 	return dev->release == ata_tdev_release;
 }
 
-static int ata_tdev_match(struct attribute_container *cont,
-			  struct device *dev)
-{
-	struct ata_internal *i = to_ata_internal(ata_scsi_transport_template);
-
-	if (!ata_is_ata_dev(dev))
-		return 0;
-	return &i->dev_attr_cont.ac == cont;
-}
-
 /**
  * ata_tdev_free  --  free an ATA transport device
  * @dev:	struct ata_device owning the transport device to free
@@ -660,16 +654,6 @@ static bool ata_is_link(const struct device *dev)
 	return dev->release == ata_tlink_release;
 }
 
-static int ata_tlink_match(struct attribute_container *cont,
-			    struct device *dev)
-{
-	struct ata_internal *i = to_ata_internal(ata_scsi_transport_template);
-
-	if (!ata_is_link(dev))
-		return 0;
-	return &i->link_attr_cont.ac == cont;
-}
-
 /**
  * ata_tlink_delete  --  remove an ATA link transport device
  * @link:	struct ata_link owning the link transport device to remove
@@ -762,6 +746,24 @@ static struct ata_internal ata_transport_internal = {
 	.dev_attr_cont.ac.match	= ata_tdev_match,
 };
 
+static int ata_tlink_match(struct attribute_container *cont,
+			    struct device *dev)
+{
+	if (!ata_is_link(dev))
+		return 0;
+
+	return &ata_transport_internal.link_attr_cont.ac == cont;
+}
+
+static int ata_tdev_match(struct attribute_container *cont,
+			  struct device *dev)
+{
+	if (!ata_is_ata_dev(dev))
+		return 0;
+
+	return &ata_transport_internal.dev_attr_cont.ac == cont;
+}
+
 /*
  * Setup / Teardown code
  */
-- 
2.53.0


