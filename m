Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4033517E90F
	for <linux-ide@vger.kernel.org>; Wed, 17 Jul 2024 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210771; cv=none; b=oaWcX92NDo9i7rYkF8Rj9XeetJXvhYHD1YG/BR2ZRugE3Kfn7/Hg7A1K5yHl/sf442YGTuxuskdnaie21rLUDu2ySRb5HPXPk6I5LiPVhRnAMw0M6hcyUW1syABWX1UyX2z5Qhb/YISdNX6U7jav0jYm8M0J7IkME+BoZjcFolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210771; c=relaxed/simple;
	bh=MYghnEZMNWq78HgnezOmQfeHxZDLKz1Ar/qEuPxda/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G629k4eff2sVU4PTbrSLc8UIwqPfsAH5P52Sy+dTZkB+yNl+eT+0Z8Tt3KAccalNBI71/m0qmsoZutL8qKsLV/wbIqp4jmKyY98s2Vl9lTiVFPxu99+NppBpNegxNStaTz7aSTGcyt36pESd4Eqir7W/2qihrNkm5piKBlqH4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xLJYM0gZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xLJYM0gZ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4279c924ca7so42020805e9.2
        for <linux-ide@vger.kernel.org>; Wed, 17 Jul 2024 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721210768; x=1721815568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MLMUJK/Z5vNN4i7adZ4/craWA542/Fh4HDOAyVU3ijA=;
        b=xLJYM0gZ88czsPwWWSUDyh0qL+DTiHdjLzIV68VQ7qG0hO7dUTErKw8c1B0QdGrF0q
         VDDh4C7YTA82iLl3J6ss2QWy/TV6vPa309Z6mME64QF9XrQ/6ik/7FQ0vpIoJlF9IZk1
         UEGR7QzrwNSsPAN0MPdaKFSB4DjENRZ344vHvOBCbGhMdPT9YkmKLp0ZY2W7CY5ssvqC
         N9i8K6Fp7KN6HRGY5pfq2VGdrxc4+AU0Z8rSvuLI4/OKhm/wZS8nsq7L7LTWZo1Cw/3P
         2EKanVNnifMHF3tKVw/cosqcSkU1vUatfWwCDCPJXQyjZBNpY886BCJeVsaDE/KPcI/Y
         foRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210768; x=1721815568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLMUJK/Z5vNN4i7adZ4/craWA542/Fh4HDOAyVU3ijA=;
        b=MiHpO1MKTuULRT24R9x0g/7CBqEWJ5IQB2fDwOnxoTRvu9fb3Jo1lvG66vgwkyKJE2
         1ulFHnLnrgX4gMqxOD1xNOqJQLsDSE0GVG5NFhtS5cNMk816I7CGT8H5VLqRRmPUik3r
         z9OEXcurSirI9WahEKB85rEEgFWdgUjc8OI8FwTDmDMgy10zsHt3LTKQ5SE7CpdpghPl
         0aDvPXSqqTTRn94jFPHsyh7+OXq95BGXKIZ0rfY3ez/GUcaY2IJtVZTw1tv+yRqAIuUs
         8v3+0O+LRZV5R9s2OC4ISLfXvaAs8cRIIShA6JzksMm58M/fRdCUIICY61C3vKmEyatX
         1sWw==
X-Forwarded-Encrypted: i=1; AJvYcCUtuchq/Upqikz0Sax3DP+bYsEN8BXYBJtLcCbr7dnWkAAHoNwPPS83zm8KnJqeodnF2GcnrofItlKjTpK9HqRX5YE+iothHVHU
X-Gm-Message-State: AOJu0YzBr0h0i5/Jgm3FWDbmMpS6IlQ0W0u2hkboVYPW83dpSkmFMts+
	DE78Vy14d8LSS4iJE4vyCeQd139oHS7NksNDFnsxyLy+rHZRyEgLQZkHavLitz8=
X-Google-Smtp-Source: AGHT+IHatreA6hJ0QZHIOG65FDXwkYQIK0dFa6H1+KKDy+5XlVo+HPtc52LX7l1aTKAS1Ci0+3S1KQ==
X-Received: by 2002:a05:600c:3c9b:b0:426:5e91:3ff1 with SMTP id 5b1f17b1804b1-427c2ce9008mr8122645e9.24.1721210767690;
        Wed, 17 Jul 2024 03:06:07 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e983e7sm163259245e9.23.2024.07.17.03.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:06:07 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	de Goede <hdegoede@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/2] Convert {a,i}pq8064 SATA AHCI controller bindings to dtschema
Date: Wed, 17 Jul 2024 11:03:05 +0100
Message-ID: <20240717100600.19005-1-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
The following patches convert the old text bindings to dtschema by using
ahci-platform.yaml.

Note: patch 1/3 from v1 of this series has been sent as a separate patch
for v2: https://lore.kernel.org/all/20240717094914.17931-2-rayyan.ansari@linaro.org/

v1: https://lore.kernel.org/all/20240716105245.49549-1-rayyan.ansari@linaro.org/

Thanks,
Rayyan

Rayyan Ansari (2):
  dt-bindings: ata: qcom,ipq806x-ahci: use dtschema
  dt-bindings: ata: qcom,apq8064-ahci: add to dtschema

 .../bindings/ata/ahci-platform.yaml           | 33 ++++++++++++-
 .../devicetree/bindings/ata/qcom-sata.txt     | 48 -------------------
 2 files changed, 31 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/qcom-sata.txt

-- 
2.45.2

