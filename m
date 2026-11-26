Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729685;
	b=iCvht4ulZu0rOSpmwaIvHDC5IWGo9CQcMlzLcjwTnCA9oDTBtZPkiSDkNZeOVv0xD7fn
	 NPhTE+xqf5tS42w7HizY6il2UsiFHppTAbmDxOHcx51am2FnxTN7lsy03dEcsaam8oXbI
	 9nTnE7gfAq4yr9X+RxeXar1Rmiakf3TtXc0HeS/uuAiADDgb7hV58wBPaIPtoVFBVIOeh
	 ZMY5ZImbN1B1t/fuihr2XDaIy5UFlDjZKUzfIU+jKTAckAAgJrduWkcXld64Q+cjrcGcd
	 A0Pr/rnLA0sjlzLtel5CmGvSwsi1xGGMNM9Kd6Vf8znGChST5SdC0ZlAt5FHOyQMlbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jYp66D5Imzo0CzQJ1wEzlIF7yj6HUJmIaReA3hk0gfM=;
	b=H/5Pa8WmgaidIPAAFPYngUyuSRLBysy7Y22hruQHO/18+LEeKV2ScurEAEcbBclEavLM
	 yQOXvNdYWD4gaj74wUuH/v+KApJy4w1CtauOJgia5Ju2FgcJcnqgkZbY5dKh+2bEe08J1
	 my7tbTWTIhUSGL5PmzWVMdvOPNCWy/D/V+kzR1uQ5+02EqA8pAU9Ao+DMO70Ejs1RP3kD
	 cs2r1/uqTDunRVqYDVGeG/gVX4PCIljoIcJr7U2EkuOxjlmp4XezQxEnkGupfI8wnatD1
	 yxJVokOx7oRA6N1S5yu8zhRx/mrUEgxnCBlfijVgnnF7R1a9ShW4BMu8+3zj/l+w4Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLN4sSUa;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696F606A33F
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 21:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8696F606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLN4sSUa
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so3793163a91.0
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 13:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729685; x=1796334485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jYp66D5Imzo0CzQJ1wEzlIF7yj6HUJmIaReA3hk0gfM=;
        b=jLN4sSUatSCzBBWPw8S+gbPgh3SJN9qEQGzwB3Yyyy44tRiDCd0TLy50ccgl1X0Kog
         r+PEXyTCmo2L/jdxQsAwf2KWzUD7Rzv0krr6TMfCBJyPNrqgymyz5+70kKIDfD48AsqC
         lvARTVIUHo43JiHDi/rC1cLBljZc8xmkxs5hNfi9U7dG46W0RW8UPiNkwhtq+tJsldPb
         0EbIwjer6h48MWFo3EGKRrW1QkhOdD+n8yEQBM1yLbNi6aBt5zQriVcg8PPLvEP3RQQT
         mPZBFzmILLAeSsYugpEtqeCzwHJlptiPBLY86qyfvVm+N0+c9Ekofp/ug/4NomceA3te
         XiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729685; x=1796334485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jYp66D5Imzo0CzQJ1wEzlIF7yj6HUJmIaReA3hk0gfM=;
        b=GClZM4H02EuYSrNgfl45Gr/MK5SQFB5t9TRb6REWPxVexaD4FUDvw4+6mIjl8SE4qP
         5WYZqz3fFAPRjvLtxuSMxHnfSx31lSCWCa+QcopruofjeZfYcoBddRitif8ettTVBfsl
         6sgZ04DbL2EuDwaxsmzrSaoHwd8GFH+R+siXz8mMLpuuXDgJaX57jd8V5VFPqk0rHoqX
         vbkBp5Afdb9vQwEoekwSCyc13Jm33CyRUKHvBTviLMlKbbLDIAjGFZp0ToBjblD3V4SC
         nDsvt8nc8PhkS0EnUKhdQhLSGnQIsgQFubHREuKV1OLDAvqaNa9VC8rKNP1pXq9xGIB3
         XC7Q==
X-Forwarded-Encrypted: i=1; AL+hErED5TJsCnq24TvKohAk9NaOEplJutMn/BRm373UeWA2MEsos+83Rv14p4zlZmqpgNAviYTWXfGLv/E=@vger.kernel.org
X-Gm-Message-State: APuU4Z90inh5DuQBzFB071yEnJ78fLvGszkmf8ThMw6Sz6oiWG+4vGFi
	xAp/icLQEU2Wue8LCa0iykhqgV5WXPmGe21IoOWONTfdhJMn8x8y7X5k
