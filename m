Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC71802B2
	for <linux-ide@vger.kernel.org>; Wed, 17 Jul 2024 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210781; cv=none; b=Svjp+ol4wSPSu0H11gpSkN24R3+VYuGA4zMPJkWxGNZs+1jREB6LW0Og27vUipC+jgRSOp1RhhHXiIwoNhyUE/Dut79WbYsnNkerhtzQOVUKF8Glxr3G1VST4bb3t7nIVA5LklUULAMShPpbN7+qcvZ2ClrdyyXn8mCOZtK/a4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210781; c=relaxed/simple;
	bh=NPsqQscMuW5YxdzEEbmIthLqN/ch20zn6EmqZT04SCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGQswzQt+xo7/+8wzp3fiHZifCCWcoYluzv4sDk4BwZ8HzWm9VSFImKRpFd7J45MiFMVVsYMp21GMgjY0V5jDfLK9htDlzMTCi6Q5AWqEfUDYxia6JOurnJ3oLP+icjdUv6H7Thp0nkHuAOOhDHMLUcYR1gdxOHhfkHUsEiughQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hH22ulwa; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hH22ulwa"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ea79e6979so7586916e87.2
        for <linux-ide@vger.kernel.org>; Wed, 17 Jul 2024 03:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721210778; x=1721815578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUM4l7NxU0k5uScQq8IEESiLEEWEEaqTyJJqCnIfkQU=;
        b=hH22ulwaOECnt+ra2JgoxXxF2fB/WkhWD2kyjH7laUqwX4VuE4SbeFFAf+nDg9SNj6
         LWf5onKSf01d0UXZyVBugAWTATVgFdkASJQC08s+TMzCL5B7pcDuT8XxdvSr1H0JKoSI
         ES7r+zpxtVJ3brMfmY1nP8eYEnOC1toMOIsOuNE1909zvNW5c0fWa+4dDb5e2AKLWHra
         8qU2177WIu48e/ckY/A9NOMFNKzWMmDLaKMoZc68KxLXPiWsJwr8O0d7eKuQNTLZsuh9
         tzYJAKgCMH9fgMhwoLLqycJAuDWaMd6KmaJiuhUPkTwphcLw2XIKpP5oJYVOI4Wuye85
         +tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210778; x=1721815578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUM4l7NxU0k5uScQq8IEESiLEEWEEaqTyJJqCnIfkQU=;
        b=AI5XCpDzmNhYCHlHdEt9FTJ2FU+fYcqLn8FncaoqWaTHxvbVIhv5k4Ah1wscQjk7vm
         hjHcjiy+jxo0z5skBFf94zY+qKpzC5rXVyMmGzAUqZwvIQ0gUltf1BbxY9qumo9VY7Up
         EXxq5gfTViWEgjh2LUfCBw/AvenyyFddawPqhnpMMpnJNLXGHA5nwPfeOTF5tAIxjO5c
         Q6UAJqjnBikpAjhhOxRr/KvtK/K2KxGp5+cBJLo+O+74P7iQXDFI6J2+sn0XpzG+UvKe
         8BeOH/WsPRgegeAj7EkoCFPVvH4oox929TJJ4WyBx/rDzQul9sob+zsUsd+cQNozd7rN
         4nQA==
X-Forwarded-Encrypted: i=1; AJvYcCW1lEcXwPu9vF7/2gSJZJLJk0uXFREhhWAn9K69kNaQFbRmxoxd1HGcLnfks23gw2o26U1MEoI71wFt6mifnjactinmTFQdiYXO
X-Gm-Message-State: AOJu0YxP39ftliENwEIO6cOLVCEvKQOFr8VgmnGIg8gsYa0lSTc6MePU
	1Q0o4Ok2DDcewvssdBqMMMj4l9utE8ZSr/O2S5LFl9MnzFU0a0ydjzpC797RIaE=
X-Google-Smtp-Source: AGHT+IEe4yKshdC5XE+lx/x85DHFDZdE9loIV36IpUydrc0hetViduQoJf0hlM7zxq6mGlyq62Jz/g==
X-Received: by 2002:a05:6512:10c5:b0:52c:e180:4eba with SMTP id 2adb3069b0e04-52ee54420a9mr832688e87.62.1721210777867;
        Wed, 17 Jul 2024 03:06:17 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e983e7sm163259245e9.23.2024.07.17.03.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:06:17 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	de Goede <hdegoede@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: ata: qcom,apq8064-ahci: add to dtschema
Date: Wed, 17 Jul 2024 11:03:07 +0100
Message-ID: <20240717100600.19005-3-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717100600.19005-1-rayyan.ansari@linaro.org>
References: <20240717100600.19005-1-rayyan.ansari@linaro.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The APQ8064 SATA AHCI controller is used in apq8064.dtsi, although it
was not documented in the old text bindings.
Add its compatible to ahci-platform.yaml.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v1 -> v2: added r-b tag

 Documentation/devicetree/bindings/ata/ahci-platform.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index 2c8fdfc3df9b..ef19468e3022 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -30,6 +30,7 @@ select:
           - marvell,armada-3700-ahci
           - marvell,armada-8k-ahci
           - marvell,berlin2q-ahci
+          - qcom,apq8064-ahci
           - qcom,ipq806x-ahci
           - socionext,uniphier-pro4-ahci
           - socionext,uniphier-pxs2-ahci
@@ -46,6 +47,7 @@ properties:
               - marvell,armada-8k-ahci
               - marvell,berlin2-ahci
               - marvell,berlin2q-ahci
+              - qcom,apq8064-ahci
               - qcom,ipq806x-ahci
               - socionext,uniphier-pro4-ahci
               - socionext,uniphier-pxs2-ahci
@@ -105,6 +107,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,apq8064-ahci
               - qcom,ipq806x-ahci
     then:
       properties:
-- 
2.45.2

