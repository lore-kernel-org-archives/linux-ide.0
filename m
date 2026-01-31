Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD830AACA
	for <linux-ide@vger.kernel.org>; Sat, 31 Jan 2026 03:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769830099; cv=none; b=Eg7iq4KON38pWQlUuaXtnLJ7Fk5N62WUg3DlXkg8g9N83uwu5/+UuzDjysDA7i2LL2LpDl1ZyX2OP/qGKVu9uXotylI7TFCRi+fGFxwGldR2hUiDDmCCHfQ1Bzyfn2pnuTki4o5ERxc7PIN64ug59wakDcQAnNZ7lCTcjz/RhmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769830099; c=relaxed/simple;
	bh=xj6L+XffNnN02tEvjrjp/p+xldzXofM0GwPRVmNuC4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hFaNgLLG18p/FrN0TEmQFe0mhoUrFadWuo2BCAQf+DdiR5jML1O2ww6Z6PIksGAx3XLtSN4elv+NNxk/spu0y2iZoK/GyqXgw/D4zv8XaRvvgZG3ikzjpsRMWADfGs8kemT7YfF1OzD3a6nzNVLnCXiIvcPBL4xpu+pLHPmy0Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBTA1xnw; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBTA1xnw"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b70abe3417so6333473eec.0
        for <linux-ide@vger.kernel.org>; Fri, 30 Jan 2026 19:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769830097; x=1770434897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOEDi8dw9GKSeEtXbEa6Z6mE5otUGJuoJZqJCo4VJOI=;
        b=KBTA1xnwl/MhKWtT79pTN4VnHm2gSCCXeUy456jQd9MgCxP8SrbQvTf3R0qQ95YqXb
         9jFEjy+1b2lP5mp9ejwaeh1+YbmR2gOtadJtnmWqZiA1RD3FfE9S9cxKlIigQM4kPUZa
         xqJzA+Vy4uuLGcZUaGI1MbTZm2d6uGbR+MMjgEMLVpus5GZ8LeE7BqvDVCH8tXT5cCLG
         LuyntOWN6J2vmMeV2fx6pnvHcp7wW5V300m7rcxirf5/0Am6ueXoiCf0XsuPDHOUXeuc
         c8/52Pf3CunOvKqNArRTk1LifouEwFjlstCBXhyHTObcOGXLFSacATtBVb6JncAJOGr5
         s4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769830097; x=1770434897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOEDi8dw9GKSeEtXbEa6Z6mE5otUGJuoJZqJCo4VJOI=;
        b=dxc1RvJ3Y7exXtCr1oIz/EedIKj9KiYDJg82bhFPye559XBHRjK46e4gqGlq04RF4o
         DO+WYHdmytMDN56Z8Gnp3ONtNnLx+q43D4GeeVRPBAPJzTIk1KuwTLsDwSvrwlXTtxao
         1Q5DpoJDlzMXFTgMFD2ZPUiT0XjTFoIaD9TUNyAX/mu3DVj3uXqbBzxjeF/9vBox77+g
         gM0oAKk4qB2kC3slJd2MKS2Cxdr3F8iLxcc4TITomX5EEHx2eTSnTQkYuRlMfiBS2KPv
         +zev+zJ06wfa6WLkAtfMwhFRvEVJIVFuI1nY9b0RDMd2+Cm69PA4sPHPrH3T4IgUp5x2
         Dm+w==
X-Gm-Message-State: AOJu0YyQigB86wKFv2MVAqALG5E09+FM/ehu1E5nwCcwo9c2Nv8KFcqv
	rM6WYPdP+WgnDMP8nZtwTt8BT3V6v+2dmUftBqF7yvvVGyovU89dBIb8AfNNCC/X
X-Gm-Gg: AZuq6aLnk4MuOO2Lf36MQfdbNwHIMIzWsFimWyHw0o+i4ypfTw6a5ebiv70nRiRG2sc
	WhGcldnPn/QK3C3JST7Pq5WEYp4dgxD+xC/A7+STTj8Iei4oRrHKh2w5jfflI4wHtkTEXCf2fyO
	qMgbArWRR9Qciloarl6z6M3vFldM4QLnXdymiJNWTspabSnVpARCJifzNfpAD/nbUMALepRBuSa
	vMbjFwTDzHH8l/FD3PItw+vhTEK8tzw3GeXrrXq0J+pU4eK26IdFqwqGNHOZZr78dNE0cNOoVz/
	SIVpGrk4UH3a0Tm8HZwd4cJFkYzvmYWZAYpGq6sGQGaXtWvUSVYFIzAX5gN2qTzr80Y4WrNSkih
	b1bro1/s3NxpoRrrsEQhCz2CKdvy+DqbxGiuco0XiypU6kGaAC8U2zHnmbkOgNyPaRAuj6RtwN1
	Fl84+cr184n8qBTc5j7hCgEpRgi9plgUjhtSLnCqfflQYSx4vx+m2BmBW1mzvEU0aH5AcrXNPJk
	1T+dP/MMMm5byJbm8YUnp5kEF6//3h32yxFiAHCmB5vANK1Vg7fdu09NbD5QsnHjPwZBpYVK+LZ
	6Ese4on0tVRpq1Q=
X-Received: by 2002:a05:7300:6404:b0:2b7:2e24:d5d6 with SMTP id 5a478bee46e88-2b7c867f678mr3087168eec.19.1769830096925;
        Fri, 30 Jan 2026 19:28:16 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe938sm14684015eec.16.2026.01.30.19.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 19:28:16 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2] ata: pata_cypress: fix typo in error message
Date: Fri, 30 Jan 2026 19:28:11 -0800
Message-ID: <20260131032812.12451-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An error message in the pata_cypress driver has a typo "mome" for
"mode". Fix it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes in v2:
Rebase on latest mainline tree
Add commit message
CC maintainers

 drivers/ata/pata_cypress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index ae347b5c2871..3b0e6858d727 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -62,7 +62,7 @@ static void cy82c693_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	u32 addr;
 
 	if (ata_timing_compute(adev, adev->pio_mode, &t, T, 1) < 0) {
-		ata_dev_err(adev, DRV_NAME ": mome computation failed.\n");
+		ata_dev_err(adev, DRV_NAME ": mode computation failed.\n");
 		return;
 	}
 
-- 
2.43.0

