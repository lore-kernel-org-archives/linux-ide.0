Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042298;
	b=t/oJq3I5s2zhUwxF3CZPUeaAVOe7+hCkNhBXqGCQTBNc3W6A6oiTPywvPM5uCXjZxARz
	 uewNCIqwdMI9cSaXI/PGjuKWPIfdBHY2nDy2+sHY4vJ00md3ZDHmIMfj0aM3dTOh17VaE
	 1MHepdTz6C5y6K+DOoBcKbTRvUO6xJukhwsB8coLjM1STMKeYPph9rHO2bwyW0e2Qxv0w
	 UryQsgJiRLTOUP0jO0p5OkBA+1kv9DCF45jhqMUdPDM7t5O5ho3uI/M9SJ8MWa4uPugtx
	 ICVH4uVBr5+b1a6+TrHD7+rcgM02e74nXz46FTXHDMRmBh7leQNRhLbjWOxfSbEoxQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042298;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=LpNaT8q0SGvIEMd/N1soAJa02WC3uqlIifzAi5jpoGQ=;
	b=G/kM/SE2euWv2rAxoDU7dfgBPa6fVFlcyusAbvkck82VncyyBkbGPea9AXcmfuSEba1C
	 lB76F2wntiQ2N0vAzlehVE7r6GO1k6QWrs4jpMQLZuaEGA/KeXds6FfYWpaVDmfup226J
	 aRSFxnB1fWJDm0+yVUCkIUMenaJxDpKSp7mBhIGpSg5+z7UoeakJyyywUidQpU+1/RCk5
	 qz0OL774KX4iOvYYGy7qmiJ6/HAJSW+xw3+n31wtLsW9MdWJKnlUh2Ds716Hx5ucxbP2q
	 1T39FspN3FZ68X45ohE3kOP8ez4VG/1M/dvSg3JXl3E1gFJYr9vQfaIJYBDjo7EMWkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=S4MriBoQ;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAAB60A2606
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 19:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DAAB60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=S4MriBoQ
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso2644758a91.1
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793042298; x=1793647098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LpNaT8q0SGvIEMd/N1soAJa02WC3uqlIifzAi5jpoGQ=;
        b=JPDmqIAissPGNOwgNqiLlDcMMdauDUd7CWKwpLgS9q5xDMxGab0gjAgOZg7kPRgscV
         DnruuVi8N2stVSc14fDims04RsEZWpIB1NcJ+Cgo9M06CURoAWx5eGQVUJHkp+4SSyLy
         AyKrDXP7d2t3zuSapwRmwSG16T8RG7KIbgMZ0KiVC7ZTyRNeGp+5kiLkrcX3c5hZBpCK
         lyTn75p/jst2o2XdSwmjS0j/1+acyl+ezzbhzCjEeWu7vd3xlS9tIVSUAsJuldRlFLia
         Q85Geh7UFVAUw8cCM4O7oH+G9CM8byqXSa08xF1SnbRaZmIqlr4pEulqNQVNgr0/7AqM
         wPHw==
X-Forwarded-Encrypted: i=1; AKwUvBzr+h/yZsS0zoUYEhJU/3IidNJFJBinm8Rf1262QyJOtbuVT9sCAK9p0MiUGiltzM5qNvDlL8owHgM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHCzgb7wog7ktgXLPdSaGgV/7/M39r9u/yYCCUoPq5Kf23gmS3
	D20iMf+VH8siPCnmpdsPziaymbS1SODwogkx55q5zjPHYl8z2T8IBDLe5LIAY+1EynpdVoWAsjS
	KJj+cxm9dE6TbDM49pa/3G4UZuY4uZurV0mvr/EJ65Q6KPnlNXA6bgjk1emAvEusBs+0PeCzyF9
	RyrzxN+DwkKz+hNYsv6i5YnXyEwaj41BdnQnDM+PMTFT9U/m3dSqJ0hD133USODA5e5DVqpV7Q5
	juL977a/dazNR+CZt3ma1c=
