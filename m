Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA024147C7D
	for <linux-ide@vger.kernel.org>; Tue, 16 Jul 2024 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127249; cv=none; b=WN71wftq1zLRBE6uTy726BBRIfP6mQUyVGcGv6OJuUiUhJ+8C4nyYemOHt8QT/zNDyzWvMXY9GAQ9MJ1o19EVzK4bFVwZEgBPF6NSm9cpWR8uJp5nrnR/HSW6v1ycb+J3dp6at+XYhy4ElLq/Y3201oSQyoBUNYxU6FPdqaY7N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127249; c=relaxed/simple;
	bh=YorhGRO2chbUqTcT71uR6rwxbeXoVYmksfD0xmDIhMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r05LkcOwp2VoK25QwkFKICawQib5c3DJDqF9zEvzqVIPdAATMeIatnLLdg2NKY+qmcwoSIgessZw+8b+/eagna0fkeCDOuwmTnNYE6TdGSqeHK1/bx3zbvRm/dKeDjMnxTFcNQyinSTn6CuP/vdBecDxVi34EaCDlz2FWA/9FiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HfCxZGq5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfCxZGq5"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36786081ac8so3101779f8f.0
        for <linux-ide@vger.kernel.org>; Tue, 16 Jul 2024 03:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721127245; x=1721732045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3idFFwXVZ1sV2FTSSvkS/EtQq1D7aCpjCrwW3Fvciew=;
        b=HfCxZGq5lq2lbTie3dsQlx3iTLFCeGvqD72gP2LPS5jgtngPzzmlOOGxdIViIchzRc
         eEBmi2R9//730W2EC2sRMLH3O+RwV8u1pSH2Llyj5k3BylH55ss7jEE3wKOTEs6Vc0rT
         aa4Vajz9IN+MW+jlXTMo75U0kh2g+cyLxTr5vpshZgz0AbeMNwaJpyVwDpvOyyNLGnq3
         CSRZCD+YB75TIiiwbPwdKTbnRlCp7yA3wahJVBf8mTK+S/+ABf4tzPFdMBTmRDKfXSQb
         lZU1ROjtzdIhZwJN+JTUSDRR38EfL2cbh7Je96mSpJc5cYWFppxwpXZm308EsncnF/UY
         hzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721127245; x=1721732045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3idFFwXVZ1sV2FTSSvkS/EtQq1D7aCpjCrwW3Fvciew=;
        b=fvePDg9J/aisnQfYpJMN4xFxcSc9AXB9MWwX2+MeM66W+Xy9xQR4qU4Exn2JGIgY9V
         tS5/wrCTziHlA/z7OQAFMVvQqDgS5QwwEU4NcDhk00E/525tXrKBkBNMnoPMJApOzZYP
         rIKTj/pg6fAVoXsOwQ7tEyI4H/KiB1RJ85X8mnEkJdMQBjjz+W+gBBjoPAmmjzLNioDv
         CWe/a+B50I49TqYOAC9/eeiyevqK9jg4VESiZdmQTZNAmnuudbUjssB8ic4QVdmVeWue
         Ltm1SsizMpmOYr8gm24UgSwHBfj94RHzK46DSLw2uFe/vyjlwj1mDLbXyU65HHqcHn5P
         OaCw==
X-Forwarded-Encrypted: i=1; AJvYcCWQfZjt9TGJ/k+s5GigJuEOVdaffuf4XAkTe8bfcWyXn+uCgdAAEgpyCokz6GOFqcw4stHvhuA8Ki1Zd3ml7yONv4uVdBUohw93
X-Gm-Message-State: AOJu0YzyK8tMVWRUp8r2VpbwhsmnQ+ySm3g0/pyh/6diJT+aiTQh0h+L
	r68Z+/ukxKS5BttTUz5K78uB2FL5P/B5p80ver/mXty38f+P4V57pO/3kAHCtSQ=
X-Google-Smtp-Source: AGHT+IHdAGXPdAISZGBpSXYAAJ4HcA1uS0a/b4dYpiEL8XWtam09tsYzhfrfMH+0AVFZTTTypTvWew==
X-Received: by 2002:a5d:6410:0:b0:366:eeda:c32d with SMTP id ffacd0b85a97d-3682614f7bbmr1154936f8f.31.1721127245325;
        Tue, 16 Jul 2024 03:54:05 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccbafsm8608295f8f.51.2024.07.16.03.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 03:54:04 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	de Goede <hdegoede@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 0/3] Convert {a,i}pq8064 SATA AHCI controller bindings to dtschema
Date: Tue, 16 Jul 2024 11:45:58 +0100
Message-ID: <20240716105245.49549-1-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
The following patches convert the old text bindings to dtschema by using
ahci-platform.yaml, whilst also fixing the device trees to actually
adhere to this schema.

Thanks,
Rayyan

Rayyan Ansari (3):
  ARM: dts: qcom: {a,i}pq8064: correct clock-names in sata node
  dt-bindings: ata: qcom,ipq806x-ahci: use dtschema
  dt-bindings: ata: qcom,apq8064-ahci: add to dtschema

 .../bindings/ata/ahci-platform.yaml           | 42 +++++++++++++++-
 .../devicetree/bindings/ata/qcom-sata.txt     | 48 -------------------
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi      |  4 +-
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi      |  2 +-
 4 files changed, 43 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/qcom-sata.txt

-- 
2.45.2

