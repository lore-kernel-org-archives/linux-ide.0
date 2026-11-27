Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804955;
	b=nuXgRPvoumutR5L/MU+rZFH+LxvZXtOxISUFzprYKtF3lxpC4GsID4AdLV6UFUVmdLX8
	 SfHZw6zsCp2vGFOCV2/JPxW6jpfES/xfcpqbXLeOFNJSDcnDXlWWuZX/UWkxy2ia9Dx4V
	 NEpTZRyp4qgUi9LdPhL7I8ZPuiY1TXUIUOAre/WyULXhX3I7y5ZcIw3CsFgwjwI/KF/h/
	 tBSGpxKhHFyfGLeEXa6zGEtuJPP/S6SM2LfWSZ8zzngnBijWf666tVJTEoFCs7IVWsumE
	 Cs1yJYGQQcL8iIiOngCDW9rIMjRXgyXyAu3XqJBdwoF+ZFcTq4DewlUq9DnOmkgTrmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=trsewjbIKbhUgCdmXW33WeHcsR6jqk0XdT0hQ+HExeY=;
	b=bWEecBut0KCNGAnGJnJwtiC2QdotK7cdSHg2kIPD+k+Tj2vCVtHlD8z2drHFeAqVAqAy
	 LPBn80ITmWqxR8E4BrA2aSMIvOmXQILLHOXtKjDFYNsDV7xzv1B5sLNMZJrT9xYiObjR1
	 MAI+ot85lfFOIjWUc3cDCvARLRLwfjWTBYGAhmJv3wWTtyhZ7q+kjUL+39S0xcKY0U7lD
	 DnXT1kXsUvKGwQYgWMLk++QfYRBQaBclLFBzziDbsaECMQCGZscPj9ar9wWmZ2z8+FJMb
	 DR/TlxFYdJCsLGQuvd50l+7UDGGKbbfH2dzxw1nrpVbto7emxVlnuF3d9TVJ4e0EHhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qkXzaT5j;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539F6606A327
	for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 18:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 539F6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qkXzaT5j
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b3e85baf7cso4902319a91.0
        for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 10:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795804954; x=1796409754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=trsewjbIKbhUgCdmXW33WeHcsR6jqk0XdT0hQ+HExeY=;
        b=qkXzaT5jiMlZWKoYgPzl1d7Ks2O2rAVN9ON61o/q294Zp3Pvui2Hrsn2r07Z+7jiWs
         q3xqPjC7iWEaHP53sdX0NZ/LQcVRglnUvVnKMXr+LB0DNXOg//sGbFwRCpOS4nLpyxWA
         LqbVPsU8Pt12sp/Vhh8Rn3Slt3bJSNyPx4Zg7rWE7HvnqbH+oOq6clUdB1p5T8OkY5ih
         vgZI8WY/KWXymMHvm4pNxur97CHVxkr84pfHhSlv2r2nQWnGVJpxkuoI/LaoQIeTsiD+
         5nYCpTNIGw+uUYokaUvDK3cPbAzL/T2aoWznFtQWeRnnZmGJ3dadR5cw5BawMj5kacRs
         vlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795804954; x=1796409754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=trsewjbIKbhUgCdmXW33WeHcsR6jqk0XdT0hQ+HExeY=;
        b=UIMbnzOSGUTAFvZ0yDM+pmICDdkb/k3E+Xp7kXBrYOb3m4CuKsI7jpHEe/0DFDY0OT
         rFfX/7QYgsoHXwqWJvlUdYEXFfMHYHQfTwiGnCSWH9t79ksOcKqWk21E0JL/6NWMWCwa
         YhNEH6x3gcSVxu/y8pCrAqrRtfKZyqheqpQdm5H2d7frpgB0ZyfZWVvdaB5/NRS1icCW
         XbyjzKywdLxAuDu1uAu+hH4Un10QxIAtR3PNQ46fEQbHyGhecirAH42L7IVZL1EQV1MC
         fJyX5h34A90l+F23Z1d2xguNfz3FXx+WIrvb1akNZDypqEONGQt3EbppJSVjLnNXC8QR
         HS2w==
X-Forwarded-Encrypted: i=1; AL+hErF2hcUGwNJx3VVgxvOUamE1G8eNMSqtmu7aX9TgCCd3YgYfRmh9pl5lFzEzQlCdibmLHh0CxTknzuM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9v7Zu5a6IFJbG/uzZtWO+fEu+ZvP1d/NHUS/zJDEUfcPi5iesC
	VffrleTSjiTOOz9w2FRBz+Wwft1vvGN3Xrl3WYZraaHi2BP8ilLs+YnZ