X-Gm-Gg: AYBFou3YmpvWWYrQc2lTAYk8FACJM2K38qHR8dDMzIhR3hTI9pAaKzRi3QJiwLC2FWT
	l7PwM/Ul+31neH3CaadQzC1/GxdLQerNXIRe1a4eYe+xVlyMcD2g/hmyOba2mh+R2XqAX0UIvSD
	apQAaQegCp7XYvhbjGYYWQcPk05agr9beFBOiN0EE7pCjM63ClhO4CJT9ZUj0GW6mWuTW0Dg4vU
	zkvSKuhCd45s6cfmC5uTP+4eRExIvH6JFnqI3V5EDdqqV4CLFWKnR7rhgghgNy+UOp3rXXGLLk7
	AYAJo3Rz6Z/xax5juISoKAy+/pElFn+lkGGA5m80P2D/yeQmQNGrZnKqOxafojeWf2yUTK8+Ahl
	DDTYfT66fZFrYHn1fENCCXwcxkXj3xCcBQ9mNK08hp+6gewla8DWuIRyUvAOIqepEa+iskwVfHW
	inMMu4y9ChNkk5GLf0WrOsta2vUGaip1F8FvMMmCk5
X-Received: by 2002:a17:90b:3e48:b0:3ac:9a03:20bf with SMTP id 98e67ed59e1d1-3adeafd64cdmr7275406a91.55.1793042297849;
        Mon, 26 Oct 2026 12:18:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adebb1a534sm3447447a91.4.2026.10.26.12.18.16
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 12:18:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb98809caso608266085a.1
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793042296; x=1793647096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpNaT8q0SGvIEMd/N1soAJa02WC3uqlIifzAi5jpoGQ=;
        b=S4MriBoQogvcAb9W58quK4VocXvh1bDHpCJk3q08cXXexUn3fBk434Wg82+eNpQiby
         yFHxjeNQuy/NgTN4tvwsUt88ezHzUJI9mIXBj06P4LjtBjOhipbyCqaRQYWkuP2cv40c
         tZGDBmIj/X4B9gh/8VwWDu/XTmG2lT6GdJLDs=
X-Forwarded-Encrypted: i=1; AKwUvBzRz9e9YtOAkxIA2CBPaKBc271YU08nkOgu7krp+nUUrWZU6Fn3MFqz156BR9gs4AyzoMXY67wQE80=@vger.kernel.org
X-Received: by 2002:a05:620a:4487:b0:93c:29b3:3525 with SMTP id af79cd13be357-940ef8e9ad7mr1116010985a.36.1793042295604;
        Mon, 26 Oct 2026 12:18:15 -0700 (PDT)
X-Received: by 2002:a05:620a:4487:b0:93c:29b3:3525 with SMTP id af79cd13be357-940ef8e9ad7mr1116005885a.36.1793042295194;
        Mon, 26 Oct 2026 12:18:15 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c62063dacsm33430996d6.37.2026.10.26.12.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:18:14 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>,
	linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM ARCHITECTURE),
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH v3 5/6] ARM: dts: broadcom: Use noncoherent SATA DMA on BCM958625HR
Date: Mon, 26 Oct 2026 12:16:17 -0700
Message-ID: <20261026191618.3178830-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026191618.3178830-1-florian.fainelli@broadcom.com>
References: <20261026191618.3178830-1-florian.fainelli@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The AHCI controller on BCM958625HR fails with the dma-coherent property
inherited from bcm-nsp.dtsi. Soft reset times out waiting for the first
FIS command, subsequent engine resets fail, and the disk is not detected.

AHCI allocates its command tables and received-FIS buffers with the DMA
API. Declaring the controller coherent bypasses the cache handling that
these buffers require on this board. Removing the property restores
hard disk detection and operation, as confirmed with a diagnostic DTB
that changed only this property.

Use noncoherent DMA for SATA on BCM958625HR, matching the downstream SDK.

Fixes: 56e2ff0346a3 ("ARM: dts: NSP: Add dma-coherent to relevant DT entries")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm/boot/dts/broadcom/bcm958625hr.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm958625hr.dts b/arch/arm/boot/dts/broadcom/bcm958625hr.dts
index a9b6aa04d573..53acae385822 100644
--- a/arch/arm/boot/dts/broadcom/bcm958625hr.dts
+++ b/arch/arm/boot/dts/broadcom/bcm958625hr.dts
@@ -182,6 +182,10 @@ partition@700000 {
 	};
 };
 
+&sata {
+	/delete-property/ dma-coherent;
+};
+
 &sata_phy0 {
 	status = "okay";
 };
-- 
2.53.0

