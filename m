Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9203F9287
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 21:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903601; cv=none; b=nO9Oq3VRualAwJoNUkpIAzHlDdFR+uMpW6JjFBol1GcUThIArSu5O6v9/rQHXtKaKZlPKffCcng9f226nQlTCLyjYyySAcPdcHVyY2VZpM+MSaiZ/6ydfRSnd118XbMPcF8P6UO1knFKiFfRcZz1SGGfXM8kJc719XZKTwNLxD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903601; c=relaxed/simple;
	bh=977pn0LLyZC5BVOhDeyI3JoMJCmiQAyuFK2zDe4vhWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TX9n/0b9TAtWJStN5Ns7o6Si7jXCEUeahji2LRdsMUXD5nXTDbJPdd0BDfytkxWxt7xIV0Adn3K7DERGUVXE6kSnLc5kaZJJHHWCbt5M/9OHjKChQi3LvWCHhfiBYHhJl8get+n6xdSoqkpchtaMW0qHSKi/5XaOq+b8JqWUTo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeaQ3MKc; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeaQ3MKc"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so4534931a12.3
        for <linux-ide@vger.kernel.org>; Tue, 08 Sep 2026 14:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788903599; x=1789508399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1sgkB+Y1tN2PwIL85ID71m07+dCgaqo9yFxVcudQGYo=;
        b=EeaQ3MKcQwWfAgytO0Z+WIcBjLZfThYEeoz5gLALwD+O2Hd/4jjBKTad8rbne2wuab
         VmCFMsjDxcJKIbSeg9IYj2w+lWbPkEEgp+ViCaMff7SI2Tev7LavbEG5G+sGsJJkbTns
         GYSu2Yx/+0UZAo/x24p/DPp5veTCs1c3kRpwbpJA2dcbmLdVBWEtDw8WsPbCPlY76WEB
         vBcoWJNN4RCrAE3xnMXev4EqHfF02NO6Co7rsGn57paqdxWH47/8YoXSKvb7lbP39/eF
         1PPo6uPvpcHrosNWthJ4mWaUAKZRGwY2NLwOD+XP4wr3RWixdhFq1JymkDsO+RNgNxmr
         mNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788903599; x=1789508399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1sgkB+Y1tN2PwIL85ID71m07+dCgaqo9yFxVcudQGYo=;
        b=q31XtyOO1E7f7sTsJS/vpWv1Gb/9ckNtdZiEImgLInGOqHDWYnfz7kYs5KqMvbna2N
         oWCPtT08qPWfou9wbugiR7z4C8Uu4T+2A6tswZFK/n5sfAc3w1+WuJT6Rr5sAd+fJZ+G
         wB3xQfb/EnVjWFsrffomS2CgUeRMDdGOVnyKnnBLbeFtNvSMX3wazl9pa80xYW+7ETNW
         bFBsxqg4tjwU9Fi5nefGzSI4HhnwKKYfQS6JgYxuKXrNhKABJZHAYpEjIsHbUgrWr5jW
         MwzGkOFLP9oPK6+MlvkCLtrz6VIZyBxJDlMEBr1QiaQoQmziMobNNBGu6vo533EAPFBJ
         45MA==
X-Gm-Message-State: AFuF++nkz2O+Ffh+FmOCwKIc73HeGxngkpvoDx03p97j0zFL/LEcdbt9
	dRMml/ZS5g35cYb/U05iTusOdFzpgYnhL0h8Z1PWQiAyAzXd/Wf4koVBwqeQ+g==
X-Gm-Gg: AYBFou0ALC1fHT8hb7cbI2khPQATsLySnhIJBsVDvYa7349FANPJ5YskCX8u7dPL2X7
	5BvU4+Q92rcnYFPq1tSH97ck5uDf1B+6Ri4qUG1z9v78bbTRqAvL/TO/ahnjNCFPCj9PMxp8r8Y
	nYxN0lLcaN022A/ZQI+nZYnGDUBLWXvrCkInV01BLzOt417lh0Mx9HZDAG/9Gotf6QhNoP0QvCz
	5mHSqw1onoJ6Uu/ERc7o2NQR2eJbg0toVEsLMjw/0A5EP8CETzk7zhf3t/mFVw0ODQfbmgtcv9X
	C6Nh/WthH6hkoARib1RVGDirpntmI6UF9s6TfwKRnV6iw3Y+EivpSln84DaZ6XX6IML0i9zY+6y
	kJ5ELqO2jWB9w/Wf0Ddt+A05Bnf/XkpRCkzHeEvNVAdBsoAiwOU4IFWxwu3Fd9JYkO6wyqWtsHG
	diSuwfHVodD10xVF+YtO8MsbG3nmxT7nFqpkPkonNjWuCYgDB8T6a2RmmqWZeMKlGjdV5TlKIFH
	5vm+a+Tyqp6Lk9wKn4P19c49d38E4OuuWAhGj01hF3r6T+KJ6b4+SWRSJprP9LLml8cl43SwPEr
	p96Sxe40tG5HFANAwVs2EKxTGwDFP+iyiqslcw==
