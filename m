Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5341E18C02E
	for <linux-ide@vger.kernel.org>; Tue, 13 Oct 2026 04:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865847; cv=none; b=V72rF+D4TrIA0h6fYDTtfdO4IfcCquN61A2XKzBw6XKxUpjpmvJg8IZ8Lh2GArS8IZ3FzlYLMQSFn3PflzBFWEazprST5PQRaFqDHMb2P/mcuV3KwXGQUHgWAYqkHbD/pt14vUrJ5IVDwG/kdlSnA/XmM8fSEuTygqzbRlKPXBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865847; c=relaxed/simple;
	bh=BNrFrJE/wUpsKueD+ymK8y1ph8hEFG7Q/w6Ctvoyqlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WGGonUg6s4zWsB/sEJy3O8DWTTLfzTJh6MYA7UDhzzCgAp3BAQEriDIALLbBLVRxUeNUTUT9sSPUZV5BoGFbldDc082nSqFjUbKX+eHx9G7NGrLeRg5doIeat9dIThxphE5QnLhS284t0Y+gzMb9xK+87PP6JHBwocIUSioTRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvnXlZUR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvnXlZUR"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b02a2359aso2310430f8f.0
        for <linux-ide@vger.kernel.org>; Mon, 12 Oct 2026 21:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791865844; x=1792470644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tfaVI07NnFWJsgWEvzIw9BI/o4zgrBmZa473QRJOYq8=;
        b=UvnXlZUR+igug6NDXq4ZRqG0kgrj2Oi6k0G36qRvKj7oTdb5V+Vu1tEqKDRuE/+8pk
         ls+nTUl6HndAzBBFaBAQPJZFZEABLFbA7/tFTiN78tEhm/s3b1A7ZNkomWrZAjyNXkkU
         V84NlFphKYf/9rm29Z4OvkToq0enl92c6s1d4+5htScsAxUPF47seJNCGkmAyVAB24lt
         3MRQFL9tmJkQKvXqLyr532IRWx6SsqNVCB8CoUKXI7sKzL/PbqhqAaAaHpKtZ4QXanFy
         bAUcuJCOkgC+usVatMpV9z3PhNg4fc7ADgzFfYD2lLWSWXHLsH9xgPownBKrO7eexkJ8
         xe8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791865844; x=1792470644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tfaVI07NnFWJsgWEvzIw9BI/o4zgrBmZa473QRJOYq8=;
        b=MFUB6HXC2AemYw238rlFakm66svLXC1IaEf0WdDn0Ru/9hz4fhJx8uOeTWmqqmb/qa
         rRNjOw9PypHLhA8mafzs2ajz+AD6uElL/Kq1ZdOqV1pk8ZGN7rS8BLMIhHiXkOXi9jOP
         nBVT2eZlWQ4FinObfDhVfpV31BndczTPlTbB2J6BpKwmhE+75SjX1g4OhMEINtiKp3HU
         563XtOqyA2QZEl2nyAdIR7xJUASF4EswRs0CUNIis3E1vhpHDiZjtC0AvfhvIjjHKBUV
         5Wz5LhEDLTIVmdgk+Oi3GDuyi8Th/c9LHHeQM7N6px2Pz7lCGoR3GsmkI4yfQ0oTYUwb
         BsIA==
X-Gm-Message-State: AFq9FYLx+GaI5seO2K+84GdgpOG7Sd33rRN4BEXIkWqc0Y32w9wHdiiM
	VjFTM/MUs+dgiU+9OV8IRpU7SN2wuIWusugcZHfBrfn+Ms43k15vAxmIXxnWRB0S
