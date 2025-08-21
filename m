Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136F1146A66
	for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765165; cv=none; b=heX2HBEjs22P7i5v5ei1HXRxecsM47NP/KB5xhP9rQ9I9PDVajliSHICSB0FtIvRmufBuMldI3eV3WdvY3k4uEhN5RVyW/62Hkr1iQZ3iIg4Lm/XO83mUyTrAdORjG2tXT1doTurfzyQCflreI1aOcu1gRnPROtmFtmgJGnrFk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765165; c=relaxed/simple;
	bh=pYJlHN1aERKTD5dn6eMI8EEOmAFnx8MCipfdGKyQVys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jHMKv3E6tgmXUte2EsvXe+0gJGBpkGHkPUn1rBaXNKJWOxg4ytRFspUUcAPTJ0b3UuwFoJrQAQiNyE3tDjM3ixGjZKf0/9B9unQ6XZ2DpjBdMEM2L7gnwcEz0e55B4HOLgKdLz5ER2isGwHeExkpXcLuehPKnWKG0B0UeDMyn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GUIHk8Q8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUIHk8Q8"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61a54560c1fso92395a12.0
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 01:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755765162; x=1756369962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TWfMwGwxSPE+2RYXTJKDSKqavznnU40dko/mHK1XUnc=;
        b=GUIHk8Q8uzrawSNaSNks8XMdrfr6Ts0Q3QcjmWhilg69aqytqdtNdYY7VQIJgYfkhB
         QYVuduOi+zadC7OirmacGltHbV7Ly5qEL4hhLrsbH99xqRXgyrKi8sYT9prjTunUe8q8
         7beSdyF5bWUcfx8Kd2KPUaKMTUdGaH6lxUfUb0gm2iqc2Tlhe3DLuLZBM5zaesG+kjUc
         O0Y9bq4uYhl+aJVjtdXNr7iojB0md7TQEhx1nJDlAXWkkolRWo5Mhbfqz8luOr64voz9
         pIL/IlzCN9tzeGcmYZ1AO95b3yuX049uS/6ywXQkAs+uRuJA285YCQlz4bjTMZghP1i4
         /vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765162; x=1756369962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWfMwGwxSPE+2RYXTJKDSKqavznnU40dko/mHK1XUnc=;
        b=R+5MleJZPpCw1InGXtkhU8J0xkYmtRAF8c93vAbmEZpKinB0kpK3VzJpOgE2uNDpH5
         LZ71mvv/nmTIN6cqA2aBSUkqXtA1Jl6mOsPtVtZG0P+J/KdO2ggksw5O8B836eelu3Kk
         HJTU6NAQYx/XcP2kuGSCmIUb9AT6u7r5VRHde5mZvlIRWjwtTjPmJ2TLyLazjdPicswA
         LsLVV+P39fIWE8ZfD8WkQEox2+V9xUrjtwogrMQpwAiQdtWq8mJsnA7xPMshH7M3D+2S
         M6yEQS9Y3pIbSlMsvhlwxdK06zECx3eI7/evzSmJlSruTQzDylO+jlzFHLTgumUtXnT0
         tNgg==
X-Forwarded-Encrypted: i=1; AJvYcCV8uTRPH/C+CplTFv1KiyXqpnbZhao2jAHV5RZwgH8hK6gYSeJMsnWf5LKlRF7o5YGjeFg6XE+EWuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2zQzKwA8R+w57xf3XmLt/PgnfMSodwKkTSqecETIsmlXrQdFq
	8uGeO41AIed+QrxYVYlaDVP/wQ5slzBtTDOqHqea0acx2K3hqw39hUXJLJJxYo01fSo=
X-Gm-Gg: ASbGncsDtYrBeK1PjUITxSKgkaPfY3Lqe6t/oO+GchLKAK1tdlt5ldbJ9AugTjDexkO
	1dERrAolg4iOlAXY0gu7DDAuZsQkHL5CvYOxLmYd72tJjaWoJ+bBHquAfxTZZaLyd5UebWm+ahP
	jHgUKfhRf8cXCzt5+tCPQFTX6EbRO50v6jHSQi5GZUpP2rcbxck73WYo+IGxAtiuFfOJSud7brQ
	eOzlX/KEjsQuKqUsFlhqKr2oZzcLo2D5U9zDFsbl2FwqKKpn/JEni6R4o5LJGW7pBA3Jnzq9YEN
	HDyBDaQ5/SZkttiS6YN6tjOuKSkZY4OQRallxJvHE2SVlYGzPQVhArSCxTdhw0INnfJ4v3q820e
	tlNyqWnkpQ9FKKDJT0aT42ea6TuQT5jdK5Q==
