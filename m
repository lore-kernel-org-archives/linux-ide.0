Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF7329993A;
	Fri, 22 Aug 2025 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885569; cv=none; b=mi1WcZVnoV1AHUSqwXmU7VgfhXD9HEk5X65Mvm1aF2AkM8nZE1TV5nHuQrwcttgKVAK/waaAHg0d8Uy72tedznQJYJjsTUuJ+EOG99hZaEVxvEBcKsjXZhsjDE3M9HtXqc7WtgCX3crbOvqHq8w5B+Hqo2DbnnoPDpc9rHjDGxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885569; c=relaxed/simple;
	bh=7AXb6D8zIILrgdU6FDSFiqmilW2h/3kHCLZws9Dtjjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uRZqU/gLgoTFqoI5GfLPTuZgJKLMgS1dvENHf210p5ooO1oHpbwlrxLl3drhoZOhbr4DPTsjSz4TyRa/2pDuolxpqjKkvJkbzzmqQZzhEhDJU3biZnVv44ONtb9zrD0OqmUwjEYtW9Qr4BRlKu6aBkHYW8ek3RsnAwAsQ9VkgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9qmlLot; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9qmlLot"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b47174c8e45so2232217a12.2;
        Fri, 22 Aug 2025 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755885567; x=1756490367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5S0VnWVEsWUOlbF2JNExqMbPEHI34IpKB3N4D9KWu/w=;
        b=V9qmlLotJTd8jI9TQco/ZkdGn8WIrPZFRtYOtDGzaMUt3QTYaP9f1AKArp6jJJ2rL+
         /VDx++DReWAKDqCj7FUjziJlja7jtzwIOoTxkhXg5KOX3HAKQxqMoWwuJoKNjSxT5oUV
         OqHixvy/4YQf4R/ybBb2EJsZ90fU/LjhROI3JuyDcQIR0A9xEer+BSvV5iNV2RqcIvgs
         lR+dFQr600/CTmcw0jIJyRIeioD7Q6cb5y5xwjgWRGYP4A4h35vHU4P185bLHycLjzD7
         rFHbyt9C+t80O2cTOPJkoTSAUW+pUaH0h1TFt8VvE3cYAa3KjCkPEjZR7Spt9D/UcMCu
         jfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755885567; x=1756490367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5S0VnWVEsWUOlbF2JNExqMbPEHI34IpKB3N4D9KWu/w=;
        b=pFMosN5F7IjpXm1TvhDi0cJxSeFwQjjlGJC629iaghV2QGE+FUU8m4xVmwgvEoXATi
         T+neB7fvHzy/8Yhylup9WzXTb5ni0duPV8wEI2upW/lvqDoihBDd1FqdFAlvFFVp7qJV
         EqxsAcixiG9J8x5kmAREbNCK/qQW6RvSBOfRDeLOs2G72+nIed+jQypA+VhgWqBz8G8b
         zOAkXvGKdtu+FYVRUEZSnq0C6WDrkx2Ebhuupa6MYPKFtwREhPMxTYuM0fsp+z5TQkWk
         joFBEbz2NzbXvLZ0cgIh3rGvs1Z31dY5y0jlzvllLK4Q5vMl52rDMVs/W8X41JgThXjr
         Nl0g==
X-Forwarded-Encrypted: i=1; AJvYcCVZMz2FOADegCeuo86UfcOnm59yjAS47f231db8ghECNrpkfLzCp5H3K2At35h8EzadHlAgSOavzhB/@vger.kernel.org, AJvYcCXcMcCPl2pceqDoUX3nRZug43HBC/e1axHs+Stx8/1Tg7uoX/PH9S4edDXKmoB5m2nAJy2gFXY7CCMi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3nhwMJed7PSgp09gcHn42Kr9ynNdE1+T8bRFVgZPdu/sjtZNL
	ZE5AyxaIXE8d31VuUck3beDDixk96q/zJK0uDYGSLyWPFdCVii9FU2NM
X-Gm-Gg: ASbGncvRDQaYyINL1kqyWAVuOTmB3Br/U7un+EQAFMLmP0Gm1kdWWmqvJsuyzpVisCo
	kUFPv+jkLI0PpoPyhkcV13SZYR0bvRlA4mEQQCSDTIzVv5PlJqC5CEmE3TyFzANYBnmGF70+A3a
	W0++n05kBWARNmCwMuxGluIIastcxgfyb5eMMsNRNkQ/kzWwjavADVbNsLdTE/+tKz2LfI7NfSS
	z2lCxYPwD19IlKJDUk0xXfTZQO8s7wcK1wn0R+oURLUXC7sy0DyO1nQGklztWorwDWXLaH98yQc
	c2K2wuDThxm10NNobnQ0ZY//0Q7aT++3Gr/51uwuA/HcQ5+/Nl6GYBfJVRTQRHa0/AoqRF52UqO
	D/v73zZFursZr8uI8b9SI3ckRNEDhbt9arcp0
X-Google-Smtp-Source: AGHT+IFPwieLOBgTuINcc+wKmOGc1Gww2KUqVQUwLOKZFRGimkYw5WrBP3+FtGEluZJwMaIuC4sfwQ==
X-Received: by 2002:a17:902:cccd:b0:246:4fd8:1983 with SMTP id d9443c01a7336-2464fd81ceemr27178775ad.17.1755885567198;
        Fri, 22 Aug 2025 10:59:27 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5ae1:41a6:4f22:1c64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466c2ac55bsm1231955ad.119.2025.08.22.10.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:59:26 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: cassel@kernel.org
Cc: dlemoal@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dt-bindings: ata: imx: Add a reference to ahci-common.yaml
Date: Fri, 22 Aug 2025 14:58:30 -0300
Message-Id: <20250822175830.91682-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'target-supply' property is documented in ahci-common.yaml.

Add a reference to ahci-common.yaml to fix the following dt-schema
warning: 

'target-supply' does not match any of the regexes: '^pinctrl-[0-9]+$'

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/ata/imx-sata.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/imx-sata.yaml b/Documentation/devicetree/bindings/ata/imx-sata.yaml
index f4eb3550a096..c60866544a53 100644
--- a/Documentation/devicetree/bindings/ata/imx-sata.yaml
+++ b/Documentation/devicetree/bindings/ata/imx-sata.yaml
@@ -88,6 +88,8 @@ required:
   - clock-names
 
 allOf:
+  - $ref: ahci-common.yaml#
+
   - if:
       properties:
         compatible:
@@ -112,7 +114,7 @@ allOf:
         clock-names:
           minItems: 2
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

