Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581444;
	b=m2wYR3ZLuKm+/phsY76m460VMwNjh7+HaIHN2yxa7yw5ZAnYXmyynBdjjn38iqrru/no
	 sVJSiMQCCnIBvLM4yub/9+xW0Dgkwiw32yLwk9aM+cW1W7jTya+QZonh0i+ZeaPkIA8DC
	 0yjqxOpvbxd8g28f2jKYD63qkl853g2Rl78tHXY9OCc6OmmXQlQzZKkNZiZetAkB0ROyv
	 U1mu74enhg+6FeczHsIwhZUG51rY+e6yN/DUWMaymy3+8fYocQr+iIaEvJqbFpY1dekP+
	 hGfmJuG9Km4IUSo/OJhN/fzvVTc0Exa2VY+yE/kMUSTMQjbSrxhB+FeoL5z2NAx5cUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qTrL4/9jM8t7yAmF2IG8ye/8M/WX8AYVFJWYbaSsj7w=;
	b=vRVE99WRAPgmDHZgmBAT9rcpVARe5vCcbkphFalHuJjtNkA0O3mr7ObyNc6EN9jCONm6
	 0m1cE0Bh87U+XlXxfVVszfBulY92SVnDVly2JS9fnUHr5wBt46c05VOkhr9CQupqFYow3
	 h0tYGgHUzXCwJr7Ju/z34nvbfhw/DqTeCahwXvaZEp5WWn5kTelqqcI5zJLbpph5XixKH
	 a+wfECbZvg52dQOozd933o6h0cgIEx1MebOhvL2i31HLARbGbY8rLiv5aKN1aoiYmx0Pp
	 w0xcgZDKJvIpt4jZi4K5UdnBRd4YkV1vqcQJWrGzfpi4IwQ4jIfvCAQb3pj9YDzI+hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zl2LdTZJ;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42FD606A31E
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 04:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D42FD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zl2LdTZJ
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso2745038a91.2
        for <linux-ide@vger.kernel.org>; Tue, 24 Nov 2026 20:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581443; x=1796186243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qTrL4/9jM8t7yAmF2IG8ye/8M/WX8AYVFJWYbaSsj7w=;
        b=zl2LdTZJvzjYeXoBL11zTugaiOLJLEwcFS2St1GqlBwLIIg6g32uPC5zkdlTXb3BMt
         2YE+TaHhA9rYBHeHDF4pVtmumcMAtgq8SKAsyRJW4AkFiWuWMCm6SeCqH8zIOJw4ODFm
         1IUwVkIrx0y5RCVw0Pi2TL8dznaDGykq8P4uk64xFAF6zVtryvgXR605Y9fYGKOw39UB
         /zOjk49Krr+7YvtdG1YGcRhqqRO45eyM3p1TBCLN81NMnPCVbz+/2sNE6O7mrv91uPFg
         UkPfq0rFSr2FRsiY6gp4aSv9qzASxCGJXb6p/todkLnag2/d5IkUQ62WNyLiOY50tvfD
         +oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581443; x=1796186243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qTrL4/9jM8t7yAmF2IG8ye/8M/WX8AYVFJWYbaSsj7w=;
        b=w8nTudzCWlssLYfn5si8U/L8uXjWniL/L/muuYhK+d/cdZ3KNVgAeDV4nh1LmnquHm
         P152YZdp6XxGbwVdf3gexoEgSPyoozciCWda5ga1x27qxyFWj45vuF1b7oVHHgieU6jE
         T3Icrv8yIR4aDRfpvUbuak2C5rrFzwc4UdFktPo/9SQzqx64rWlFgt2Eas+JGVJRKiWV
         AHSfyqydyKsya87xdvDpZw7mfD+ITdc/qcuhBx2VtodND5j07/1qES9XJy+O4Ken8b4w
         xWU0CMxjOyZIYdTPHtmQvwz2BTOvrJIfLlIiv11gP+YEqtT4sGC1oRXFsgQdn79B/8S0
         bFXw==
X-Forwarded-Encrypted: i=1; AL+hErElWAufhv8uxvMlj10oINpPHyI8hS41Jsz0/KVYASLZoJEDv0rOScCB1agNiJxetbd8Pw4srHSXtzM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WTEn3nQ0jwFVKb7Dii3xA2DsUK7xya55SUKgid2g/q4YVT1U+
	LftNCynprvpUqin1hkDkwUCdlGwP5wh1gqEHUBICIb6fsbIhB5AdDTDS
