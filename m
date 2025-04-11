Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC61EE014
	for <linux-ide@vger.kernel.org>; Fri, 11 Apr 2025 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351105; cv=none; b=OPgOINkaLJRUu1PiKN2BGiMk5/0dTBAKpTLViivseT63Vhm8ODAcMPfmvpB8+LSQDW6lJNkMJsj2nybkKiRVm+UFtny0g0GFrRUVWfgB8+HtHOqzhh8gV3+2QZ4YohAhEJuMIu3Wp/eRV88Fmj1U5sHnMBsxboQXp/MtowR4Y3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351105; c=relaxed/simple;
	bh=wJ31W/+DVKX+lEArl5oUtIQc/0Zx9pV4OGZhMCcDvoY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gs8I3atpVtU66hRyQLvE2/0DpyOcUNcyWzo7XWXJW7mo/VW2wL1OfPnfAsFYCuN9V1QF63fqIbP9CMYBtPYP7zMuN1qjBoGKak45WZBylj2SfBOcJhGvf+UEisjFWtMK0j/gbqZ2XplE6gmFS1kQBDWcan4xHy8zk+G7l3+VWyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8Vq+tds; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8Vq+tds"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39d83782ef6so1674965f8f.0
        for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2025 22:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744351102; x=1744955902; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi1vNo80V+kirekGbsAr15/nEWz+oubM5MalfsI9cYE=;
        b=X8Vq+tdsz9q76EakRltXj0KTYBx+neH2+2K+9S6iC4jTS9AVx3c4nS2BHY6Gg1Zx/J
         sz6l8PEhYZv1yJzcalaR3jtuoMtV26dHuRWjMTHaMbkOs/URmo+TLn124dl4R62foyiW
         A+cVgx2n2AHCOhLljdO4cDfMRH3xgPxX0upOeu16kOAqQ8r2a1z/cfCdQV2QltcBY9zx
         3+3T6sC1vVloGx44v4I4tb0YE+2h3DYgT03IUaI9yY41t1rLjiL2Xu/PuLW/PERPOPiG
         puVf4yrRawmMiykoLqAan1WQ71/dRi0RPhB6ZyR3CTl7jJao69lMDjd14sPQu4KH+o04
         MTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744351102; x=1744955902;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hi1vNo80V+kirekGbsAr15/nEWz+oubM5MalfsI9cYE=;
        b=l15S62L9jlyRqTq5d73CqeEtM/jBumfeBXEj1LGfXVZ5JGNEvfTGGhBj9QF0iKb2Yz
         A5m8qq3QXEOiNtqKcrijWVQgWxhHhGTIHtUD+Vs7M4f7RPSDvIciTbV7eWzB8CMM9oEd
         sYbDjD8wFhlJB+VSnqPOToJG/qHkePb5E+JTo6h+nMhBzr/9Otv/NXr6kmYWGDPZQq5v
         6mv5KlGrypLZ2F6i3X2fnBnhJVNnFotqIPIha5PxLG15KOCQ2drsaHnAZqgMKbJltSSY
         aTlz0FySJMYyRXX5qBNyRJ612dARE3xDE+JIOYBPf91lf4uOC5CMONwUpVZceT7Z3KZH
         SuyQ==
X-Gm-Message-State: AOJu0YzHw7JU1AKgqyMhnkg7GmERJhBhX9tCG2zNjKz4VhtMrRnmxT70
	ZGx7UFxQ/LMmkYRNCEma2sgvt1AsiIhqZqcQtbc6KP0kHHWMYU9+q7wLYQ==
X-Gm-Gg: ASbGnctJvvpEMxQcNPh1Pfn1kaxMldEJkPiznLiO9Eq/OKV1Z2yHfJoLEAkq0jMxAzv
	FDu7NE2wrBMmxsbdgAsnsgEs0az+i8XQTJdCJCvasWoBYGoLs3PiMFuCjan2v1t5Ii/6TZsDW6q
	hU9ZGZXXgeKwkfAotJkQtIpy3mrHS3mDVndYvX/l5F18pDNYifk6NGGYDyIhFMpuq72La+clhoF
	rc6DfF6GADJdI/6DbCO10/1OHl+po1gKMX3YOV0N+bQ7l3W7v7hVyUyxw7ioTTAD3GsDfkSjKaN
	3NMcHeA/DT/JlQCoiv+cqpEdK8Mv3SVv0KBrAlJNANJUDUqSajOxXfUQcDBCwGWIt9iqF0AFapU
	N0krnJxr0RX9t91y+AZp7HDGPp/soySkkyTXjkDhhua7C8zv4dwq9AtAP5NG6oxxODd9iV/XhKi
	slLvtuyuwo/QuMQLJVr+tIYwOkmuNNmw==
X-Google-Smtp-Source: AGHT+IGlUYMtXOs0n+3s/ed74cV9D3P9WHoI4+iXL24O3eETvj52JICMx8N6yy2aw2/D2Qfv/OLKcw==
X-Received: by 2002:a5d:598e:0:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-39d8f21d531mr4560976f8f.0.1744351102122;
        Thu, 10 Apr 2025 22:58:22 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a54c:3600:549:9f8b:a298:4c0e? (dynamic-2a02-3100-a54c-3600-0549-9f8b-a298-4c0e.310.pool.telefonica.de. [2a02:3100:a54c:3600:549:9f8b:a298:4c0e])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f233c8224sm71437655e9.22.2025.04.10.22.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 22:58:20 -0700 (PDT)
Message-ID: <3c13edc3-89ee-442f-ac7a-767ea5097424@gmail.com>
Date: Fri, 11 Apr 2025 07:59:09 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] ata: libata-core: Simplify ata_print_version_once
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use dev_dbg_once() instead of open-coding the once functionality.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- inline ata_print_version_once
---
 drivers/ata/libata-core.c |  6 ------
 include/linux/libata.h    | 17 +++++------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 773799cfd..79b20da0a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6682,12 +6682,6 @@ const struct ata_port_info ata_dummy_port_info = {
 };
 EXPORT_SYMBOL_GPL(ata_dummy_port_info);
 
-void ata_print_version(const struct device *dev, const char *version)
-{
-	dev_printk(KERN_DEBUG, dev, "version %s\n", version);
-}
-EXPORT_SYMBOL(ata_print_version);
-
 EXPORT_TRACEPOINT_SYMBOL_GPL(ata_tf_load);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ata_exec_command);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ata_bmdma_setup);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e5695998a..98affa1d9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -41,17 +41,6 @@
  */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
 
-
-#define ata_print_version_once(dev, version)			\
-({								\
-	static bool __print_once;				\
-								\
-	if (!__print_once) {					\
-		__print_once = true;				\
-		ata_print_version(dev, version);		\
-	}							\
-})
-
 /* defines only for the constants which don't work well as enums */
 #define ATA_TAG_POISON		0xfafbfcfdU
 
@@ -1593,7 +1582,11 @@ do {								\
 #define ata_dev_dbg(dev, fmt, ...)				\
 	ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__)
 
-void ata_print_version(const struct device *dev, const char *version);
+static inline void ata_print_version_once(const struct device *dev,
+					  const char *version)
+{
+	dev_dbg_once(dev, "version %s\n", version);
+}
 
 /*
  * ata_eh_info helpers
-- 
2.49.0