X-Received: by 2002:a05:6a21:6110:b0:3d1:3c2:85b6 with SMTP id adf61e73a8af0-3da39b43743mr50588659637.5.1788903598992;
        Tue, 08 Sep 2026 14:39:58 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc45e15604fsm5608261a12.0.2026.09.08.14.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:39:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mans Rullgard <mans@mansr.com>,
	Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] ata: sata_dwc_460ex: fix PHY lifecycle ordering on device removal
Date: Tue,  8 Sep 2026 14:39:57 -0700
Message-ID: <20260908213957.596103-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sata_dwc_remove() calls phy_exit() while phy_power_off() is still
pending in sata_dwc_port_stop(), which runs later during device
teardown.  This violates the expected PHY sequencing of power_off
before exit.

Fixes: 0f48debdb906 ("ata: sata_dwc_460ex: add phy support")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: resend as standalone patch
 drivers/ata/sata_dwc_460ex.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 8e3fc713891a..8a1d80ac906a 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -851,10 +851,14 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	if (err)
 		goto CLEANUP_ALLOC;
 
-	err = phy_power_on(hsdev->phy);
+	err = phy_init(hsdev->phy);
 	if (err)
 		goto CLEANUP_ALLOC;
 
+	err = phy_power_on(hsdev->phy);
+	if (err)
+		goto CLEANUP_PHY;
+
 	for (i = 0; i < SATA_DWC_QCMD_MAX; i++)
 		hsdevp->cmd_issued[i] = SATA_DWC_CMD_ISSUED_NOT;
 
@@ -880,6 +884,8 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	dev_dbg(ap->dev, "%s: done\n", __func__);
 	return 0;
 
+CLEANUP_PHY:
+	phy_exit(hsdev->phy);
 CLEANUP_ALLOC:
 	kfree(hsdevp);
 CLEANUP:
@@ -897,6 +903,7 @@ static void sata_dwc_port_stop(struct ata_port *ap)
 	dmaengine_terminate_sync(hsdevp->chan);
 	dma_release_channel(hsdevp->chan);
 	phy_power_off(hsdev->phy);
+	phy_exit(hsdev->phy);
 
 	kfree(hsdevp);
 	ap->private_data = NULL;
@@ -1163,6 +1170,10 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	if (irq < 0)
 		return irq;
 
+	hsdev->phy = devm_phy_optional_get(dev, "sata-phy");
+	if (IS_ERR(hsdev->phy))
+		return PTR_ERR(hsdev->phy);
+
 #ifdef CONFIG_SATA_DWC_OLD_DMA
 	if (!of_property_present(dev->of_node, "dmas")) {
 		err = sata_dwc_dma_init_old(ofdev, hsdev);
@@ -1171,29 +1182,26 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	}
 #endif
 
-	hsdev->phy = devm_phy_optional_get(dev, "sata-phy");
-	if (IS_ERR(hsdev->phy))
-		return PTR_ERR(hsdev->phy);
-
-	err = phy_init(hsdev->phy);
-	if (err)
-		goto error_out;
-
 	/*
 	 * Now, register with libATA core, this will also initiate the
 	 * device discovery process, invoking our port_start() handler &
 	 * error_handler() to execute a dummy Softreset EH session
 	 */
 	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
-	if (err)
+	if (err) {
 		dev_err(dev, "failed to activate host");
+		goto error_out;
+	}
 
 	/* Enable SATA Interrupts */
 	sata_dwc_enable_interrupts(hsdev);
 	return 0;
 
 error_out:
-	phy_exit(hsdev->phy);
+#ifdef CONFIG_SATA_DWC_OLD_DMA
+	if (!device_property_present(dev, "dmas"))
+		sata_dwc_dma_exit_old(hsdev);
+#endif
 	return err;
 }
 
@@ -1205,8 +1213,6 @@ static void sata_dwc_remove(struct platform_device *ofdev)
 
 	ata_host_detach(host);
 
-	phy_exit(hsdev->phy);
-
 #ifdef CONFIG_SATA_DWC_OLD_DMA
 	/* Free SATA DMA resources */
 	sata_dwc_dma_exit_old(hsdev);
-- 
2.55.0

