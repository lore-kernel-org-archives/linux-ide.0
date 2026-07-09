Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1A37648F
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 02:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564334; cv=none; b=lTBRZky2Yuf5+fohCKpPV4P+3N5y6c9tYbp2ZYW8um43kmJc/b5eBgVJoPhrZAZj3iRpX54zjFXxldVf3yDf8Cd95YnPrOEfoFjzFI+sCoGlwSNXfoJXPGKcHU0HMEJ1oVNwAr9k7WWKC9dsiEIk6D3vtc933bJfMnQiOkZV46c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564334; c=relaxed/simple;
	bh=2Dtmbs89HKUndcVX4gVLy7bjqf9OKz9nj6X8XiPjNJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNIT+36P/RHQEbx3yUI8HnHsx8M1WPT5yb0Tv/OKNJEBjeQzbegR3drH2JdWDNta0X3qaIZx4Io6an59Nx6qxnDbNUKC+Lb3g6PR+MFLfTT5odZO533NASFKxlk04o7jIIQ62uyAc+KwH2vGYN83V9UsFu+p+sgcPdrdioe+5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jh9LLdgs; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh9LLdgs"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8485fad302bso22710b3a.3
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2026 19:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783564332; x=1784169132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=18JTIpV0nCmEL5fegM0Z7dyxwLAxPNhc3uNEqo12imk=;
        b=jh9LLdgs54WHDC2I1oZqVOp5RX47vfj8MN9/RbqTnpxVkRPWZ0O/RZBcfHHt2Fcbma
         D0Iq4+seaNZpOwF63F3u4c36mITvGsjpj2omVrryD7qwApl+0W20JvU7Kw0dEwDwc6nl
         hrzWNLi4Gehc5FQleGyTIJJ1QP6DQzQCXIAQjly8DvG1oBtyQrhvBU8Ex+2JpOODENnI
         Ya2Wmrknw7rjaDzEqe0N44JxLV5iSK/7Sew5SqwGSR7SjVpqFn3p5+lCb119SJM9vSZD
         Fa4rKkLHoeq4vQ8BU9MOco01BkMaXcm1KXL0rhRFznD1JdVvNGlw+t+Ols0wXTiougLx
         tmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783564332; x=1784169132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=18JTIpV0nCmEL5fegM0Z7dyxwLAxPNhc3uNEqo12imk=;
        b=hOsyuTQky+xvBP07aeHnO2Lfil6gKpljI5HwbZ6bQqQB7fCjWKwpTkxYirDUlLDA5W
         JcYdsE6/YJcCuBD4hlGhRxBAHQcYEwrZpqictLGLtCeMV0bGjT0erMQq/nCKfNWHx0kA
         f3diqGOBQzlLIwHDBH3oOktvS/WApZCBWEjaxL7wwm9jtNUgg2DGJC/wUBPCdlt2RC7a
         9QklUY6EZhKJMh7dgCfKtBAk3P22RiIjjQJoSsmq2m8567loLEkMJywfDkeXggib9m31
         H+Tf/9JXPtFnKzIrz4sgGhe7wLXgubzUmIg1kgdCCCVIqH5EIZvuoFBc/XhwODVTr0sU
         FLVw==
X-Gm-Message-State: AOJu0YzrnL/JHJAiBmZ/2RGe9+HfhDp6If8jZrZ8w0LVm2yjpjPE3pnM
	pxGHJb+VpiQa9XIO/S+5OwmSzNGdkFT7sUXuAQ2poBKAM21JExDpyb2sZOUALg==
X-Gm-Gg: AfdE7cmeTiUe0MZ+lPsuswQs5cPmR/OGJRsaa22UlWAH/P9Zpfedua2/6RW8NMWCzpE
	v5A15keZVLS763elLbTGfV6OaaXvY99G8n9uu7hUq9eNq+FORhNQlBJxaiwLV+KPohiwHJpXa7Z
	6CzLt30KYke8ucPs/i+c/MH0ZOD1lpGkuW2OKwiSoQEL9R6WGkVt4OoYzgvnPvWN/vWy/HCQeB8
	50GyySHhAKbzTf9PmDnDjE0aym1fjkZHALORZOq/8FlTyVXI2NqAWxcYHc3ROAky/VSD1JiO97X
	Wfm4sWpjAYoxTjR5pHjoPy66SArL7615sy3vEpxZswhepjNRDcHmFbb29M5dB0ktP+puovGxjgF
	RwVMdTtSlPMtw6BVg4PH9hSPcm4aZTtZqBDg4z7MZNHfhu2rCERQexOe7GmB1vSBcK9yH+UqP/g
	pLtbE4CoM/TCFFwBw9vuE1bNIomXTnEqwns21P5K8aHtqMwspDKji3HcWkxRXKarVAjyxGnbkpv
	1gPRbnE4YHvkZ30y8I73gBmEF2ZAL4869OP5s9391PM5obqFz7B9frpFFJvtpiioT1MqAkK+tPH
X-Received: by 2002:aa7:888e:0:b0:848:2f77:e2d8 with SMTP id d2e1a72fcca58-8484390d246mr4750121b3a.65.1783564331717;
        Wed, 08 Jul 2026 19:32:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b975a0sm7935954b3a.14.2026.07.08.19.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 19:32:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Prodyut Hazarika <phazarika@appliedmicro.com>,
	Mark Miesfeld <mmiesfeld@appliedmicro.com>,
	Rupjyoti Sarmah <rsarmah@amcc.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 5/5] ata: sata_dwc_460ex: disable SATA interrupts on device removal
Date: Wed,  8 Jul 2026 19:32:02 -0700
Message-ID: <20260709023202.2132165-6-rosenp@gmail.com>
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

sata_dwc_remove() fails to mask the controller's INTMR and ERRMR
registers before tearing down the host.  If the hardware asserts an
interrupt during teardown (after ata_host_detach() but before the
IRQ handler is unregistered by devres), this can trigger an unhandled
interrupt storm and potentially lock up the system.

Add sata_dwc_disable_interrupts() and call it at the beginning of
sata_dwc_remove(), before ata_host_detach().

Fixes: 62936009f35a ("[libata] Add 460EX on-chip SATA driver, sata_dwc_460ex"
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 08d40e287bac..381ace5d33e1 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -752,6 +752,14 @@ static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc)
 	return 0;
 }
 
+static void sata_dwc_disable_interrupts(struct sata_dwc_device *hsdev)
+{
+	sata_dwc_writel(&hsdev->sata_dwc_regs->intmr, 0);
+	sata_dwc_writel(&hsdev->sata_dwc_regs->errmr, 0);
+	/* Flush posted writes */
+	sata_dwc_readl(&hsdev->sata_dwc_regs->intpr);
+}
+
 static void sata_dwc_enable_interrupts(struct sata_dwc_device *hsdev)
 {
 	/* Enable selective interrupts by setting the interrupt maskregister*/
@@ -1203,6 +1211,8 @@ static void sata_dwc_remove(struct platform_device *ofdev)
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct sata_dwc_device *hsdev = host->private_data;
 
+	sata_dwc_disable_interrupts(hsdev);
+
 	ata_host_detach(host);
 
 	phy_exit(hsdev->phy);
-- 
2.55.0

