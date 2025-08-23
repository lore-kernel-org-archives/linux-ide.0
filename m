Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F61F130B;
	Sat, 23 Aug 2025 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755978634; cv=none; b=OnvP4AUP0g+IcUGa9/jxwcevXS/HEZJEBQZ+lXgxNM2Yb7IJyx+sgSoVV2hHVcq6ViY58CyORHv04R0HSHT11YGsZFJtUuZtHMlV0V+NKwAe4NdmVUsm/kxaAR9f7Zg5y4+tdwrjEqJKX6szfus06+XZLrlm06ORFOEzIwe7S/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755978634; c=relaxed/simple;
	bh=Qk905zrBLDF4PbjR/ReREmrvHFkb4qI8PdI4+6ugjEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oV/VBjuNYiyzLx9drc5DNgesRkPTLp+gjQ4Bg2bMKwCy61ISSu6XPhkCzqFeQIgZLbLyt8fQ7wbQqCee1oxhs0CBJMYZ8OKQsPFLnwYWftgjiJViN4VKseM9eMGeFD0EJTu5Gy5Zwy6D19M2AlFX2/YnQ2kOtLgOgpecEwSrgrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dc0zSH6L; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dc0zSH6L"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so3200204b3a.0;
        Sat, 23 Aug 2025 12:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755978632; x=1756583432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p8dCm9iTBNbyL8PLXSFmH49Cko3V+WwG8eJ32pEsAX8=;
        b=Dc0zSH6LgJr/0rb0j3cNh2Viz9hr3J9YEOCOtFXxKRMNHDLFfu5OkS8sPsM+zUixJj
         38fnsnBn8AbSqy3IrDjWHypOg4a5L8gZ/qtjV2PxKJXUtSoSl1AdxmQ0WzKtX+tQOMb8
         6maxKZC54V0Ta6bR3AzkSMUR3/15gGCNZ5WeHpb4/e5sdJpv1aKJKNw66KcXFnHHdla0
         SVa6f6lQP33wkw2FpuiXjAIGA8AMVB9Kw6FxzVZNhPiK8ki1mYT2bkalSvMMCDg7git9
         ACla7ic1CHtzJ4Ct1nQQmXzWjsdiHUZQVfBBtY1Nkxtlp2EQj91jiTX/4i2uqgZihV0F
         TdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755978632; x=1756583432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8dCm9iTBNbyL8PLXSFmH49Cko3V+WwG8eJ32pEsAX8=;
        b=IrDQKYwowgkMqxGsyAHNQVAvyIN9tPhOf2EqE1K5MBcQbNA4V1WNpl8ov2cW0BR40d
         k1lViicx9ScBGXW1qYUzW+vD4yynFW74TuWlUR7fPdx+6ixQ+a9VrdeMQuXpJKSUXPjD
         Uszjh0/XFmEvik3sLznKPTFFaIqKcZ72C76GbF4CvppyIOZuTSTRnwihtnZ1D3tjjwGS
         U0Rl2lJ28yJGAIn0+bhCfaLkMlfYuCWW5N1SaRR7KMCNEehd7rgU3HEng/PFJ08xFTAE
         GhGa3oSWvGv5nKD/qo3HvEyLNKQZidN1RVnPO6Mm0+fxwsj3uXMaFZFDv+aAiWfA2tPJ
         0c5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRGgCS3tIyf2YNS4tM1pbHylA8GtDjr7EasAS6fjcilb047hR77cAHK3LmvvuDP2RrHyj0Js/YQHPO@vger.kernel.org, AJvYcCXuO2uhODSkBffeUkPRd7X1FGUtZY7n0mE1rU78BzzXKKtjVGtJNbCylx9a0xf4gUrD38el+MQJM13Y@vger.kernel.org
X-Gm-Message-State: AOJu0YwvId64u3nzG8aIDBHJbL4WszM/F3xFzue+8wLzKPzi7ubphtnK
	1WvQBAvZ2vm1EY5Lcj+redohIdFOkgmbGspndFpUYi/4UTNvcg9RU2BgjGkiQw==
X-Gm-Gg: ASbGnct0j4xfZDhFJ1EpXN0H4LRTqrx1xkw7VYJaXo2VekYIkU+b3QI3TVfdzB1X9a8
	fONiC7KpuKWA7ezKnOgzFpAquqV9PQCS9b7yrF0dwtqTpxhH73TYGRKclR5qLahSjPJTndA3Kyn
	Xa7xv6RSHPv3QJ7rlOc06Z0GX+yrgzwpZiq2vt0WOhRTMij+MsvU6NZdceyadSIU1lPZg59bAgy
	OdCEHrXxlqyhy+F2EMozwCGGugwDIrfiHv7ss7FXnGp8MdAo390t2EiU6/zasqaaGHg7DOuou//
	TBJTR0XRetfYFWc61OiacGi6RrEbdxdNsBgJZzCTsLXNQz1ZaWfX+N4cFQJcEPJOnwXC9RZqlCo
	kBlVOAm/pEhFcyUfUcv+vAX0MrXca7y+LXp3z
X-Google-Smtp-Source: AGHT+IHW6AMOusNqYStc5v+apO3GCt5QtTRMdQzakF3T6bepmEvLwJ+cOSpp+gBOPQ+/zvEm2OZyPg==
X-Received: by 2002:a05:6a20:3d1a:b0:23d:7a30:a82d with SMTP id adf61e73a8af0-24340b5817bmr10348591637.5.1755978632095;
        Sat, 23 Aug 2025 12:50:32 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:720a:4760:f024:645c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm3219888b3a.75.2025.08.23.12.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 12:50:31 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: cassel@kernel.org
Cc: dlemoal@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] dt-bindings: ata: imx: Document 'target-supply'
Date: Sat, 23 Aug 2025 16:50:21 -0300
Message-Id: <20250823195021.300488-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'target-supply' property is used by some i.MX devicetree files.

Document it to fix the following dt-schema warning:

'target-supply' does not match any of the regexes: '^pinctrl-[0-9]+$'

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Document target-supply instead of adding a reference to ahci-common.yaml (Conor)

 Documentation/devicetree/bindings/ata/imx-sata.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/imx-sata.yaml b/Documentation/devicetree/bindings/ata/imx-sata.yaml
index f4eb3550a096..31c43374763a 100644
--- a/Documentation/devicetree/bindings/ata/imx-sata.yaml
+++ b/Documentation/devicetree/bindings/ata/imx-sata.yaml
@@ -80,6 +80,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  target-supply:
+    description: Power regulator for the SATA target device.
+
 required:
   - compatible
   - reg
-- 
2.34.1