X-Google-Smtp-Source: AGHT+IGMnezZ6ckgY8AKdVlLCLh1IVSQUiVwR7g1JhcEMXYzft+A2GYQmT0QzedKEJaajR/pCpytUg==
X-Received: by 2002:a05:6402:40d6:b0:61b:1d72:d429 with SMTP id 4fb4d7f45d1cf-61bf8960fffmr672345a12.8.1755765162387;
        Thu, 21 Aug 2025 01:32:42 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a755d9cfasm4919714a12.9.2025.08.21.01.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:32:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: ata: highbank: Minor whitespace cleanup in example
Date: Thu, 21 Aug 2025 10:32:40 +0200
Message-ID: <20250821083239.46726-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=pYJlHN1aERKTD5dn6eMI8EEOmAFnx8MCipfdGKyQVys=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoptmnsTovpUp0/NauL0CHLJrtigRtcK3WY3a+/
 +Q903kTARWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKbZpwAKCRDBN2bmhouD
 1ygQD/4wWi7NB8P+MQ2AyI/JSFdOU1h/YYw29UEPWzuMTWFcmqHeLdj2Npff8h8CMSl0dE6SvWG
 PLhx0k+HaPIZiW+pxfQVj4EpgefcFbmHv5VuITuxkg3WWStP4gYUDv5kQn1sTPlaB26VpG4FGwD
 oYl+qhoUy5WlFbm1tYlkpe3DjaYKZ7Byyvyir9zntsHqLZUVCFZGsphbh12pY5gY4ttAWr3eemZ
 fceBs0eGlWh/mXs//X6IW5FGgySw6y/8ciVcxvPmuDq1SB0L0tm63LgyNpT/NeaBIOKK+GnpdSD
 BNjHVzIDtc8f+/D0sQOFRpZpReKcpiAzFHRAMP5QDx4tnhHxl4q6Y7v46SEhtfT8+7qpiYHFihd
 iV+mf+GvfNAMYqO44n3Hh0Rhue8Wo1bxR0V6nNBHVDrlqdT3nUl/WfD1xw08OWpDq4wTceIVCmw
 ShSSvU1Kkje/pl7tPzBBGQATvz/G94AoVtp5sQXY4ApRbdviwZi91TtYKS0wJB5favXGJDBnxaH
 CeUICh3xRXXN3UO+S8d5pN9ilN/2KMKAfiXm3oDOz9SAmJ7FkgnYlHyRqA7RK1wknuTVmXhBNIQ
 IQ/ro/vIhdcyWHPeu1BhpgsxJLkIzQWECGRIOgVtKHKp6W/eyuZnonrKrzpXmA68QS6YCX6wZz7 Hw+byCKApNq0cKA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/ata/sata_highbank.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/sata_highbank.yaml b/Documentation/devicetree/bindings/ata/sata_highbank.yaml
index f23f26a8f21c..48bdca0f5577 100644
--- a/Documentation/devicetree/bindings/ata/sata_highbank.yaml
+++ b/Documentation/devicetree/bindings/ata/sata_highbank.yaml
@@ -85,7 +85,7 @@ examples:
         dma-coherent;
         calxeda,port-phys = <&combophy5 0>, <&combophy0 0>, <&combophy0 1>,
                              <&combophy0 2>, <&combophy0 3>;
-        calxeda,sgpio-gpio =<&gpioh 5 1>, <&gpioh 6 1>, <&gpioh 7 1>;
+        calxeda,sgpio-gpio = <&gpioh 5 1>, <&gpioh 6 1>, <&gpioh 7 1>;
         calxeda,led-order = <4 0 1 2 3>;
         calxeda,tx-atten = <0xff 22 0xff 0xff 23>;
         calxeda,pre-clocks = <10>;
-- 
2.48.1

