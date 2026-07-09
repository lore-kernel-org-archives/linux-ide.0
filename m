Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221AD36CDFD
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564329; cv=none; b=qXDrNrewM37+L6OcT3OSBXYhHnx5XKH33owcWf7jEestYg91DmIC2sSHMQWsvD/eodBiZS2V5aJlALKeAGTWSp5n6wXeGlIF3wAmJ65eehmltSit72Tbmj2yXRsqcKS1KpFw7WWRcp0kdCls14jMcFWC9QQ+bc9Z50EtlkqvY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564329; c=relaxed/simple;
	bh=9dYLJgGNu8I32f87if5Q5pK0a3jpWdv8Kp36e3F2ygI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LShEnE0d4tbsEJVZKv+xZjrzuHoOlTUO9nB/Dmch8qwiUQ9aUO3xPKqTrHEz6y3tQnEm6fZilpYNkW2VijQw1MynXgmIpUogXT9S5XsfL02Qm5RkmP6DFFwJN9414EJPic6OpNoR0GqTihziftDutV88knjtQVEqlqHzZqJUPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ7IBiwF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ7IBiwF"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-848593533cbso238037b3a.3
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2026 19:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783564327; x=1784169127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9apZB0ggetfGgdc3bmsqNaTtxOfdIcGG//LQF2MtOco=;
        b=NZ7IBiwFBnqQKDXv+u1cV8E3CiaSeWei7qip4bWRQKEseGpJwTneJ6aeOUyJlcvBOn
         FoCzMtnrZE3nETm5mlwLdNmD+wcxIG7xfiOBSqKtT0HxnZcWrtSqlTEgshnGkWX421Go
         XPO0/086D2ZRa58YefZv/PxUyU2TyIKeF14oNC047JO7jy2LwDy+2M1agmX9Y3QBBoXg
         LyhO1PKiTncMMEb/5W5HPrbFv7OIVDKE+UDWdwLFEgrcuoLPS0uu2q7ikHRPgE5qHNCS
         JyKH6bT84x3SqmagPpCi6UDUB91A3bnSow8+50ckENhEhL0lpt5c7wB7rupr24aPEsfs
         RM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783564327; x=1784169127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9apZB0ggetfGgdc3bmsqNaTtxOfdIcGG//LQF2MtOco=;
        b=HJ+povMHhBKmj13wtShxP6D2EuAtlK75vLkkiNmjtfc8InkeKx2DrF7m+Y+DAGpD6q
         cPA76kSQ8h9ueHGb6ABSnKR5pabn2ovNn50ivUCvkNZYzhePVM/gaeACoaVAPJJE06X5
         0r4eQlj6APSgRiBu3O69Uz/TW7nFjvfisyBjwXNNwpGEv7n1xeLo19/5+AtmRhSmny++
         e+XqTV9rNkSUs8t7hpHcD1XuWchRFLQNqQFlq5eFqznlcjNVc19mnfnXN06NWcIRLX2d
         yeCW3mb7jgqVT7OVdNpCqYFKxuPAV3dAFDfb3CCwKSUc1aXQjXm/BueLI+m2bUDZC/u7
         cRrA==
X-Gm-Message-State: AOJu0Yx+ufx0NiFwV2V5LA0EMIUFP4GIEVIqfnnCDpoZNCeUIc0liePR
	53E1rioNEykwtGAamDgMsNXonqKntotIrRPA1R8FMwFJZjf57IPirJ+Dffkt/Q==
X-Gm-Gg: AfdE7clfZoM9GRMAz9RiICJQ9TLC5OiWvxFLehVCKf4MJPZgiS5e+By3hn5jN/5Uboe
	sof28H5AI2GqIdv+FQuoJS1kWCvJd6BOYddMOFyCJcd+58EABl7rNxaumB4Li2G3xtlqRPuFNw7
	8H4ian7PhQPdrYXQ4omxna8t2tUqqreInxDyX6kscCO7/+tVZCrTn3dBqIcx/dt4Mfd5xfZwIVE
	0vUMPjDkkxLTTzNdFeqBD4AJ2cK7YepXUxsns9AqzuxdIc1mFXtiQvxZriJrRCM90HBAqEqYa3S
	+roVAOXTlefJMOQcG80R+P16mLY1XyycATjRwonFeusZ7zX+BwCfnvvCWm5omXTCBdpC4JE/di+
	ACilm2hk08kOwepjPDUyvaQ+2jG6A1MXv/DbORPl2tvL7cGvhwfFrbw4R+Hb0dEhAqjXMd4fqs+
	96h3PZ02UWX5bkGI1tCXArOc1Q2Wt6nBEYxQu2FqUjby9eTijQR71PJ1jwfveJ66iArqMhfvK+b
	5NKO2+Sn2qInLpNvKpTZY7ZzknY7vDdXI0Ow57Zsb7pcpjMASX9ngJb2xDOwmdqrg==
X-Received: by 2002:a05:6a00:4091:b0:845:eb88:3d86 with SMTP id d2e1a72fcca58-84842f9fe12mr4778768b3a.48.1783564327517;
        Wed, 08 Jul 2026 19:32:07 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b975a0sm7935954b3a.14.2026.07.08.19.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 19:32:07 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Prodyut Hazarika <phazarika@appliedmicro.com>,
	Mark Miesfeld <mmiesfeld@appliedmicro.com>,
	Rupjyoti Sarmah <rsarmah@amcc.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 2/5] ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is registered
Date: Wed,  8 Jul 2026 19:31:59 -0700
Message-ID: <20260709023202.2132165-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709023202.2132165-1-rosenp@gmail.com>
References: <20260709023202.2132165-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sata_dwc_enable_interrupts() is called before platform_get_irq() and
ata_host_activate(), leaving the SATA controller's interrupt mask
enabled without a registered handler.  If a later step fails (irq
request, phy init, etc.) or if the controller asserts an interrupt
during probe, the irq line may fire with no handler, causing a
spurious interrupt storm.

Move sata_dwc_enable_interrupts() after ata_host_activate() so that
interrupts are only unmasked once the handler is registered and the
core is fully initialized.

Fixes: 62936009f35a ("[libata] Add 460EX on-chip SATA driver, sata_dwc_460ex")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 442c6e9d06e0..e206fbf6d2e9 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1164,9 +1164,6 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	/* Save dev for later use in dev_xxx() routines */
 	hsdev->dev = dev;
 
-	/* Enable SATA Interrupts */
-	sata_dwc_enable_interrupts(hsdev);
-
 	/* Get SATA interrupt number */
 	irq = platform_get_irq(ofdev, 0);
 	if (irq < 0)
@@ -1197,6 +1194,8 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	if (err)
 		dev_err(dev, "failed to activate host");
 
+	/* Enable SATA Interrupts */
+	sata_dwc_enable_interrupts(hsdev);
 	return 0;
 
 error_out:
-- 
2.55.0