X-Gm-Gg: AYBFou3KzP7wZxgkJy+cKF7NPROKzbR+wPexw/Gov/FK1MySNZspPX//GzoY5UA9gD7
	2wRGV73ah+yO/JlBxOI2qdRPHRDknrsyRaEgq/hzpPmgPBPoMMORtEV5FQBUU83cNaZEQOH0vUY
	I1dFruItvItuBZRyzc6Gevqk9xtrypdjKS2jrq6SbxR4XEQGhMLAoAwip6NKfzttqOJC8rZqyY6
	Q11vv7KYd2q1IShxnR/lgIESSatO0honVc7XH4mzVYU600quhAS8073BHRMYHfpfzoVsNT0O5U1
	f1vhl0JaKuVqqp+v/2nurKwdkvUm9g3T2de2WhNZaszRFLV6PWb6BzC9yuJcBxuRtgSMtlRBybj
	tuL1J0yJPlNDVbcjNTjOAna5kbw+lP5qPOG4+wgNFDlQcspUIwTO1s932u5uZOtBYuc9tj7CjQF
	tBbLxWs9mfMyu11MytKCP4tf2vISZLAoCksxXZDxJ0YadP0QtxUZjUP2hIOiC5Gw==
X-Received: by 2002:a05:6000:1788:b0:488:868a:1b88 with SMTP id ffacd0b85a97d-48db9465b3bmr21992459f8f.5.1791865844344;
        Mon, 12 Oct 2026 21:30:44 -0700 (PDT)
Received: from jo-Z6 ([2a02:586:e82e:5000:7fc2:feac:cb16:51fd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab5af7sm3026046f8f.31.2026.10.12.21.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 21:30:43 -0700 (PDT)
From: Ioannis Barkas <jnyb.de@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Ioannis Barkas <jnyb.de@gmail.com>
Subject: [PATCH] ata: pata_atiixp allow maximum UDMA speed
Date: Tue, 13 Oct 2026 07:30:16 +0300
Message-ID: <20261013043016.77075-1-jnyb.de@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable UDMA 6 for compatible IDE hosts, tested on SB600 & SB700
using ATA133 HDDs & SSDs. SSDs can exceed now 100MB/s

Signed-off-by: Ioannis Barkas jnyb.de@gmail.com
Signed-off-by: Nick Barkas nickbgrk@gmail.com
---
 drivers/ata/pata_atiixp.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 4c612f9543..74ef9195bd 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -279,8 +279,26 @@ static int atiixp_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		.udma_mask = ATA_UDMA5,
 		.port_ops = &atiixp_port_ops
 	};
+	static const struct ata_port_info info_ata133 = {
+		.flags = ATA_FLAG_SLAVE_POSS,
+		.pio_mask = ATA_PIO4,
+		.mwdma_mask = ATA_MWDMA12_ONLY,
+		.udma_mask = ATA_UDMA6,
+		.port_ops = &atiixp_port_ops
+	};
 	const struct ata_port_info *ppi[] = { &info, &info };
 
+	/* SB300 and newer: UDMA6 */
+	switch (pdev->device) {
+	case PCI_DEVICE_ID_ATI_IXP300_IDE:
+	case PCI_DEVICE_ID_ATI_IXP400_IDE:
+	case PCI_DEVICE_ID_ATI_IXP600_IDE:
+	case PCI_DEVICE_ID_ATI_IXP700_IDE:
+	case PCI_DEVICE_ID_AMD_HUDSON2_IDE:
+		ppi[0] = ppi[1] = &info_ata133;
+		break;
+	}
+
 	/* SB600 doesn't have secondary port wired */
 	if (pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE)
 		ppi[1] = &ata_dummy_port_info;
@@ -314,7 +332,7 @@ static struct pci_driver atiixp_pci_driver = {
 module_pci_driver(atiixp_pci_driver);
 
 MODULE_AUTHOR("Alan Cox");
-MODULE_DESCRIPTION("low-level driver for ATI IXP200/300/400");
+MODULE_DESCRIPTION("low-level driver for ATI IXP200/300/400, AMD SB600/700 series and Hudson-2");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, atiixp);
 MODULE_VERSION(DRV_VERSION);
-- 
2.53.0

