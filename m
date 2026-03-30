Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D78191F98
	for <linux-ide@vger.kernel.org>; Mon, 30 Mar 2026 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883984; cv=none; b=dPfNHKmO2LspYA4PQ5Np13Poo61Z0XUFSqvhWxxHa6GFmhP3LN0UCgqQL52rdsEFkPC0iq93Yw+cxmTg8NqdrNgusmqYvedbD+MdTeBMVzncTMT9tF0VJEM8mrTXiwqeUnbkg04fWpNh9CwyDaWUIViz/uyz0FjwV3O4pvB66m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883984; c=relaxed/simple;
	bh=hu1YP51P/vjX2oOa/P/62qEWO0z3+lJ/6N64oZ27Mbc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=p/CV+3CJchQHgU5fuxY5TsNNraEZ0KSa0w02ke3GbLyeApO0GhP28AdlqGKIZ65KFgbrzVdoyXX6bukBBo9dZkjisnEiBes2SouCf05kdnJHTplcZ7w2PikstD2/3XXfL5avwXZIeUpktwcm5I8vQ0oj4+WMdEcCnKfNA8XMBS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh8MOCdp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh8MOCdp"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48704db565eso60301545e9.1
        for <linux-ide@vger.kernel.org>; Mon, 30 Mar 2026 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774883981; x=1775488781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gy0R9/04fPCu55njiskqJaVF+n5Mwa2jUo8Tkn51Nm4=;
        b=Uh8MOCdppcz2lwsmQ/WxcScyMGlInMDUXg6bpq23F1V1Ieq5aMX3RCDVcpTyH/uMPX
         FzLFGMe15FLmvwVIzRL1TM2ZNY80GIAM8Z/pKUmTHD6AQQXcevj1q9zOvqdJKpyQmW0+
         ozSb0hcDxz+5cXHLEOWIYF3BVmLjM/KZZDqiYGDeoG/cLfcDxCKDQx79l7HjCGXSECWE
         2mwHHqF/4qE4v9PBXwevY9Rxal5L5TNz1Q88j191fLE0PIr9K8DTaQBMIZGGK0LGjJit
         mmKmX1aYAK+tT1Uk2yicc+5R7c17hXZ9O/0WGZhBkKVo/0Q1TvX7urtTa389FqP5tAgl
         eKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774883981; x=1775488781;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gy0R9/04fPCu55njiskqJaVF+n5Mwa2jUo8Tkn51Nm4=;
        b=iv6bFrnTbrgVeG/MMIBoT3K1m8pMCs5oLPS6DqFrsuYVNBoSf4mhVvkog6dc2KP6Ze
         bRN6BCvwhs5bY2Dg8mlziGwcqazuydKu6f5xK9fep8Y7Pa2HY6TD7L90CRZEXWzwwfUl
         P1mi3eaGsASzyVveUkjKzx/PQKVnDskhAo9vYFqsZEUNHdDRVFA0QzWBhfDpFvO158ZV
         dEvCuirttS+lnKEzDIPZ9cDMu6aDgkvdJQYHllFoAdDgq/lDxXbrVNbaXV0ucefH9Hvz
         DqrQPm1+OdwbDAFr15wWPobfRS64ILKGsDMk1G/k6TVcbKdp8KvhfRNVuYbiqzSu1tBQ
         hhgQ==
X-Gm-Message-State: AOJu0Yz50WXIepVMMr83l4OGLdCoFTv6RR2wicYGkH4mx93m53Cmcfum
	AeZML6mvSnAiqYTS0SVVVRs3TZ0YIMyoJB1t0Ohc5q3I09c1bjAlkHzZYvVnVw==
X-Gm-Gg: ATEYQzwyNRV6GYb0Q8qlTJG2EcL+kc3gld4aULCyxqRWb5xKONVsZSfdN+bK0i8V7gz
	FRsfEN6+4D4QaJO1S9/bjkoikxYqjEdSVv+j+bSJ6pm2gtWTB135bkIgjM0aLzEYXbADyp6Mb10
	rhSWDuTnNDc6EDnZW4Goc8Ck5nz0U4O+pGRtraet59VvPunFA+MrFmQKLySFThmr/GyvUfLkMP6
	Y1Kgrhpif7nktAGID4GfUZ2HgpjqHdUHz46983EynQ2eBV8tgr7StWAdQFyiW01a4fdCFcunvSo
	lnLFsn/Z95dTf5oBNuGADaAQWrXVXKiDRFTUSm5hezR+QzwTQrgEPcmCVrPUX4ubHTZaC7+xULz
	SuvEi06ZeYBqg/yq1pNGDK5xG1vBzXiVQLhnknQUVzYkTFTPn/ikH+LchqP0YLNQM8GZqO6jLgi
	4x2RCPHFRGlo1ovh6dgtXK5W+UVZGOhX/DAxwPwzoM6Uk/8+yzG1UWFlff+csTVIU7HskXz6kE7
	puVuSZ5aomEbqyPcIL0H81FCGrcBIncDmUyYj+n4tIku+fVtLDoYVcAUlBya0GjUQ==
X-Received: by 2002:a05:600d:8449:b0:485:5981:1411 with SMTP id 5b1f17b1804b1-48727ecf47dmr169678805e9.23.1774883981322;
        Mon, 30 Mar 2026 08:19:41 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1a:ba00:c5ab:4ea4:3ed7:a674? (p200300ea8f1aba00c5ab4ea43ed7a674.dip0.t-ipconnect.de. [2003:ea:8f1a:ba00:c5ab:4ea4:3ed7:a674])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21eb95fsm21789439f8f.12.2026.03.30.08.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 08:19:40 -0700 (PDT)
Message-ID: <a0fbf4ec-cbd8-43e3-b52c-39eaf937052c@gmail.com>
Date: Mon, 30 Mar 2026 17:19:40 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/5] ata: libata-transport: use static struct
 ata_transport_internal to simplify match functions
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
Content-Language: en-US
In-Reply-To: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Both matching functions can make use of static struct
ata_transport_internal. This eliminates the dependency on static
variable ata_scsi_transport_template, and it allows to remove helper
to_ata_internal(). Small drawback is that a forward declaration of
both functions is needed.

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