X-Gm-Gg: AZFdTZeQAB/O077/SpxS9b12QjPdcdGbJq7DNj2vlqXqToCdomMHRklobaPddMRrEF1
	b50QFAEP0vGSSv8BOAEmbKK2JHk4YJrB7LGUEDUJ15vEcd/Mz1IhcwbVkR2b8ycpgolOr9C5/sL
	plbhLfeWuGxABjvvOmDinqE+dzLuJs12ei8I4wmyxQKSBjD+upmPKObxiX5W1Y8EZhX5KulFxI6
	IptPDp5jjb3MEQiGJ3mfHd57zC1w4N+kAzV/Y1d+wjb0uJJQpXQlAXxqWrCutTWbJEW3d32FyVR
	PWc/nQjTQ3DWq0FQXWspBBIDUVmukZuivFW+SHQ535zuIGXcE1m3YkMxCSpGxIntb8qNrH3GWBk
	nOh9BXwbtfGIIBbpGy/LLQLLywXpRJUn5Ot6U1ICANMs98D2Qy5Oeab0aHLhBPcc6rXnjJnlyGP
	mO0NY6lhCNLh4zh0zzxYsd4V0jLHxkpp41/c1PS5RrXgNCybBZsvANUZGg3e7gJ/N6y72uqsNlN
	XUnqY8N45SfeWm+eSOEsG49v1mHptRVUrclmUxWoVGrkOoS9WughVNhZDeBwzcVBIYm4OzqdidU
	JUn9haMZGrkAdvZwFVhkFgFBVup5TuXQlV9P+NgNjGa+2jwMYw==
X-Received: by 2002:a17:90b:4cd0:b0:3ad:5c64:c7a0 with SMTP id 98e67ed59e1d1-3b41c92a56cmr21044124a91.38.1795729684865;
        Thu, 26 Nov 2026 13:48:04 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm34636414a91.8.2026.11.26.13.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:48:04 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linus.walleij@linaro.org,
	viresh.kumar@linaro.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v3 3/4] ata: sata_dwc_460ex: add missing newlines to error messages
Date: Thu, 26 Nov 2026 15:47:55 -0600
Message-ID: <20261126214756.39027-4-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126214756.39027-1-artem122novak@gmail.com>
References: <20261126214756.39027-1-artem122novak@gmail.com>
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
index 486ea94a0184..c2bbd991a460 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -421,7 +421,7 @@ static void sata_dwc_error_intr(struct ata_port *ap,
 	tag = ap->link.active_tag;
 
 	dev_err(ap->dev,
-		"%s SCR_ERROR=0x%08x intpr=0x%08x status=0x%08x dma_intp=%d pending=%d issued=%d",
+		"%s SCR_ERROR=0x%08x intpr=0x%08x status=0x%08x dma_intp=%d pending=%d issued=%d\n",
 		__func__, serror, intpr, status, hsdevp->dma_interrupt_count,
 		hsdevp->dma_pending[tag], hsdevp->cmd_issued[tag]);
 
@@ -498,7 +498,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 
 		qc = ata_qc_from_tag(ap, tag);
 		if (unlikely(!qc)) {
-			dev_err(ap->dev, "failed to get qc");
+			dev_err(ap->dev, "failed to get qc\n");
 			handled = 1;
 			goto DONE;
 		}
@@ -612,7 +612,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		tag_mask &= ~(1U << tag);
 		qc = ata_qc_from_tag(ap, tag);
 		if (unlikely(!qc)) {
-			dev_err(ap->dev, "failed to get qc");
+			dev_err(ap->dev, "failed to get qc\n");
 			handled = 1;
 			goto DONE;
 		}
@@ -707,7 +707,7 @@ static void sata_dwc_dma_xfer_complete(struct ata_port *ap)
 	tag = ap->link.active_tag;
 	qc = ata_qc_from_tag(ap, tag);
 	if (!qc) {
-		dev_err(ap->dev, "failed to get qc");
+		dev_err(ap->dev, "failed to get qc\n");
 		return;
 	}
 
@@ -1186,7 +1186,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	 */
 	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
 	if (err) {
-		dev_err(dev, "failed to activate host");
+		dev_err(dev, "failed to activate host\n");
 		goto error_out;
 	}
 
-- 
2.56.1

