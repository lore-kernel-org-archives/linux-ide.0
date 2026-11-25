Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581456;
	b=as3TPXgwrWYD9nu5ePH0Bp6off6CYZ1KXCD1qR1j3gx0ZreD5ghOVcvxZ+SKp2H3GAfr
	 YLgWR9tkA+0fqAiuDK6/0M9Eje5yNDoZlRKpKqdqzWy2zgv4R2Lo95kmVr/CTocTYhLRk
	 TMkP6yC9I92qlOElJtR2B/nGphlVyXobQYIj2s6/9r7FozifCXc1LCANLyrAFwrydyO1f
	 O2neIJxOT44lbyItmyQK8jOEXZ3IAV/UeG+bq1Oerg/QVSNtWKTwSmMCvfCwenEpEjUNC
	 FJIkWdE0QHmudvDkRba2hdNvcMyEC0wXtvIcogwQkHxiZrIzzWKAMr9tLtZZ5QBI9eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ry895IeeCwvvoVrLKPY1qGl5vh7XehrgPQ0oBew1BlU=;
	b=C7TYuVTc7hFEvqsbD93ggWfU9fftQ5OIly3uHC5SPExiZIkNtOLocD+RSHTYIZoHKtn2
	 Ktczu1Jr9M3Cx/+QJPBOwOboWW3+WJyPKDxv6nqm1zuNWFl0KZ8KN84ZDI1znVMoeF15C
	 DitQyfMBo60W2H+cEAc9zuc05kbkzy+btY1U7zRBF9dvbgVseSBVwJzYtwuOD6kB3b9uB
	 x+kTBfCRAukKihnGTepRwip5VJM150X3Tcek10l73wrHy9k39aw2wpDGr/0Iuo2qByQIf
	 c+Uuc7gIZqUUqEGAOhLgovENet2vz/xwD1F36fdkNbYTvnhiECWW5lu3+C4XlJ9W70Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wr1g3rtd;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35110606A333
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 04:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35110606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wr1g3rtd
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b612fd74e1so1777048b3a.0
        for <linux-ide@vger.kernel.org>; Tue, 24 Nov 2026 20:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581455; x=1796186255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ry895IeeCwvvoVrLKPY1qGl5vh7XehrgPQ0oBew1BlU=;
        b=wr1g3rtdkM1+iqfuEpAmW2uI+mDmxkhSbZUiHOjNGeXYWtGHcIpm0T5xgOIxQQO6y+
         U59F7Ek6tl8AX+VqB01IBuq2pW6ZMPiryT3UBENNYfv6S5IMIW042XtKvcoGUj9cAFBt
         IHwGOuSNPp51RYHkspBjfvXMUWOL6qRntcTaduvUm3TaglWRPtcfjvJ5t24ZWMvrhQ6E
         9TBkjFdjAn9+5e3/2jRO/4Kyd1QEfCNZq71N4/f23NClZF/8bXp2hRGEdEPcrJBJRjge
         8slxvAWhDcRyMFBox42yrr4HCHu9s3fLIkdYqGTXSGLvVGkog2A3x4MX5SwGT2fh0pkd
         gFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581456; x=1796186256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ry895IeeCwvvoVrLKPY1qGl5vh7XehrgPQ0oBew1BlU=;
        b=aXd8xq+9o++5W+hHIYEjty7Yo99AZLPvmUm0SvXrdiGZ5a+WDC3w6C9PfegZxQ51U/
         9WqoEo492wZG8PwsY+tOR2jGpGGNYBIzK7Rb3+7aIuMXSYDb+8PNldTu1LjuWcqemDZh
         hgJpat255UN/mZchrn0dFlhkqPpjcAiim/v2zVDnNdoyi+Wt1cuaAVPMUyRdl/OydSca
         M0tcSTy7xS4XDEFhoTVYsaOQjSO4jyD4aRBqa0dUf1OdlvBiVGrFn7x9aCIJs9T4uPtP
         KQqfPhIkOFsHlf/E8TApjbNtn+FtFwa9G03/hjadPU3DLWnbuXpjM/WjuzD8gf4LYSpa
         +r8w==
X-Forwarded-Encrypted: i=1; AL+hErFXdRsJouiwB0SHfGWOY+hg4UE8wwcjAtm5kO6SY9hJWOQJNJfDIP41okG7hzmm9xieXZkvXURduaA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Vpx6sPB9e3welpeikonbXsF/NxsooNm0eXRW2Mhvdrjc9yogS
	yBzg20F4K5beANd1cqs4Jnh5gEKw91r5qnyP41zRvmxN3rm1Mu/nvuQI
