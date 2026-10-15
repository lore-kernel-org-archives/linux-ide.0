Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C83248880;
	Thu, 15 Oct 2026 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792033629; cv=none; b=Nc1HyzcDMMf+h8e4KmaP4FCrBJlfZNhbK+DHQaJjkVVHwYLzowuI9Eh/b9p5Vs+ZTeO+p4NXTTXJUA02w0U6Zjh9XILBonaroAArKJApOUIwIUj1fSbDKj/OjenvzCmzvUiT44h4Eljj9JbmPEniDqBAgx993+3neAsGkeRwrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792033629; c=relaxed/simple;
	bh=+gYw+3sUsg14DlcbLrjueFcj9EC/ttbsvn7/7gIUaiM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=jwaU+LdeHkrHw1WktfY18fE8r+w3HYfOprWzomw6o7M1mKoYQnba1DIJq2597eOrO9QUGm2fACLgmeEp53YjuQAFRkPZA+AUTWTtC+JLOTCRxBXwRkMjNsFJ+LfQRmEnu8/cExC7ehSPafV48Wmqf9JYhjX0h1HdqwkHJUoWeh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=w0ycVgh2; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="w0ycVgh2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1792033620;
	bh=yUDt//PJXit0FvcW0Ffq9mi2xIbedhJD3D6xAfTiaOs=;
	h=From:To:Cc:Subject:Date;
	b=w0ycVgh2ou52g+UEfxlJ1Z88qxeTD4rikjJgLrYjDr3WZBQekDxGumtY8Z/uCu6pP
	 +T6BSPAlsYr+4p6+a5HvP3g//r8bG1MIlvMdBTuHRPsYM3i/WRSgAhkJbUFJlETX4d
	 z+a1ZL4Gp1VOS57K0CThqZ4RU9DfOkD9PFuTL1iU=
Received: from RE0700.barrietech.com ([115.196.186.15])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 1B9B66C4; Thu, 15 Oct 2026 11:06:57 +0800
X-QQ-mid: xmsmtpt1792033617t1vug9ypo
Message-ID: <tencent_E0E7052529B6851284963EB90DF4D28CBB06@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnL0o1PdiPUuyqKyv4jKqvl7xvb0gtkWzDzWoEct0TCHD2rHkDX1C
	 wQNamOpr4B+XWNuBuxOOd0jfEKpzZZB+GnGoym1au15zS+pxxr02f9XIJgJWFAA5Osz/HT+E5Usl
	 AX4ZQKzvpNJj3SWnAGEdSQdFdGx9t+PEs50qJaKa6ok9MK22OhBZ+8ES+MjY6aDRlzOadDYDSVcL
	 tETN0GpEoex6G0JGjSv7588aR0gKqkih7pwajTpOZGPKdZronWZCmclr8AEfcCpQml/iOKP2w64L
	 QBG561F06l8S1M0qkQ+xYIlYDbj2pq/On4NWpNCiexNPLEEqb2/m+2MgIFmbvXRlbI/h5+1AbR1S
	 0HYzldj3acVGQTHam9XHX7bLnft8YX28d+FGhcNn2HaC1TjSUIVz8hwxFBWZi5vVoFD8Ng6Hf8Lw
	 p0ajy+m0/4P0G2XbxpSPh3bFkmqgDre66IbjIwNRcAcdv0ah5vkQIcURo+rBCRWoZH5YgIUGOhmY
	 3NcICgohU/NmbD/GYdZ5IxVIjeOtlABduBa/06C+GttvJhvDsZEJOryws89JdqEbMgyyFjq8m4rR
	 OzWGeOl6j8Tst+UXtCjwq4yuRZEgm2q/QCfQr1X25alIXZHTh867fJJUnVGbfhbp5sbItBMwrJyr
	 /kZ4XJpg3Yw0m92QXRLKi9eRPCHRsEPU03SanEX4X9Fl2LsKXuvNX13cXzZtjhTHZmWxn/oY6s3w
	 TThQzg7GOw8z+UsWt/wk9xaDlc/T3uNvUhyQTAzz4D5js6SbLnAsUAqLUldL0jN4VuIU6Iv+i35y
	 2OFzZOOrZhGZt1u6U1FvpCq8RNGJy7EOM8WC9d1Do8CN9k8uNtZwRriWCZG7Jx+nr/0ic6rXs4xl
	 C64RUjKCGuPYm1FMr7kD+PFZiboHaU+OIjXgYexEfGQFDI7Y8uO2LzBJ/bk3ZTwbhhsNP+QZuyEJ
	 6pxT+tIK0iy1nVvAtQ6BvKGD75wfgfaBZ6hxdBVH2+81V+IvG2PBO3p6CkNeBxb/laEDyySTm/44
	 ZdO/gTj30BMEdZPjoaMNy7WIgcsY6OcvFldNq8U4nZsoXZycYBPY78/WexqP97NXMx9llx5mOqyC
	 eyhkrxH6w0+TsZS6I=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: zhoumin <teczm@foxmail.com>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	teczm@foxmail.com
Subject: [PATCH] ata: ahci: preserve preset port masks
Date: Thu, 15 Oct 2026 11:06:55 +0800
X-OQ-MSGID: <20261015030655.6682-1-teczm@foxmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ahci_get_port_mask() returns zero for absent or unmatched parameters,
overwriting the mask set by the Marvell PATA quirk.

Update the mask in place only when parsing a global value or a matching
device entry. Preserve existing numeric parsing and override behavior.

Fixes: 70c1595c181c ("ata: ahci: Allow ignoring the external/hotplug capability of ports")
Signed-off-by: zhoumin <teczm@foxmail.com>
---
 drivers/ata/ahci.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9b8c0935001c..324e4918a055 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1654,22 +1654,21 @@ static u32 ahci_port_mask(struct device *dev, char *mask_s)
 	return mask;
 }
 
-static u32 ahci_get_port_mask(struct device *dev, char *mask_p)
+static void ahci_get_port_mask(struct device *dev, char *mask_p, u32 *mask)
 {
 	char *param, *end, *str, *mask_s;
 	char *name;
-	u32 mask = 0;
 
 	if (!mask_p || !strlen(mask_p))
-		return 0;
+		return;
 
 	str = kstrdup(mask_p, GFP_KERNEL);
 	if (!str)
-		return 0;
+		return;
 
 	/* Handle single mask case */
 	if (!strchr(str, '=')) {
-		mask = ahci_port_mask(dev, str);
+		*mask = ahci_port_mask(dev, str);
 		goto free;
 	}
 
@@ -1704,13 +1703,11 @@ static u32 ahci_get_port_mask(struct device *dev, char *mask_p)
 			param++;
 		}
 
-		mask = ahci_port_mask(dev, mask_s);
+		*mask = ahci_port_mask(dev, mask_s);
 	}
 
 free:
 	kfree(str);
-
-	return mask;
 }
 
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
@@ -1736,10 +1733,10 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 	}
 
 	/* Handle port map masks passed as module parameter. */
-	hpriv->mask_port_map =
-		ahci_get_port_mask(&pdev->dev, ahci_mask_port_map);
-	hpriv->mask_port_ext =
-		ahci_get_port_mask(&pdev->dev, ahci_mask_port_ext);
+	ahci_get_port_mask(&pdev->dev, ahci_mask_port_map,
+			   &hpriv->mask_port_map);
+	ahci_get_port_mask(&pdev->dev, ahci_mask_port_ext,
+			   &hpriv->mask_port_ext);
 
 	ahci_save_initial_config(&pdev->dev, hpriv);
 }
-- 
2.53.0

