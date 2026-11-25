Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581453;
	b=HBkiccYLIoPNK3bKZs+x2pbzOfUSyHgK/Pg32Sh5n5i8aoVaf/jbShaTdwlRWJ+pttXY
	 61E6/Y/U2dvqAEYdAQ4ZCmEITaSblquUA4Zwp93j5nDJ3g/l9MU31B/5EOzHf8YPVH9yC
	 qlFgELSUAhD1UBGNsYStNV/QV+xXJblKnUk2S66KpaaE+eF02/mw92TkP1BRUHMsXCQxF
	 cVhGf0Ru4yhdaXsZ/Vlx3gV0qj9Lq3k9+rQVE9C1BaKhx9SVr4uHKPlmiWfcpy49/a/jO
	 NwT6R8EoirO5IAszhhkkZSt8IYQhuT1KaadvtGnJFnClbz1hufNhX2L5iMPSZepS79w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rkE7p4aQLSp2kYV7vRBIkJ3P+8n0i8bdfYVP4ePHIkQ=;
	b=xiYKB87F8dWrlU9uquwwC2YGOkjFue/UMmktrhcDGnDUKS3BkmelTjtnWL8mfXzk15ML
	 OAQZa8MUkNlYonZz67kf0u80Is4kPjEZlOYq5nHnca42WPIPoPG0XcgoGfQGOx4oRlj2g
	 5JtobAqBtwrIpvCqnAoD0McGyMa0jR/kRjf/RirhWK8GQ7A5NRYK5CiFmQ03Ah09uh7me
	 dE7vQRKxSru7R9/AtR1BO1x8ROdhoNVHq2/xHnHeoAk9VceV7sVG9k6fVkyP0cu3NyiFF
	 llenZVzGtXI9OBijUuOqLK9u8t7eqqROdbJl1T6MIpanCNfkUxhCNC5UjZg4U1xhfOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xTXrqdTe;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC9606A33E
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 04:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29CC9606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xTXrqdTe
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so3183970b3a.1
        for <linux-ide@vger.kernel.org>; Tue, 24 Nov 2026 20:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581452; x=1796186252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rkE7p4aQLSp2kYV7vRBIkJ3P+8n0i8bdfYVP4ePHIkQ=;
        b=xTXrqdTe+k1Bcn1+GxFlxR2ebQqsRT1M6j+6aYNb9r7mHlRo1fwWLDw4IySXue6Dcl
         KBC1LPnqdZpfI/A+9xmUzotNvieDwV3SMZ4p8tIm9TdJ8zO6mwFBwH3pm3xWXrevrabk
         K2w07uepa6D84x7VWDXgxWsceiGrwKmT0aobivANPe75XkwyR4R4xCcK1XmFWgM9LT2m
         x73zYmJNUkyLBfdibwDMgg04dO2Cn7IXlVfBYXZu8tF152ii0uqWAh3Mhxg0ey3JmFg4
         1fIS8fEaOY7anibxyTO+n5sgar3Ls0+2rGe3zJpPeCBNZofGyNj3rnccEVzZB4wgIeUh
         iCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581452; x=1796186252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rkE7p4aQLSp2kYV7vRBIkJ3P+8n0i8bdfYVP4ePHIkQ=;
        b=X1/mhtyI+dRsWJrUh6r/pOw8L5CtzvkB9Scc0fAeuqjj9OBoqB6G14vBA1o07/qi7k
         8kDfVXjbB/kyHE7LAmPY4++8eFrQF9VddcPi2QGXt91x6qwXJ1k7QxTt040yUrMQFeQv
         vFzsYXzdfeNMKoYG2SqSmhRjfsrwLiciPqM4rBxH9PjMUjJ2vIekUb2CxzSxR5ia4ant
         VXOlORvDHaf53uSNdADNSt1LHkRSQNPGQMsMb2IUFCCFsscscpx7u2uwjiklKMYONdal
         Cx5/7+PHaSK7lcfsV9FhnFRfguTwJvoE0RN/3upMOqI+v2q58mic/Hs5Fg84n6uJhXOB
         +mNw==
X-Forwarded-Encrypted: i=1; AL+hErGe9E2YxQD3+YtmKui2pv3eI7kYAZ0NhwWH4zm8TaDs0oZu94JZ6rE9FnE4rVyM6FXp5biClAkFKgs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/A8VxkvwIie23E4nfo7GuXXiypAe+KRmkOSdSLsliywLdjxwTy
	dk8GHJyzfogSZ0EoBeGOisY65QOdoZkFKD5kvdENcrKd1REjML/19WmY