X-Gm-Gg: AZFdTZf1tIZuXPt58/WJiKwvy902FC7AmTxP7PQNE+1aktAhvEgrPi0TgDG9bbNx0VL
	5Hfdn44mPF6tnXWL5Dra0gIi7KuX2fWhu0XzA7/HTf27ODcyLWutkSoZFsmw+Ul10Sf//tVCoYx
	+Zlkuf2TQyKwkN6kijKi+Y4gg5Tr3Ri7McOYSYA15ZfdS81669AdTYA12LRPIFV8Tsr1jAIpVo8
	ExrGVVzXO7J9d1ROEXEanLzvYyLuLlPfWbDJuZzuy7fAjohbWZhNse5wGxZTP35g6ik0MpOXess
	qe7tQPPhaaYw1n3MJNuyB4XnpOKoj7bvEYJjIwvEfpWimOIFB/TvDqo520gf76Ml0yx2d0irOth
	84yFmSHu9PEPnRVORTi9gyS87KylcdWRZeuoEJInICVxuexQqI8/DwevB3T7WMbm2x3uO0ha5oB
	5zNEKW90EUfOxlrIYBU9ocMaJMD3Wnnb4xQ7u3f+VPjKNajc6ND6MnZfFPqllsikSnoI7rxCCEj
	I6Vnqb6DmQ6LDo3cF5+WajgKVxKj83nmSwLSFEQRDkcsbhq7MRi6tX8ccpvztEl6QPFWhFgSIFy
	AMf8zrPcNclNp3gE4jPfGfpinis=
X-Received: by 2002:a05:6a00:b92:b0:882:6d80:e5ad with SMTP id d2e1a72fcca58-8c87bcbcee9mr14392696b3a.9.1795581455547;
        Tue, 24 Nov 2026 20:37:35 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e45eccsm8215994b3a.31.2026.11.24.20.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:37:35 -0800 (PST)
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
Subject: [PATCH v5 6/8] doc: phy: Document some bulk helper functions
Date: Wed, 25 Nov 2026 12:36:37 +0800
Message-ID: <20261125043639.249525-7-inochiama@gmail.com>
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

Document all newly added bulk helper function, it can be used to manage
a set of PHYs automatically. This is useful when the driver want to
simplify the management of multiple PHYs.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 Documentation/driver-api/phy/phy.rst | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/driver-api/phy/phy.rst b/Documentation/driver-api/phy/phy.rst
index 0865c2e94eec..cae3d4700814 100644
--- a/Documentation/driver-api/phy/phy.rst
+++ b/Documentation/driver-api/phy/phy.rst
@@ -114,6 +114,12 @@ it. This framework provides the following APIs to get a reference to the PHY.
 	struct phy *devm_of_phy_get_by_index(struct device *dev,
 					     struct device_node *np,
 					     int index);
+	int devm_phy_bulk_get(struct device *dev, int num_phys,
+			      struct phy_bulk_data *phys);
+	int devm_phy_bulk_get_all(struct device *dev,
+				  struct phy_bulk_data **phys);
+	int devm_of_phy_bulk_get_all(struct device *dev, struct device_node *np,
+				     struct phy_bulk_data **phys);
 
 phy_get, devm_phy_get and devm_phy_optional_get can be used to get the PHY.
 In the case of dt boot, the string arguments
@@ -129,6 +135,21 @@ Some generic drivers, such as ehci, may use multiple phys. In this case,
 devm_of_phy_get or devm_of_phy_get_by_index can be used to get a phy
 reference based on name or index.
 
+The bulk helpers are useful when a controller operates several PHYs together,
+for example the lanes of a single PCIe port. To get a set of PHYs by name,
+the driver supplies an array of ``struct phy_bulk_data`` with the ``id`` of
+each entry set to the corresponding PHY name. devm_phy_bulk_get() returns
+zero if it obtains all the requested PHYs or a negative error code on failure.
+The driver owns the array and keeps it valid until driver detach, when the
+PHY references are released.
+
+When a controller needs every PHY listed in a device node's ``phys`` property,
+devm_phy_bulk_get_all() obtains them from the controller's device node.
+devm_of_phy_bulk_get_all() does the same for an explicitly supplied device
+node. These functions return the number of PHYs listed in the node, which may
+be zero, or a negative error code on failure. They store the allocated array
+in ``*phys`` only when the return value is positive.
+
 It should be noted that NULL is a valid phy reference. All phy
 consumer calls on the NULL phy become NOPs. That is the release calls,
 the phy_init() and phy_exit() calls, and phy_power_on() and
@@ -149,6 +170,14 @@ The general order of calls should be::
     phy_exit()
     [[of_]phy_put()]
 
+After acquiring a set of PHYs with a bulk helper, the order is::
+
+    phy_bulk_init()
+    phy_bulk_power_on()
+    ...
+    phy_bulk_power_off()
+    phy_bulk_exit()
+
 Some PHY drivers may not implement :c:func:`phy_init` or :c:func:`phy_power_on`,
 but controllers should always call these functions to be compatible with other
 PHYs. Some PHYs may require :c:func:`phy_set_mode <phy_set_mode_ext>`, while
@@ -172,6 +201,12 @@ PHY framework provides 2 APIs to release a reference to the PHY.
 Both these APIs are used to release a reference to the PHY and devm_phy_put
 destroys the devres associated with this PHY.
 
+For devm_phy_bulk_get_all() and devm_of_phy_bulk_get_all(), driver detach
+releases both the PHY references and the allocated array. To release them
+earlier, use::
+
+	void devm_phy_bulk_put_all(struct device *dev, struct phy_bulk_data *phy);
+
 Destroying the PHY
 ==================
 
@@ -221,3 +256,8 @@ DeviceTree Binding
 
 The documentation for PHY dt binding can be found @
 Documentation/devicetree/bindings/phy/phy-bindings.txt
+
+Missing Bulk Helpers
+====================
+Currently, only a few bulk helper functions are added as they have users.
+Function not upstreamed can be found at https://lore.kernel.org/linux-phy/20260904083709.425893-1-inochiama@gmail.com/
-- 
2.56.1