X-Gm-Gg: AZFdTZd2+afCt64QLuy3vKKBQzCDbiuTGRF43Dg+17fNug78m5DUwRxdLlKuRQmiBTO
	U5QiGF1MHbofzpkq9Xni+oSYXAbwxBDVhSBPhlA200qi2ZBzW7PoWm3KgzE7MxnjcYMMybg6ufq
	ic70Pji5lKj8w89rXbZ4bXOV1WJ3pQ2sNpfe92AoDoz1MYzY2sWjL2na40pDPCZ5bvy7Xxm9152
	rwuFB1PoIs6+iqxdOdVUv39uhgfMj86WtFZMde5Yyvjqokwj3lJdvWtW3pAAYtxR7b9FVzzyQZ1
	VUSP6eSNtqYQIZA0vKw0InVF4FK9jKZNQ2Oo5CgnnCcvTeduhZfk5zKp4v/YtwEIYj/JPCvAY22
	9W04ap0xMdU9Guga5164MfmmruAX8tABQdI1GNkxTu1bPH0tMvrRa5lHpcJ7M+RIPxiDqmRqI31
	KcIqNggC3P4N8kO69qauTCzAmS5x9XW5YUXUvo+GU4zX/a7hZlimpPdnJXPzoPnIC5zkVF29uJf
	2Uz9zoIRGmMPRbF3H9Siy4AU8g4HQ/xq37yCiV9XbqLiLlm1FUC3FP9Kbip7eENh/byT/5FtcD+
	rIVm1e1bXkz0cx+Wt+t2m1Y+DkfC2Juv1fzcZaEHacXltrqxRg==
X-Received: by 2002:a17:90b:5847:b0:3b4:6094:2fad with SMTP id 98e67ed59e1d1-3b4609432acmr18849073a91.48.1795804953683;
        Fri, 27 Nov 2026 10:42:33 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4dfbe54a2sm19149071a91.17.2026.11.27.10.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:42:33 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: artem122novak@gmail.com
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	linusw@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vireshk@kernel.org
Subject: [PATCH v5 3/4] ata: sata_dwc_460ex: add missing newlines to error messages
Date: Fri, 27 Nov 2026 12:42:27 -0600
Message-ID: <20261127184228.185827-4-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127184228.185827-1-artem122novak@gmail.com>
References: <20261127181619.183139-1-artem122novak@gmail.com>
 <20261127184228.185827-1-artem122novak@gmail.com>
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

Terminate the error messages with newlines so that subsequent
kernel log messages are properly separated.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/sata_dwc_460ex.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 4ab378d2c26f..c05dd172f75d 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -420,7 +420,7 @@ static void sata_dwc_error_intr(struct ata_port *ap,
 	tag = ap->link.active_tag;
 
 	dev_err(ap->dev,
-		"%s SCR_ERROR=0x%08x intpr=0x%08x status=0x%08x dma_intp=%d pending=%d issued=%d",
+		"%s SCR_ERROR=0x%08x intpr=0x%08x status=0x%08x dma_intp=%d pending=%d issued=%d\n",
 		__func__, serror, intpr, status, hsdevp->dma_interrupt_count,
 		hsdevp->dma_pending[tag], hsdevp->cmd_issued[tag]);
 
@@ -497,7 +497,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 
 		qc = ata_qc_from_tag(ap, tag);
 		if (unlikely(!qc)) {
-			dev_err(ap->dev, "failed to get qc");
+			dev_err(ap->dev, "failed to get qc\n");
 			handled = 1;
 			goto DONE;
 		}
@@ -611,7 +611,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		tag_mask &= ~(1U << tag);
 		qc = ata_qc_from_tag(ap, tag);
 		if (unlikely(!qc)) {
-			dev_err(ap->dev, "failed to get qc");
+			dev_err(ap->dev, "failed to get qc\n");
 			handled = 1;
 			goto DONE;
 		}
@@ -706,7 +706,7 @@ static void sata_dwc_dma_xfer_complete(struct ata_port *ap)
 	tag = ap->link.active_tag;
 	qc = ata_qc_from_tag(ap, tag);
 	if (!qc) {
-		dev_err(ap->dev, "failed to get qc");
+		dev_err(ap->dev, "failed to get qc\n");
 		return;
 	}
 
@@ -1187,7 +1187,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	 */
 	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
 	if (err) {
-		dev_err(dev, "failed to activate host");
+		dev_err(dev, "failed to activate host\n");
 		goto error_out;
 	}
 
-- 
2.56.1