X-Gm-Gg: AZFdTZcq1qRb7p/II+f+744kZJmKBERqqzponBe1pCZc3bwjrCXuDamvcfNaEet9bb7
	W8DjinfrHhLEaYMumRZ6IMAfQSFpyNo7aW64S3sNsZI/jnAKIL+cpbQZHcEGJNFFh4ZiFfhn7QP
	kjeJNcvwfSNL8090s8BiyGylN+tNEyGOMgvZ4v93FSbotTji0/2b2tDHqu/ViN3M6cvxuU2ckMn
	3qqpmP/PLSNQKn80JOJtRa6kyhHanwSz/mzsniiuz8nz2Mj1ix4HNMvFycWtZdIoiYWilfuZbN0
	dYZzCI1RR0hWk/693YWu/umDHx2Gm6M8Bo0Wyip7Q+5Ggl06NlReOOMjRlciXePsYoeQ/GHE3S4
	2l1Uh6HOdXV3eiM2r10f2L1LCyLb/p9v75qdoBs6AdWno9UK//sgAtR8/aUgi2FeYwRUd8LrBlf
	KJC1HaznX3DyvAC/Gd6CZlntLp9w5bv249fK9gxJTQwtwchQGjO7govd/l/dmafK1JOUnxN/Vn8
	h8wyKsQLZbdWgRtRWTXtuyY8h7RD/ie3Y3gRCL2y8LEhrWNKzjBlk5sk5lfpnsCf4vEtaFeuAI7
	X5HN2EmXRsVONLJSarbbf2VZUffoShEY3jQI1VthKLjfAWmJ
X-Received: by 2002:a05:6a00:4107:b0:89f:ed19:f0ba with SMTP id d2e1a72fcca58-8c7dd9d67bbmr11654419b3a.23.1795581452525;
        Tue, 24 Nov 2026 20:37:32 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1e2f3sm7882825b3a.54.2026.11.24.20.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:37:32 -0800 (PST)
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
Subject: [PATCH v5 5/8] phy: core: Add managed phy bulk data helper functions
Date: Wed, 25 Nov 2026 12:36:36 +0800
Message-ID: <20261125043639.249525-6-inochiama@gmail.com>
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

Add device managed variants of the phy bulk helper functions. So
the driver can benefit from automatically managed phy handles.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/phy/phy-core.c  | 139 ++++++++++++++++++++++++++++++++++++++++
 include/linux/phy/phy.h |  31 +++++++++
 2 files changed, 170 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 87a317a144b4..eeba1b899c20 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -1281,6 +1281,145 @@ static void phy_bulk_put_all(struct device *dev, int num_phys,
 	kfree(phys);
 }
 