X-Gm-Gg: AZFdTZdsg3xsJmXmWFrahJmS8474K4XZnArVVuL2Ipw0yM7f6lWL+ajBi8BT31rn383
	L+0D6cPRJYWOK91wy6Wt5joKJxuZao2paj4bP4Kd30t1VlMVHPPHUIfqhACRvmJMpemcCvq6Kzo
	kBHs+OBQZNiXaBouQQViW/8k2zIl5owjHekmmpJykKIN9WNth06w3mBX0xlig5lVK6OLsfyWgnR
	Vcqeo9Zvm92BJb6Fu7ejameaD/orXyGzKVAXEge2zEOsQS+GryCbinRU233cdUNgLkLTbZ702AO
	jXbb/k6lK/0OTS9vaGMvCQNjfvOLIh+9KatwaXMmUghBAl5iQNhHO1YZzRlUc6migaKzwYXQUaf
	N70tHhJkr938MYi8eLP7tHhA6uXN2XIEF28s7oW3fLq95tKDgAuB+ql3KyCHjoY0nPUs+pnjiJV
	Ahik98dMS4A36jroZw+yUaRhMRUE6WpDRJ0EJS/gzTzx3ywzfV5wr8m6WAPUhWdHdQZ/UNapN1A
	fv3zOqZKFUB1TejdEHAEfCqeuXZRFSgIAfeIsdJwsixtbwN4oUYca0BOb1CLQUg06yFk68LYvMO
	CDintknovd3NOdDbiOERB5Kj58eEquSRB2ibWRncR8dkBQHz
X-Received: by 2002:a17:90b:4c0b:b0:3b4:12a9:2e1 with SMTP id 98e67ed59e1d1-3b41c931d36mr16931812a91.33.1795581443120;
        Tue, 24 Nov 2026 20:37:23 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm26615594a91.1.2026.11.24.20.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:37:22 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aksh Garg <a-garg7@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Rhys Tumelty <rhys@tumelty.co.uk>,
	Manikandan K Pillai <mpillai@cadence.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Hans Zhang <18255117159@163.com>,
	Yao Zi <me@ziyao.cc>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 2/8] phy: core: Add common helper for get phy phandle by index
Date: Wed, 25 Nov 2026 12:36:33 +0800
Message-ID: <20261125043639.249525-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125043639.249525-1-inochiama@gmail.com>
References: <20261125043639.249525-1-inochiama@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two phy helpers use index to get phy phandle of a device node,
add a common function for the future reuse.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-core.c | 57 ++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index b7550ca37e66..efbd7e139dce 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -697,38 +697,55 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 	return phy;
 }
 
+/**
+ * _of_phy_get_by_index() - lookup and obtain a reference to a phy using a
+ * device_node by index.
+ * @np: device_node for which to get the phy
+ * @index: index of the phy from device's point of view
+ *
+ * Returns: the phy device, after getting a refcount to it; or
+ * -ENODEV if there is no such phy. The caller is responsible for
+ * calling of_phy_put() to release that count.
+ */
+static struct phy *_of_phy_get_by_index(struct device_node *np, int index)
+{
+	struct phy *phy;
+
+	phy = _of_phy_get(np, index);
+	if (IS_ERR(phy))
+		return phy;
+
+	if (!try_module_get(phy->ops->owner)) {
+		phy = ERR_PTR(-EPROBE_DEFER);
+		return phy;
+	}
+
+	get_device(&phy->dev);
+
+	return phy;
+}
+
 /**
  * of_phy_get() - lookup and obtain a reference to a phy using a device_node.
  * @np: device_node for which to get the phy
  * @con_id: name of the phy from device's point of view
  *
- * Returns: the phy driver, after getting a refcount to it; or
+ * Returns: the phy device, after getting a refcount to it; or
  * -ENODEV if there is no such phy. The caller is responsible for
  * calling of_phy_put() to release that count.
  */
 struct phy *of_phy_get(struct device_node *np, const char *con_id)
 {
-	struct phy *phy = NULL;
+	struct phy *phy;
 	int index = 0;
 
 	if (con_id)
 		index = of_property_match_string(np, "phy-names", con_id);
 
 	mutex_lock(&phy_provider_mutex);
-
-	phy = _of_phy_get(np, index);
-	if (IS_ERR(phy))
-		goto out_unlock;
-
-	if (!try_module_get(phy->ops->owner)) {
-		phy = ERR_PTR(-EPROBE_DEFER);
-		goto out_unlock;
-	}
-
-	get_device(&phy->dev);
-
-out_unlock:
+	phy = _of_phy_get_by_index(np, index);
 	mutex_unlock(&phy_provider_mutex);
+
 	return phy;
 }
 EXPORT_SYMBOL_GPL(of_phy_get);
@@ -1001,20 +1018,12 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 		return ERR_PTR(-ENOMEM);
 
 	mutex_lock(&phy_provider_mutex);
-	phy = _of_phy_get(np, index);
+	phy = _of_phy_get_by_index(np, index);
 	if (IS_ERR(phy)) {
 		devres_free(ptr);
 		goto out_unlock;
 	}
 
-	if (!try_module_get(phy->ops->owner)) {
-		devres_free(ptr);
-		phy = ERR_PTR(-EPROBE_DEFER);
-		goto out_unlock;
-	}
-
-	get_device(&phy->dev);
-
 	*ptr = phy;
 	devres_add(dev, ptr);
 
-- 
2.56.1

