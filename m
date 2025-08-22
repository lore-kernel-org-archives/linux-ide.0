Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67835975;
	Fri, 22 Aug 2025 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886684; cv=none; b=jQczWcWJHsqr4T/zFbqk8bYT3AYWrNH6kktmxEdmh3BQ4uTtv1PzM8nlDzAbF5oJQDioxdNXNSBv9ajB23BH7TmN0O0ywpBF8nuokBU+E4no5tWSnUDR17h7KoUtJQJ1uQw/m7/cbrDXjcG8zfflTDvR6z+uBjOM6O7BHjAy4UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886684; c=relaxed/simple;
	bh=Rhl7vm2/jNHqaqFI4dckagXFVsPGO6AXO5D9UCVBAjo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a83jTR1d9HYSoQfJHeI78XDnvwyNixJ+QlebPFJKZLy2wCYa7KQv4aFQzFUddYTc2BDaYy1YFfu6A3M6QNGhsHFQDnu887Tik0h9gHzyJwazzHNXSTUMD1b6gxNx+ryHjL8QDqkU4D+xmJa95cyC8GD6gS7zJIUtdiSSwwtOnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROnNU1Bc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROnNU1Bc"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2eb3726cso1784418b3a.3;
        Fri, 22 Aug 2025 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755886682; x=1756491482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mY7Wd+C3YFXnttk/L3KXrhaNzCg1a9Bny5gM/NA2DfM=;
        b=ROnNU1BckM5YtDAKCp0pJCVD8TiWvxCo32yFoqSiglCG3MfzU0JPdv7gZ4Gdaki2iG
         2/N5KWpepVphf196X4PdO+deCCmP2n0kw02umLYudRZPxAvv5YfslSbxpy/5r358ZbE+
         8LY7t55/6k0OChcAGoatmouM4dmtVmZZn09a+DKpI2Vd9L28H8z5yl2CcMrY6Ttruuat
         wOaz8BcTaEVihnroeaLE/1oYVF9mQD28rUK7q+V3JExON6gmePez5z6j+bbK00OkfrX/
         A1nKpmbLdE63XeMzUjysTqO4vPGOKE6eZ6FG4b2HYOP0MjlXH5nWZEchjwkRkRYCeTet
         WQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886682; x=1756491482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mY7Wd+C3YFXnttk/L3KXrhaNzCg1a9Bny5gM/NA2DfM=;
        b=bVBnScOxpACIb4XNivdZWQ6URSoMlXU5okGvvQNWZhej4sDdSjUosqP7Rz0cRDtFY4
         voQljm205zeuecRMQKyyhrfSFeL/IGlrKMA4mAMVFfsVRrgp6pdDQCp7in3q7ujDfR5U
         FHXqHsyFc++2196MUJm7WjOW/dpxMtwGTZUCYwrCH9vcMGs+SdmN1rG7C+7IKlsj7Qiu
         SGCd1j6H24aWqeS50ZZ9f1hmwnaM//nxNl4voyDeRmfUBk5i4BR7l4vLLxRqOM6IALPE
         FhG7AxRW3j9O3yyx6XDrOF434irA4HHvG2TZlgxJz4gWdOCRjf10WdQm3nB2sDs68OoA
         Cy9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQFkA/Fr7Vp4+UThjuBcJLwBw4kXdypWQbbcbi1PF+RD18XnWAPjCzAKQB5D3yLGTbMmCwyKiqg3i5@vger.kernel.org, AJvYcCWyFIcriSB8v+Aw6TcGQYUa1+FxWZU6SXSzRNnRZr04MhwBrcF8AxNfXyANZijzLr6v7Y5QjbGMpZzD@vger.kernel.org
X-Gm-Message-State: AOJu0YyTkf5RL77oR/UkEfN+RRGIFOlJ4oWM7oraGen34omf1gDt6Ybc
	Kyhe2bjcVQMWRPDqsAFBkerCBh/BVRI+HrjhKzQY6Lq5c/0lWJ9VSlfVxuMpAw==
X-Gm-Gg: ASbGncuPZPLHGGsrcMi/ihChU2GVIjYPGYphMBBw+ln5hgARPEw9Vtkwo9R2AMOugzW
	YtiaF+L53TTmpltcRrLPyvq0fF/idLPPYcmiCYHVhQGx+U4AXr+L8Iqq/1aRVkMX1plm+vZY6Vm
	SHZud3QVT/0gzvHUa60uN63wutMcVuiFKbx72J7mlG+lDWhH/ADMrMUJpVfmJiRvRskIpPdPTyi
	3SQdP3ZMZdYqdb81vSGcNqsL/XF7o+QktR/d9y0em/7HxsXb5j+8oLXnARsUo+Gr64Y9Vsa46sb
	UmKDx/PNPdzd3B8eksqXvl6VWpnA6tTPRKhyF7W3cGD/wnBqk+scMPjFcSImLg+sebnXjNq5AxE
	EeaoWBGD1YS357IAogYO2u4RyTg8QEtM7QHvm
X-Google-Smtp-Source: AGHT+IEGi5/44w16yr5A0+t2lzxFMKe8fWVDUdxG9fUpVVpBgNcr2qGKDTgj2sN9l+SWiKXxGmpICw==
X-Received: by 2002:a05:6a00:b93:b0:76e:885a:c34a with SMTP id d2e1a72fcca58-7702fbf6ba3mr5642706b3a.32.1755886681804;
        Fri, 22 Aug 2025 11:18:01 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5ae1:41a6:4f22:1c64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040225c45sm487212b3a.99.2025.08.22.11.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:18:01 -0700 (PDT)
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
Subject: [PATCH] dt-bindings: ata: sun4i-a10: Add a reference to ahci-common.yaml
Date: Fri, 22 Aug 2025 15:17:49 -0300
Message-Id: <20250822181749.94232-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'target-supply' property is already documented in ahci-common.yaml.

Instead of documenting it locally, add a reference to ahci-common.yaml.

Also change to 'unevaluatedProperties: false' to allow the properties
from ahci-common.yaml to be evaluated.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 .../devicetree/bindings/ata/allwinner,sun4i-a10-ahci.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.yaml b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.yaml
index 2011bd03cdcd..8826aed4ec03 100644
--- a/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.yaml
@@ -10,6 +10,9 @@ maintainers:
   - Chen-Yu Tsai <wens@csie.org>
   - Maxime Ripard <mripard@kernel.org>
 
+allOf:
+  - $ref: ahci-common.yaml#
+
 properties:
   compatible:
     const: allwinner,sun4i-a10-ahci
@@ -25,16 +28,13 @@ properties:
   interrupts:
     maxItems: 1
 
-  target-supply:
-    description: Regulator for SATA target power
-
 required:
   - compatible
   - reg
   - clocks
   - interrupts
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

