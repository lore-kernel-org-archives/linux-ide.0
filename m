Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40277641E;
	Tue, 17 Sep 2024 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726574140; cv=none; b=jrahdlIdd3scFGQER1XGLS8EsNiYBxDi3c6+qejT8xtpsrx3072UGBqG5JmpeeaVHg8pnR9nkQ0weGm4f+bPwrSWZqJ1VzgmGQzFdz6gPlJm+tNUQ2PjhA93M+OSHc9jRlNuyCc8tHJl+RJRJznBCB7N4Gji5ewm00Am8naPmgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726574140; c=relaxed/simple;
	bh=sp7cSthR52PzYqZRX3P72SbVpw5PQuVNc6bD1TmFGkc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=enDEZ+EOhfmhbih0BeqWYZriY4hA6erAPB10PMUjDk3R7jLT1UPKRbfc+t8SVK+PZyexI2uxXRK1zB1t3A6VDUMT91sP1XmQCAuGaa5U0pR0eTyUih9pesLBzOw48FVBNPgPpTfnmGDNE/WTacsr07oL22MAaqXVXQBIc93UzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gKoM1mV7; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gKoM1mV7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726574136; x=1727178936; i=markus.elfring@web.de;
	bh=zua1ApMHw3rOWmzAukL1t3peOdrxAZmWc2hAYjbCCCU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gKoM1mV7hSEPjC5gdHGkgVs9iCmUm3cZoGxm8XIE2nF3lN7+TAkGBZNUaa0iogyn
	 nTeLIQ05OKY9ksiLxg1r4QuPEfa5ttxI+3mh6kbnLGgnYK0D5uc381DtavfknNkuB
	 jVQPI2i43axljxUzf9dMwI0vEax4OCb8gHFIKU1Ps8NCFv7BTlBnkTSnggZqjfQle
	 pJtIjsNWaWIpOprkFGJdlDBWhwlBJBAaQxSje0rqLLXtCPpY0vUZsAdKhgIHj4Gy7
	 lXyKJAJjv0ix1WBbqRgnEFoCBfLSTBBfWx9uEIhr+ztmN/6vaD1Y44Qa9sw7jemaj
	 XytwEx1ImwCs4rE3kw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MEUSE-1skSAT3hF4-0019Hc; Tue, 17
 Sep 2024 13:50:11 +0200
Message-ID: <4ca111f2-9b38-47a1-88d5-7dfaedcc6ea5@web.de>
Date: Tue, 17 Sep 2024 13:50:09 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ata: pata_octeon_cf: Use common error handling code in
 octeon_cf_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sR5GSIOYZLM/xAaDxEcWkO2gnVy/0XTJj7WtkmttGKzyXBA3hJW
 lv/TOsnZCwQakzsKwIkxNNB4N1+q3oxeaIqngL+Wx0cYpeu7+nM51QEK93SSt688KFaIfur
 6OgTtxQu/W9LWsmzSNeYoF+ElXuD3Qcwu5JUMsSPDAPgKjL/kX0d6YplE8oGU08gQzXO4k1
 guDK52WYUZFu5fmGhOe1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RFFaeWbjS2E=;cKwxwddK+ZEkN1vEtSSuRUz1lPf
 IfnDYNi/QsqRVvjr6mVpvTZRUxYCfM57g/34/dNY+AwM04cnT6a2SX+4cM/OSqo4tfmQ8cNqi
 TizzqyItFCfD2dlDIWPGlRFb4dLq5IwJERBuqtPU+B14AiIuYSy2GAP6mbkIWf0q+4k3qZHWj
 JfEPc/XqDbUffaGwdx/lKtCdpqJHw+XXeUcovpJm2L2fFvFBqbIyx06xVUJXHY0KWQnKJZZcI
 TurpdqS6P60fY2XgTOZWSKl91Wm+5wlXyqStwzBLjaxtbXn3j5ufMLFhnOHB8pOMQBxL8eHzi
 N+XRufP/Vzs0ErklIwBj92jPRM6UyCDRgEC/DS8W8iNLvHCrue/F+MV7oaW/F9EsTHLZ1dkkk
 tuphm43vTMCOi2HxYJ+d3R2lZCfeRUUVPNwGOjvuYKNxPb9P1qefcyCDq88uQW+9/fSEFsU9P
 ZYbFHq/Kv5iC6Ja+Uab34B4adB8GTe+w1I5ZIuGkAFt+98FSnxEABH2uEcOspbmy/youzTK1g
 SUiJsxajKMwPb3iWQN9rFGdSpfPj4DMdF9Rsjs9Hjob/Fpq5i6Iky4cGHwTn+4ksirJ7OuPeo
 k6g/sjSoNxv8gEPSRh031wW2g1t38cfFjx5M9F1wkQx6/zmI8PtOgN9k1l5gZJKNrBTHU4oJJ
 cZB7gXL/NSNe3+z2FwPrcZwKWg5nwVYVAdGXXGb1t7jmEMzRBkFBh6MeckUslRBXGGFpEjQVS
 WNIF7uDQG53bum20HePAAod28W/bYtvQrKVlmaonDpJBy/Ld+il4ATVicYQF3lct+wz2wdE10
 98K8hf9d0xJsqtk2cVOFXq3A==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 17 Sep 2024 13:43:24 +0200

Add a label so that a bit of exception handling can be better reused
in a subsequent if branch of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/ata/pata_octeon_cf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 0bb9607e7348..62289f6aef95 100644
=2D-- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -848,14 +848,13 @@ static int octeon_cf_probe(struct platform_device *p=
dev)
 				struct resource *res_dma;
 				int i;
 				res_dma =3D platform_get_resource(dma_dev, IORESOURCE_MEM, 0);
-				if (!res_dma) {
-					put_device(&dma_dev->dev);
-					of_node_put(dma_node);
-					return -EINVAL;
-				}
+				if (!res_dma)
+					goto put_device;
+
 				cf_port->dma_base =3D (u64)devm_ioremap(&pdev->dev, res_dma->start,
 									 resource_size(res_dma));
 				if (!cf_port->dma_base) {
+put_device:
 					put_device(&dma_dev->dev);
 					of_node_put(dma_node);
 					return -EINVAL;
=2D-
2.46.0