+struct phy_bulk_devres {
+	struct phy_bulk_data *phys;
+	int num_phys;
+};
+
+static void devm_phy_bulk_release(struct device *dev, void *res)
+{
+	struct phy_bulk_devres *devres = res;
+
+	phy_bulk_put(dev, devres->num_phys, devres->phys);
+}
+
+/**
+ * devm_phy_bulk_get() - managed lookup of multiple PHYs
+ * @dev: device that requests the PHYs
+ * @num_phys: number of entries in the phys array
+ * @phys: array of struct phy_bulk_data with PHY names set
+ *
+ * Gets the PHYs using phy_bulk_get() and associates the references with
+ * @dev. The references are automatically released on driver detach.
+ *
+ * Return: %0 if successful, a negative error code otherwise
+ */
+int devm_phy_bulk_get(struct device *dev, int num_phys,
+		      struct phy_bulk_data *phys)
+{
+	struct phy_bulk_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_phy_bulk_release, sizeof(*devres),
+			      GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret = phy_bulk_get(dev, num_phys, phys);
+	if (ret) {
+		devres_free(devres);
+		return ret;
+	}
+
+	devres->phys = phys;
+	devres->num_phys = num_phys;
+	devres_add(dev, devres);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_phy_bulk_get);
+
+static int devm_phy_bulk_match(struct device *dev, void *res, void *match_data)
+{
+	struct phy_bulk_devres *devres = res;
+
+	return devres->phys == match_data;
+}
+
+static void devm_phy_bulk_release_all(struct device *dev, void *res)
+{
+	struct phy_bulk_devres *devres = res;
+
+	phy_bulk_put_all(dev, devres->num_phys, devres->phys);
+}
+
+/**
+ * devm_phy_bulk_get_all() - managed lookup of all PHYs requested by a device
+ * @dev: device that requests the PHYs
+ * @phys: pointer to store the allocated array of struct phy_bulk_data
+ *
+ * The function calls devm_of_phy_bulk_get_all() directly, but sets the
+ * @np parameter to dev_of_node(dev).
+ *
+ * Return: the number of PHYs on success, %0 if no PHYs are found, or a
+ * negative error code otherwise
+ */
+int devm_phy_bulk_get_all(struct device *dev, struct phy_bulk_data **phys)
+{
+	return devm_of_phy_bulk_get_all(dev, dev_of_node(dev), phys);
+}
+EXPORT_SYMBOL_GPL(devm_phy_bulk_get_all);
+
+/**
+ * devm_of_phy_bulk_get_all() - managed lookup of all PHYs from a device node
+ * @dev: device that requests the PHYs
+ * @np: device node containing the PHY references
+ * @phys: pointer to store the allocated array of struct phy_bulk_data
+ *
+ * Gets all PHYs from the specified device node, associates the allocated array
+ * and PHY references with @dev, and creates a device link for each PHY. They
+ * are automatically released on driver detach.
+ *
+ * Return: the number of PHYs on success, %0 if no PHYs are found, or a
+ * negative error code otherwise
+ */
+int devm_of_phy_bulk_get_all(struct device *dev, struct device_node *np,
+			     struct phy_bulk_data **phys)
+{
+	struct phy_bulk_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_phy_bulk_release_all, sizeof(*devres),
+			      GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret = of_phy_bulk_get_all(np, &devres->phys);
+	if (ret > 0) {
+		for (int i = 0; i < ret; i++)
+			phy_add_device_link(dev, devres->phys[i].phy);
+		*phys = devres->phys;
+		devres->num_phys = ret;
+		devres_add(dev, devres);
+	} else {
+		devres_free(devres);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_of_phy_bulk_get_all);
+
+/**
+ * devm_phy_bulk_put_all() - release the multiple PHY
+ * @dev: device that wants to release this phy
+ * @phy: the phy bulk data returned by devm_phy_bulk_get_all()
+ *
+ * destroys the devres associated with this phy bulk data and invokes
+ * phy_bulk_put to release the phy.
+ */
+void devm_phy_bulk_put_all(struct device *dev, struct phy_bulk_data *phy)
+{
+	int r;
+
+	if (!phy)
+		return;
+
+	r = devres_release(dev, devm_phy_bulk_release_all,
+			   devm_phy_bulk_match, phy);
+	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
+}
+EXPORT_SYMBOL_GPL(devm_phy_bulk_put_all);
+
 /**
  * phy_bulk_init() - initialize multiple PHYs
  * @num_phys: number of entries in the phys array
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index c170d9aeeeb4..a51b3c283efd 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -326,6 +326,13 @@ void devm_of_phy_provider_unregister(struct device *dev,
 int phy_create_lookup(struct phy *phy, const char *con_id, const char *dev_id);
 void phy_remove_lookup(struct phy *phy, const char *con_id, const char *dev_id);
 
+int devm_phy_bulk_get(struct device *dev, int num_phys,
+		      struct phy_bulk_data *phys);
+int devm_phy_bulk_get_all(struct device *dev, struct phy_bulk_data **phys);
+int devm_of_phy_bulk_get_all(struct device *dev, struct device_node *np,
+			     struct phy_bulk_data **phys);
+void devm_phy_bulk_put_all(struct device *dev, struct phy_bulk_data *phy);
+
 int phy_bulk_init(int num_phys, struct phy_bulk_data *phys);
 int phy_bulk_exit(int num_phys, struct phy_bulk_data *phys);
 int phy_bulk_power_on(int num_phys, struct phy_bulk_data *phys);
@@ -603,6 +610,30 @@ phy_create_lookup(struct phy *phy, const char *con_id, const char *dev_id)
 static inline void phy_remove_lookup(struct phy *phy, const char *con_id,
 				     const char *dev_id) { }
 
+static inline int devm_phy_bulk_get(struct device *dev, int num_phys,
+				    struct phy_bulk_data *phys)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int devm_of_phy_bulk_get_all(struct device *dev,
+					   struct device_node *np,
+					   struct phy_bulk_data **phys)
+{
+	return 0;
+}
+
+static inline int devm_phy_bulk_get_all(struct device *dev,
+					struct phy_bulk_data **phys)
+{
+	return 0;
+}
+
+static inline void devm_phy_bulk_put_all(struct device *dev,
+					 struct phy_bulk_data *phy)
+{
+}
+
 static inline int phy_bulk_init(int num_phys, struct phy_bulk_data *phys)
 {
 	return 0;
-- 
2.56.1

